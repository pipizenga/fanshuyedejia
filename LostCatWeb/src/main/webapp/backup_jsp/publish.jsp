<%@ page import="java.util.*, java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发布寻猫</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .preview-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 16px;
            margin-top: 8px;
            border: 2px solid #ffc489;
            display: none;
        }
        .file-label {
            background: #ff9800;
            color: white;
            padding: 8px 20px;
            border-radius: 40px;
            display: inline-block;
            cursor: pointer;
            margin: 8px 0;
        }
        .upload-status {
            font-size: 0.85rem;
            margin-top: 5px;
            color: #666;
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
    <h2 class="section-title">📝 发布寻猫启示</h2>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            request.setCharacterEncoding("UTF-8");
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String lostDate = request.getParameter("lostDate");
            String desc = request.getParameter("desc");
            String contact = request.getParameter("contact");
            String imageUrl = request.getParameter("imageUrl");  // 从图床返回的URL
            if (name != null && !name.trim().isEmpty() && contact != null && !contact.trim().isEmpty()) {
                List<Map<String, String>> cats = (List<Map<String, String>>) application.getAttribute("cats");
                if (cats == null) cats = new ArrayList<>();
                Map<String, String> newCat = new HashMap<>();
                newCat.put("id", UUID.randomUUID().toString());
                newCat.put("name", name);
                newCat.put("location", location == null ? "" : location);
                newCat.put("lostDate", lostDate == null ? "" : lostDate);
                newCat.put("desc", desc == null ? "" : desc);
                newCat.put("contact", contact);
                newCat.put("imageUrl", imageUrl == null ? "" : imageUrl);
                cats.add(newCat);
                application.setAttribute("cats", cats);
                out.println("<p style='color:white; background:rgba(0,0,0,0.6); padding:10px; border-radius:40px; text-align:center;'>✅ 发布成功！<a href='list.jsp' style='color:#ffaa66;'>查看所有启示</a></p>");
            } else {
                out.println("<p style='color:#ffaa66; text-align:center;'>❌ 请填写猫咪昵称和联系电话</p>");
            }
        }
    %>
    <div class="form-card">
        <form method="post" id="publishForm">
            <div class="form-group">
                <label>猫咪昵称 *</label>
                <input type="text" name="name" required>
            </div>
            <div class="form-group">
                <label>丢失地点</label>
                <input type="text" name="location">
            </div>
            <div class="form-group">
                <label>丢失日期</label>
                <input type="date" name="lostDate">
            </div>
            <div class="form-group">
                <label>特征描述</label>
                <textarea name="desc" rows="3"></textarea>
            </div>
            <div class="form-group">
                <label>联系电话 *</label>
                <input type="tel" name="contact" required>
            </div>
            <div class="form-group">
                <label>🐾 猫咪照片（选择图片自动上传）</label>
                <input type="file" id="catImage" accept="image/*" style="display:none;">
                <label for="catImage" class="file-label" id="uploadBtn">📸 选择图片</label>
                <div id="previewContainer"></div>
                <div id="uploadStatus" class="upload-status"></div>
                <input type="hidden" id="imageUrl" name="imageUrl">
            </div>
            <button type="submit" class="btn-submit">🐾 发布</button>
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

<script>
    const fileInput = document.getElementById('catImage');
    const previewContainer = document.getElementById('previewContainer');
    const uploadStatus = document.getElementById('uploadStatus');
    const imageUrlField = document.getElementById('imageUrl');
    const submitBtn = document.querySelector('.btn-submit');

    fileInput.addEventListener('change', async function(e) {
        const file = e.target.files[0];
        if (!file) return;

        // 预览
        const reader = new FileReader();
        reader.onload = function(ev) {
            previewContainer.innerHTML = `<img src="${ev.target.result}" class="preview-img" style="display:block;">`;
        };
        reader.readAsDataURL(file);

        // 上传到图床（sm.ms API）
        uploadStatus.innerText = '上传中...';
        const formData = new FormData();
        formData.append('smfile', file);

        try {
            const response = await fetch('https://sm.ms/api/v2/upload', {
                method: 'POST',
                body: formData
            });
            const result = await response.json();
            if (result.success) {
                const url = result.data.url;
                imageUrlField.value = url;
                uploadStatus.innerHTML = `<span style="color:green;">✅ 上传成功！图片URL已获取</span>`;
            } else {
                // 如果图片已存在，sm.ms 会返回图片链接
                if (result.code === 'image_repeated') {
                    const url = result.images;
                    imageUrlField.value = url;
                    uploadStatus.innerHTML = `<span style="color:green;">✅ 图片已存在，URL已获取</span>`;
                } else {
                    uploadStatus.innerHTML = `<span style="color:red;">❌ 上传失败：${result.message}</span>`;
                }
            }
        } catch (err) {
            uploadStatus.innerHTML = `<span style="color:red;">❌ 网络错误，请重试</span>`;
            console.error(err);
        }
    });
</script>
</body>
</html>