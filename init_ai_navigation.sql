-- ==========================================
-- PureNav 全量 AI 导航数据初始化脚本
-- UUID 格式: aN000000-... (L1), bMN0000-... (L2)
-- 共 10 个一级分类、26 个二级分类、120+ 个网站
-- ==========================================

-- ==========================================
-- 第一步：批量写入【一级主分类】(parent_id 为空)
-- ==========================================
INSERT INTO categories (id, name, icon, sort_order) VALUES 
('a1000000-0000-0000-0000-000000000000', 'AI 聊天与陪伴', '💬', 100),
('a2000000-0000-0000-0000-000000000000', 'AI 编程工具', '⌨️', 90),
('a3000000-0000-0000-0000-000000000000', 'AI 视频工具', '📹', 80),
('a4000000-0000-0000-0000-000000000000', 'AI 设计工具', '🎨', 70),
('a5000000-0000-0000-0000-000000000000', 'AI 音乐与音频', '🎵', 60),
('a6000000-0000-0000-0000-000000000000', 'AI 智能体', '🤖', 50),
('a7000000-0000-0000-0000-000000000000', 'AI 效率工具', '⚡', 40),
('a8000000-0000-0000-0000-000000000000', 'AI 学习与教育', '📚', 30),
('a9000000-0000-0000-0000-000000000000', 'AI 图像工具', '🖼️', 20),
('aa000000-0000-0000-0000-000000000000', 'AI 搜索聚合', '🔍', 10);

-- ==========================================
-- 第二步：批量写入【二级子分类】
-- ==========================================

-- L1: AI 聊天与陪伴
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b1100000-0000-0000-0000-000000000000', '通用对话', 'a1000000-0000-0000-0000-000000000000', 100),
('b1200000-0000-0000-0000-000000000000', '角色扮演 / AI酒馆', 'a1000000-0000-0000-0000-000000000000', 90),
('b1300000-0000-0000-0000-000000000000', '本地运行', 'a1000000-0000-0000-0000-000000000000', 80);

-- L2: AI 编程工具
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b2100000-0000-0000-0000-000000000000', 'AI IDE', 'a2000000-0000-0000-0000-000000000000', 100),
('b2200000-0000-0000-0000-000000000000', '编程插件', 'a2000000-0000-0000-0000-000000000000', 90),
('b2300000-0000-0000-0000-000000000000', '代码审查与运维', 'a2000000-0000-0000-0000-000000000000', 80);

-- L3: AI 视频工具
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b3100000-0000-0000-0000-000000000000', '视频生成', 'a3000000-0000-0000-0000-000000000000', 100),
('b3200000-0000-0000-0000-000000000000', '数字人播报', 'a3000000-0000-0000-0000-000000000000', 90),
('b3300000-0000-0000-0000-000000000000', '视频编辑', 'a3000000-0000-0000-0000-000000000000', 80);

-- L4: AI 设计工具
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b4100000-0000-0000-0000-000000000000', 'UI/UX 设计', 'a4000000-0000-0000-0000-000000000000', 100),
('b4200000-0000-0000-0000-000000000000', '平面与品牌设计', 'a4000000-0000-0000-0000-000000000000', 90),
('b4300000-0000-0000-0000-000000000000', '3D 设计', 'a4000000-0000-0000-0000-000000000000', 80);

-- L5: AI 音乐与音频
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b5100000-0000-0000-0000-000000000000', '音乐生成', 'a5000000-0000-0000-0000-000000000000', 100),
('b5200000-0000-0000-0000-000000000000', '语音合成', 'a5000000-0000-0000-0000-000000000000', 90),
('b5300000-0000-0000-0000-000000000000', '音频处理', 'a5000000-0000-0000-0000-000000000000', 80);

-- L6: AI 智能体
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b6100000-0000-0000-0000-000000000000', '桌面端 Agent', 'a6000000-0000-0000-0000-000000000000', 100),
('b6200000-0000-0000-0000-000000000000', '网页端 Agent', 'a6000000-0000-0000-0000-000000000000', 90),
('b6300000-0000-0000-0000-000000000000', '工作流编排', 'a6000000-0000-0000-0000-000000000000', 80);

-- L7: AI 效率工具
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b7100000-0000-0000-0000-000000000000', '笔记与写作', 'a7000000-0000-0000-0000-000000000000', 100),
('b7200000-0000-0000-0000-000000000000', '演示与文档', 'a7000000-0000-0000-0000-000000000000', 90),
('b7300000-0000-0000-0000-000000000000', '自动化办公', 'a7000000-0000-0000-0000-000000000000', 80);

-- L8: AI 学习与教育
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b8100000-0000-0000-0000-000000000000', '课程平台', 'a8000000-0000-0000-0000-000000000000', 100),
('b8200000-0000-0000-0000-000000000000', '社区与资讯', 'a8000000-0000-0000-0000-000000000000', 90);

-- L9: AI 图像工具
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('b9100000-0000-0000-0000-000000000000', '图像生成', 'a9000000-0000-0000-0000-000000000000', 100),
('b9200000-0000-0000-0000-000000000000', '图像编辑', 'a9000000-0000-0000-0000-000000000000', 90);

