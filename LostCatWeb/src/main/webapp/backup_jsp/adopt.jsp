<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>领养申请表</title>
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

<section class="section">
    <h2 class="section-title">🐾 领养申请表</h2>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            if (name != null && !name.trim().isEmpty() && phone != null && !phone.trim().isEmpty()) {
                out.println("<p class='success-msg' style='color:white; background:rgba(0,0,0,0.6); padding:10px; border-radius:40px; text-align:center;'>✅ 申请已提交，我们会尽快联系您！</p>");
            } else {
                out.println("<p class='error-msg' style='color:#ffaa66; text-align:center;'>❌ 请填写姓名和联系电话。</p>");
            }
        }
    %>
    <div class="form-card">
        <form method="post">
            <div class="form-group">
                <label><i class="fas fa-user"></i> 姓名 *</label>
                <input type="text" name="name" required>
            </div>
            <div class="form-group">
                <label><i class="fas fa-phone-alt"></i> 联系电话 *</label>
                <input type="tel" name="phone" required>
            </div>
            <div class="form-group">
                <label><i class="fas fa-home"></i> 居住地址</label>
                <input type="text" name="address">
            </div>
            <div class="form-group">
                <label><i class="fas fa-comment"></i> 申请理由（为什么想领养）</label>
                <textarea rows="4" name="reason"></textarea>
            </div>
            <button type="submit" class="btn-submit">提交申请</button>
        </form>
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