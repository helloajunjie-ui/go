// Cloudflare Worker: 全自动 AI 狩猎机 (Cron 定时任务版)
// 每天凌晨 3 点自动抓取趋势工具 → DeepSeek 提纯 → 写入 Supabase PENDING
//
// 部署步骤:
// 1. CF Dashboard → Workers & Pages → 新建 Worker → 命名 ai-hunter
// 2. 粘贴本代码
// 3. Settings → Variables → 添加环境变量 (不要硬编码在代码里):
//    DEEPSEEK_API_KEY   = sk-your-deepseek-key (在 CF 环境变量里设置)
//    SUPABASE_URL       = https://ltxxqgdzwdxsmyttrndh.supabase.co
//    SUPABASE_ANON_KEY  = sb_publishable_dEXB1daaGCziI29i3hDJAA_ctgmK-1S
//    MANUAL_TRIGGER_TOKEN = 设置一个随机字符串用于手动触发鉴权
// 4. Triggers → Cron Triggers → 添加 "0 3 * * *" (每天 UTC 3:00 = 北京时间 11:00)

// 预置的 AI 分类映射 (从 Supabase categories 表查询得来)
// L1 分类 ID 列表，AI 从中选择最匹配的
const CATEGORY_IDS = [
  'a1000000-0000-0000-0000-000000000001', // AI聊天与陪伴
  'a2000000-0000-0000-0000-000000000002', // AI图像生成
  'a3000000-0000-0000-0000-000000000003', // AI视频与动画
  'a4000000-0000-0000-0000-000000000004', // AI写作与内容
  'a5000000-0000-0000-0000-000000000005', // AI编程与开发
  'a6000000-0000-0000-0000-000000000006', // AI设计创意
  'a7000000-0000-0000-0000-000000000007', // AI音乐与音频
  'a8000000-0000-0000-0000-000000000008', // AI学习与教育
  'a9000000-0000-0000-0000-000000000009', // AI搜索与效率
  'a10000000-0000-0000-0000-000000000010', // AI数据与商业
];

// 每日狩猎列表 — 高价值 AI 工具发现源
// 你可以扩展这个列表，加入 ProductHunt API、GitHub Trending 等
const HUNT_SOURCES = [
  'https://api.producthunt.com/v2/api/graphql',  // ProductHunt API
  'https://github.com/trending',                  // GitHub Trending
  'https://news.ycombinator.com/show',            // HackerNews Show
];

// 硬编码的每日目标 URL（兜底：即使 API 挂掉也有数据入库）
const FALLBACK_TARGETS = [
  'https://cursor.sh',
  'https://v0.dev',
  'https://perplexity.ai',
  'https://suno.ai',
  'https://midjourney.com',
];

