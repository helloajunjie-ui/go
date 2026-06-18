<template>
  <div class="zen-layout">
    <!-- 左侧：纯净索引 -->
    <aside class="zen-sidebar">
      <div class="zen-logo">
        Pure<span class="logo-accent">Nav</span>
      </div>

      <div class="zen-nav">
        <div v-for="l1 in categories" :key="l1.id" class="nav-group">
          <button
            class="nav-l1"
            :class="{ 'nav-l1--active': activeL1 === l1.id }"
            @click="scrollTo(l1.id, true)"
          >
            <span class="nav-l1-icon">{{ l1.icon }}</span>
            {{ l1.name }}
          </button>

          <div
            class="nav-children-wrap"
            :style="{ gridTemplateRows: activeL1 === l1.id ? '1fr' : '0fr' }"
          >
            <div class="nav-children">
              <button
                v-for="l2 in l1.children"
                :key="l2.id"
                class="nav-l2"
                @click.stop="scrollTo(l2.id, false)"
              >
                {{ l2.name }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </aside>

    <!-- 右侧：极简内容流 -->
    <main class="zen-content" ref="rightScrollRef">
      <div class="zen-content-inner">
        <section
          v-for="l1 in categories"
          :key="l1.id"
          :id="l1.id"
          class="scroll-section"
        >
          <h2 class="section-title">
            <span class="section-title-icon">{{ l1.icon }}</span>
            {{ l1.name }}
          </h2>

          <div
            v-for="l2 in l1.children"
            :key="l2.id"
            :id="l2.id"
            class="subsection"
          >
            <h3 class="subsection-title">{{ l2.name }}</h3>

            <div class="card-grid">
              <a
                v-for="tool in l2.tools"
                :key="tool.name"
                :href="tool.url"
                target="_blank"
                class="tool-card"
              >
                <div class="tool-card-header">
                  <img
                    :src="tool.icon"
                    class="tool-card-icon"
                    alt=""
                    @error="onIconError"
                  />
                  <span class="tool-card-name">{{ tool.name }}</span>
                </div>
                <p class="tool-card-desc">{{ tool.desc }}</p>
              </a>
            </div>
          </div>
        </section>

        <div class="content-bottom"></div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue';
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://ltxxqgdzwdxsmyttrndh.supabase.co';
const supabaseKey = 'sb_publishable_dEXB1daaGCziI29i3hDJAA_ctgmK-1S';
const supabase = createClient(supabaseUrl, supabaseKey);

const categories = ref([]);
const isDataLoaded = ref(false);
const activeL1 = ref(null);
const rightScrollRef = ref(null);
let observer = null;
let isClickScrolling = false;

onMounted(async () => {
  console.log('🚀 1. 开始向 Supabase 发起连接...');

  try {
    const [catsRes, sitesRes] = await Promise.all([
      supabase.from('categories').select('*').order('sort_order', { ascending: false }),
      supabase.from('sites').select('*').eq('status', 'APPROVED')
    ]);

    if (catsRes.error) throw new Error(`分类获取失败: ${catsRes.error.message}`);
    if (sitesRes.error) throw new Error(`站点获取失败: ${sitesRes.error.message}`);

    console.log('✅ 2. 数据拉取成功！', { 分类数量: catsRes.data.length, 站点数量: sitesRes.data.length });
    console.log('📦 数据库原始分类:', catsRes.data);
    console.log('📦 数据库原始站点:', sitesRes.data);

    const treeData = buildTree(catsRes.data, sitesRes.data);
    console.log('🌳 3. 树形结构组装完成:', treeData);

    categories.value = treeData;

    if (treeData.length > 0) {
      activeL1.value = treeData[0].id;
    }

    isDataLoaded.value = true;

    await nextTick();
    initScrollSpy();

  } catch (error) {
    console.error('❌ 致命错误：数据流转中断', error);
  }
});

function buildTree(flatCats, flatSites) {
  const l2Map = {};

  flatCats.filter(c => c.parent_id).forEach(c => {
    l2Map[c.id] = { id: c.id, name: c.name, tools: [] };
  });

  flatSites.forEach(s => {
    if (l2Map[s.category_id]) {
      l2Map[s.category_id].tools.push({
        name: s.name,
        desc: s.description,
        url: s.url,
        icon: s.icon
      });
    }
  });

  return flatCats
    .filter(c => !c.parent_id)
    .map(l1 => ({
      id: l1.id,
      name: l1.name,
      icon: l1.icon,
      children: flatCats
        .filter(c => c.parent_id === l1.id)
        .map(c => l2Map[c.id])
    }));
}

function initScrollSpy() {
  if (!rightScrollRef.value) return;
  const options = { root: rightScrollRef.value, rootMargin: '-30% 0px -60% 0px', threshold: 0 };
  observer = new IntersectionObserver((entries) => {
    if (isClickScrolling) return;
    entries.forEach(entry => {
      if (entry.isIntersecting) activeL1.value = entry.target.id;
    });
  }, options);

  document.querySelectorAll('.scroll-section').forEach(sec => observer.observe(sec));
}

const scrollTo = (id, isL1 = true) => {
  if (isL1) activeL1.value = id;
  const target = document.getElementById(id);
  if (target) {
    isClickScrolling = true;
    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    setTimeout(() => { isClickScrolling = false; }, 800);
  }
};
</script>

<style>
/* ===== 全局重置 ===== */
.zen-layout * {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

/* ===== 布局 ===== */
.zen-layout {
  display: flex;
  height: 100vh;
  width: 100%;
  background: #f9fafb;
  color: #1f2937;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  overflow: hidden;
}

/* ===== 左侧边栏 ===== */
.zen-sidebar {
  width: 240px;
  background: #fff;
  border-right: 1px solid #f3f4f6;
  display: flex;
  flex-direction: column;
  z-index: 10;
  box-shadow: 4px 0 24px rgba(0, 0, 0, 0.02);
  flex-shrink: 0;
}

.zen-logo {
  height: 64px;
  display: flex;
  align-items: center;
  padding: 0 24px;
  font-size: 20px;
  font-weight: 900;
  letter-spacing: -0.03em;
  border-bottom: 1px solid #f9fafb;
  margin-bottom: 16px;
}

.logo-accent {
  color: #2563eb;
}

/* ===== 导航 ===== */
.zen-nav {
  flex: 1;
  overflow-y: auto;
  padding: 0 12px 32px;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.zen-nav::-webkit-scrollbar {
  width: 4px;
}
.zen-nav::-webkit-scrollbar-track {
  background: transparent;
}
.zen-nav::-webkit-scrollbar-thumb {
  background-color: #e5e7eb;
  border-radius: 10px;
}
.zen-nav:hover::-webkit-scrollbar-thumb {
  background-color: #d1d5db;
}

.nav-group {
  display: flex;
  flex-direction: column;
}

.nav-l1 {
  width: 100%;
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 12px;
  border-radius: 10px;
  font-size: 14px;
  font-weight: 500;
  border: none;
  background: none;
  cursor: pointer;
  color: #6b7280;
  transition: all 0.2s ease;
  text-align: left;
}

.nav-l1:hover {
  background: #f9fafb;
  color: #374151;
}

.nav-l1--active {
  background: #eff6ff;
  color: #2563eb;
  font-weight: 600;
  box-shadow: 0 1px 3px rgba(37, 99, 235, 0.06);
}

.nav-l1-icon {
  font-size: 16px;
  width: 24px;
  text-align: center;
  flex-shrink: 0;
}

/* 手风琴 0fr → 1fr */
.nav-children-wrap {
  display: grid;
  transition: grid-template-rows 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.nav-children {
  overflow: hidden;
  padding-left: 34px;
  padding-right: 8px;
  padding-top: 4px;
  padding-bottom: 4px;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.nav-l2 {
  text-align: left;
  font-size: 12px;
  padding: 6px 10px;
  border-radius: 6px;
  border: none;
  background: none;
  cursor: pointer;
  color: #9ca3af;
  transition: color 0.15s;
}

.nav-l2:hover {
  color: #2563eb;
}

/* ===== 右侧内容 ===== */
.zen-content {
  flex: 1;
  overflow-y: auto;
  scroll-behavior: smooth;
}

.zen-content::-webkit-scrollbar {
  width: 5px;
}
.zen-content::-webkit-scrollbar-track {
  background: transparent;
}
.zen-content::-webkit-scrollbar-thumb {
  background-color: #e5e7eb;
  border-radius: 10px;
}
.zen-content:hover::-webkit-scrollbar-thumb {
  background-color: #d1d5db;
}

.zen-content-inner {
  padding: 32px 32px;
  display: flex;
  flex-direction: column;
  gap: 40px;
}

/* ===== 分类标题 ===== */
.section-title {
  font-size: 22px;
  font-weight: 800;
  display: flex;
  align-items: center;
  gap: 10px;
  color: #111827;
  border-bottom: 1px solid #f3f4f6;
  padding-bottom: 12px;
  margin-bottom: 0;
}

.section-title-icon {
  font-size: 22px;
}

/* ===== 子分类 ===== */
.subsection {
  margin-top: 20px;
}

.subsection-title {
  font-size: 14px;
  font-weight: 600;
  color: #6b7280;
  margin-bottom: 12px;
  padding-left: 8px;
  border-left: 3px solid #d1d5db;
}

/* ===== 卡片网格 ===== */
.card-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}

@media (min-width: 768px) {
  .card-grid { grid-template-columns: repeat(3, 1fr); }
}
@media (min-width: 1024px) {
  .card-grid { grid-template-columns: repeat(4, 1fr); }
}
@media (min-width: 1440px) {
  .card-grid { grid-template-columns: repeat(5, 1fr); }
}
@media (min-width: 1920px) {
  .card-grid { grid-template-columns: repeat(6, 1fr); }
}

/* ===== 工具卡片 ===== */
.tool-card {
  display: flex;
  flex-direction: column;
  gap: 8px;
  background: #fff;
  border-radius: 12px;
  padding: 14px;
  border: 1px solid rgba(243, 244, 246, 0.8);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
  text-decoration: none;
  transition: all 0.3s ease;
  cursor: pointer;
}

.tool-card:hover {
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
  border-color: #e5e7eb;
  transform: translateY(-4px);
}

.tool-card-header {
  display: flex;
  align-items: center;
  gap: 10px;
}

.tool-card-icon {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  background: #f9fafb;
  object-fit: cover;
  border: 1px solid #f3f4f6;
  flex-shrink: 0;
}

.tool-card-name {
  font-size: 14px;
  font-weight: 600;
  color: #111827;
  transition: color 0.2s;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.tool-card:hover .tool-card-name {
  color: #2563eb;
}

.tool-card-desc {
  font-size: 12px;
  color: #9ca3af;
  line-height: 1.6;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* ===== 底部占位 ===== */
.content-bottom {
  height: 50vh;
}
</style>
