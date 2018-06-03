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
    <!--打印控件-->
    <script language="javascript" src="<%=path %>/static/print/LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
               <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>

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
        .print_container{
            padding: 5px;
            font-size: 12px;
        }
        .section1{
        }
        .section2 label{
            display: block;
        }
        .section3 label{
            display: block;
        }

    </style>
</head>
<body>
<%
    ClassDetail classDetail = (ClassDetail)request.getSession().getAttribute("jf_stu_classInfo");
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("studentName");
   /* String  name="";
    if(null!=studentName && (!"".equals(studentName))){
        byte[] b = studentName.getBytes("iso-8859-1");
        name = new String(b,"UTF-8");
    }*/
%>
<input id="stuId" value="<%=request.getParameter("studentId") %>" hidden/>
<input id="stuName" value="<%=name %>" hidden/>
<h1 class="page-header"><button type="button" class="button red side" style="width: 250px">缴费完成</button></h1>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <div class="listTable" style="text-align: center;width: 100%;margin-top: 300px">
        <table class="table table-hover" style="width: 100%;margin: 0 auto;text-align: center" >
            <thead>
            <tr style="text-align: center;font-size: 25px;font-family: 楷体" >
                <th style="text-align: center">学生姓名</th>
                <th style="text-align: center">班级代码</th>
                <th style="text-align: center">班级名称</th>
                <th style="text-align: center">专业</th>
                <th style="text-align: center">课表</th>
                <th style="text-align: center">学期</th>
                <th style="text-align: center">学年</th>
                <th style="text-align: center">开课时间</th>
                <th style="text-align: center">开课次数</th>
                <th style="text-align: center">费用</th>
            </tr>
            </thead>
            <tbody>
               <tr class="userInfo" style="cursor: pointer;font-size: 20px;">
                   <td><%= classDetail.getStudentName()%></td>
                   <td><%=classDetail.getClassCode() %></td>
                   <td><%=classDetail.getClassName() %></td>
                   <td><%=classDetail.getMajor() %></td>
                   <td><%= classDetail.getScheduleInfo()%></td>
                   <td><%= classDetail.getSemester()%></td>
                   <td><%= classDetail.getTerm()%></td>
                   <td><%= classDetail.getBeginTime()%></td>
                   <td><%= classDetail.getTimes()%></td>
                   <td><%= classDetail.getCost()%></td>
                   <%--<td><button style="width:50px;" id="printbtu_<%=classDetail.getClassCode() %>" value="<%=classDetail.getClassCode() %>" type="button" class="btn btn-primary" data-toggle="button" onclick="printme(this.value)">打印</button></td>--%>
               </tr>
            </tbody>
        </table>
<%--
        <button style="margin-left:900px;width:130px;" id="printbtu" type="button" class="btn btn-primary" data-toggle="button">打印</button>
--%>
        <script>


            var LODOP;
            function printme(classCode)
            {
                var time=getNowFormatDate();
                $("#printTime").html("打印时间："+time);
                $.ajax({
                    url: 'print/getRecord.do',
                    type: 'POST', //GET
                    async: true,    //或false,是否异步
                    data: {
                        classId: classCode,
                        studentId: $("#stuId").val(),
                        studentName: $("#stuName").val()
                    },
                    success: function (data) {
                        if (data.status == "ture") {
                            prn1_print(classCode)
                            $.ajax({
                                url: 'print/record.do',
                                type: 'POST', //GET
                                async: true,    //或false,是否异步
                                data: {
                                    classId: classCode,
                                    studentId: $("#stuId").val(),
                                    studentName: $("#stuName").val()
                                },
                            });
                        }
                    }}
                    )

            }
            function prn1_print(classCode) {
                CreateOneFormPage(classCode);
                LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW",1);

                LODOP.SET_PRINT_PAGESIZE(3,"72mm","15mm","");
                LODOP.PRINT();

                $("#printbtu_"+classCode).attr("disabled", true);
            };
            function CreateOneFormPage(classCode){
                LODOP=getLodop();
                LODOP.PRINT_INITA(0,0,"72mm","15mm","");
                LODOP.SET_PRINT_STYLE("FontSize",12);
                LODOP.SET_PRINT_STYLE("Bold",1);
                var hei = $('#printInfo_'+classCode).outerHeight();
                hei=hei+50;
                LODOP.ADD_PRINT_HTM(0,0,"72mm",hei,document.getElementById("printInfo_"+classCode).innerHTML);

            };

        </script>
        <!-- 打印DIV -->
        <div id="printInfo_<%=classDetail.getClassCode() %>" class="print_container" style="display: none">
            <div class="section1">
              成都市青少年宫
           </div>
            <div class="section1">
                培训中心自助机业务信息单
            </div>
            <span>**************************</span>
            <div class="section2">
                <label>预约号：<%= classDetail.getReserveNo()%></label><br>
                <label>姓名：<%= classDetail.getStudentName()%></label><br>
                <label>班级代码：<%=classDetail.getClassCode() %></label><br>
                <label>班级名称：<%=classDetail.getClassName() %></label><br>
                <label>专业：<%=classDetail.getMajor() %></label><br>
                <label>上课时间：<%= classDetail.getScheduleInfo()%></label><br>
                <label>开课时间：<%= classDetail.getBeginTime()%></label><br>
                <label>学年：<%= classDetail.getTerm()%></label><br>
                <label>学期：<%= classDetail.getSemester()%></label><br>
                <label>课次：<%= classDetail.getTimes()%></label><br>
                <label>学费：<%= classDetail.getCost()%></label><br>

            </div>
            <span>**************************</span><br>
           <label id="printTime"></label><br>
            <label>打印次数：<%=classDetail.getPrintNum()%></label><br>
            <span>**************************</span><br>
             <label>开课三次后不能退费,敬请理解</label><br>
        </div>

        </div>
        <div class="printDiv" id="printId" hidden>
            <tr><td>学生姓名</td><td><%= classDetail.getStudentName()%></td></tr>
            <tr><td>班级代码</td><td><%=classDetail.getClassCode() %></td></tr>
            <tr><td>班级名称</td><td><%=classDetail.getClassName() %></td></tr>
            <tr><td>专业</td><td><%=classDetail.getMajor() %></td></tr>
            <tr><td>课表</td><td><%= classDetail.getScheduleInfo()%></td></tr>
            <tr><td>学期</td><td><%= classDetail.getSemester()%></td></tr>
            <tr><td>学年</td><td><%= classDetail.getDate()%></td></tr>
            <tr><td>开课次数</td><td><%= classDetail.getTimes()%></td></tr>
            <tr><td>费用</td><td><%= classDetail.getCost()%></td></tr>
        </div>
    </div>
<div><a class="printBtu" id="print_id" onclick="printme('<%=classDetail.getClassCode() %>')"><img id="print_img" src="<%=path %>/static/img/printButton.png"></a></div>
    <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</div>
<script>
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var seperator2 = ":";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
        return currentdate;
    }
    $(function(){

    $("#myprinttime").html("打印时间:"+getNowFormatDate());
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
