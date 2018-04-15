<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>用户登录</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap/dist/css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js" ></script>
	<style>
		body {
		    
		}
		.mycenter{
		    margin-top: 100px;
		    margin-left: auto;
		    margin-right: auto;
		    height: 350px;
		    width:500px;
		    padding: 5%;
		    padding-left: 5%;
		    padding-right: 5%;
		}
		.mycenter mysign{
		    width: 440px;
		}
		.mycenter input,checkbox,button{
		    margin-top:2%;
		    margin-left: 10%;
		    margin-right: 10%;
		}
		.mycheckbox{
		    margin-top:10px;
		    margin-left: 40px;
		    margin-bottom: 10px;
		    height: 10px;
		}
		.pass-reglink{
			float:right;
			margin-top:20px;
			margin-right: 15%;
		}
	</style>
</head>
<body>
	<form id="login-form" action="/login/doLogin" method="post">
        <div class="mycenter">
            <div class="mysign">
                <div class="col-lg-11 text-center text-info">
                    <h2>请登录</h2>
                </div>
                <div class="col-lg-10">
                    <input id="username" type="text" class="form-control" name="username" placeholder="请输入账户名" required autofocus/>
                </div>
                <div class="col-lg-10"></div>
                <div class="col-lg-10">
                    <input type="password" class="form-control" name="password" placeholder="请输入密码" required autofocus/>
                </div>
                <input type="hidden" name="bs_code" value="${bs_code }">
                <div class="col-lg-10"></div>
                <div class="col-lg-10 mycheckbox checkbox">
                    <input type="checkbox" class="col-lg-1">记住密码</input>
                </div>
                <div class="col-lg-10"></div>
                <div class="col-lg-10">
                    <button id="btn_submit"  onclick="login.loginSubmin();return false;"  class="btn btn-success col-lg-12">登录</button>
                </div>

            </div>
        </div>
     </form>

<script type="text/javascript">
var redirect="${redirect}";

var login={
	loginSubmin:function(){


		var userdata = $("#login-form").serialize();
		$.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/login/doLogin",
			data:userdata,
			async: false,
			dataType:"json",
			success:function(result){
				if (result.code == 000000){
                    var redirect="<%=request.getContextPath()%>/admin";
                    window.location.href=redirect+"?t="+new Date().getTime();
				} else {
					alert("提示："+result.info);
					return;
				}
			},
			error:function(result){
				
			}
		})
		
	}

};


	
$(function(){
	/* $("#btn_submit").click(function(){
		login.loginSubmin();
		
	}); */
});



function sleep(numberMillis) { 
	var now = new Date(); 
	var exitTime = now.getTime() + numberMillis; 
	while (true) { 
	now = new Date(); 
	if (now.getTime() > exitTime) 
	return; 
	} 
	};
	
function setBusiCookies(token){
	$.ajax({
		type:"get",
		url:"/business/getAllBusiUrl",
		dataType:"json",
		async: false,
		success:function(result){
			if (result.status == 200) {
				for(var i = 0; i < result.data.length; i++){
					
					setDomainCookie(result.data[i],token);
				}
				
				
				//延迟跳转到回调url,setTimeout,setInterval
				window.setTimeout(function()
						{
						 window.location.href=redirect+"?t="+new Date().getTime();
						},500);
				
			} else {
				alert("登录失败，原因是：" + result.msg);
				$("#username").select();
				return;
			}
			
			
			
		},
		error:function(){
			
		}
	});
	//window.location.href=redirect+"?t="+new Date().getTime();
};

function setDomainCookie(busiUrl,token){
	var busiUrl = busiUrl+"?token="+token;
	$.ajax({
		type:"get",
		dataType:"jsonp",
		url:busiUrl,
		async:false,
		crossDomain:true,
		success:function(result){
			
		},
		error:function(){
			
		}
	})
};

</script>



</body>
</html>