<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI性格分析 - 流浪猫领养中心</title>
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
    <h2 class="section-title"><i class="fas fa-brain"></i> AI性格分析 · 你适合养什么样的猫？</h2>
    <div class="quiz-container" id="quizContainer">
        <div id="quizQuestions">
            <div class="quiz-question"><p>1. 你平时的生活节奏？</p><label class="quiz-option"><input type="radio" name="q1" value="calm"> 悠闲安静</label><label class="quiz-option"><input type="radio" name="q1" value="active"> 充满活力</label><label class="quiz-option"><input type="radio" name="q1" value="busy"> 忙碌但愿意陪伴</label></div>
            <div class="quiz-question"><p>2. 你希望猫咪的性格？</p><label class="quiz-option"><input type="radio" name="q2" value="cuddly"> 粘人爱撒娇</label><label class="quiz-option"><input type="radio" name="q2" value="independent"> 独立高冷</label><label class="quiz-option"><input type="radio" name="q2" value="playful"> 活泼爱玩</label></div>
            <div class="quiz-question"><p>3. 你能接受猫咪掉毛的程度？</p><label class="quiz-option"><input type="radio" name="q3" value="low"> 完全不能接受</label><label class="quiz-option"><input type="radio" name="q3" value="medium"> 可以接受少量</label><label class="quiz-option"><input type="radio" name="q3" value="high"> 无所谓</label></div>
            <button onclick="showResult()">🔮 查看分析结果</button>
        </div>
        <div id="quizResult" style="display:none;" class="quiz-result"></div>
    </div>
</main>
<footer>
    <p>© 2026 流浪猫领养中心 | 科学领养，爱不流浪</p>
</footer>
<script>
    function showResult() {
        let q1 = document.querySelector('input[name="q1"]:checked');
        let q2 = document.querySelector('input[name="q2"]:checked');
        let q3 = document.querySelector('input[name="q3"]:checked');
        if (!q1 || !q2 || !q3) { alert("请回答所有问题~"); return; }
        let result = "";
        if (q1.value === "calm" && q2.value === "cuddly") result = "🌟 推荐领养：布偶猫、英短。温顺粘人，适合安静的家庭。";
        else if (q1.value === "active" && q2.value === "playful") result = "🐾 推荐领养：阿比西尼亚、孟加拉猫。活力四射，和你一起玩耍！";
        else if (q1.value === "busy" && q2.value === "independent") result = "🏠 推荐领养：俄罗斯蓝猫、中华田园猫。独立不粘人，适合工作忙的你。";
        else result = "🐱 推荐领养：中华田园猫！适应性超强，总有一款适合你~";
        document.getElementById('quizQuestions').style.display = 'none';
        document.getElementById('quizResult').innerHTML = "<h3><i class='fas fa-chart-line'></i> AI分析结果</h3><p>"+result+"</p><button onclick='resetQuiz()'>重新测试</button>";
        document.getElementById('quizResult').style.display = 'block';
    }
    function resetQuiz() { location.reload(); }
</script>
</body>
</html>