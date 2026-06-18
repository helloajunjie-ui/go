# PureNav 🧭

> AI 工具导航站 — 禅意双栏 · UGC 生态 · 全自动狩猎机 · 一键部署

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

### 🟢 全天候雷达 — Umami 无痕分析

- **< 2KB 脚本**，defer 异步加载，零性能影响
- **无需 Cookie 弹窗**，GDPR 合规
- **实时仪表盘**：访客国家、设备、页面浏览、点击热图
- 已注入 [`index.html`](index.html) `<head>`，开箱即用

### 🔴 全自动 AI 狩猎机 — Cron 定时任务

- **每天凌晨 3 点** (UTC) Cloudflare Cron 自动唤醒
- **ProductHunt API** 抓取当日 Top 5 高赞项目
- **DeepSeek API** AI 提纯：20 字中文描述 + 自动匹配分类
- **自动写入 Supabase** `status='PENDING'`，早上醒来按 5 下 Y 即可
- 代码见 [`api/ai-hunter.js`](api/ai-hunter.js)

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
├── index.html     — 主站 (Vue3 + Tailwind + Supabase + Umami)
├── submit.html    — 提交页 (Vue3 + CF Worker + Supabase)
└── review.html    — 审核后台 (Vue3 + Supabase Auth)

后端 (BaaS + Edge Function)
├── Supabase       — 数据库 (categories + sites) + Auth
├── CF Worker      — URL 解析引擎 (HTMLRewriter)
└── ai-hunter.js   — Cron 定时 AI 狩猎机 (DeepSeek + Supabase)
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

## 部署 AI 狩猎机

```bash
# 1. 获取 DeepSeek API Key: https://platform.deepseek.com/
#    充值 1 元够跑半年

# 2. CF Dashboard → Workers & Pages → 新建 Worker
#    名称: ai-hunter
#    粘贴 api/ai-hunter.js 内容

# 3. Settings → Variables → 添加环境变量 (不要硬编码在代码里):
#    DEEPSEEK_API_KEY   = sk-your-deepseek-key (在 CF 环境变量里设置)
#    SUPABASE_URL       = https://ltxxqgdzwdxsmyttrndh.supabase.co
#    SUPABASE_ANON_KEY  = sb_publishable_dEXB1daaGCziI29i3hDJAA_ctgmK-1S
#    MANUAL_TRIGGER_TOKEN = (设置一个随机字符串用于手动触发)

# 4. Triggers → Cron Triggers → 添加 "0 3 * * *"
```

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
- [x] Umami 无痕分析雷达
- [x] AI 全自动狩猎机 (Cron + DeepSeek)
- [ ] 用户注册/投稿积分
- [ ] 站点搜索功能
- [ ] 站点点击统计
- [ ] 暗色/亮色主题切换
