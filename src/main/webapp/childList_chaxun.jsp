<%@ page import="com.sis.model.StudentInfo" %>
<%@ page import="com.sis.model.AttendInfo" %><%--
  Created by IntelliJ IDEA.
  User: 13046
  Date: 2017/11/10
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="WEB-INF/views/common/taglibs.jsp"%>
<!-- Bootstrap -->
<%@ include file="WEB-INF/views/common/head.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="static/img/icon.png" type="image/x-icon"/>
    <script type="text/javascript" src="<%=path %>/static/js/jquery-3.1.1.js" ></script>
    <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />
    <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
    <link href="<%=path %>/static/css/sis/button.css" rel="stylesheet" />
    <script src="<%=path %>/static/js/sis/common/showDate.js"></script>
    <!-- 二维码插件 -->
	<script type="text/javascript" src="<%=path %>/static/jquery-qrcode-master/jquery.qrcode.min.js"></script> 
    <title>欢迎</title>

    <title>学生信息列表</title>
    <style type="text/css">
        body{
            background-image:url("static/img/background_index_old.png");
            background-repeat: no-repeat;
        }
        .main{
            text-align: center;
            width:1280px;
            height:1024px;
        }
        .date{
            font-size: 35px;
            color: #8bc816;
            letter-spacing: 12px;
            left: 300px;
            top:100px;
            position: absolute;
        }
        .page-header{
            position: absolute;
            left : 100px;
            top : 180px;
            width: 1080px;
        }
        .userInfo{
            font-size: 24px;
            width: 40px;
            font-family: 微软雅黑;
        }
    </style>
</head>
<body>
<%
	List<StudentInfo> studentInfos = (List<StudentInfo>)request.getSession().getAttribute("cxstu_List");
%>
<h1 class="page-header"><button type="button" class="button red side" style="width: 250px">请选择学生</button></h1>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <div class="listTable" style="text-align: center;width: 100%;margin-top: 300px">
        <table class="table table-hover" style="width: 70%;margin: 0 auto;text-align: center" >
            <thead>
            <tr style="text-align: center;font-size: 30px;font-family: 楷体" >
                <th style="text-align: center">编号</th>
                <th style="text-align: center">学生姓名</th>
                <th style="text-align: center">性别</th>
                <th style="text-align: center">就读年级</th>
                <th style="text-align: center">生日</th>
            </tr>
            </thead>
            <tbody>
           <%
               int i = 0;
             for(StudentInfo info:studentInfos){
             	i++;
           %>
           <tr class="userInfo" style="cursor: pointer">
               <td class="idnumber"><%=i %></td>
               <td><a href="schedule.jsp?studentId=<%=info.getStudentId() %>"><%=info.getStuName() %></a></td>
               <td><%=info.getStuSex() %></td>
               <td><%=info.getGrade() %></td>
               <td><%=info.getBirthDay() %></td>
           </tr>
           <%
             }
           %>
            </tbody>
        </table>
    </div>
    <a href="<%=basePath %>phoneCode_chaxun.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
    <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</div>
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
</body>
</html>
