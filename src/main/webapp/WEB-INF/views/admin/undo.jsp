<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/admin/layui/css/layui.css?t=1510786361436"  media="all">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <jsp:include page="./common/header.jsp"></jsp:include>
    <jsp:include page="./common/leftNav.jsp"></jsp:include>

    <!--body-->
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">

            <blockquote class="layui-elem-quote layui-text">
                功能还没做，敬请期待
            </blockquote>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                <legend>先看下广告</legend>
            </fieldset>
            <div class="layui-carousel" id="test10">
                <div carousel-item="">
                    <div><img src="//res.layui.com/images/layui/demo/1.png"></div>
                    <div><img src="//res.layui.com/images/layui/demo/2.png"></div>
                    <div><img src="//res.layui.com/images/layui/demo/3.png"></div>
                    <div><img src="//res.layui.com/images/layui/demo/4.png"></div>
                </div>
            </div>


        </div>
    </div>

    <jsp:include page="./common/footer.jsp"></jsp:include>

</div>
<script src="<%=request.getContextPath()%>/static/admin/layui/layui.js?t=1510786361436" charset="utf-8"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>
</body>
</html>
