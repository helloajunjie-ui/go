<template>
  <div class="app">
    <header class="app-header">
      <div class="logo">LOGO</div>
      <MegaMenu :data="navData" />
    </header>
  </div>
</template>

<script>
import MegaMenu from './MegaMenu.vue'

export default {
  name: 'App',
  components: { MegaMenu },
  data() {
    return {
      navData: [
        {
          id: 'cat-1',
          parentId: null,
          name: '电子产品',
          icon: '📱',
          tag: 'HOT',
          isLeaf: false,
          marketingProps: {
            image: 'https://picsum.photos/seed/electronics/780/100',
            link: '/promo/electronics'
          },
          children: [
            {
              id: 'cat-1-1',
              parentId: 'cat-1',
              name: '智能手机',
              tag: 'NEW',
              isLeaf: false,
              children: [
                { id: 'cat-1-1-1', parentId: 'cat-1-1', name: 'iPhone 15 Pro', isLeaf: true },
                { id: 'cat-1-1-2', parentId: 'cat-1-1', name: 'Samsung Galaxy S24', isLeaf: true },
                { id: 'cat-1-1-3', parentId: 'cat-1-1', name: '小米 14 Ultra', isLeaf: true },
                { id: 'cat-1-1-4', parentId: 'cat-1-1', name: 'OPPO Find X7', isLeaf: true }
              ]
            },
            {
              id: 'cat-1-2',
              parentId: 'cat-1',
              name: '笔记本电脑',
              isLeaf: false,
              children: [
                { id: 'cat-1-2-1', parentId: 'cat-1-2', name: 'MacBook Pro 14"', isLeaf: true },
                { id: 'cat-1-2-2', parentId: 'cat-1-2', name: 'ThinkPad X1 Carbon', isLeaf: true },
                { id: 'cat-1-2-3', parentId: 'cat-1-2', name: 'ROG 幻 16', isLeaf: true }
              ]
            },
            {
              id: 'cat-1-3',
              parentId: 'cat-1',
              name: '平板电脑',
              isLeaf: false,
              children: [
                { id: 'cat-1-3-1', parentId: 'cat-1-3', name: 'iPad Pro M4', isLeaf: true },
                { id: 'cat-1-3-2', parentId: 'cat-1-3', name: '华为 MatePad Pro', isLeaf: true }
              ]
            },
            {
              id: 'cat-1-4',
              parentId: 'cat-1',
              name: '智能穿戴',
              isLeaf: false,
              children: [
                { id: 'cat-1-4-1', parentId: 'cat-1-4', name: 'Apple Watch Ultra', isLeaf: true },
                { id: 'cat-1-4-2', parentId: 'cat-1-4', name: '小米手环 9', isLeaf: true }
              ]
            },
            {
              id: 'cat-1-5',
              parentId: 'cat-1',
              name: '耳机音箱',
              isLeaf: false,
              children: [
                { id: 'cat-1-5-1', parentId: 'cat-1-5', name: 'AirPods Pro 2', isLeaf: true },
                { id: 'cat-1-5-2', parentId: 'cat-1-5', name: 'Sony WH-1000XM5', isLeaf: true }
              ]
            },
            {
              id: 'cat-1-6',
              parentId: 'cat-1',
              name: '相机摄影',
              isLeaf: false,
              children: [
                { id: 'cat-1-6-1', parentId: 'cat-1-6', name: 'Sony A7 IV', isLeaf: true },
                { id: 'cat-1-6-2', parentId: 'cat-1-6', name: '富士 X-T5', isLeaf: true }
              ]
            }
          ]
        },
        {
          id: 'cat-2',
          parentId: null,
          name: '服装鞋帽',
          icon: '👕',
          isLeaf: false,
          children: [
            {
              id: 'cat-2-1',
              parentId: 'cat-2',
              name: '男装',
              isLeaf: false,
              children: [
                { id: 'cat-2-1-1', parentId: 'cat-2-1', name: '西装', isLeaf: true },
                { id: 'cat-2-1-2', parentId: 'cat-2-1', name: '休闲夹克', isLeaf: true },
                { id: 'cat-2-1-3', parentId: 'cat-2-1', name: '衬衫', isLeaf: true }
              ]
            },
            {
              id: 'cat-2-2',
              parentId: 'cat-2',
              name: '女装',
              isLeaf: false,
              children: [
                { id: 'cat-2-2-1', parentId: 'cat-2-2', name: '连衣裙', isLeaf: true },
                { id: 'cat-2-2-2', parentId: 'cat-2-2', name: '针织衫', isLeaf: true },
                { id: 'cat-2-2-3', parentId: 'cat-2-2', name: '半身裙', isLeaf: true }
              ]
            },
            {
              id: 'cat-2-3',
              parentId: 'cat-2',
              name: '运动鞋',
              tag: 'HOT',
              isLeaf: false,
              children: [
                { id: 'cat-2-3-1', parentId: 'cat-2-3', name: 'Nike Air Max', isLeaf: true },
                { id: 'cat-2-3-2', parentId: 'cat-2-3', name: 'Adidas Ultraboost', isLeaf: true }
              ]
            }
          ]
        },
        {
          id: 'cat-3',
          parentId: null,
          name: '家居生活',
          icon: '🏠',
          isLeaf: false,
          children: [
            {
              id: 'cat-3-1',
              parentId: 'cat-3',
              name: '家具',
              isLeaf: false,
              children: [
                { id: 'cat-3-1-1', parentId: 'cat-3-1', name: '沙发', isLeaf: true },
                { id: 'cat-3-1-2', parentId: 'cat-3-1', name: '床', isLeaf: true },
                { id: 'cat-3-1-3', parentId: 'cat-3-1', name: '书桌', isLeaf: true }
              ]
            },
            {
              id: 'cat-3-2',
              parentId: 'cat-3',
              name: '厨房用品',
              isLeaf: false,
              children: [
                { id: 'cat-3-2-1', parentId: 'cat-3-2', name: '锅具套装', isLeaf: true },
                { id: 'cat-3-2-2', parentId: 'cat-3-2', name: '餐具', isLeaf: true }
              ]
            },
            {
              id: 'cat-3-3',
              parentId: 'cat-3',
              name: '家纺',
              isLeaf: false,
              children: [
                { id: 'cat-3-3-1', parentId: 'cat-3-3', name: '四件套', isLeaf: true },
                { id: 'cat-3-3-2', parentId: 'cat-3-3', name: '被子', isLeaf: true }
              ]
            }
          ]
        },
        {
          id: 'cat-4',
          parentId: null,
          name: '美妆个护',
          icon: '💄',
          tag: 'NEW',
          isLeaf: false,
          children: [
            {
              id: 'cat-4-1',
              parentId: 'cat-4',
              name: '面部护肤',
              isLeaf: false,
              children: [
                { id: 'cat-4-1-1', parentId: 'cat-4-1', name: '精华液', isLeaf: true },
                { id: 'cat-4-1-2', parentId: 'cat-4-1', name: '面霜', isLeaf: true },
                { id: 'cat-4-1-3', parentId: 'cat-4-1', name: '面膜', isLeaf: true }
              ]
            },
            {
              id: 'cat-4-2',
              parentId: 'cat-4',
              name: '彩妆',
              isLeaf: false,
              children: [
                { id: 'cat-4-2-1', parentId: 'cat-4-2', name: '口红', isLeaf: true },
                { id: 'cat-4-2-2', parentId: 'cat-4-2', name: '粉底液', isLeaf: true }
              ]
            }
          ]
        },
        {
          id: 'cat-5',
          parentId: null,
          name: '图书文娱',
          icon: '📚',
          isLeaf: false,
          children: [
            {
              id: 'cat-5-1',
              parentId: 'cat-5',
              name: '文学小说',
              isLeaf: false,
              children: [
                { id: 'cat-5-1-1', parentId: 'cat-5-1', name: '科幻', isLeaf: true },
                { id: 'cat-5-1-2', parentId: 'cat-5-1', name: '悬疑', isLeaf: true },
                { id: 'cat-5-1-3', parentId: 'cat-5-1', name: '经典文学', isLeaf: true }
              ]
            },
            {
              id: 'cat-5-2',
              parentId: 'cat-5',
              name: '动漫周边',
              isLeaf: false,
              children: [
                { id: 'cat-5-2-1', parentId: 'cat-5-2', name: '手办', isLeaf: true },
                { id: 'cat-5-2-2', parentId: 'cat-5-2', name: '盲盒', isLeaf: true }
              ]
            }
          ]
        }
      ]
    }
  }
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  background: #f5f6fa;
}

.app {
  min-height: 100vh;
}

.app-header {
  background: #fff;
  border-bottom: 1px solid #f0f0f0;
  padding: 0 40px;
  display: flex;
  align-items: flex-start;
  position: relative;
}

.logo {
  font-size: 24px;
  font-weight: 900;
  color: #4f6ef7;
  padding: 20px 40px 20px 0;
  white-space: nowrap;
}
</style>
