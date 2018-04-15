<%@ page import="com.sis.model.StudentInfo" %>
<%@ page import="com.sis.model.ClassDetail" %><%--
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
	StudentInfo studentInfo = (StudentInfo)request.getSession().getAttribute("jfstu_List");
	ClassDetail classDetail = (ClassDetail)request.getSession().getAttribute("jfdetail_List");
%>
<h1 class="page-header"><button type="button" class="button red side" style="width: 250px">请选择学生</button></h1>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <div class="listTable" style="text-align: center;width: 100%;margin-top: 300px">
        <table class="table table-hover" style="width: 85%;margin: 0 auto;text-align: center" >
            <thead>
            <tr style="text-align: center;font-size: 30px;font-family: 楷体" >
                <th style="text-align: center">学生姓名</th>
                <th style="text-align: center">区域</th>
                <th style="text-align: center">班级代码</th>
                <th style="text-align: center">班级名称</th>
                <th style="text-align: center">费用</th>
                <th style="text-align: center">缴费状态</th>
                <th style="text-align: center">操作</th>
            </tr>
            </thead>
            <tbody>
           
           <tr class="userInfo" style="cursor: pointer">
               <td><%=studentInfo.getStuName()%></td>
               <td><%=classDetail.getArea()%></td>
               <td><%=classDetail.getClassCode()%></td>
               <td><%=classDetail.getClassName()%></td>
               <td><%=classDetail.getCost()%></td>
               <td><%=classDetail.getStatusName()%></td>
               <%
                    String status = classDetail.getStatusName();
                    if(status.equals("可缴费")){
               %>
               <td><a style="cursor: pointer" id="modeltigger"  data-toggle="modal" data-target="#myModal">缴费</a></td>
               <%
                   }else{
               %>
               <td><%=classDetail.getStatusName()%></td>
               <%
                   }
               %>
           </tr>

            </tbody>
        </table>
    </div>
    <a href="jiaofei.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
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
                  if(timeOut==60){
                      layer.msg("操作超时", {
                          icon : 5
                      });
                      window.location.href = "index.jsp";
                  }
              },1000);
              
        	$(".modal-content").css("height","350px");
        	
       		$(".payBtu").css("margin-top","50px").css("list-style","none");
       		
       		
       		$(".pay_weixin").click(function(){
       			$(".payBtu").hide();
           	 	$.ajax({
                     url:'pay/getKeyNoCode.do',
                     type:'POST', //GET
                     async:true,    //或false,是否异步
                     data:{
                      	payType:12
                     },
                     success:function(dataPay){
                    	 layer.msg("等待响应", {
                             icon : 0
                         });
                    	 timeOut=0;
						var statusPay = dataPay.status;
						if(statusPay=="SUCCESS"){
							layer.msg("请在120秒之内完成扫码支付", {
                                 icon : 0
                             });
							$(".modal-content").css("height","650px");
							var mobody = $("#firstmodal");
							mobody.css("text-align","center").html('<img src="'+dataPay.codePic+'"/>');
							$("#myModalLabel").text("请使用微信扫一扫");
							timeOut=-120;
							var payResult = window.setInterval( function  (){
								
								$.ajax({
	                                 url:'pay/getPayStatus.do',
	                                 type:'POST', //GET
	                                 async:false,    //或false,是否异步
	                                 success:function(data){
	                                	 if(data=="SUCCESS"){
	                                		 layer.msg("支付成功", {
		                                         icon : 0
		                                     });
	                                		 window.location.href="jiaofei_end.jsp";
                                            // window.location.href='index.jsp';
	                                	 }else{
	                                		 layer.msg("等待支付结果", {
		                                         icon : 0
		                                     });
	                                	 }
	                                 },
	                                 error:function(){
	                                	 layer.msg("获取支付结果失败，请联系管理员", {
	                                         icon : 5
	                                     });
	                                	 clearInterval(payResult);
	                                	 return;
	                                 }
								});
							
			              },4000);
						}
                        else if(statusPay == "error"){
                            layer.msg("获取支付链接失败，请联系管理员", {
                                icon : 5,
                                time:2000
                            });
                            setTimeout( window.location.href="index.jsp",5000)
                        }
						else{
							layer.msg("预约号无效，请联系管理员", {
                                 icon : 5
                             });
							window.location.href="childList_pay.jsp";
						}
                     },
                     error:function(){
                    	 layer.msg("网络异常，支付接口无响应", {
                             icon : 5
                         });
                    	 window.location.href="childList_pay.jsp";
                     }
           		 });  
       		});
       		$(".pay_zifubao").click(function(){
       			$(".payBtu").hide();
           		$.ajax({
                     url:'pay/getKeyNoCode.do',
                     type:'POST', //GET
                     async:true,    //或false,是否异步
                     data:{
                     	payType:22
                     },
                     success:function(dataPay){
                    	 layer.msg("等待响应", {
                             icon : 0
                         });
                    	 timeOut=-120;
						var statusPay = dataPay.status;
						if(statusPay=="SUCCESS"){
							layer.msg("请在120秒之内完成扫码支付", {
                                 icon : 0
                             });
							$(".modal-content").css("height","650px");
							var mobody = $("#firstmodal");
							mobody.css("text-align","center").html('<img src="'+dataPay.codePic+'"/>');
							$("#myModalLabel").text("请使用支付宝扫一扫");
							timeOut=0;
							var payResult = window.setInterval( function  (){
								
								$.ajax({
	                                 url:'pay/getPayStatus.do',
	                                 type:'POST', //GET
	                                 async:false,    //或false,是否异步
	                                 success:function(data){
	                                	 if(data=="SUCCESS"){
	                                		 layer.msg("支付成功", {
		                                         icon : 0
		                                     });
                                             window.location.href="jiaofei_end.jsp";
                                             //window.location.href='index.jsp';
	                                	 }else{
	                                		 layer.msg("等待支付结果", {
		                                         icon : 0
		                                     });
	                                	 }
	                                 },
	                                 error:function(){
	                                	 layer.msg("获取支付结果失败，请联系管理员", {
	                                         icon : 5
	                                     });
	                                	 clearInterval(payResult);
	                                	 return;
	                                 }
								});
							
			              },4000);
						}
                        else if(statusPay == "error"){
                            layer.msg("获取支付链接失败，请联系管理员", {
                                icon : 5,
                                time:2000
                            });
                            setTimeout( window.location.href="index.jsp",5000)

                        }
						else{
							layer.msg("预约号无效，请联系管理员", {
                                 icon : 5
                             });
							window.location.href="childList_pay.jsp";
						}
                     },
                     error:function(){
                    	 layer.msg("网络异常，支付接口无响应", {
                             icon : 5
                         });
                    	 window.location.href="childList_pay.jsp";
                     }
          		 });
       		});
            function toUtf8(str) {    
                var out, i, len, c;    
                out = "";    
                len = str.length;    
                for(i = 0; i < len; i++) {    
                    c = str.charCodeAt(i);    
                    if ((c >= 0x0001) && (c <= 0x007F)) {    
                        out += str.charAt(i);    
                    } else if (c > 0x07FF) {    
                        out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));    
                        out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));    
                        out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));    
                    } else {    
                        out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));    
                        out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));    
                    }    
                }    
                return out;    
            } 
        });
    </script>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="ture">
    <div class="modal-dialog">
        <div class="modal-content" style="width:1000px;margin-left:-200px;height:500px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" style="font-family: 楷体">选择支付方式</h4>
            </div>
           		 <ul class="payBtu">
              		<li style="float:left;margin-left:200px;"><a class="pay_weixin"><img src="<%=path %>/static/img/pay/weixin.png"/></a></li>
              		<li ><a class="pay_zifubao"><img src="<%=path %>/static/img/pay/zhifubao.png"/></a></li>
              	</ul>
              <div class="modal-body" id="firstmodal">
              </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
