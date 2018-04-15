<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>打印管理</title>
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
                配置每个学员可以通过查询机打印次数,选择“-1”为不限制打印次数。
            </blockquote>
            <br>
           <form action="<%=request.getContextPath()%>/admin/configprintcount" method="post">
               <div class="form-group" style="font-size: 24px;float: left">
                   <div class="col-sm-10">
                       <input type="number" class="form-control" id="countMum" name="countMum" style="line-height: 24px;width: 300px" value="${count}" min="-1">
                   </div>
               </div>
               <button type="submit" class="btn btn-primary">修改每位学员(每个课程)打印上限</button>
           </form>
            <br>
            <form action="<%=request.getContextPath()%>/admin/configprintcountday" method="post">
                <div class="form-group" style="font-size: 24px;float: left">
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="countMumDay" name="countMumDay" style="line-height: 24px;width: 300px" value="${dayCount}" min="-1">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">修改每位学员每个课程(每天)打印上限</button>
            </form>
            <br>
            <form action="<%=request.getContextPath()%>/admin/configYear" method="post">
                <div class="form-group" style="font-size: 24px;float: left">
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="pringYear" name="year" style="line-height: 24px;width: 300px" value="${year}" min="-1">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">修改打印学年</button>不同学年使用"|"竖线分割
            </form>
            <br>
            <br>
            <form action="<%=request.getContextPath()%>/admin/configTerm" method="post">
                <div class="form-group" style="font-size: 24px;float: left">
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="pringTerm" name="term" style="line-height: 24px;width: 300px" value="${term}" min="-1">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">修改打印学期</button>不同学期使用"|"竖线分割
            </form>

        </div>
    </div>
    <jsp:include page="./common/footer.jsp"></jsp:include>
</div>
<script src="<%=request.getContextPath()%>/static/admin/layui/layui.js?t=1510786361436" charset="utf-8"></script>
</body>
</html>
