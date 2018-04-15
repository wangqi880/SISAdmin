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
        .container-fluid
        {
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
<script>
    $(function(){
        var timeOut = 0;
        $(window).click(function(){
            timeOut = 0;
        });
        var timeClick = window.setInterval( function  (){
            timeOut = timeOut + 1;
            if(timeOut==150){
                layer.msg("操作超时", {
                    icon : 5
                });
                window.location.href = "index.jsp";
            }
        },1000);
    });
</script>
<h1 class="page-header"><button type="button" class="button red side" style="width: 200px">身份验证</button></h1>
<!-- 短信验证 -->
<div id="phoneNumberDIV" style="text-align: center;width:1280px; height:1024px;" >

    <div class="showDate">
        <span class="date">日期</span>
    </div>

    <div style="text-align: center;width: 30%;margin: 0 auto">
        <input type="text" class="form-control" id="phoneNumber" placeholder="请输入手机号码" style="margin-top: 350px;height: 50px;font-size: 35px">
        <button type="button" class="btn btn-primary" id="code" style="position: absolute;top: 350px;left:860px;height: 50px">获取手机验证码</button>
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
                        keepPhone=$("#phoneNumber").val();
                    if(keepPhone.length!=11){
                        layer.msg("无效手机号", {
                            icon : 5
                        });
                        return ;
                    }
                    isGetCode = 1;
                    $.ajax({
                        url:'info/getPhoneCheckInfo.do',
                        type:'POST', //GET
                        async:true,    //或false,是否异步
                        data:{
                            phoneNumber:keepPhone
                        },
                        success:function(data){
                            if(data=="SUCCESS"){
                                layer.msg("请注意查收手机短信验证码", {
                                    icon : 1
                                });
                                times=120;
                                $("#phoneNumber").val("");
                                $("#phoneNumber").attr("placeholder","请输入手机验证码");
                                window.setInterval(shwoCodeTime,1000);
                                $(".clean").unbind('mousedown');
                                $(".clean").unbind("mouseup");
                                $(".clean").text("确认").css("background","#3366CC").click(ckeck);
                            }else{
                                layer.msg("账号不存在，请先注册", {
                                    icon : 5
                                });
                            }
                        },
                        error:function(){
                            layer.msg("获取验证码失败", {
                                icon : 5
                            });
                        },
                    });
                });
                function shwoCodeTime(){
                    if(times > 0){
                        $("#code").text(times+"s后重新获取").css("background","#C0C0C0");
                        times = times-1;
                        $("#code").attr('disabled',true);
                    }else{
                        clearInterval(fun);
                        $("#code").attr('disabled',false);
                        $("#code").text("获取手机验证码").css("background","#3366CC");
                    }
                }

                function ckeck(){
                    var checkCode = $("#phoneNumber").val();
                    if(checkCode.length!=4){
                    	layer.msg("无效验证码", {
                            icon : 5
                        });
                    	return;
                    }
                    $.ajax({
                        url:'info/checkCodeLogin.do',
                        type:'POST', //GET
                        async:true,    //或false,是否异步
                        data:{
                            phoneCode:checkCode ,
                            phoneNumber:keepPhone,
                        },
                        success:function(data){
                            if(data=="SUCCESS"){
                                window.location="childList_chaxun.jsp";
                            }else{
                                layer.msg("错误验证码，请重新输入", {
                                    icon :5
                                });
                            }
                        },
                        error:function(){
                            layer.msg("网络异常，请稍后重试", {
                                icon : 5
                            });
                        }
                    });
                }
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
     <a href="index.jsp" class="stepBtu"><img src="<%=path %>/static/img/back.png"></a>
    <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</div>
</body>
</html>
