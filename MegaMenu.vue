<template>
  <div
    class="mega-menu"
    @mouseleave="handleMouseLeave"
    @keydown="handleKeydown"
    ref="menuEl"
  >
    <!-- L1: 左侧主分类 -->
    <div class="l1-bar">
      <div
        v-for="item in data"
        :key="item.id"
        class="l1-item"
        :class="{ active: activeL1 === item.id }"
        @mouseenter="handleL1Enter($event, item.id)"
        tabindex="0"
        @keydown.enter="handleL1Enter($event, item.id)"
        @keydown.space.prevent="handleL1Enter($event, item.id)"
      >
        <span v-if="item.icon" class="l1-icon">{{ item.icon }}</span>
        <span>{{ item.name }}</span>
        <span v-if="item.tag" class="l1-tag" :class="item.tag.toLowerCase()">{{ item.tag }}</span>
      </div>
    </div>

    <!-- L2 & L3 右侧浮动面板 -->
    <transition name="panel-fade">
      <div
        v-if="activeL1"
        class="l2-panel"
        @mouseenter="clearLeaveTimer"
        @mousemove="onL2MouseMove"
      >
        <!-- L2 内容 -->
        <div class="l2-content" :class="{ 'l2-pushed': activeL2 }">
          <div class="l2-header">
            <h3>{{ getL1Item(activeL1)?.name }}</h3>
            <span class="l2-subtitle">二级分类</span>
          </div>
          <div class="l2-grid">
            <div
              v-for="l2 in getL1Item(activeL1)?.children || []"
              :key="l2.id"
              class="l2-card"
              @mouseenter="handleL2Enter(l2.id)"
              @click="handleL2Click(l2.id)"
              tabindex="0"
              @keydown.enter="handleL2Click(l2.id)"
              @keydown.space.prevent="handleL2Click(l2.id)"
            >
              <span class="l2-name">{{ l2.name }}</span>
              <span v-if="l2.tag" class="l2-tag" :class="l2.tag.toLowerCase()">{{ l2.tag }}</span>
            </div>
          </div>
          <!-- 运营位 -->
          <div v-if="getL1Item(activeL1)?.marketingProps" class="l2-marketing">
            <img
              :src="getL1Item(activeL1)?.marketingProps?.image"
              alt=""
              style="background: #f0f0f0;"
            />
          </div>
        </div>

        <!-- L3 抽屉 -->
        <transition name="drawer-slide">
          <div v-if="activeL2" class="l3-drawer">
            <button class="l3-back" @click="activeL2 = null" tabindex="0">
              <span class="back-arrow">←</span> 返回
            </button>
            <h3 class="l3-title">{{ getL2Item(activeL1, activeL2)?.name }}</h3>
            <div class="l3-body">
              <div
                v-for="l3 in getL2Item(activeL1, activeL2)?.children || []"
                :key="l3.id"
                class="l3-item"
                tabindex="0"
              >
                {{ l3.name }}
              </div>
              <!-- 骨架屏占位 -->
              <div v-if="!getL2Item(activeL1, activeL2)?.children?.length" class="l3-skeleton">
                <div class="skeleton-line" v-for="i in 4" :key="i"></div>
              </div>
            </div>
          </div>
        </transition>
      </div>
    </transition>
  </div>
</template>

