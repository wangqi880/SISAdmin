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
        .stepBtu{
            position: absolute;
            top:950px;
        }

        .indexBtu{
            position: absolute;
            top:950px;
            left: 984px;
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
            	var info = data.info;
            	if(info==""){
            		 layer.msg("未查询到课表信息", {
                         icon : 5
                     });
            	}
               	for(var i = 0 ; i < info.length;i++){
               		layer.msg("等待加载课表", {
                        icon : 1
                    });
               		var tdid = "day_"+info[i].xString;
               		$("#"+tdid).append("</br>"+info[i].infoname+"</br></br>"+info[i].infotime+"</br></br>"+info[i].infoarea+"</br><hr></br>");
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
<div class="container-fluid">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <div class="showTable" style="text-align: center">
    	<table class='schedule' style='width:1000px;height:200px;margin-left:160px;margin-top:200px;table-layout:fixed;'>
	    	<thead class='thead' style='color:white;text-align:center;font-size:30px;font-family:方正舒体;background-color:#0080FF;line-height:45px;'>
	    		<td style='background-color:#EA7500;'>周一</td><td style='background-color:#FFD306;'>周二</td><td style='background-color:#8CEA00;'>周三</td><td style='background-color:#02F78E;'>周四</td>
	    		<td style='background-color:#FF60AF;'>周五</td><td style='background-color:#5B00AE;'>周六</td><td style='background-color:red;'>周日</td>
	    	</thead>
	    	<tr >
	    		<td style="width:142.8px" id="day_1"></td>
	    		<td style="width:142.8px" id="day_2"></td>
	    		<td style="width:142.8px" id="day_3"></td>
	    		<td style="width:142.8px" id="day_4"></td>
	    		<td style="width:142.8px" id="day_5"></td>
	    		<td style="width:142.8px" id="day_6"></td>
	    		<td style="width:142.8px" id="day_0"></td>
	    	</tr>
    	</table>
    </div>
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
