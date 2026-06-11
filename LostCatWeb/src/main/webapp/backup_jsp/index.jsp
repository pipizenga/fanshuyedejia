<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>流浪猫领养中心 | 让爱不再流浪</title>
  <link rel="stylesheet" href="style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<header>
  <div class="header-container">
    <a href="index.jsp" class="logo"><i class="fas fa-cat"></i> 流浪猫领养中心</a>
    <div class="menu-toggle" onclick="document.getElementById('main-nav').classList.toggle('active')">
      <i class="fas fa-bars"></i>
    </div>
    <nav id="main-nav">
      <a href="index.jsp">首页</a>
      <a href="list.jsp">寻猫启示</a>
      <a href="adopt.jsp">领养申请</a>
      <a href="publish.jsp">发布寻猫</a>
    </nav>
  </div>
</header>

<div class="hero">
  <div class="hero-content">
    <h1>让爱不再流浪</h1>
    <p>我们专注于帮助流浪猫找到温暖的家，您的每一次转发、领养，都是它们新生活的开始。</p>
    <div class="hero-buttons">
      <a href="adopt.jsp" class="btn btn-primary">我要领养</a>
      <a href="publish.jsp" class="btn btn-secondary">发布寻猫</a>
    </div>
  </div>
</div>

<section class="section">
  <h2 class="section-title">🐾 最新寻猫启事</h2>
  <div class="card-grid">
    <%
      List<Map<String, String>> cats = (List<Map<String, String>>) application.getAttribute("cats");
      if (cats == null) {
        cats = new ArrayList<>();
        Map<String, String> demo = new HashMap<>();
        demo.put("id", "1");
        demo.put("name", "番薯叶");
        demo.put("location", "南宁市良庆区南晓镇派双村岽球坡17号");
        demo.put("lostDate", "2026-04-01");
        demo.put("desc", "虎纹圆胖，慵懒霸气狸花猫");
        demo.put("contact", "18776002487");
        demo.put("imageBase64", "");
        demo.put("imageUrl", "https://s3.bmp.ovh/2026/06/04/IpMRcZa0.jpg"); // 您的图片URL
        cats.add(demo);
        application.setAttribute("cats", cats);
      }
      int total = cats.size();
      int start = total > 3 ? total - 3 : 0;
      List<Map<String, String>> last3 = new ArrayList<>(cats.subList(start, total));
      Collections.reverse(last3);
      for (Map<String, String> cat : last3) {
        String imgUrl = cat.get("imageUrl");
        String imgBase64 = cat.get("imageBase64");
        String imgSrc = null;
        if (imgUrl != null && !imgUrl.trim().isEmpty()) {
          imgSrc = imgUrl;
        } else if (imgBase64 != null && !imgBase64.trim().isEmpty()) {
          imgSrc = imgBase64;
        }
    %>
    <div class="card" onclick="location.href='detail.jsp?id=<%= cat.get("id") %>'">
      <% if (imgSrc != null) { %>
      <div style="position: relative; width: 100%;">
        <img class="card-img" src="<%= imgSrc %>" alt="猫咪照片"
             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
        <div class="no-img" style="display: none;"><i class="fas fa-cat fa-4x"></i></div>
      </div>
      <% } else { %>
      <div class="no-img"><i class="fas fa-cat fa-4x"></i></div>
      <% } %>
      <div class="card-info">
        <h3><%= cat.get("name") %></h3>
        <p><i class="fas fa-map-marker-alt"></i> <%= cat.get("location") %></p>
        <p><i class="far fa-calendar-alt"></i> <%= cat.get("lostDate") %></p>
      </div>
    </div>
    <% } %>
  </div>
  <div style="text-align:center; margin-top:30px;">
    <a href="list.jsp" class="btn btn-primary">查看更多寻猫启示 <i class="fas fa-arrow-right"></i></a>
  </div>
</section>

<section class="section two-columns">
  <div class="partners">
    <h3><i class="fas fa-handshake"></i> 合作机构</h3>
    <ul class="partner-list">
      <li><i class="fas fa-hospital"></i> 爱心宠物医院 · 010-12345678</li>
      <li><i class="fas fa-building"></i> 流浪动物收容所 · 海淀区中关村大街1号</li>
      <li><i class="fas fa-clinic-medical"></i> 小动物救助站 · 朝阳区建国路123号</li>
    </ul>
  </div>
  <div class="stories">
    <h3><i class="fas fa-book-open"></i> 领养成功故事</h3>
    <div class="story-card"><i class="fas fa-quote-left"></i> “领养了‘小橘’，它现在胖嘟嘟的，超粘人！”<br><span>—— 王女士</span></div>
    <div class="story-card"><i class="fas fa-quote-left"></i> “通过寻猫启示两小时找回‘豆豆’，感谢平台！”<br><span>—— 李先生</span></div>
  </div>
</section>

<div class="subscribe">
  <div class="subscribe-box">
    <h3><i class="fas fa-envelope"></i> 订阅福利</h3>
    <p>获取最新领养资讯、猫咪冷知识和救助指南</p>
    <div class="subscribe-form">
      <input type="email" id="subEmail" placeholder="您的电子邮箱">
      <button onclick="alert('感谢订阅！我们会定期发送猫咪信息。')">订阅</button>
    </div>
  </div>
</div>

<footer>
  <div class="footer-links">
    <a href="index.jsp">首页</a>
    <a href="list.jsp">寻猫启示</a>
    <a href="adopt.jsp">领养申请</a>
    <a href="publish.jsp">发布寻猫</a>
  </div>
  <p>© 2026 流浪猫领养中心 | 人工智能与信息工程学院 曾候恩 | 公益热线 400-123-4567</p>
</footer>
</body>
</html>