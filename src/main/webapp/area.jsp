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
<head>
    <link href="<%=path %>/static/css/sis/area.css" rel="stylesheet" />
    <link rel="icon" href="<%=path %>/static/img/icon.png" type="image/x-icon"/>
    <script type="text/javascript" src="<%=path %>/static/js/jquery-3.1.1.js" ></script>
    <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />
    <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
    <link href="<%=path %>/static/css/sis/button.css" rel="stylesheet" />
    <script src="<%=path %>/static/js/sis/common/showDate.js"></script>
    <title>选择报名区域</title>
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
            if(timeOut==30){
                layer.msg("操作超时", {
                    icon : 5
                });
                window.location.href = "index.jsp";
            }
        },1000);
    });
</script>
<div style=""></div>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <div class="search">
    	<h1 class="page-header"><button type="button" class="button red side" style="width: 250px">查找班级</button></h1>
    	<input type="text" class="form-control" id="searchClass" style="font-size: 24px"  placeholder="请输入班级代码数字部分"/>
    	<script>
    		$(function(){
    			$(".unmberkey").hide();
    			$("#searchClass").on("click",function(e){
    				$(".area").hide();
    				$(".unmberkey").show();
    				 $(document).one("click", function(){
    				        $(".unmberkey").hide();
    				        $(".area").show();
    				    });

    				    e.stopPropagation();
    			});
    			$(".unmberkey").on("click", function(e){
    			    e.stopPropagation();
    			});
    			$("#searchBtu").click(function(){
    				var classId = $("#searchClass").val();
    				if(classId != ""){
    					classId = "cd"+classId;
    				}
    			});
    		});
    	</script>
    	<a href="#" class="searchBtu"><img style="height: 60px" src="<%=path %>/static/img/search.png"/></a>
    </div>
    <ul class="area" id="area_top">
        <li><a href="major.jsp?area=1"><img src="<%=path %>/static/img/area/area_suncheng.png"></a></li>
        <li style="margin-left: 55px"><a href="major.jsp?area=2"><img src="<%=path %>/static/img/area/area_xiaonan.png"></a></li>
        <li style="margin-left: 55px"><a href="major.jsp?area=6"><img src="<%=path %>/static/img/area/area_jingchenxiaoqu.png"></a></li>
    </ul>
    <ul class="area" id="area_bottom">
        <li><a href="major.jsp?area=4"><img src="<%=path %>/static/img/area/area_baihuaxilu.png"></a></li>
        <li style="margin-left: 55px"><a href="major.jsp?area=5"><img src="<%=path %>/static/img/area/area_jianshenanlu.png"></a></li>
        <li style="margin-left: 60px"><a href="major.jsp?area=3"><img src="<%=path %>/static/img/area/area_jiulidi.png"></a></li>
    </ul>
    <div class="unmberkey">
    	 <table class="numberTable" style="text-align: center;width: 100%">
            <tr><td class="number">1</td><td class="number">2</td><td class="number">3</td></tr>
            <tr><td class="number">4</td><td class="number">5</td><td class="number">6</td></tr>
            <tr><td class="number">7</td><td class="number">8</td><td class="number">9</td></tr>
            <tr><td class="clean">重输</td><td class="number">0</td><td class="delete">删除</td></tr>
        </table>
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
                    var phoneNumber = $("#searchClass").val();
                    var nowNubmer = phoneNumber+""+val;
                    if(nowNubmer.length<=11){
                        $("#searchClass").val(nowNubmer);
                    }
                });

                $(".clean").mousedown(function(){
                    $("#searchClass").val("");
                });

                $(".delete").mousedown(function(){
                    var phone = $("#searchClass").val();
                    var phone = phone.substring(0,phone.length-1);
                    $("#searchClass").val(phone);
                });
            });
         </script>
   <a href="index.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
    <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</div>
</body>
</html>
