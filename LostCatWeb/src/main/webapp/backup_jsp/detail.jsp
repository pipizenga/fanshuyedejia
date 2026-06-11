<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>猫咪详情</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .detail-img {
            max-width: 100%;
            max-height: 300px;
            object-fit: cover;
            border-radius: 24px;
            margin: 0 auto 20px;
            display: block;
        }
        .no-img-detail {
            width: 100%;
            height: 200px;
            background-color: #f5e6d3;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            border-radius: 24px;
            margin-bottom: 20px;
        }
    </style>
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

<section class="section">
    <%
        String id = request.getParameter("id");
        List<Map<String, String>> cats = (List<Map<String, String>>) application.getAttribute("cats");
        Map<String, String> cat = null;
        if (id != null && cats != null) {
            for (Map<String, String> c : cats) {
                if (id.equals(c.get("id"))) {
                    cat = c;
                    break;
                }
            }
        }
        if (cat == null) {
            out.println("<p style='text-align:center; color:white;'>未找到相关信息。</p>");
        } else {
            String imgUrl = cat.get("imageUrl");
            String imgBase64 = cat.get("imageBase64");
            String imgSrc = null;
            if (imgUrl != null && !imgUrl.trim().isEmpty()) {
                imgSrc = imgUrl;
            } else if (imgBase64 != null && !imgBase64.trim().isEmpty()) {
                imgSrc = imgBase64;
            }
    %>
    <div class="detail-card">
        <h2><%= cat.get("name") %></h2>
        <% if (imgSrc != null) { %>
        <div style="position: relative;">
            <img class="detail-img" src="<%= imgSrc %>" alt="猫咪照片"
                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
            <div class="no-img-detail" style="display: none;"><i class="fas fa-cat fa-4x"></i></div>
        </div>
        <% } else { %>
        <div class="no-img-detail"><i class="fas fa-cat fa-4x"></i></div>
        <% } %>
        <p><i class="fas fa-map-marker-alt"></i> <strong>丢失地点：</strong> <%= cat.get("location") %></p>
        <p><i class="far fa-calendar-alt"></i> <strong>丢失日期：</strong> <%= cat.get("lostDate") %></p>
        <p><i class="fas fa-info-circle"></i> <strong>特征描述：</strong> <%= cat.get("desc") != null ? cat.get("desc") : "暂无" %></p>
        <p><i class="fas fa-phone-alt"></i> <strong>联系电话：</strong> <%= cat.get("contact") %></p>
        <button class="btn btn-primary" style="width:100%;" onclick="window.location.href='tel:<%= cat.get("contact") %>'">📞 联系主人</button>
    </div>
    <% } %>
</section>

<footer>
    <div class="footer-links">
        <a href="index.jsp">首页</a>
        <a href="list.jsp">寻猫启示</a>
        <a href="adopt.jsp">领养申请</a>
        <a href="publish.jsp">发布寻猫</a>
    </div>
    <p>© 2026 流浪猫领养中心 | 曾候恩</p>
</footer>
</body>
</html>