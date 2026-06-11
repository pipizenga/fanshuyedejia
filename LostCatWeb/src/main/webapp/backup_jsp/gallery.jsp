<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>猫咪图库 - 流浪猫领养中心</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header>
    <div class="header-container">
        <div class="logo"><i class="fas fa-cat"></i> 流浪猫领养中心</div>
        <nav>
            <a href="index.jsp"><i class="fas fa-home"></i> 首页</a>
            <a href="list.jsp"><i class="fas fa-list"></i> 寻猫启示</a>
            <a href="adopt.jsp"><i class="fas fa-heart"></i> 领养申请</a>
            <a href="resources.jsp"><i class="fas fa-hand-holding-heart"></i> 救助资源</a>
            <a href="gallery.jsp"><i class="fas fa-images"></i> 猫咪图库</a>
            <a href="quiz.jsp"><i class="fas fa-brain"></i> AI测试</a>
            <a href="publish.jsp"><i class="fas fa-plus-circle"></i> 发布寻猫</a>
        </nav>
    </div>
</header>
<main>
    <h2 class="section-title"><i class="fas fa-images"></i> 猫咪图库</h2>
    <div class="gallery-grid">
        <%
            List<Map<String, String>> cats = (List<Map<String, String>>) application.getAttribute("cats");
            if (cats != null) {
                for (Map<String, String> cat : cats) {
                    String img = cat.get("imageBase64");
                    if (img != null && !img.trim().isEmpty()) {
        %>
        <div class="gallery-item" onclick="window.open('detail.jsp?id=<%= cat.get("id") %>')">
            <img src="<%= img %>" alt="猫咪">
            <div class="gallery-caption"><%= cat.get("name") %> - <%= cat.get("location") %></div>
        </div>
        <%      }
        }
        }
        %>
    </div>
    <p style="text-align:center; margin-top:30px;"><a href="publish.jsp" class="btn-primary"><i class="fas fa-plus"></i> 上传新照片</a></p>
</main>
<footer>
    <p>© 2026 流浪猫领养中心 | 每一张照片都是一个故事</p>
</footer>
</body>
</html>