export default {
  async scheduled(event, env, ctx) {
    console.log('🐺 AI 猎犬已苏醒，开始执行巡逻任务...');

    const targets = [];

    // 1. 从 ProductHunt 获取今日热榜
    try {
      const phRes = await fetch(HUNT_SOURCES[0], {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: JSON.stringify({
          query: `{
            posts(first: 5, order: VOTES) {
              edges {
                node {
                  name
                  tagline
                  url
                  website
                }
              }
            }
          }`
        })
      });
      if (phRes.ok) {
        const phData = await phRes.json();
        const posts = phData?.data?.posts?.edges || [];
        for (const edge of posts) {
          const node = edge.node;
          if (node.website) {
            targets.push({ url: node.website, name: node.name, description: node.tagline });
          }
        }
        console.log(`✅ ProductHunt 捕获 ${targets.length} 个目标`);
      }
    } catch (e) {
      console.log('⚠️ ProductHunt API 不可用，使用兜底列表');
    }

    // 2. 如果 ProductHunt 没抓到，用兜底列表
    if (targets.length === 0) {
      for (const url of FALLBACK_TARGETS) {
        targets.push({ url, name: '', description: '' });
      }
      console.log('📋 使用兜底目标列表');
    }

    // 3. 对每个目标召唤 AI 大脑
    for (const target of targets) {
      try {
        console.log(`🔍 分析目标: ${target.url}`);

        const aiResponse = await fetch('https://api.deepseek.com/v1/chat/completions', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${env.DEEPSEEK_API_KEY}`
          },
          body: JSON.stringify({
            model: 'deepseek-chat',
            messages: [
              {
                role: 'system',
                content: `你是一个极客导航站的 AI 编辑。分析用户提供的 URL，用极简专业的中文输出 JSON。
规则：
- name: 产品名（中文或英文原名）
- description: 一句少于 20 字的克制描述
- category_id: 从以下分类 ID 中选择最匹配的一个：
  a1000000-0000-0000-0000-000000000001 = AI聊天与陪伴
  a2000000-0000-0000-0000-000000000002 = AI图像生成
  a3000000-0000-0000-0000-000000000003 = AI视频与动画
  a4000000-0000-0000-0000-000000000004 = AI写作与内容
  a5000000-0000-0000-0000-000000000005 = AI编程与开发
  a6000000-0000-0000-0000-000000000006 = AI设计创意
  a7000000-0000-0000-0000-000000000007 = AI音乐与音频
  a8000000-0000-0000-0000-000000000008 = AI学习与教育
  a9000000-0000-0000-0000-000000000009 = AI搜索与效率
  a10000000-0000-0000-0000-000000000010 = AI数据与商业
如果你无法访问该 URL 或它不是 AI 工具，返回空 JSON {}。`
              },
              {
                role: 'user',
                content: `URL: ${target.url}\n已知名称: ${target.name}\n已知描述: ${target.description}`
              }
            ],
            response_format: { type: 'json_object' }
          })
        });

        if (!aiResponse.ok) {
          console.log(`⚠️ DeepSeek API 返回 ${aiResponse.status}，跳过 ${target.url}`);
          continue;
        }

        const aiResult = await aiResponse.json();
        const content = aiResult?.choices?.[0]?.message?.content;
        if (!content) continue;

        const extractedData = JSON.parse(content);

        // AI 觉得是垃圾，跳过
        if (!extractedData.name) {
          console.log(`⏭️ AI 判定 ${target.url} 非优质工具，跳过`);
          continue;
        }

        // 验证 category_id 是否有效
        const categoryId = CATEGORY_IDS.includes(extractedData.category_id)
          ? extractedData.category_id
          : CATEGORY_IDS[4]; // 默认丢进 AI编程与开发

        // 4. 写入 Supabase PENDING
        const insertRes = await fetch(`${env.SUPABASE_URL}/rest/v1/sites`, {
          method: 'POST',
          headers: {
            'apikey': env.SUPABASE_ANON_KEY,
            'Authorization': `Bearer ${env.SUPABASE_ANON_KEY}`,
            'Content-Type': 'application/json',
            'Prefer': 'return=minimal'
          },
          body: JSON.stringify({
            name: extractedData.name,
            url: target.url,
            description: extractedData.description || target.description || '',
            icon: `https://www.google.com/s2/favicons?domain=${new URL(target.url).hostname}&sz=64`,
            category_id: categoryId,
            status: 'PENDING'
          })
        });

        if (insertRes.ok) {
          console.log(`✅ 成功捕获入库: ${extractedData.name} → ${categoryId}`);
        } else {
          const errText = await insertRes.text();
          console.log(`❌ 入库失败 ${target.url}: ${errText}`);
        }

      } catch (err) {
        console.log(`❌ 处理 ${target.url} 异常: ${err.message}`);
      }
    }

    console.log('🏁 AI 猎犬巡逻任务完成，返回狗窝休眠');
  },

  // 支持手动触发测试 (HTTP 请求唤醒)
  async fetch(request, env, ctx) {
    // 简单鉴权：防止被滥用
    const authHeader = request.headers.get('X-Auth-Token');
    if (authHeader !== env.MANUAL_TRIGGER_TOKEN) {
      return new Response('Unauthorized', { status: 401 });
    }
    // 手动触发一次狩猎
    await this.scheduled(null, env, ctx);
    return new Response('🐺 AI 猎犬已手动释放，任务完成', { status: 200 });
  }
};
