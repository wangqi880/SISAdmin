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
            background-image:url("static/img/liangeren.png");
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
    Map<String , Object> childList = (Map<String , Object>)request.getSession().getAttribute("childMap");
    List<StudentInfo> studentInfos =null;
    if(null!=childList){
                        studentInfos = (List<StudentInfo>)childList.get("childList");
    }

    AttendInfo attendInfo = (AttendInfo)request.getSession().getAttribute("attendInfo");
%>
<h1 class="page-header"><button type="button" class="button red side" style="width: 250px">请选择学生</button></h1>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
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
              
            $(".userInfo").click(function () {
                var tdarray  =  $(this).children(".idnumber");
                var id = 0;
                tdarray.each(function(){
                	id = $(this).text();
                });
               var classid = $("#classid").val();
                $.ajax({
                    url:'info/getAttendInfo.do',
                    type:'POST', //GET
                    async:true,    //或false,是否异步
                    data:{
                    	classCode:classid,
                    	idnumber:id-1
                    },
                    success:function(data){
                       var stu = data.student;
                       $("#firstname").val(stu.stuName);
                       $("#stubirthday").val(stu.birthDay);
                       $("#parentphone").val(stu.phoneNumber);
                    	$("#identId").val(stu.indentityCard);
                    	$("#school").val(stu.schoolName);
                    	$("#sex").val(stu.stuSex);
                    	$("#parentname").val(stu.parentName);
                    	$("#familyphone").val(stu.familyCall);
                    	$("#grade").val(stu.grade);
                    	$("#bz").val(stu.attentionInfo);
                    	var classinfo = data.classinfo;
                    	$("#className").val(classinfo.className);
                    	$("#cost").val(classinfo.cost);
                    	$("#classCode").val(classinfo.classCode);
                    	$("#stuId").val(stu.studentId);
                    },
                    error:function(){
                        layer.msg("获取报名信息失败", {
                            icon : 5
                        });
                    },
                });
                
            });
            $("#attend").click(function(){
    			 $.ajax({
                     url:'info/attend.do',
                     type:'POST', //GET
                     async:true,    //或false,是否异步
                     data:{
                     	studentId:$("#stuId").val(),
                     },
                     success:function(data){
                    	 var status = data.status;
                        if(status=="SUCCESS"){
                        	timeOut=0;
                        	var cdcode = data.reserveNo;
                        	if(cdcode==null || cdcode==""){
                        		layer.msg("您已报名此课程，请前往支付", {
                                    icon : 5
                                });
                        		return ;
                        	}
                        	layer.msg("恭喜您成功报名", {
                                icon : 1
                            });
                        	//保留学生姓名、id
                            var sid = $("#stuId").val();
                            var sname = $("#firstname").val();
                        	//获取后端的预约号
                        	$(".yyh span").text(cdcode);
                        	$(".modal-title").text("选择支付方式")
                        	$(".modal-content").css("height","350px");
                        //	window.location.href = "pay.jsp";
                        	$(".modal-body").children().remove();
                       		$("#attend").remove();
                       		$(".payBtu").show().css("margin-top","50px").css("list-style","none");
                       		$(".yyh").show();
                       		$(".payhr").show();
                       		$("#close").remove();
                       		$(".pay_weixin").click(function(){
                       			$(".payBtu").hide();
                           		$(".yyh").hide();
                           		$(".payhr").hide();
                           	 	$.ajax({
	                                 url:'pay/getKey.do',
	                                 type:'POST', //GET
	                                 async:true,    //或false,是否异步
	                                 data:{
	                                	reserveNo:cdcode,
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
                                                         async:false,
						                                 type:'POST', //GET
						                                 async:true,    //或false,是否异步
						                                 success:function(data){
						                                	 if(data=="SUCCESS"){
						                                		 layer.msg("支付成功", {
							                                         icon : 0
							                                     });
						                                		 window.location.href="print_jf.jsp?studentId="+sid+"&studentName="+sname;
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
                                                icon : 5
                                            });
                                            window.location.href="childList.jsp";
                                        }
										else{
											layer.msg("预约号无效，请联系管理员", {
		                                         icon : 5
		                                     });
											window.location.href="childList.jsp";
										}
	                                 },
	                                 error:function(){
	                                	 layer.msg("网络异常，支付接口无响应", {
	                                         icon : 5
	                                     });
	                                	 window.location.href="childList.jsp";
	                                 }
                           		 });  
                       		});
                       		$(".pay_zifubao").click(function(){
                       			$(".payBtu").hide();
                           		$(".yyh").hide();
                           		$(".payhr").hide();
                           		$.ajax({
	                                 url:'pay/getKey.do',
	                                 type:'POST', //GET
	                                 async:true,    //或false,是否异步
	                                 data:{
	                                	reserveNo:cdcode,
	                                 	payType:22
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
											$("#myModalLabel").text("请使用支付宝扫一扫");
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
                                                             window.location.href="print_jf.jsp?studentId="+sid+"&studentName="+sname;
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
                                                icon : 5
                                            });
                                            window.location.href="childList.jsp";
                                        }
										else{
											layer.msg("预约号无效，请联系管理员", {
		                                         icon : 5
		                                     });
											window.location.href="childList.jsp";
										}
	                                 },
	                                 error:function(){
	                                	 layer.msg("网络异常，支付接口无响应", {
	                                         icon : 5
	                                     });
	                                	 window.location.href="childList.jsp";
	                                 }
                          		 });
                       		});
                        }else{
                        	layer.msg(data.msg, {
                                icon : 5
                            });
                        }
                     },
                     error:function(){
                         layer.msg("预约号获取失败-网络异常，请稍后重试", {
                             icon : 5
                         });
                     },
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
    <div class="listTable" style="text-align: center;width: 100%;margin-top: 320px">
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
               if(null!=studentInfos){
             for(StudentInfo info:studentInfos){
             	i++;
           %>
           <tr class="userInfo" style="cursor: pointer" id="modeltigger"  data-toggle="modal" data-target="#myModal">
               <td class="idnumber"><%=i%></td>
               <td><%=info.getStuName()%></td>
               <td><%=info.getStuSex()%></td>
               <td><%=info.getGrade()%></td>
               <td><%=info.getBirthDay()%></td>
           </tr>
           <%
             }}
           %>
            </tbody>
        </table>
    </div>
    <input id="classid" value="<%=attendInfo.getClassId()%>" hidden/>
    <a href="class_detail_test.jsp?major=<%=attendInfo.getMajorDetailId()%>" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
    <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width:1000px;margin-left:-200px;height:500px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" style="font-family: 楷体">核对学员及报名班级信息</h4>
            </div>
            	<div class="yyh" style="margin-left:50px; font-size:18px;" hidden>
            		您的报名预约号为：<span style="color:red"></span><br><br>
            		提示：	您已经成功报名，凭预约号在过期日期前到成都青少年宫办理缴费手续 或点此下面支付按钮进行支付。
            		
            	</div>
    			
            	<input type="hidden" value="" id="stuId"></input>
            	<hr class="payhr" style="width:100%;" hidden>
            	<span>
            	支付说明：支付成功后，上课之前如需退费，仅支持原路退至您
					的(支付宝、微信)支付账户。请不要找他人代刷支付学费，若钱
					款损失，责任自负。开课三次后不再办理退费。谢谢合作！
				</span>
				<div class="checkbox">
				    <label>
				      <input type="checkbox" id="checkknow">我已阅读并知晓以上信息。
				    </label>
				</div>
           		 <ul class="payBtu" hidden>
              		<li style="float:left;margin-left:200px;"><a class="pay_weixin"><img src="<%=path %>/static/img/pay/weixin.png"/></a></li>
              		<li ><a class="pay_zifubao"><img src="<%=path %>/static/img/pay/zhifubao.png"/></a></li>
              	</ul>
              <div class="modal-body" id="firstmodal">
                <div class="form-group" style="float:left;width:50%;">
                    <label for="classCode" class="col-sm-2 control-label"  style="width:20%">班级代码</label>
                    <div class="col-sm-10"  style="width:80%">
                        <input type="text" class="form-control" id="classCode" value="">
                    </div>
                </div>


                <div class="form-group" style="width:50%;float:right">
                    <label for="className" class="col-sm-2 control-label"  style="width:20%">班级名称</label>
                    <div class="col-sm-10"  style="width:80%">
                        <input type="text" class="form-control" id="className" value="">
                    </div>
                </div>

                <div class="form-group" style="float:left;width:50%;">
                    <label for="major" class="col-sm-2 control-label" style="width:20%">专业</label>
                    <div class="col-sm-10" style="width:80%">
                        <input type="text" class="form-control" id="major" value="<%=attendInfo.getMajorDetail()%>">
                    </div>
                </div>

				
                <div class="form-group" style="width:50%;float:right">
                    <label for="cost" class="col-sm-2 control-label" style="width:20%">费用</label>
                    <div class="col-sm-10" style="width:80%">
                        <input type="text" class="form-control" id="cost" value="">
                    </div>
                </div>
            </div>
            <div class="modal-body">
            
                        <div class="form-group" style="width: 50%;float: left">
                            <label for="firstname" class="col-sm-2 control-label" style="width:20%">学员姓名</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="firstname" value="" >
                            </div>
                        </div>
