<%--
  Created by IntelliJ IDEA.
  User: 13046
  Date: 2017/11/2
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="WEB-INF/views/common/taglibs.jsp"%>
<%@ include file="WEB-INF/views/common/head.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <link href="<%=path %>/static/css/sis/area.css" rel="stylesheet" />
    <link rel="icon" href="<%=path %>/static/img/icon.png" type="image/x-icon"/>
    <script type="text/javascript" src="<%=path %>/static/js/jquery-3.1.1.js" ></script>
    <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />
    <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
    <script src="<%=path %>/static/js/sis/common/showDate.js"></script>
    <title>选择报名区域</title>
</head>
<body>
<script>
    $(function(){
        var timeOut = 0;
        $(window).click(function(){
            timeOut = 0;
        });
        var timeClick = window.setInterval( function  (){
            timeOut = timeOut + 1;
            if(timeOut==30){
                layer.msg("操作超时", {
                    icon : 5
                });
                window.location.href = "index.jsp";
            }
        },1000);
    });
</script>
<div style=""></div>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <ul class="area" id="area_left">
        <li><a href="major.jsp?area=1"><img src="<%=path %>/static/img/area/area_suncheng.png"></a></li>
        <li><a href="major.jsp?area=2"><img src="<%=path %>/static/img/area/area_xiaonan.png"></a></li>
        <li><a href="major.jsp?area=3"><img src="<%=path %>/static/img/area/area_jiulidi.png"></a></li>
    </ul>
    <ul class="area" id="area_right">
        <li><a href="major.jsp?area=4"><img src="<%=path %>/static/img/area/area_baihuaxilu.png"></a></li>
        <li><a href="major.jsp?area=5"><img src="<%=path %>/static/img/area/area_jianshenanlu.png"></a></li>
        <li><a href="major.jsp?area=6"><img src="<%=path %>/static/img/area/area_jingchenxiaoqu.png"></a></li>
    </ul>
   <a href="index.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
    <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</div>
</body>
</html>
