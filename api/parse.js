// 智能爬虫解析引擎 — 可部署于 Vercel Edge / Cloudflare Workers
// 依赖: npm install cheerio

import * as cheerio from 'cheerio'

// 私有 IP 段检测（SSRF 防护）
const PRIVATE_RANGES = [
  /^127\./,
  /^10\./,
  /^172\.(1[6-9]|2\d|3[01])\./,
  /^192\.168\./,
  /^0\./,
  /^169\.254\./,
  /^fc00:/i,
  /^fe80:/i,
  /^::1$/,
  /^localhost$/i
]

function isPrivateHost(hostname) {
  return PRIVATE_RANGES.some(re => re.test(hostname))
}

export async function parseWebsiteMeta(url) {
  // 1. 基础校验
  if (!url || typeof url !== 'string') return { error: 'URL 不能为空' }
  url = url.trim()
  if (!/^https?:\/\//i.test(url)) {
    url = 'https://' + url
  }

  let urlObj
  try {
    urlObj = new URL(url)
  } catch {
    return { error: 'URL 格式无效' }
  }

  // 2. SSRF 防护：拒绝内网 IP
  if (isPrivateHost(urlObj.hostname)) {
    return { error: '不允许解析内网地址' }
  }

  // 3. 带超时的 Fetch
  try {
    const controller = new AbortController()
    const timeout = setTimeout(() => controller.abort(), 3500)

    const response = await fetch(url, {
      signal: controller.signal,
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
      }
    })
    clearTimeout(timeout)

    if (!response.ok) {
      return { url, title: '', description: '', iconUrl: '' }
    }

    const html = await response.text()
    const $ = cheerio.load(html)

    // 4. 瀑布流信息提取
    const title =
      $('meta[property="og:title"]').attr('content') ||
      $('meta[name="twitter:title"]').attr('content') ||
      $('title').text() ||
      urlObj.hostname

    const description =
      $('meta[property="og:description"]').attr('content') ||
      $('meta[name="description"]').attr('content') ||
      $('meta[name="twitter:description"]').attr('content') ||
      ''

    // 5. 图标提取
    let iconUrl =
      $('link[rel="apple-touch-icon"]').attr('href') ||
      $('link[rel="apple-touch-icon-precomposed"]').attr('href') ||
      $('link[rel="icon"]').attr('href') ||
      $('link[rel="shortcut icon"]').attr('href')

    if (iconUrl && !iconUrl.startsWith('http')) {
      iconUrl = new URL(iconUrl, urlObj.origin).href
    } else if (!iconUrl) {
      iconUrl = `${urlObj.origin}/favicon.ico`
    }

    return {
      url: urlObj.href,
      title: title.trim().substring(0, 200),
      description: description.trim().substring(0, 300),
      iconUrl
    }
  } catch {
    return { url, title: '', description: '', iconUrl: '' }
  }
}
