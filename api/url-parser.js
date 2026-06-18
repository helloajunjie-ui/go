export default {
  async fetch(request) {
    const corsHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,OPTIONS",
      "Access-Control-Max-Age": "86400",
    };
    if (request.method === "OPTIONS") return new Response(null, { headers: corsHeaders });

    const url = new URL(request.url).searchParams.get("url");
    if (!url) return new Response("缺少 URL 参数", { status: 400, headers: corsHeaders });

    try {
      const targetRes = await fetch(url, {
        headers: { "User-Agent": "Mozilla/5.0 (compatible; PureNavBot/1.0; +http://yourwebsite.com)" }
      });

      let title = "";
      let description = "";

      const rewriter = new HTMLRewriter()
        .on("title", { text(text) { title += text.text; } })
        .on('meta[name="description"]', {
          element(element) { description = element.getAttribute("content") || description; }
        })
        .on('meta[property="og:description"]', {
          element(element) { description = element.getAttribute("content") || description; }
        });

      await rewriter.transform(targetRes).text();

      const result = {
        url: url,
        title: title.trim(),
        description: description.trim(),
        icon: `https://www.google.com/s2/favicons?domain=${new URL(url).hostname}&sz=64`
      };

      return new Response(JSON.stringify(result), {
        headers: { "Content-Type": "application/json", ...corsHeaders }
      });

    } catch (err) {
      return new Response(JSON.stringify({ error: "解析失败，目标网站可能设置了防爬防火墙" }), { 
        status: 500, headers: { "Content-Type": "application/json", ...corsHeaders } 
      });
    }
  }
};
