<%--
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
    <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />

    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>课程表</title>
    <!-- Bootstrap -->
    <script type="text/javascript" src="<%=path %>/static/js/sis/pay.js" ></script>
    <link rel="stylesheet" href="<%=path %>/static/form_wizard/steps/jquery.steps.css" />
    <link rel="stylesheet" href="<%=path %>/static/datatimepicker/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="<%=path %>/static/datatimepicker/bootstrap-datetimepicker.min.js" ></script>
    <script type="text/javascript" src="<%=path %>/static/datatimepicker/bootstrap-datetimepicker.zh-CN.js" ></script>
    <script type="text/javascript" src="<%=path %>/static/form_wizard/steps/jquery.steps.min.js" ></script>
    <script type="text/javascript" src="<%=path %>/static/form_wizard/validate/jquery.validate.min.js" ></script>
    <script type="text/javascript" src="<%=path %>/static/form_wizard/validate/messages_zh.min.js" ></script>
    <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
    <link href="<%=path %>/static/css/sis/button.css" rel="stylesheet" />
    <script src="<%=path %>/static/js/sis/common/showDate.js"></script>
    <style type="text/css">
        body{
            background-image:url("static/img/st.png");
            background-repeat: no-repeat;
        }
        .container-fluid{
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

        td{
            text-align:center;
        }
    </style>
</head>
<body>
<%
    String stuId  = request.getParameter("studentId");
%>
<input hidden value="<%=stuId %>" id="stuId"/>
<script>
    $(function(){
        $.ajax({
            url:'info/showSchedule.do?studentId='+$("#stuId").val(),
            type:'POST', //GET
            async:true,    //或false,是否异步
            contentType: "application/json",
            success:function(data){
                var status = data.status;
                if(status!="SUCCESS"){
                    layer.msg("未查询到课表信息", {
                        icon : 5
                    });
                    return;
                }
                var info = data.data;
                if(info==""){
                    layer.msg("未查询到课表信息", {
                        icon : 5
                    });
                }
                for (i in info) {
                    /*layer.msg("等待加载课表", {
                        icon : 1
                    });*/
                    $("tbody").append(" <tr>\n" +
                        "                <td>"+info[i].year+"</td>\n" +
                        "                <td>"+info[i].term+"</td>\n" +
                        "                <td>"+info[i].spelName+"</td>\n" +
                        "                <td>"+info[i].clazzNo+"</td>\n" +
                        "                <td>"+info[i].name+"</td>\n" +
                        "                <td>"+info[i].area+"</td>\n" +
                        "                <td>"+info[i].timeable+"</td>\n" +
                        "                <td>"+info[i].classPlace+"</td>\n" +
                        "                <td>"+info[i].beginTime+"</td>\n" +
                        "            </tr>");
                }
            },
            error:function(){
                layer.msg("网络异常，请稍后重试", {
                    icon : 5
                });
            }
        });
    });
</script>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <div  class="listTable" style="text-align: center;width: 100%;margin-top: 300px">
        <table class="table table-hover" style="width: 70%;cellpadding:2px" >
            <thead>
            <tr style="text-align: center;font-size: 25px;font-family: 楷体" >
                <th style="text-align: center">学年</th>
                <th style="text-align: center">学期</th>
                <th style="text-align: center">专业</th>
                <th style="text-align: center">班级代码</th>
                <th style="text-align: center">班级名称</th>
                <th style="text-align: center">区域</th>
                <th style="text-align: center">上课时间</th>
                <th style="text-align: center">教室</th>
                <th style="text-align: center">开课时间</th>
            </tr>
            </thead>
            <tbody>
           <%-- <tr>
                <td>无</td>
                <td>info[i].year</td>
                <td>info[i].term</td>
                <td>info[i].spelName</td>
                <td>info[i].clazzNo</td>
                <td>info[i].name</td>
                <td>info[i].area</td>
                <td>info[i].timeable</td>
                <td>info[i].classPlace</td>
                <td>info[i].beginTime</td>
            </tr>--%>
            </tbody>
        </table>
    </div>
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
<a href="#" onclick="javascript:history.back(-1);" class="stepBtu"><img src="<%=path %>/static/img/back.png"></a>
<a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</body>
</html>
