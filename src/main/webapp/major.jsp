<%--
  Created by IntelliJ IDEA.
  User: 13046
  Date: 2017/11/2
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="WEB-INF/views/common/taglibs.jsp"%>
<%@ include file="WEB-INF/views/common/head.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="<%=path %>/static/img/icon.png" type="image/x-icon"/>
    <link href="<%=path %>/static/css/sis/major.css" rel="stylesheet" />
    <script type="text/javascript" src="<%=path %>/static/js/jquery-3.1.1.js" ></script>
    <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />
    <link href="<%=path %>/static/css/sis/button.css" rel="stylesheet" />
    <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
    <script src="<%=path %>/static/js/sis/common/showDate.js"></script>
    <title>专业大类</title>
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
    <div class="main">
        <div class="showDate">
            <span class="date">日期</span>
        </div>
		<input value="<%=request.getParameter("area")%>" id="area" type="hidden"/>
        <div class="majorList">
        	<a id="li_1_1" class="科技类"><img class="img" src="<%=path %>/static/img/major/major_keji.png"></a>
            <a id="li_1_2" class="美术类"><img class="img" src="<%=path %>/static/img/major/major_meishu.png"></a>
            <a id="li_1_3" class="实践类"><img class="img" src="<%=path %>/static/img/major/major_shijian.png"></a>
            <a id="li_1_4" class="书法类"><img class="img" src="<%=path %>/static/img/major/major_shufa.png"></a>
            <a id="li_3_0" class="戏曲类"><img class="img" src="<%=path %>/static/img/major/major_xiqu.png"></a>
            <a id="li_3_1" class="舞蹈类"><img class="img" src="<%=path %>/static/img/major/major_wudao.png"></a>
            <a id="li_2_2" class="外语类"><img class="img" src="<%=path %>/static/img/major/major_waiyu.png"></a>
            <a id="li_2_3" class="文化类"><img class="img" src="<%=path %>/static/img/major/major_wenhua.png"></a>
            <a id="li_2_1" class="语言类"><img class="img" src="<%=path %>/static/img/major/major_yyby.png"></a>
            <a id="li_3_2" class="音乐类"><img class="img" src="<%=path %>/static/img/major/major_yinyue.png"></a>
            <a id="li_4_1" class="体育类"><img class="img" src="<%=path %>/static/img/major/major_tiyu.png"></a>
            <a id="li_4_2" class="综合类"><img class="img" src="<%=path %>/static/img/major/major_zh.png"></a>
        </div>
        <div class="major_table">
        	<table class="table" style="margin-top: 300px">
			  <tbody>
			  </tbody>
			</table>
        </div>
        <script>
		        $(function(){
		        	$(".table").hide();
		        	$("a").click(function(){
		        		var majorBtu = $(this);
		        		majorBtu.click(function(){
		        			location.reload();
		        		});
			        	var majorName = majorBtu.attr('class');
			        	$.ajax({
			          	  type: 'POST',
			          	  url: "info/majorDetail.do",
			          	  data: {area:$("#area").val(),major:majorName},
			          	  success: function(data){
			          		 var $aList = $(".img");
			          		 $aList.each(function(){
			          			 var $this = $(this).parent("a");
			          			 if($this.attr('class') != majorName){
			          				 $this.fadeOut("slow");
			          			 }
			          		 });
			          		  majorBtu.animate({
			          		    left:'40px',
			          		    top:'180px',
			          		  });
			          		  showTable(data);
			          	  },
			          	});
		        	});
		        	
		        	function showTable(data){
		        		var nameList = data.nameList;
		        		var idList = data.idList;
		        		$(".table").fadeIn("slow");
		        		var id = 0 ; 
		        		for(var i = 0 ; i < 8 ; i ++){
		        			$(".table").append("<tr><td id="+(++id)+"></td><td id="+(++id)+"></td><td id="+(++id)+"></td><td id="+(++id)+"></td></tr>");
		        		}
		        		$(".table td").css("border-top-style","none");
		        		var len = nameList.length;
		        		for(var k = 1 ; k <= len;k++){
		        			$("#"+k).html("<a class='majora' href='class_detail_test.jsp?major="+idList[k-1]+"'><button type='button' class='button blue'>"+nameList[k-1]+"</button></a>");
		        		}
		        	}
		        });
        </script>
        <a href="area.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
        <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
    </div>
</body>
</html>





         <%--  <ul class="majorul">
                    <li>
                        <ul class="major"  id="majorList_fir">
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=科技类"><img src="<%=path %>/static/img/major/major_keji.png"></a></li>
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=美术类"><img src="<%=path %>/static/img/major/major_meishu.png"></a></li>
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=实践类"><img src="<%=path %>/static/img/major/major_shijian.png"></a></li>
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=书法类"><img src="<%=path %>/static/img/major/major_shufa.png"></a></li>
                        </ul>
                    </li>
                    <li>
                        <ul class="major" id="majorList_sec">
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=舞蹈类"><img src="<%=path %>/static/img/major/major_wudao.png"></a></li>
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=外语类"><img src="<%=path %>/static/img/major/major_waiyu.png"></a></li>
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=文化类"><img src="<%=path %>/static/img/major/major_wenhua.png"></a></li>
                        </ul>
                    </li>
                    <li>
                        <ul class="major"  id="majorList_thr">
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=语言表演类"><img src="<%=path %>/static/img/major/major_yyby.png"></a></li>
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=音乐类"><img src="<%=path %>/static/img/major/major_yinyue.png"></a></li>
                        </ul>
                    </li>
                    <li>
                        <ul class="major"   id="majorList_foth">
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=体育类"><img src="<%=path %>/static/img/major/major_tiyu.png"></a></li>
                            <li><a href="ageAndCalendar.jsp?area=<%=request.getParameter("area")%>&major=综合类"><img src="<%=path %>/static/img/major/major_zh.png"></a></li>
                        </ul>
                    </li>
                </ul> --%>