<script>
export default {
  name: 'MegaMenu',
  props: {
    data: { type: Array, default: () => [] }
  },
  data() {
    return {
      activeL1: null,
      activeL2: null,
      leaveTimer: null,
      l1EnterTimer: null,
      // 向量防误触
      mousePrev: null,
      l2Rect: null
    }
  },
  mounted() {
    document.addEventListener('keydown', this.globalKeydown)
  },
  beforeUnmount() {
    document.removeEventListener('keydown', this.globalKeydown)
  },
  methods: {
    getL1Item(id) {
      return this.data.find(d => d.id === id)
    },
    getL2Item(l1Id, l2Id) {
      const l1 = this.getL1Item(l1Id)
      return l1?.children?.find(c => c.id === l2Id) || null
    },
    clearLeaveTimer() {
      if (this.leaveTimer) { clearTimeout(this.leaveTimer); this.leaveTimer = null }
    },
    clearL1Timer() {
      if (this.l1EnterTimer) { clearTimeout(this.l1EnterTimer); this.l1EnterTimer = null }
    },

    // ===== 升级1: 向量防误触 (True Hover Intent) =====
    handleL1Enter(e, id) {
      this.clearL1Timer()
      this.clearLeaveTimer()

      const cur = { x: e.clientX, y: e.clientY }

      // 判断移动方向
      let isVertical = false
      if (this.mousePrev) {
        const dx = cur.x - this.mousePrev.x
        const dy = Math.abs(cur.y - this.mousePrev.y)
        // 水平位移很小 或 垂直位移远大于水平位移 → 垂直移动
        if (Math.abs(dx) < 5 || dy > Math.abs(dx) * 1.5) {
          isVertical = true
        }
      }
      this.mousePrev = cur

      if (isVertical) {
        // 垂直浏览 → 0ms 瞬间切换
        this.activeL1 = id
        this.activeL2 = null
        this.l2Rect = null
      } else {
        // 斜向/横向 → 300ms 延迟（防误触）
        this.l1EnterTimer = setTimeout(() => {
          this.activeL1 = id
          this.activeL2 = null
          this.l2Rect = null
        }, 300)
      }
    },

    onL2MouseMove() {
      // 进入 L2 面板后重置向量记录，避免回到 L1 时误判
      this.mousePrev = null
    },

    handleL2Enter(id) {
      this.clearLeaveTimer()
      this.activeL2 = id
    },
    handleL2Click(id) {
      this.activeL2 = id
    },
    handleMouseLeave() {
      this.clearL1Timer()
      this.clearLeaveTimer()
      this.mousePrev = null
      this.l2Rect = null
      this.leaveTimer = setTimeout(() => {
        this.activeL1 = null
        this.activeL2 = null
      }, 200)
    },

    // ===== 升级3: 键盘与焦点接管 (A11y) =====
    globalKeydown(e) {
      if (e.key === 'Escape') {
        if (this.activeL2) {
          this.activeL2 = null
          e.preventDefault()
        } else if (this.activeL1) {
          this.activeL1 = null
          e.preventDefault()
        }
      }
    },
    handleKeydown(e) {
      if (e.key === 'Escape') {
        if (this.activeL2) {
          this.activeL2 = null
          e.preventDefault()
        } else if (this.activeL1) {
          this.activeL1 = null
          e.preventDefault()
        }
      }
    }
  }
}
</script>

<style>
/* ===== 全局重置 ===== */
.mega-menu * {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

/* ===== 容器 ===== */
.mega-menu {
  position: relative;
  display: flex;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  font-size: 14px;
  color: #1a1a2e;
  user-select: none;
  outline: none;
}

/* ===== L1 左侧栏 ===== */
.l1-bar {
  width: 220px;
  background: #fff;
  border-right: 1px solid #f0f0f0;
  display: flex;
  flex-direction: column;
  z-index: 20;
  position: relative;
}

.l1-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 20px;
  cursor: pointer;
  transition: all 0.15s ease;
  border-left: 3px solid transparent;
  position: relative;
  outline: none;
}

.l1-item:hover {
  background: #f8f9ff;
}

.l1-item.active {
  background: #eef1ff;
  border-left-color: #4f6ef7;
  color: #4f6ef7;
  font-weight: 600;
}

.l1-item:focus-visible {
  background: #f0f2ff;
  border-left-color: #4f6ef7;
}

.l1-icon {
  font-size: 18px;
  width: 24px;
  text-align: center;
}

.l1-tag {
  font-size: 10px;
  padding: 1px 6px;
  border-radius: 10px;
  font-weight: 600;
  margin-left: auto;
}

.l1-tag.hot {
  background: #fee2e2;
  color: #dc2626;
}

.l1-tag.new {
  background: #dbeafe;
  color: #2563eb;
}

