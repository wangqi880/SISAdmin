<%@ page import="com.sis.model.ClassDetail" %>
<%@ page import="com.sis.model.AttendInfo" %>
<%--
  Created by IntelliJ IDEA.
  User: 13046
  Date: 2017/11/6
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="common/taglibs.jsp"%>
<%@include file="common/head.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link href="<%=path %>/static/css/sis/button.css" rel="stylesheet" />
    <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />
    <link rel="icon" href="/static/img/icon.png" type="image/x-icon"/>
    <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
    <title>班级详细信息</title>
</head>
<style type="text/css">
    .main{
        width:1280px;
        height:1024px;
        text-align: center;
    }
    .page-header{
        position: absolute;
        left : 100px;
        top : 180px;
        width: 1080px;
    }
    body{
        background-image:url("<%=path %>/static/img/background_index_old.png");
        background-repeat: no-repeat;
        width:1280px;
        height:1024px;
        overflow-x: hidden;
        overflow-y: hidden;
    }
    table{
        margin:0 auto;
        margin-top: 350px;
        width: 1000px;
        margin-left: 140px;
        height: 500px;
    }
    table td{
        border:1px solid #2aabd2;
        width: 125px;
    }
</style>
<body>
<%
    ClassDetail myclass = (ClassDetail)request.getSession().getAttribute("class");
	AttendInfo attendId = (AttendInfo)request.getSession().getAttribute("attendInfo");
%>
<h1 class="page-header"><button type="button" class="button yellow  side" style="width: 200px">班级详情</button></h1>
    <div class="main">
        <table>
            <tr>
                <td class="title">班级代码：</td><td style="color:red"><%=myclass.getClassCode()%></td><td>班级名称：</td><td colspan="5"><%=myclass.getClassName()%></td>
            </tr>
            <tr>
                <td class="title">学年：</td><td><%=myclass.getTerm()%></td><td>学期：</td><td><%=myclass.getSemester()%></td><td>专业：</td><td><%=myclass.getMajor()%></td><td>专业程度：</td><td><%=myclass.getLevel()%></td>
            </tr>
            <tr>
                <td class="title">开课时间：</td><td><%=myclass.getDate()%></td><td>课次：</td><td><%=myclass.getTimes()%></td><td>总费用：</td><td style="color:red"><%=myclass.getCost()%></td><td>班级状态：</td><td><%=myclass.getStatus()%></td>
            </tr>
            <tr>
                <td class="title">班级描述：</td><td colspan="7"><%=myclass.getDesc()%></td>
            </tr>
            <tr>
                <td class="title">课表信息：</td><td colspan="3"><%=myclass.getScheduleInfo()%></td> <td >学员年龄阶段:</td><td colspan="3"><%=myclass.getAge()%></td>
            </tr>
            <tr>
                <td class="title">能力特征：</td><td colspan="3"><%=myclass.getAbility()%></td> <td >态度特征:</td><td colspan="3"><%=myclass.getAttitudinal()%></td>
            </tr>
        </table>
        <%
            if(attendId!=null){
        %>
        <a href="<%=basePath %>class_detail_test.jsp?major=<%=attendId.getMajorDetail()%>" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
        <%
            }else{
        %>
        <a href="<%=basePath %>class_detail_test.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
        <%
            }
        %>
        <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
    </div>
</body>
</html>