<br>
                        <div class="form-group" style="width: 50%;float: right">
                            <label for="stubirthday" class="col-sm-2 control-label" style="width:20%">出生日期</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="stubirthday" value="">
                            </div>
                        </div>
<br>

                        <div class="form-group" style="width: 50%;float: left">
                            <label for="parentphone" class="col-sm-2 control-label" style="width:20%">家长手机</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="parentphone" value="" >
                            </div>
                        </div>
<br>
                        <div class="form-group" style="width: 50%;float: right">
                            <label for="identId" class="col-sm-2 control-label" style="width:20%">身份证号</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="identId" value="">
                            </div>
                        </div>
<br>

                        <div class="form-group" style="width: 50%;float: left">
                            <label for="school" class="col-sm-2 control-label" style="width:20%">就读学校</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="school" value="">
                            </div>
                        </div>
                        
                        <div class="form-group" style="width: 50%;float: right">
                            <label for="sex" class="col-sm-2 control-label" style="width:20%">学员性别</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="sex" value="">
                            </div>
                        </div>
<br>
                        <div class="form-group" style="width: 50%;float: left">
                            <label for="parentname" class="col-sm-2 control-label" style="width:20%">家长姓名</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="parentname" value="">
                            </div>
                        </div>

<br>
                        <div class="form-group" style="width: 50%;float: right">
                            <label for="familyphone" class="col-sm-2 control-label" style="width:20%">家庭电话</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="familyphone" value="">
                            </div>
                        </div>
<br>
                        <div class="form-group" style="width: 50%;float: left">
                            <label for="grade" class="col-sm-2 control-label" style="width:20%">就读年级</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="grade" value="">
                            </div>
                        </div>
<br>

                        <div class="form-group" style="width: 50%;float: right">
                            <label for="bz" class="col-sm-2 control-label" style="width:20%">备注</label>
                            <div class="col-sm-10" style="width:80%">
                                <input type="text" class="form-control" id="bz" value="">
                            </div>
                        </div>
            </div>
          
           <div class="footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left:830px;" id="close">关闭</button>
                <button type="button" class="btn btn-primary" id="attend">报名缴费</button>
            </div>  
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
