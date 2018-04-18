<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="WEB-INF/views/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>班级列表</title>
    <!-- Bootstrap -->
    <%@ include file="WEB-INF/views/common/head.jsp" %>
    <script type="text/javascript" src="<%=path %>/static/js/sis/query.js" ></script>
    <link rel="icon" href="/static/img/icon.png" type="image/x-icon"/>
    <script type="text/javascript" src="<%=path %>/static/js/sis/class_detail.js"></script>
     <script src="<%=path %>/static/js/sis/common/showDate.js"></script>
    <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
    <link href="<%=path %>/static/css/sis/button.css" rel="stylesheet" />
     <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />
    <style type="text/css">
        body{
            background-image:url("static/img/background_index_old.png");
            background-repeat: no-repeat;
        }
        html,body{
            width:1280px;
            height:1024px;
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
</head>
<body>
<input value="<%=request.getParameter("major") %>" type="hidden" id="majorInfo"/>
<h1 class="page-header"><button type="button" class="button red side" style="width: 200px">班级列表</button></h1>
<div class="container-fluid">
        <div class="showDate">
            <span class="date">日期</span>
        </div>

    <div class="row" style="margin-top: 20em;text-align: center" id="mainTable">
        <div class="col-md-10" style="margin-left: 100px">
            <table class="table table-bordered" id="classTable" style="background: white;height: 100%;">
            </table>
        </div>
    </div>
         <a href="major.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
    <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</div>
<!-- 短信验证 -->
<div id="phoneNumberDIV" style="text-align: center;width:1280px; height:1024px;" hidden>

    <div class="showDate">
        <span class="date">日期</span>
    </div>

    <div style="text-align: center;width: 30%;margin: 0 auto">
        <input type="text" class="form-control" id="phoneNumber" placeholder="请输入手机号码" style="margin-top: 350px;height: 50px;font-size: 35px">
        <a id="code" style="position: absolute;top: 340px;left:860px;height: 50px"><img src="<%=path %>/static/img/sure.png"></a>
    </div>
    <script>
            $(function () {
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
                    if(keepPhone.length!=11){
                        layer.msg("无效手机号", {
                            icon : 5
                        });
                        return ;
                    }
                    isGetCode = 1;
                    $.ajax({
                        url:'<%=basePath %>info/getAccountInfo.do',
                        type:'POST', //GET
                        async:true,    //或false,是否异步
                        data:{
                            phoneNumber:keepPhone ,
                            classCode:$("#classId").val()
                        },
                        success:function(data){
                            if(data=="SUCCESS"){
                            	window.location="childList.jsp";
                            }else{
                                layer.msg("账号不存在或未绑定学员，请先注册", {
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
    <div style="width: 80%;margin: 0 auto">
        <table class="numberTable" style="text-align: center;width: 100%;margin-top:50px">
            <tr><td class="number">1</td><td class="number">2</td><td class="number">3</td></tr>
            <tr><td class="number">4</td><td class="number">5</td><td class="number">6</td></tr>
            <tr><td class="number">7</td><td class="number">8</td><td class="number">9</td></tr>
            <tr><td class="clean">重输</td><td class="number">0</td><td class="delete">删除</td></tr>
        </table>
        <input value="" id="classId" hidden/>
    </div>
    <%
    	String major = request.getParameter("major");
    	if(major==null || major ==""){
    %>
    	 <a href="area.jsp" class="stepBtu"><img src="<%=path %>/static/img/back.png"></a>
    <% 
    	}else{
    %>
    <a href="class_detail_test.jsp?major=<%=request.getParameter("major") %>" class="stepBtu"><img src="<%=path %>/static/img/back.png"></a>
	<% 
    	}
    %>
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
    });
</script>
</body>
</html>
