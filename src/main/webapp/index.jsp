<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="WEB-INF/views/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
    <link rel="icon" href="/static/img/icon.png" type="image/x-icon"/>
    <title>欢迎</title>
    <!-- Bootstrap -->
    <%@ include file="WEB-INF/views/common/head.jsp" %>
    <style type="text/css">
        html{
            overflow-x:hidden;
        }
    </style>
    <link href="<%=path %>/static/assets/css/font-awesome.css" rel="stylesheet" />
    <link href="<%=path %>/static/css/sis/index.css" rel="stylesheet" />
    <script src="static/js/sis/common/showDate.js"></script>
<%--    <style type="text/css">
        body{a:text-decoration:none;}
    </style>--%>
</head>
<body>
<script>
	$(function(){
		 $.ajax({
             url:'index/clearSession.do',
             type:'POST', //GET
             async:true,    //或false,是否异步
             success:function(data){
            	
             }
		 });
	});
</script>
    <div class="main">
        <div class="showDate">
            <span class="date">日期</span>
        </div>
<%--        <div class="sztz">
            <div class="title_sztz">
                <ul class="title_sztz_text">
                    <li>素质</li>
                    <li>培训</li>
                </ul>
            </div>
        </div>--%>
        <%--<div class="hdbs">
            <div class="title_hdbs">
                <ul class="title_hdbs_text">
                    <li>活动</li>
                    <li>比赛</li>
                </ul>
            </div>
        </div>--%>
    </div>
    <a id="btu_baoming" href="area.jsp"><img src="static/img/index_baoming.png"/></a>
    <a id="btu_jiaofei" href="jiaofei.jsp"><img src="static/img/index_jiaofei.png"/></a>
    <a id="btu_chaxun" href="phoneCode_chaxun.jsp"><img src="static/img/index_chaxun.png"/></a>
    <a id="btu_dayin" href="phoneCode_dy.jsp"><img src="static/img/index_dayin.png"/></a>
    <!-- 暂时不用 -->
   <%-- <a id="btu_chafeng"><img src="static/img/index_chafeng.png"/></a>
    <a id="btu_cansai"><img src="static/img/index_cansai.png"/></a>
    <a id="btu_dazheng"><img src="static/img/index_dazheng.png"/></a>
    <a id="btu_yuyue"><img src="static/img/index_yuyue.png"/></a>
    <img id="lock" src="static/img/index_lock.png"/>--%>
</body>
</html>
