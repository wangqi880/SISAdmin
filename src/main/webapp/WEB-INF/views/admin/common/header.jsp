<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!--header-->
<div class="layui-header">
    <div class="layui-logo">查询机后台管理</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
        <li class="layui-nav-item"><a href="<%=request.getContextPath()%>/admin">控制台</a></li>
        <li class="layui-nav-item"><a href="<%=request.getContextPath()%>/index.jsp">首页</a></li>
        <li class="layui-nav-item">
            <a href="javascript:;">其它系统</a>
            <dl class="layui-nav-child">
                <dd><a href="http://bm.cdqsng.com/qsng-bsp/cd/apply-front.action">青少年宫网上预约缴费系统</a></dd>
                <dd><a href="http://www.cdqsng.com/">青少年宫官网</a></dd>
            </dl>
        </li>
    </ul>
    <ul class="layui-nav layui-layout-right">
        <li class="layui-nav-item">
            <a href="javascript:;">
                <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                ${loginUser.username}
            </a>
            <dl class="layui-nav-child">
                <dd><a href="<%=request.getContextPath() %>/admin/undo">基本资料</a></dd>
                <dd><a href="<%=request.getContextPath() %>/admin/undo">安全设置</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item"><a href="javascript:userExitSystem()">退了</a></li>
    </ul>
    <script type="text/javascript">
        function userExitSystem() {
            window.parent.location.href = "<%=request.getContextPath() %>/login/logout";
        }
    </script>
</div>