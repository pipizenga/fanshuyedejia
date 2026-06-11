<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>所有寻猫启示</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .card-img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            background-color: #f5e6d3;
        }
        .no-img {
            width: 100%;
            height: 220px;
            background-color: #f5e6d3;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: #bc9a6c;
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
    <h2 class="section-title">📋 所有寻猫启事</h2>
    <div class="card-grid">
        <%
            List<Map<String, String>> cats = (List<Map<String, String>>) application.getAttribute("cats");
            if (cats == null || cats.isEmpty()) {
                out.println("<p style='text-align:center; color:white;'>暂无寻猫启示，<a href='publish.jsp' style='color:#ffaa66;'>点击发布</a></p>");
            } else {
                for (Map<String, String> cat : cats) {
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
        <%      }
        }
        %>
    </div>
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