/* ===== L2 右侧面板 ===== */
.l2-panel {
  position: absolute;
  left: 220px;
  top: 0;
  width: 780px;
  min-height: 480px;
  background: #fff;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
  border-radius: 0 16px 16px 0;
  overflow: hidden;
  z-index: 10;
  display: flex;
}

.l2-content {
  width: 100%;
  padding: 32px;
  transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
  position: relative;
}

.l2-content.l2-pushed {
  transform: translateX(-40px);
  opacity: 0.5;
}

.l2-header {
  margin-bottom: 24px;
}

.l2-header h3 {
  font-size: 22px;
  font-weight: 800;
  color: #1a1a2e;
}

.l2-subtitle {
  font-size: 13px;
  color: #94a3b8;
  margin-top: 4px;
  display: block;
}

.l2-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.l2-card {
  padding: 16px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
  border: 1px solid transparent;
  outline: none;
}

.l2-card:hover {
  background: #f8f9ff;
  border-color: #e8ecff;
}

.l2-card:focus-visible {
  background: #f8f9ff;
  border-color: #4f6ef7;
}

.l2-card:hover .l2-name {
  color: #4f6ef7;
}

.l2-name {
  font-weight: 600;
  transition: color 0.2s;
  display: block;
}

.l2-tag {
  font-size: 10px;
  padding: 1px 6px;
  border-radius: 10px;
  font-weight: 600;
  margin-top: 6px;
  display: inline-block;
}

.l2-tag.hot {
  background: #fee2e2;
  color: #dc2626;
}

.l2-tag.new {
  background: #dbeafe;
  color: #2563eb;
}

.l2-marketing {
  margin-top: 24px;
  border-radius: 12px;
  overflow: hidden;
}

.l2-marketing img {
  width: 100%;
  height: 100px;
  object-fit: cover;
  display: block;
}

/* ===== L3 抽屉 ===== */
.l3-drawer {
  position: absolute;
  inset: 0;
  background: rgba(255, 255, 255, 0.97);
  backdrop-filter: blur(12px);
  z-index: 30;
  padding: 32px;
  border-left: 1px solid #f0f0f0;
  box-shadow: -10px 0 30px rgba(0, 0, 0, 0.05);
  overflow-y: auto;
}

.l3-back {
  display: flex;
  align-items: center;
  gap: 6px;
  background: none;
  border: none;
  color: #94a3b8;
  font-size: 14px;
  cursor: pointer;
  padding: 0;
  margin-bottom: 20px;
  transition: color 0.2s;
  outline: none;
}

.l3-back:hover {
  color: #1a1a2e;
}

.l3-back:focus-visible {
  color: #4f6ef7;
}

.back-arrow {
  font-size: 16px;
}

.l3-title {
  font-size: 24px;
  font-weight: 900;
  margin-bottom: 20px;
  color: #1a1a2e;
}

.l3-body {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding-bottom: 40px;
}

.l3-item {
  padding: 12px 16px;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.15s;
  outline: none;
}

.l3-item:hover {
  background: #f8f9ff;
}

.l3-item:focus-visible {
  background: #f0f2ff;
}

/* 骨架屏 */
.l3-skeleton {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.skeleton-line {
  height: 16px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e8e8e8 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite;
  border-radius: 4px;
}

.skeleton-line:nth-child(1) { width: 80%; }
.skeleton-line:nth-child(2) { width: 60%; }
.skeleton-line:nth-child(3) { width: 70%; }
.skeleton-line:nth-child(4) { width: 50%; }

@keyframes shimmer {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

/* ===== 过渡动画 ===== */
.panel-fade-enter-active {
  transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
}
.panel-fade-leave-active {
  transition: all 0.15s ease;
}
.panel-fade-enter-from {
  opacity: 0;
  transform: translateX(-10px);
}
.panel-fade-leave-to {
  opacity: 0;
}

.drawer-slide-enter-active {
  transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
}
.drawer-slide-leave-active {
  transition: all 0.2s ease;
}
.drawer-slide-enter-from {
  transform: translateX(100%);
  opacity: 0;
}
.drawer-slide-leave-to {
  transform: translateX(100%);
  opacity: 0;
}
</style>
