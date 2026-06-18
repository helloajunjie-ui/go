# PureNav 架构文档

## 项目概览

PureNav 是一个 AI 工具导航站，采用 **静态前端 + BaaS 后端** 架构。前端部署在 Cloudflare Workers Static Assets，后端依赖 Supabase（数据库 + Auth）+ Cloudflare Workers（URL 解析引擎）。

## 架构图

```
┌─────────────────────────────────────────────────────────┐
│                    Cloudflare Workers                    │
│                                                         │
│  go.helloajunjie.workers.dev/                           │
│    ├── /          → index.html   (主站 - 禅意导航)       │
│    ├── /submit    → submit.html  (游客提交)              │
│    ├── /review    → review.html  (管理员审核)             │
│    └── /api/parse → url-parser.js (HTMLRewriter 解析)    │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │  index.html (Vue3 + Import Map + Tailwind CDN)  │    │
│  │  ┌───────────────────────────────────────────┐  │    │
│  │  │ 左侧边栏 (L1 分类手风琴)                    │  │    │
│  │  │   ├─ AI聊天与陪伴                          │  │    │
│  │  │   │   ├─ AI酒馆 (L2)                      │  │    │
│  │  │   │   └─ 通用对话 (L2)                    │  │    │
│  │  │   ├─ AI图像生成                           │  │    │
│  │  │   ├─ AI视频与动画                         │  │    │
│  │  │   └─ ...                                 │  │    │
│  │  ├───────────────────────────────────────────┤  │    │
│  │  │ 右侧主内容区 (IntersectionObserver 滚动)    │  │    │
│  │  │   ├─ 分类标题 + 子分类网格                  │  │    │
│  │  │   │   └─ 站点卡片 (图标 + 名称 + 描述)      │  │    │
│  │  │   └─ 滚动联动左侧高亮                       │  │    │
│  │  └───────────────────────────────────────────┘  │    │
│  └─────────────────────────────────────────────────┘    │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │  submit.html (Vue3 Options API)                  │    │
│  │  ├─ Magic Input → CF Worker 解析 URL             │    │
│  │  ├─ 分类选择下拉 (从 Supabase 加载 L1)            │    │
│  │  └─ 确认 → INSERT sites (status='PENDING')       │    │
│  └─────────────────────────────────────────────────┘    │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │  review.html (Vue3 Composition API)              │    │
│  │  ├─ Supabase Auth 登录                           │    │
│  │  ├─ Tinder 卡片审核 (Y/N 键盘快捷键)              │    │
│  │  ├─ 乐观更新 (shift() 即时移除)                  │    │
│  │  └─ 操作记录面板                                │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────┐
│                    Supabase (BaaS)                       │
│                                                         │
│  Project: ltxxqgdzwdxsmyttrndh                          │
│                                                         │
│  Tables:                                                │
│    categories                                           │
│    ├─ id: uuid (PK)                                     │
│    ├─ name: text                                        │
│    ├─ icon: text (emoji)                                │
│    ├─ parent_id: uuid (nullable, FK→categories.id)      │
│    └─ sort_order: int                                   │
│                                                         │
│    sites                                                │
│    ├─ id: uuid (PK)                                     │
│    ├─ name: text                                        │
│    ├─ description: text                                 │
│    ├─ url: text                                         │
│    ├─ icon: text (favicon URL)                          │
│    ├─ category_id: uuid (FK→categories.id)              │
│    ├─ status: text (APPROVED | PENDING | REJECTED)      │
│    └─ created_at / updated_at: timestamp                │
│                                                         │
│  RLS Policies:                                          │
│    sites: anonymous 只能 SELECT status='APPROVED'       │
│    sites: authenticated 可以 ALL (审核后台)              │
│    categories: anonymous 可以 SELECT                    │
│                                                         │
│  Auth:                                                  │
│    admin@purenav.com (管理员账号)                        │
│                                                         │
└─────────────────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────┐
│          Cloudflare Workers (URL Parser)                 │
│                                                         │
│  api/url-parser.js                                      │
│  ├─ GET /api/parse?url=https://example.com              │
│  ├─ HTMLRewriter 流式解析 (不下载完整 HTML)              │
│  │   ├─ <title> → title                                 │
│  │   ├─ <meta name="description"> → description         │
│  │   └─ <meta property="og:description"> → description  │
│  ├─ Google Favicon API → icon                           │
│  └─ 返回 JSON { url, title, description, icon }        │
└─────────────────────────────────────────────────────────┘
```

## 数据流

### 读流程（主站展示）

```
index.html
  → onMounted: supabase.from('categories').select('*')
  → onMounted: supabase.from('sites').select('*').eq('status', 'APPROVED')
  → buildTree(): O(N) 将 flat 数组转为嵌套树
  → Vue3 响应式渲染
```

### 写流程（游客提交）

```
submit.html
  → 用户粘贴 URL
  → fetch(CF Worker /api/parse?url=...)
  → 解析结果回填表单
  → 用户选择分类
  → supabase.from('sites').insert({..., status: 'PENDING'})
  → 等待管理员审核
```

### 审核流程（管理员）

```
review.html
  → Supabase Auth 登录 (email/password)
  → supabase.from('sites').select('*').eq('status', 'PENDING')
  → 显示 Tinder 卡片
  → 按 Y: supabase.update({status:'APPROVED'}) + shift() 移除
  → 按 N: supabase.update({status:'REJECTED'}) + shift() 移除
  → 主站下次刷新即可看到 APPROVED 站点
```

## 技术栈

| 层 | 技术 | 备注 |
|----|------|------|
| 前端框架 | Vue 3 (CDN) | Import Map + ES Module |
| 样式 | Tailwind CSS (CDN) | JIT 模式 |
| 数据库 | Supabase (PostgreSQL) | 双表架构 |
| 认证 | Supabase Auth | Email/Password |
| 托管 | Cloudflare Workers | Static Assets |
| URL 解析 | Cloudflare Workers + HTMLRewriter | 流式解析 |
| 图标 | Google Favicon API | 兜底方案 |

## 文件清单

| 文件 | 用途 | 技术 |
|------|------|------|
| [`index.html`](index.html) | 主站入口（禅意导航） | Vue3 + Tailwind + Supabase |
| [`zen.html`](zen.html) | 同 index.html（历史保留） | Vue3 + Tailwind + Supabase |
| [`submit.html`](submit.html) | 游客提交页面 | Vue3 + CF Worker + Supabase |
| [`review.html`](review.html) | 管理员审核后台 | Vue3 + Supabase Auth |
| [`api/url-parser.js`](api/url-parser.js) | URL 解析 Worker | HTMLRewriter |
| [`api/parse.js`](api/parse.js) | 旧版解析引擎（已废弃） | Node.js + cheerio |
| [`init_ai_navigation.sql`](init_ai_navigation.sql) | 全量数据 SQL | PostgreSQL |
| [`ZenDirectory.vue`](ZenDirectory.vue) | Vue SFC 组件 | Vue3 `<script setup>` |
| [`MegaMenu.vue`](MegaMenu.vue) | 旧版菜单组件（已废弃） | Vue3 Options API |
| [`App.vue`](App.vue) | 旧版 App Shell（已废弃） | Vue3 |

## 部署

```bash
# 推送 master 分支
git push origin master

# 同步到 Cloudflare Workers 分支
git push origin master:cloudflare/workers-autoconfig --force
```

Cloudflare Workers 自动部署后访问：
- 主站：https://go.helloajunjie.workers.dev/
- 提交：https://go.helloajunjie.workers.dev/submit
- 审核：https://go.helloajunjie.workers.dev/review
