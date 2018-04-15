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
        .numberTable td{
            border:1px solid #2aabd2;
            cursor: pointer;
            width: 150px;
            height: 100px;
            font-size: 45px;
        }
    </style>
<head>
    <link rel="icon" href="<%=path %>/static/img/icon.png" type="image/x-icon"/>
    <script type="text/javascript" src="<%=path %>/static/js/jquery-3.1.1.js" ></script>
    <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />
    <script src="<%=path %>/static/js/sis/common/showDate.js"></script>
      <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
        <link href="<%=path %>/static/css/sis/button.css" rel="stylesheet" />
            <!-- 二维码插件 -->
	<script type="text/javascript" src="<%=path %>/static/jquery-qrcode-master/jquery.qrcode.min.js"></script>
    <title>缴费</title>
</head>
<body>
<h1 class="page-header"><button type="button" class="button red side" style="width: 440px">预约号直接缴费通道</button></h1>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <div style="text-align: center;width: 30%;margin: 0 auto;">
       	<span style="position: absolute;top: 355px;left:380px;font-size:45px">cd</span><input type="text" class="form-control" id="phoneNumber" placeholder="请输入预约号数字部分" style=";width:80%;margin-top: 360px;height: 50px;font-size: 25px">
        <a id="code" style="position: absolute;top: 350px;left:820px;height: 55px"><img src="<%=path %>/static/img/sure.png"></a>
    </div>

    <script>
            $(function () {
            	
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
                  
               $(".numberTable td").mousedown(function(){
                   $(this).css("background","white");
               });

                $(".numberTable td").mouseup(function(){
                    $(this).css("background","");
                });

                $(".number").mousedown(function(){
                    var val = $(this).text();
                    var phoneNumber = $("#phoneNumber").val();
                    var nowNubmer = phoneNumber+""+val;
                    if(nowNubmer.length<=11){
                        $("#phoneNumber").val(nowNubmer);
                    }
                });

                $(".clean").mousedown(function(){
                    $("#phoneNumber").val("");
                });

                $(".delete").mousedown(function(){
                    var phone = $("#phoneNumber").val();
                    var phone = phone.substring(0,phone.length-1);
                    $("#phoneNumber").val(phone);
                });

                var fun = Object;
                var times = 60;
                var keepPhone = 12345678952;
                var isGetCode = 0;
                $("#code").click(function(){
                    if(isGetCode==0){
                        keepPhone=$("#phoneNumber").val();
                    }
                    if(keepPhone.length!=6){
                        layer.msg("无效预约号", {
                            icon : 5
                        });
                        return ;
                    }
                    isGetCode = 1;
                    $.ajax({
                        url:'pay/getBookingInfo.do',
                        type:'POST', //GET
                        async:true,    //或false,是否异步
                        data:{
                            phoneNumber:"cd"+keepPhone
                        },
                        success:function(data){
                        	if(data == "SUCCESS"){
                        		layer.msg("正确", {
                                    icon : 1
                                });
                        		window.location.href = "childList_pay.jsp";
                        	}else{
                        		layer.msg("预约号错误", {
                                    icon : 5
                                });
                        	}
                        },
                        error:function(){
                            layer.msg("网络异常，请稍后重试", {
                                icon : 5
                            });
                        },
                    });
                });
            });
    </script>
    <script >
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
    <div style="width: 80%;margin: 0 auto">
        <table class="numberTable" style="text-align: center;width: 100%;margin-top:50px">
            <tr><td class="number">1</td><td class="number">2</td><td class="number">3</td></tr>
            <tr><td class="number">4</td><td class="number">5</td><td class="number">6</td></tr>
            <tr><td class="number">7</td><td class="number">8</td><td class="number">9</td></tr>
            <tr><td class="clean">重输</td><td class="number">0</td><td class="delete">删除</td></tr>
        </table>
        <input value="" id="classId" hidden/>
    </div>
   <a href="index.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
   <!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="ture">
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
            	<hr class="payhr" style="width:100%;" hidden>
           		 <ul class="payBtu" hidden>
              		<li style="float:left;margin-left:200px;"><a class="pay_weixin"><img src="<%=path %>/static/img/pay/weixin.png"/></a></li>
              		<li ><a class="pay_zifubao"><img src="<%=path %>/static/img/pay/zhifubao.png"/></a></li>
              	</ul>
              	<!-- 二维码 -->
              	<div id="codeshow" hidden style="margin-top:35px;margin-left:400px;"></div>
              <div class="modal-body">
              	
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
                        <input type="text" class="form-control" id="major" value="美术类">
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
                <button type="button" class="btn btn-primary" id="attend">确认</button>
            </div>  
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
      <script>
        $(function(){
        
            $("#attend").click(function(){
    			
                        	$(".yyh span").text("cd685974");
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
                           		$("#codeshow").show();
                           		$("#codeshow").qrcode({ 
                           		    render: "table", //table方式 
                           		    width: 200, //宽度 
                           		    height:200, //高度 
                           		    text: toUtf8("陆晨曦") //任意内容 
                           		});
                       		});
                       		$(".pay_zifubao").click(function(){
                       			$(".payBtu").hide();
                           		$(".yyh").hide();
                           		$(".payhr").hide();
                           		$("#codeshow").show();
                           		$("#codeshow").qrcode({ 
                           		    render: "table", //table方式 
                           		    width: 200, //宽度 
                           		    height:200, //高度 
                           		    text: toUtf8("陆晨曦") //任意内容 
                           		});
    						});
                       		window.setTimeout(function(){
                                window.location.href="schedule.jsp";
                            },5000);
                       		
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
</div>
</body>
</html>
