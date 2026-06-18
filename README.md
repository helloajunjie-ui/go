# PureNav 🧭

> AI 工具导航站 — 禅意双栏 · UGC 生态 · 一键部署

![Vue3](https://img.shields.io/badge/Vue-3.4-4FC08D?logo=vue.js)
![Tailwind](https://img.shields.io/badge/Tailwind-3-06B6D4?logo=tailwindcss)
![Supabase](https://img.shields.io/badge/Supabase-BaaS-3ECF8E?logo=supabase)
![Cloudflare](https://img.shields.io/badge/Cloudflare-Workers-F38020?logo=cloudflare)

---

## 在线地址

| 入口 | 链接 |
|------|------|
| 🏠 主站导航 | https://go.helloajunjie.workers.dev/ |
| ✨ 推荐好站 | https://go.helloajunjie.workers.dev/submit |
| 🛡️ 审核中心 | https://go.helloajunjie.workers.dev/review |

---

## 功能特性

### 🏠 主站 — 禅意双栏导航

- **左侧手风琴** — CSS-only `grid-template-rows: 0fr→1fr` 展开动画
- **右侧内容区** — IntersectionObserver 滚动监听，联动左侧高亮
- **响应式网格** — 1~5 列自适应，大屏不空荡
- **10 大 AI 分类**，100+ 精选 AI 工具官网

### ✨ 提交系统

- **Magic Input** — 粘贴 URL 自动解析标题/描述/图标
- **CF Worker 解析引擎** — HTMLRewriter 流式解析，不下载完整页面
- **分类选择** — 从数据库动态加载一级分类
- **写入 PENDING** — 提交后进入审核队列

### 🛡️ 审核后台

- **Supabase Auth** — 管理员邮箱密码登录
- **Tinder 卡片** — 显示待审核站点信息
- **键盘快捷键** — `Y` 通过 / `N` 拒绝
- **乐观更新** — 即时移除卡片，异步写库
- **操作记录** — 实时显示最近审核历史

---

## 技术架构

```
前端 (Cloudflare Workers Static Assets)
├── index.html   — 主站 (Vue3 + Tailwind + Supabase)
├── submit.html  — 提交页 (Vue3 + CF Worker + Supabase)
└── review.html  — 审核后台 (Vue3 + Supabase Auth)

后端 (BaaS + Edge Function)
├── Supabase     — 数据库 (categories + sites) + Auth
└── CF Worker    — URL 解析引擎 (HTMLRewriter)
```

详细架构见 [`ARCHITECTURE.md`](ARCHITECTURE.md)

---

## 数据库表结构

### categories

| 字段 | 类型 | 说明 |
|------|------|------|
| id | uuid | 主键 |
| name | text | 分类名称 |
| icon | text | Emoji 图标 |
| parent_id | uuid? | 父分类 (null=L1) |
| sort_order | int | 排序 |

### sites

| 字段 | 类型 | 说明 |
|------|------|------|
| id | uuid | 主键 |
| name | text | 站点名称 |
| description | text | 描述 |
| url | text | 官网地址 |
| icon | text | Favicon URL |
| category_id | uuid | 所属分类 |
| status | text | APPROVED/PENDING/REJECTED |

---

## 本地开发

```bash
# 克隆
git clone https://github.com/helloajunjie-ui/go.git

# 使用 VSCode Live Server 打开（必须 HTTP 协议）
# file:// 协议会阻止 CDN 脚本加载
code go/
# 右键 index.html → Open with Live Server
```

---

## 部署

```bash
# 推送 master
git push origin master

# 同步 Cloudflare Workers
git push origin master:cloudflare/workers-autoconfig --force
```

Cloudflare Workers 自动部署。

---

## 项目路线图

- [x] 禅意双栏导航
- [x] Supabase 数据库集成
- [x] UGC 提交系统
- [x] 管理员审核后台
- [x] URL 自动解析引擎
- [ ] 用户注册/投稿积分
- [ ] 站点搜索功能
- [ ] 站点点击统计
- [ ] 暗色/亮色主题切换