-- L10: AI 搜索聚合
INSERT INTO categories (id, name, parent_id, sort_order) VALUES 
('ba100000-0000-0000-0000-000000000000', 'AI 搜索引擎', 'aa000000-0000-0000-0000-000000000000', 100),
('ba200000-0000-0000-0000-000000000000', '聚合导航', 'aa000000-0000-0000-0000-000000000000', 90);

-- ==========================================
-- 第三步：批量轰炸式写入【具体网站】
-- ==========================================

-- === b11: 通用对话 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('ChatGPT', 'OpenAI 推出的旗舰级 AI 对话助手', 'https://chatgpt.com', 'https://api.dicebear.com/7.x/icons/svg?seed=chatgpt&backgroundColor=10a37f', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Claude', 'Anthropic 出品的安全智能 AI 助手', 'https://claude.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=claude&backgroundColor=d97706', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Gemini', 'Google 最新多模态 AI 对话模型', 'https://gemini.google.com', 'https://api.dicebear.com/7.x/icons/svg?seed=gemini&backgroundColor=4285f4', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('DeepSeek Chat', '深度求索出品的高性能免费 AI 对话', 'https://chat.deepseek.com', 'https://api.dicebear.com/7.x/icons/svg?seed=deepseek&backgroundColor=4f46e5', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('豆包', '字节跳动出品的 AI 对话助手', 'https://www.doubao.com', 'https://api.dicebear.com/7.x/icons/svg?seed=doubao&backgroundColor=1e80ff', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('通义千问', '阿里云出品的大语言模型对话服务', 'https://tongyi.aliyun.com', 'https://api.dicebear.com/7.x/icons/svg?seed=tongyi&backgroundColor=ff6a00', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('文心一言', '百度出品的知识增强大语言模型', 'https://yiyan.baidu.com', 'https://api.dicebear.com/7.x/icons/svg?seed=wenxin&backgroundColor=2932e1', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Kimi', '月之暗面出品的长文本 AI 助手', 'https://kimi.moonshot.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=kimi&backgroundColor=8b5cf6', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('智谱清言', '智谱 AI 出品的对话式 AI 助手', 'https://chatglm.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=chatglm&backgroundColor=2563eb', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Groq', '极速推理芯片驱动的 AI 对话平台', 'https://groq.com', 'https://api.dicebear.com/7.x/icons/svg?seed=groq&backgroundColor=111827', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Perplexity', 'AI 驱动的对话式搜索引擎', 'https://www.perplexity.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=perplexity&backgroundColor=6366f1', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Mistral Chat', 'Mistral AI 出品的开源大模型对话', 'https://chat.mistral.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=mistral&backgroundColor=7c3aed', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Cohere', '企业级 AI 对话与检索平台', 'https://coral.cohere.com', 'https://api.dicebear.com/7.x/icons/svg?seed=cohere&backgroundColor=0891b2', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Poe', '集成多模型的一站式 AI 聊天平台', 'https://poe.com', 'https://api.dicebear.com/7.x/icons/svg?seed=poe&backgroundColor=9333ea', 'b1100000-0000-0000-0000-000000000000', 'APPROVED'),
('Character.AI', '与 AI 角色进行沉浸式对话', 'https://character.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=character&backgroundColor=dc2626', 'b1100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b12: 角色扮演 / AI酒馆 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('SillyTavern', '开源 AI 角色扮演聊天前端（AI酒馆）', 'https://sillytavern.app', 'https://api.dicebear.com/7.x/icons/svg?seed=sillytavern&backgroundColor=be185d', 'b1200000-0000-0000-0000-000000000000', 'APPROVED'),
('RisuAI', 'AI 角色扮演与故事创作平台', 'https://risuai.net', 'https://api.dicebear.com/7.x/icons/svg?seed=risuai&backgroundColor=db2777', 'b1200000-0000-0000-0000-000000000000', 'APPROVED'),
('JanitorAI', '海量 AI 角色聊天社区', 'https://janitorai.com', 'https://api.dicebear.com/7.x/icons/svg?seed=janitor&backgroundColor=0891b2', 'b1200000-0000-0000-0000-000000000000', 'APPROVED'),
('SpicyChat', '无限制 AI 角色扮演聊天', 'https://spicychat.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=spicy&backgroundColor=dc2626', 'b1200000-0000-0000-0000-000000000000', 'APPROVED'),
('Chub', 'AI 角色卡片分享与发现社区', 'https://www.chub.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=chub&backgroundColor=7c3aed', 'b1200000-0000-0000-0000-000000000000', 'APPROVED'),
('Backyard AI', '本地运行 AI 角色的桌面客户端', 'https://backyard.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=backyard&backgroundColor=059669', 'b1200000-0000-0000-0000-000000000000', 'APPROVED');

-- === b13: 本地运行 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Ollama', '一键本地运行大语言模型', 'https://ollama.com', 'https://api.dicebear.com/7.x/icons/svg?seed=ollama&backgroundColor=111827', 'b1300000-0000-0000-0000-000000000000', 'APPROVED'),
('LM Studio', '图形化本地运行和测试 AI 模型', 'https://lmstudio.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=lmstudio&backgroundColor=2563eb', 'b1300000-0000-0000-0000-000000000000', 'APPROVED'),
('llama.cpp', 'C/C++ 实现的高性能 LLM 推理引擎', 'https://github.com/ggerganov/llama.cpp', 'https://api.dicebear.com/7.x/icons/svg?seed=llamacpp&backgroundColor=374151', 'b1300000-0000-0000-0000-000000000000', 'APPROVED'),
('vLLM', '高性能大模型推理服务框架', 'https://vllm.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=vllm&backgroundColor=0891b2', 'b1300000-0000-0000-0000-000000000000', 'APPROVED'),
('Open WebUI', '自托管的 AI 对话 Web 界面', 'https://openwebui.com', 'https://api.dicebear.com/7.x/icons/svg?seed=openwebui&backgroundColor=6366f1', 'b1300000-0000-0000-0000-000000000000', 'APPROVED'),
('Hugging Face', '全球最大的 AI 模型托管与社区平台', 'https://huggingface.co', 'https://api.dicebear.com/7.x/icons/svg?seed=huggingface&backgroundColor=f59e0b', 'b1300000-0000-0000-0000-000000000000', 'APPROVED');

-- === b21: AI IDE ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Cursor', 'AI First 的现代化代码编辑器', 'https://cursor.sh', 'https://api.dicebear.com/7.x/icons/svg?seed=cursor&backgroundColor=6d28d9', 'b2100000-0000-0000-0000-000000000000', 'APPROVED'),
('Windsurf', 'Codeium 出品的 AI 驱动 IDE', 'https://codeium.com/windsurf', 'https://api.dicebear.com/7.x/icons/svg?seed=windsurf&backgroundColor=0891b2', 'b2100000-0000-0000-0000-000000000000', 'APPROVED'),
('GitHub Copilot', 'GitHub 出品的 AI 编程助手', 'https://github.com/features/copilot', 'https://api.dicebear.com/7.x/icons/svg?seed=copilot&backgroundColor=8957e5', 'b2100000-0000-0000-0000-000000000000', 'APPROVED'),
('Replit Agent', '浏览器内 AI 全栈开发环境', 'https://replit.com', 'https://api.dicebear.com/7.x/icons/svg?seed=replit&backgroundColor=667085', 'b2100000-0000-0000-0000-000000000000', 'APPROVED'),
('Bolt.new', 'AI 驱动的全栈 Web 应用生成器', 'https://bolt.new', 'https://api.dicebear.com/7.x/icons/svg?seed=bolt&backgroundColor=6366f1', 'b2100000-0000-0000-0000-000000000000', 'APPROVED'),
('Lovable', '用自然语言构建 Web 应用的 AI 平台', 'https://lovable.dev', 'https://api.dicebear.com/7.x/icons/svg?seed=lovable&backgroundColor=db2777', 'b2100000-0000-0000-0000-000000000000', 'APPROVED'),
('v0.dev', 'Vercel 出品的 AI UI 生成工具', 'https://v0.dev', 'https://api.dicebear.com/7.x/icons/svg?seed=v0dev&backgroundColor=111827', 'b2100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b22: 编程插件 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Continue', '开源 AI 编程助手（VS Code / JetBrains）', 'https://continue.dev', 'https://api.dicebear.com/7.x/icons/svg?seed=continue&backgroundColor=059669', 'b2200000-0000-0000-0000-000000000000', 'APPROVED'),
('Tabnine', 'AI 代码补全与生成插件', 'https://www.tabnine.com', 'https://api.dicebear.com/7.x/icons/svg?seed=tabnine&backgroundColor=2563eb', 'b2200000-0000-0000-0000-000000000000', 'APPROVED'),
('Amazon CodeWhisperer', 'AWS 出品的免费 AI 编程助手', 'https://aws.amazon.com/codewhisperer', 'https://api.dicebear.com/7.x/icons/svg?seed=codewhisperer&backgroundColor=ff9900', 'b2200000-0000-0000-0000-000000000000', 'APPROVED'),
('CodeGeeX', '智谱 AI 出品的开源编程助手', 'https://codegeex.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=codegeex&backgroundColor=2563eb', 'b2200000-0000-0000-0000-000000000000', 'APPROVED'),
('通义灵码', '阿里云出品的 AI 编程助手', 'https://tongyi.aliyun.com/lingma', 'https://api.dicebear.com/7.x/icons/svg?seed=lingma&backgroundColor=ff6a00', 'b2200000-0000-0000-0000-000000000000', 'APPROVED');

-- === b23: 代码审查与运维 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Sentry AI', 'AI 增强的错误监控与性能追踪', 'https://sentry.io', 'https://api.dicebear.com/7.x/icons/svg?seed=sentry&backgroundColor=362d59', 'b2300000-0000-0000-0000-000000000000', 'APPROVED'),
('CodeRabbit', 'AI 驱动的代码审查机器人', 'https://coderabbit.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=coderabbit&backgroundColor=6366f1', 'b2300000-0000-0000-0000-000000000000', 'APPROVED'),
('Linear', 'AI 增强的现代化项目管理工具', 'https://linear.app', 'https://api.dicebear.com/7.x/icons/svg?seed=linear&backgroundColor=5e6ad2', 'b2300000-0000-0000-0000-000000000000', 'APPROVED');

-- === b31: 视频生成 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Sora', 'OpenAI 推出的文本到视频生成模型', 'https://sora.com', 'https://api.dicebear.com/7.x/icons/svg?seed=sora&backgroundColor=10a37f', 'b3100000-0000-0000-0000-000000000000', 'APPROVED'),
('Runway Gen-3', '专业级 AI 视频生成与编辑平台', 'https://runwayml.com', 'https://api.dicebear.com/7.x/icons/svg?seed=runway&backgroundColor=111827', 'b3100000-0000-0000-0000-000000000000', 'APPROVED'),
('Pika', '简单易用的 AI 视频生成工具', 'https://pika.art', 'https://api.dicebear.com/7.x/icons/svg?seed=pika&backgroundColor=be185d', 'b3100000-0000-0000-0000-000000000000', 'APPROVED'),
('Kling', '快手出品的可灵 AI 视频生成', 'https://kling.kuaishou.com', 'https://api.dicebear.com/7.x/icons/svg?seed=kling&backgroundColor=ff6a00', 'b3100000-0000-0000-0000-000000000000', 'APPROVED'),
('Vidu', '生数科技出品的高清 AI 视频生成', 'https://www.vidu.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=vidu&backgroundColor=4f46e5', 'b3100000-0000-0000-0000-000000000000', 'APPROVED'),
('Luma Dream Machine', 'Luma AI 出品的逼真视频生成', 'https://lumalabs.ai/dream-machine', 'https://api.dicebear.com/7.x/icons/svg?seed=luma&backgroundColor=7c3aed', 'b3100000-0000-0000-0000-000000000000', 'APPROVED'),
('HeyGen', 'AI 数字人视频生成平台', 'https://www.heygen.com', 'https://api.dicebear.com/7.x/icons/svg?seed=heygen&backgroundColor=0891b2', 'b3100000-0000-0000-0000-000000000000', 'APPROVED'),
('剪映', '字节跳动出品的 AI 视频剪辑工具', 'https://www.capcut.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=capcut&backgroundColor=1e80ff', 'b3100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b32: 数字人播报 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('D-ID', 'AI 数字人面部动画与语音播报', 'https://www.d-id.com', 'https://api.dicebear.com/7.x/icons/svg?seed=did&backgroundColor=6366f1', 'b3200000-0000-0000-0000-000000000000', 'APPROVED'),
('Synthesia', '企业级 AI 数字人视频制作平台', 'https://www.synthesia.io', 'https://api.dicebear.com/7.x/icons/svg?seed=synthesia&backgroundColor=111827', 'b3200000-0000-0000-0000-000000000000', 'APPROVED'),
('Vidnoz', '免费 AI 数字人视频生成工具', 'https://www.vidnoz.com', 'https://api.dicebear.com/7.x/icons/svg?seed=vidnoz&backgroundColor=2563eb', 'b3200000-0000-0000-0000-000000000000', 'APPROVED');

-- === b33: 视频编辑 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Descript', 'AI 驱动的视频/音频编辑工作站', 'https://www.descript.com', 'https://api.dicebear.com/7.x/icons/svg?seed=descript&backgroundColor=dc2626', 'b3300000-0000-0000-0000-000000000000', 'APPROVED'),
('Opus Clip', 'AI 长视频自动剪辑为短视频', 'https://www.opus.pro', 'https://api.dicebear.com/7.x/icons/svg?seed=opus&backgroundColor=059669', 'b3300000-0000-0000-0000-000000000000', 'APPROVED'),
('Wondershare Filmora', '集成 AI 功能的视频剪辑软件', 'https://filmora.wondershare.com', 'https://api.dicebear.com/7.x/icons/svg?seed=filmora&backgroundColor=2563eb', 'b3300000-0000-0000-0000-000000000000', 'APPROVED');

-- === b41: UI/UX 设计 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Figma AI', 'Figma 内置 AI 设计辅助功能', 'https://www.figma.com', 'https://api.dicebear.com/7.x/icons/svg?seed=figma&backgroundColor=a259ff', 'b4100000-0000-0000-0000-000000000000', 'APPROVED'),
('Visily', 'AI 驱动的快速原型设计工具', 'https://www.visily.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=visily&backgroundColor=6366f1', 'b4100000-0000-0000-0000-000000000000', 'APPROVED'),
('Uizard', 'AI 将手绘稿转为 UI 设计稿', 'https://uizard.io', 'https://api.dicebear.com/7.x/icons/svg?seed=uizard&backgroundColor=7c3aed', 'b4100000-0000-0000-0000-000000000000', 'APPROVED'),
('Galileo AI', 'AI 从文本描述生成 UI 设计', 'https://www.usegalileo.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=galileo&backgroundColor=0891b2', 'b4100000-0000-0000-0000-000000000000', 'APPROVED'),
('MasterGo', '国产 AI 协同设计工具', 'https://mastergo.com', 'https://api.dicebear.com/7.x/icons/svg?seed=mastergo&backgroundColor=2563eb', 'b4100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b42: 平面与品牌设计 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Canva', 'AI 增强的在线平面设计平台', 'https://www.canva.com', 'https://api.dicebear.com/7.x/icons/svg?seed=canva&backgroundColor=00c4cc', 'b4200000-0000-0000-0000-000000000000', 'APPROVED'),
('Looka', 'AI 品牌 Logo 与视觉识别设计', 'https://looka.com', 'https://api.dicebear.com/7.x/icons/svg?seed=looka&backgroundColor=6366f1', 'b4200000-0000-0000-0000-000000000000', 'APPROVED'),
('Recraft', 'AI 生成矢量图标与品牌素材', 'https://www.recraft.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=recraft&backgroundColor=be185d', 'b4200000-0000-0000-0000-000000000000', 'APPROVED'),
('稿定设计', 'AI 辅助的国产在线设计平台', 'https://www.gaoding.com', 'https://api.dicebear.com/7.x/icons/svg?seed=gaoding&backgroundColor=ff6a00', 'b4200000-0000-0000-0000-000000000000', 'APPROVED');

-- === b43: 3D 设计 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Meshy', 'AI 文本/图片生成 3D 模型', 'https://www.meshy.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=meshy&backgroundColor=7c3aed', 'b4300000-0000-0000-0000-000000000000', 'APPROVED'),
('Luma AI', 'AI 3D 扫描与重建技术', 'https://lumalabs.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=luma3d&backgroundColor=0891b2', 'b4300000-0000-0000-0000-000000000000', 'APPROVED'),
('Spline AI', 'AI 辅助的 3D 网页设计工具', 'https://spline.design', 'https://api.dicebear.com/7.x/icons/svg?seed=spline&backgroundColor=ff6a00', 'b4300000-0000-0000-0000-000000000000', 'APPROVED'),
('CSM AI', 'AI 从单张图片生成 3D 模型', 'https://www.csm.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=csm&backgroundColor=6366f1', 'b4300000-0000-0000-0000-000000000000', 'APPROVED');

-- === b51: 音乐生成 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('Suno', 'AI 根据文本生成完整歌曲', 'https://suno.com', 'https://api.dicebear.com/7.x/icons/svg?seed=suno&backgroundColor=111827', 'b5100000-0000-0000-0000-000000000000', 'APPROVED'),
('Udio', '高质量 AI 音乐生成平台', 'https://www.udio.com', 'https://api.dicebear.com/7.x/icons/svg?seed=udio&backgroundColor=7c3aed', 'b5100000-0000-0000-0000-000000000000', 'APPROVED'),
('Stable Audio', 'Stability AI 出品的音频生成', 'https://www.stableaudio.com', 'https://api.dicebear.com/7.x/icons/svg?seed=stableaudio&backgroundColor=0891b2', 'b5100000-0000-0000-0000-000000000000', 'APPROVED'),
('天工音乐', '昆仑万维出品的 AI 音乐生成', 'https://music.tiangong.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=tiangong&backgroundColor=2563eb', 'b5100000-0000-0000-0000-000000000000', 'APPROVED'),
('AIVA', 'AI 古典音乐与配乐作曲', 'https://www.aiva.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=aiva&backgroundColor=be185d', 'b5100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b52: 语音合成 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('ElevenLabs', '业界领先的 AI 语音合成平台', 'https://elevenlabs.io', 'https://api.dicebear.com/7.x/icons/svg?seed=elevenlabs&backgroundColor=111827', 'b5200000-0000-0000-0000-000000000000', 'APPROVED'),
('Fish Audio', '开源 AI 语音克隆与合成', 'https://fish.audio', 'https://api.dicebear.com/7.x/icons/svg?seed=fishaudio&backgroundColor=0891b2', 'b5200000-0000-0000-0000-000000000000', 'APPROVED'),
('PlayHT', 'AI 文本转语音与语音克隆平台', 'https://play.ht', 'https://api.dicebear.com/7.x/icons/svg?seed=playht&backgroundColor=7c3aed', 'b5200000-0000-0000-0000-000000000000', 'APPROVED'),
('Azure Speech', '微软 Azure 云语音合成服务', 'https://azure.microsoft.com/zh-cn/products/ai-services/ai-speech', 'https://api.dicebear.com/7.x/icons/svg?seed=azure&backgroundColor=0078d4', 'b5200000-0000-0000-0000-000000000000', 'APPROVED');

-- === b53: 音频处理 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('Adobe Podcast', 'Adobe 出品的 AI 音频增强与降噪', 'https://podcast.adobe.com', 'https://api.dicebear.com/7.x/icons/svg?seed=adobepodcast&backgroundColor=ff0000', 'b5300000-0000-0000-0000-000000000000', 'APPROVED'),
('Auphonic', 'AI 音频后期处理与音量均衡', 'https://auphonic.com', 'https://api.dicebear.com/7.x/icons/svg?seed=auphonic&backgroundColor=2563eb', 'b5300000-0000-0000-0000-000000000000', 'APPROVED'),
(' Krisp', 'AI 实时降噪与音频增强', 'https://krisp.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=krisp&backgroundColor=6366f1', 'b5300000-0000-0000-0000-000000000000', 'APPROVED');

-- === b61: 桌面端 Agent ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('AutoGPT', '自主 AI 智能体，自动完成复杂任务', 'https://autogpt.net', 'https://api.dicebear.com/7.x/icons/svg?seed=autogpt&backgroundColor=111827', 'b6100000-0000-0000-0000-000000000000', 'APPROVED'),
('Claude Computer Use', 'Anthropic 推出的桌面操控 AI 智能体', 'https://docs.anthropic.com/en/docs/agents-and-tools/computer-use', 'https://api.dicebear.com/7.x/icons/svg?seed=computeruse&backgroundColor=d97706', 'b6100000-0000-0000-0000-000000000000', 'APPROVED'),
('OpenAI Operator', 'OpenAI 出品的浏览器自动化智能体', 'https://operator.chatgpt.com', 'https://api.dicebear.com/7.x/icons/svg?seed=operator&backgroundColor=10a37f', 'b6100000-0000-0000-0000-000000000000', 'APPROVED'),
('Manus', '通用 AI 智能体，自动执行复杂工作流', 'https://manus.im', 'https://api.dicebear.com/7.x/icons/svg?seed=manus&backgroundColor=6366f1', 'b6100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b62: 网页端 Agent ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('Dify', '开源 LLM 应用开发与智能体平台', 'https://dify.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=dify&backgroundColor=0891b2', 'b6200000-0000-0000-0000-000000000000', 'APPROVED'),
('Coze', '字节跳动出品的 AI Bot 构建平台', 'https://www.coze.com', 'https://api.dicebear.com/7.x/icons/svg?seed=coze&backgroundColor=1e80ff', 'b6200000-0000-0000-0000-000000000000', 'APPROVED'),
('扣子', '字节跳动出品的国内版 AI Bot 平台', 'https://www.coze.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=kouzi&backgroundColor=2563eb', 'b6200000-0000-0000-0000-000000000000', 'APPROVED'),
('百度智能体', '百度出品的 AI 智能体构建平台', 'https://agents.baidu.com', 'https://api.dicebear.com/7.x/icons/svg?seed=baiduagent&backgroundColor=2932e1', 'b6200000-0000-0000-0000-000000000000', 'APPROVED');

-- === b63: 工作流编排 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('n8n', '开源 AI 工作流自动化平台', 'https://n8n.io', 'https://api.dicebear.com/7.x/icons/svg?seed=n8n&backgroundColor=ea4c89', 'b6300000-0000-0000-0000-000000000000', 'APPROVED'),
('Zapier AI', 'AI 增强的无代码自动化平台', 'https://zapier.com', 'https://api.dicebear.com/7.x/icons/svg?seed=zapier&backgroundColor=ff4a00', 'b6300000-0000-0000-0000-000000000000', 'APPROVED'),
('Make', '可视化 AI 工作流编排平台', 'https://www.make.com', 'https://api.dicebear.com/7.x/icons/svg?seed=make&backgroundColor=6d28d9', 'b6300000-0000-0000-0000-000000000000', 'APPROVED'),
('LangChain', 'LLM 应用开发与编排框架', 'https://langchain.com', 'https://api.dicebear.com/7.x/icons/svg?seed=langchain&backgroundColor=0891b2', 'b6300000-0000-0000-0000-000000000000', 'APPROVED');

-- === b71: 笔记与写作 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('Notion AI', 'Notion 内置 AI 写作与知识管理', 'https://www.notion.so', 'https://api.dicebear.com/7.x/icons/svg?seed=notion&backgroundColor=111827', 'b7100000-0000-0000-0000-000000000000', 'APPROVED'),
('Obsidian', '本地优先的知识库与笔记工具', 'https://obsidian.md', 'https://api.dicebear.com/7.x/icons/svg?seed=obsidian&backgroundColor=7c3aed', 'b7100000-0000-0000-0000-000000000000', 'APPROVED'),
('飞书文档', '字节跳动出品的 AI 协同文档', 'https://www.feishu.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=feishu&backgroundColor=1e80ff', 'b7100000-0000-0000-0000-000000000000', 'APPROVED'),
('语雀', '阿里出品的 AI 知识库与文档工具', 'https://www.yuque.com', 'https://api.dicebear.com/7.x/icons/svg?seed=yuque&backgroundColor=00b96b', 'b7100000-0000-0000-0000-000000000000', 'APPROVED'),
('Jasper', 'AI 营销文案与内容创作平台', 'https://www.jasper.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=jasper&backgroundColor=6366f1', 'b7100000-0000-0000-0000-000000000000', 'APPROVED'),
('Grammarly', 'AI 英文写作助手与语法检查', 'https://www.grammarly.com', 'https://api.dicebear.com/7.x/icons/svg?seed=grammarly&backgroundColor=15c39a', 'b7100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b72: 演示与文档 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('Gamma', 'AI 一键生成演示文稿', 'https://gamma.app', 'https://api.dicebear.com/7.x/icons/svg?seed=gamma&backgroundColor=6366f1', 'b7200000-0000-0000-0000-000000000000', 'APPROVED'),
('Beautiful.ai', 'AI 智能排版的演示文稿工具', 'https://www.beautiful.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=beautifulai&backgroundColor=be185d', 'b7200000-0000-0000-0000-000000000000', 'APPROVED'),
('Tome', 'AI 叙事式演示文稿创作', 'https://tome.app', 'https://api.dicebear.com/7.x/icons/svg?seed=tome&Blueprint=7c3aed', 'b7200000-0000-0000-0000-000000000000', 'APPROVED'),
('MindShow', 'AI 一键生成思维导图与演示', 'https://mindshow.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=mindshow&backgroundColor=2563eb', 'b7200000-0000-0000-0000-000000000000', 'APPROVED');

-- === b73: 自动化办公 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('Microsoft Copilot', '微软 365 全系列 AI 办公助手', 'https://copilot.microsoft.com', 'https://api.dicebear.com/7.x/icons/svg?seed=microsoft&backgroundColor=0078d4', 'b7300000-0000-0000-0000-000000000000', 'APPROVED'),
('WPS AI', 'WPS 内置 AI 办公辅助功能', 'https://ai.wps.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=wps&backgroundColor=2563eb', 'b7300000-0000-0000-0000-000000000000', 'APPROVED'),
('Tableau AI', 'Tableau 内置 AI 数据分析与可视化', 'https://www.tableau.com', 'https://api.dicebear.com/7.x/icons/svg?seed=tableau&backgroundColor=1f77b4', 'b7300000-0000-0000-0000-000000000000', 'APPROVED');

-- === b81: 课程平台 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('DeepLearning.AI', '吴恩达出品的 AI 深度学习课程平台', 'https://www.deeplearning.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=deeplearning&backgroundColor=059669', 'b8100000-0000-0000-0000-000000000000', 'APPROVED'),
('Fast.ai', '面向程序员的实用深度学习课程', 'https://www.fast.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=fastai&backgroundColor=7c3aed', 'b8100000-0000-0000-0000-000000000000', 'APPROVED'),
('Coursera AI', 'Coursera 上的 AI 与机器学习专项课程', 'https://www.coursera.org/browse/data-science/machine-learning', 'https://api.dicebear.com/7.x/icons/svg?seed=coursera&backgroundColor=0056d2', 'b8100000-0000-0000-0000-000000000000', 'APPROVED'),
('李沐深度学习', '李沐《动手学深度学习》在线课程', 'https://d2l.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=d2l&backgroundColor=dc2626', 'b8100000-0000-0000-0000-000000000000', 'APPROVED'),
('吴恩达 CS229', '斯坦福经典机器学习课程', 'https://cs229.stanford.edu', 'https://api.dicebear.com/7.x/icons/svg?seed=cs229&backgroundColor=8b5cf6', 'b8100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b82: 社区与资讯 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('机器之心', '国内最专业的 AI 科技媒体', 'https://www.jiqizhixin.com', 'https://api.dicebear.com/7.x/icons/svg?seed=jiqizhixin&backgroundColor=2563eb', 'b8200000-0000-0000-0000-000000000000', 'APPROVED'),
('量子位', 'AI 前沿科技资讯与产业报道', 'https://www.qbitai.com', 'https://api.dicebear.com/7.x/icons/svg?seed=qbitai&backgroundColor=dc2626', 'b8200000-0000-0000-0000-000000000000', 'APPROVED'),
('36氪 AI', '36氪 AI 板块，关注 AI 商业动态', 'https://36kr.com/info/ai', 'https://api.dicebear.com/7.x/icons/svg?seed=36kr&backgroundColor=06c160', 'b8200000-0000-0000-0000-000000000000', 'APPROVED'),
('ArXiv', '全球最大的 AI 论文预印本平台', 'https://arxiv.org', 'https://api.dicebear.com/7.x/icons/svg?seed=arxiv&backgroundColor=111827', 'b8200000-0000-0000-0000-000000000000', 'APPROVED'),
('Papers With Code', 'AI 论文与代码实现索引', 'https://paperswithcode.com', 'https://api.dicebear.com/7.x/icons/svg?seed=paperswithcode&backgroundColor=0891b2', 'b8200000-0000-0000-0000-000000000000', 'APPROVED');

-- === b91: 图像生成 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('Midjourney', '目前画质最高的 AI 绘画工具', 'https://www.midjourney.com', 'https://api.dicebear.com/7.x/icons/svg?seed=midjourney&backgroundColor=111827', 'b9100000-0000-0000-0000-000000000000', 'APPROVED'),
('Stable Diffusion', '开源的顶级图像生成模型', 'https://stability.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=stability&backgroundColor=0891b2', 'b9100000-0000-0000-0000-000000000000', 'APPROVED'),
('DALL·E 3', 'OpenAI 出品的文本到图像生成', 'https://openai.com/dall-e-3', 'https://api.dicebear.com/7.x/icons/svg?seed=dalle&backgroundColor=10a37f', 'b9100000-0000-0000-0000-000000000000', 'APPROVED'),
('Adobe Firefly', 'Adobe 出品的 AI 图像生成', 'https://firefly.adobe.com', 'https://api.dicebear.com/7.x/icons/svg?seed=firefly&backgroundColor=ff0000', 'b9100000-0000-0000-0000-000000000000', 'APPROVED'),
('通义万相', '阿里云出品的 AI 图像生成', 'https://tongyi.aliyun.com/wanxiang', 'https://api.dicebear.com/7.x/icons/svg?seed=wanxiang&backgroundColor=ff6a00', 'b9100000-0000-0000-0000-000000000000', 'APPROVED'),
('文心一格', '百度出品的 AI 艺术创作平台', 'https://yige.baidu.com', 'https://api.dicebear.com/7.x/icons/svg?seed=yige&backgroundColor=2932e1', 'b9100000-0000-0000-0000-000000000000', 'APPROVED'),
('ComfyUI', '节点式 Stable Diffusion 工作流界面', 'https://www.comfy.org', 'https://api.dicebear.com/7.x/icons/svg?seed=comfyui&backgroundColor=6d28d9', 'b9100000-0000-0000-0000-000000000000', 'APPROVED'),
('Leonardo.ai', '游戏资产 AI 生成平台', 'https://leonardo.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=leonardo&backgroundColor=0891b2', 'b9100000-0000-0000-0000-000000000000', 'APPROVED');

-- === b92: 图像编辑 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('Clipdrop', 'Stability AI 出品的 AI 图像编辑套件', 'https://clipdrop.co', 'https://api.dicebear.com/7.x/icons/svg?seed=clipdrop&backgroundColor=7c3aed', 'b9200000-0000-0000-0000-000000000000', 'APPROVED'),
('Remove.bg', 'AI 一键去除图片背景', 'https://www.remove.bg', 'https://api.dicebear.com/7.x/icons/svg?seed=removebg&backgroundColor=059669', 'b9200000-0000-0000-0000-000000000000', 'APPROVED'),
('Cleanup.pictures', 'AI 图片去水印与修复', 'https://cleanup.pictures', 'https://api.dicebear.com/7.x/icons/svg?seed=cleanup&backgroundColor=6366f1', 'b9200000-0000-0000-0000-000000000000', 'APPROVED'),
('Magnific AI', 'AI 图像放大与增强', 'https://magnific.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=magnific&backgroundColor=be185d', 'b9200000-0000-0000-0000-000000000000', 'APPROVED'),
('Upscale.media', 'AI 图片无损放大与画质修复', 'https://upscale.media', 'https://api.dicebear.com/7.x/icons/svg?seed=upscale&backgroundColor=2563eb', 'b9200000-0000-0000-0000-000000000000', 'APPROVED');

-- === ba1: AI 搜索引擎 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('Perplexity', 'AI 驱动的对话式搜索引擎', 'https://www.perplexity.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=perplexity&backgroundColor=6366f1', 'ba100000-0000-0000-0000-000000000000', 'APPROVED'),
('Google AI Overviews', 'Google 搜索 AI 摘要功能', 'https://www.google.com', 'https://api.dicebear.com/7.x/icons/svg?seed=google&backgroundColor=4285f4', 'ba100000-0000-0000-0000-000000000000', 'APPROVED'),
('秘塔 AI 搜索', '国产 AI 搜索引擎，无广告直达', 'https://metaso.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=metaso&backgroundColor=2563eb', 'ba100000-0000-0000-0000-000000000000', 'APPROVED'),
('天工 AI 搜索', '昆仑万维出品的 AI 搜索引擎', 'https://www.tiangong.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=tiangongsearch&backgroundColor=0891b2', 'ba100000-0000-0000-0000-000000000000', 'APPROVED'),
('Devv', '面向开发者的 AI 搜索引擎', 'https://devv.ai', 'https://api.dicebear.com/7.x/icons/svg?seed=devv&backgroundColor=111827', 'ba100000-0000-0000-0000-000000000000', 'APPROVED'),
('Phind', '面向开发者的 AI 技术问答搜索', 'https://www.phind.com', 'https://api.dicebear.com/7.x/icons/svg?seed=phind&backgroundColor=7c3aed', 'ba100000-0000-0000-0000-000000000000', 'APPROVED');

-- === ba2: 聚合导航 ===
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES
('AI-Bot.cn', '最全的 AI 工具导航站', 'https://ai-bot.cn', 'https://api.dicebear.com/7.x/icons/svg?seed=aibot&backgroundColor=6366f1', 'ba200000-0000-0000-0000-000000000000', 'APPROVED'),
('Futurepedia', '海外最大的 AI 工具目录', 'https://www.futurepedia.io', 'https://api.dicebear.com/7.x/icons/svg?seed=futurepedia&backgroundColor=0891b2', 'ba200000-0000-0000-0000-000000000000', 'APPROVED'),
('There''s An AI For That', '按需求搜索 AI 工具', 'https://theresanaiforthat.com', 'https://api.dicebear.com/7.x/icons/svg?seed=thereisanai&backgroundColor=be185d', 'ba200000-0000-0000-0000-000000000000', 'APPROVED'),
('EasyWithAI', 'AI 工具发现与评测社区', 'https://easywithai.com', 'https://api.dicebear.com/7.x/icons/svg?seed=easywithai&backgroundColor=059669', 'ba200000-0000-0000-0000-000000000000', 'APPROVED');
INSERT INTO sites (name, description, url, icon, category_id, status) VALUES 
('ElevenLabs', '业界领先的 AI 语音合成平台', 'https://elevenlabs.io', 'https://api.dicebear.com/7.x/icons/svg?seed=elevenlabs&backgroundColor=111827', 'b5200000-0000-0000-0000-000000000000', 'APPROVED'),
('Fish Audio', '开源 AI 语音克隆与合成', 'https://fish.audio', 'https://api.dicebear.com/7.x/icons/svg?seed=fish