<%--
  Created by IntelliJ IDEA.
  User: 13046
  Date: 2017/11/2
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="WEB-INF/views/common/taglibs.jsp"%>
<%@ include file="WEB-INF/views/common/head.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <link href="<%=path %>/static/css/sis/area.css" rel="stylesheet" />
    <link rel="icon" href="<%=path %>/static/img/icon.png" type="image/x-icon"/>
    <script type="text/javascript" src="<%=path %>/static/js/jquery-3.1.1.js" ></script>
    <link href="<%=path %>/static/css/sis/stepBtu.css" rel="stylesheet" />
    <script src="<%=path %>/static/js/sis/common/showDate.js"></script>
    <script src="<%=path %>/static/layui/lay/dest/layui.all.js"></script>
    <title>选择报名区域</title>

    <!--打印控件-->
    <script language="javascript" src="<%=path %>/static/print/LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
               <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>
    <style type="text/css">
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
<object id="factory" name="factory" style="display: none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
        codebase="smsx.cab" viewastext></object>
<div class="main">
    <div class="showDate">
        <span class="date">日期</span>
    </div>
    <%
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("studentName");
       /* String  name="";
        if(null!=studentName && (!"".equals(studentName))){
            byte[] b = studentName.getBytes("iso-8859-1");
              name = new String(b,"UTF-8");
        }*/
       /* String name = request.getParameter("studentName");*/
    %>
    <input id="stuId" value="<%=request.getParameter("studentId") %>" hidden/>
    <input id="stuName" value="<%=name %>" hidden/>
    <div class="tab" style="text-align:center;margin-top:250px;">
        <blockquote class="layui-elem-quote" id="print_year_term_show">

        </blockquote>
        <div class="layui-form">
            <table class="layui-table" style="margin:0 auto">
                <colgroup>
                    <col width="120">
                    <col width="120">
                    <col width="120">
                    <col width="120">
                    <col width="120">
                    <col width="120">
                    <col width="120">
                    <col width="120">
                    <col width="120">
                    <col width="120">

                </colgroup>
                <thead>
                <tr style="text-align: center">
                    <th style="text-align:center">姓名</th>
                    <th style="text-align:center">班级代码</th>
                    <th style="text-align:center">班级名称</th>
                    <th style="text-align:center">专业</th>
                    <th style="text-align:center">课程表</th>
                    <th style="text-align:center">学期</th>
                    <th style="text-align:center">学年</th>
                    <th style="text-align:center">开课时间</th>
                    <th style="text-align:center">开课次数</th>
                    <th style="text-align:center">学费</th>

                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
       <%-- <table style="margin:0 auto;width:80%;" class="table">
            <thead><tr style="font-size:24px;text-align:center;"><td>姓名</td><td>班级代码</td><td>班级名称</td><td>专业</td><td>课程表</td><td>学期</td><td>学年</td><td>开课次数</td><td>学费</td></tr></thead>
            <tbody>
            </tbody>
        </table>--%>
    </div>
    <script>

        var LODOP;
        function printme(classCode)
        {
          //  alert($("#stuName").val())
            $.ajax({
                url:'print/getRecord.do',
                type:'POST', //GET
                async:true,    //或false,是否异步
                data:{
                    classId:classCode,
                    studentId : $("#stuId").val(),
                    studentName: $("#stuName").val()
                },
                success:function(data){
                    if(data.status=="ture"){
                        prn1_print(classCode);
                        //记录打印日志
                        $.ajax({
                            url:'print/record.do',
                            type:'POST', //GET
                            async:true,    //或false,是否异步
                            data:{
                                classId:classCode,
                                studentId : $("#stuId").val(),
                                studentName: $("#stuName").val()
                            },
                        });
                    }else{
                        layer.msg(data.messageinfo, {
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
        }
        function prn1_print(classCode) {
            CreateOneFormPage(classCode);
            LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW",1);
            LODOP.SET_PRINT_PAGESIZE(3,"72mm","15mm","");
          /*  LODOP.PREVIEW();*/
            LODOP.PRINT();

            $("#printbtu_"+classCode).attr("disabled", true);
        };
        function CreateOneFormPage(classCode){
            LODOP=getLodop();
            LODOP.PRINT_INITA(0,0,"72mm","15mm","");
            LODOP.SET_PRINT_STYLE("FontSize",12);
            LODOP.SET_PRINT_STYLE("Bold",1);
            var hei = $('#printInfo_'+classCode).outerHeight();
            hei=hei;
            LODOP.ADD_PRINT_HTM(0,0,"72mm",hei,document.getElementById("printInfo_"+classCode).innerHTML);

        };

    </script>
    <%--<button style="margin-left:900px;width:130px;" id="printbtu" type="button" class="btn btn-primary" onclick="printme()" data-toggle="button">打印</button>--%>
    <div><a class="printBtu" id="print_id" onclick="print()"><img id="print_img"></a></div>
    <a href="<%=basePath %>index.jsp" class="indexBtu"><img src="<%=path %>/static/img/trunIndex.png"></a>
</div>
<!-- 打印DIV -->
<div class="printDiv" id="printId" hidden>
</div>
<script language="javascript">

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
    var classId="";
    function print() {
        printme(classId);
    }
    $(function(){
        $.ajax({
            url:'info/getPrintInfo.do?studentId='+$("#stuId").val()+"&studentName="+$("#stuName").val(),
            type:'POST', //GET
            async:false,    //或false,是否异步
            success:function(data){
                var status = data.status;
                if(status == "SUCCESS"){
                    layer.msg("等待加载打印信息", {
                        icon : 1
                    });
                    var classinfo = data.classinfo;
                    var printYear=data.controlYear;
                    var printTerm = data.controlTerm;
                    $("#print_year_term_show").append("打印控制:学年-"+printYear+",学期-"+printTerm+"");
                    for(var i =0; i < classinfo.length;i++){
                        classId=classinfo[i].classCode;
                        var info = '<tr style="text-align:center">' +
                            '<td style="text-align:center">'+classinfo[i].studentName+'</td>' +
                            '<td style="text-align:center" class="classcode">'+classinfo[i].classCode+'</td>' +
                          '<td style="text-align:center">'+classinfo[i].className+'</td>' +
                           '<td style="text-align:center">'+classinfo[i].major+'</td>' +
                            '<td style="text-align:center">'+classinfo[i].scheduleInfo+'</td>' +
                             '<td style="text-align:center">'+classinfo[i].semester+'</td>' +
                              '<td style="text-align:center">'+classinfo[i].term+'</td>' +
                            '<td style="text-align:center">'+classinfo[i].beginTime+'</td>' +
                            '<td style="text-align:center">'+classinfo[i].times+'</td>' +
                                '<td style="text-align:center">'+classinfo[i].cost+'</td>' +
                                 '</tr>'
                        var printInfo='<div id="printInfo_'+classinfo[i].classCode+'"class="print_container" style="display: none;font-size: 10px">\n' +
                            '        <div class="section1">\n' +
                            '            成都市青少年宫\n' +
                            '        </div>\n' +
                            '        <div class="section1">\n' +
                            '        培训中心自助机业务信息单\n' +
                            '        </div>\n' +
                            '        <span>**************************</span>\n' +
                            '        <div class="section2">\n' +
                            '            <label>预约号：'+classinfo[i].reserveNo+'</label><br>\n' +
                            '            <label>姓名：'+classinfo[i].studentName+'</label><br>\n' +
                            '            <label>班级代码：'+classinfo[i].classCode+'</label><br>\n' +
                            '            <label>班级名称：'+classinfo[i].className+'</label><br>\n' +
                            '            <label>专业：'+classinfo[i].major+'</label><br>\n' +
                            '            <label>上课时间：'+classinfo[i].scheduleInfo+'</label><br>\n' +
                            '            <label>开课时间：'+classinfo[i].beginTime+'</label><br>\n' +
                            '            <label>学年：'+classinfo[i].term+'</label><br>\n' +
                            '            <label>学期：'+classinfo[i].semester+'</label><br>\n' +
                            '            <label>课次：'+classinfo[i].times+'</label><br>\n' +
                            '            <label>学费：'+classinfo[i].cost+'</label><br>\n' +
                            '        </div>\n' +
                            '        <span>**************************</span><br>\n' +
                            '            <label>打印时间：'+getNowFormatDate()+'</label><br>\n' +
                            '            <label>打印次数：'+classinfo[i].printNum+'</label><br>\n' +
                            '        <span>**************************</span><br>\n' +
                            '            <label>开课三次后不能退费,敬请理解</label><br>\n' +
                            '    </div>'
                        $("tbody").append(info).append(printInfo);

                        /*  var info = '<tr style="text-align:center"><td>'+$("#stuName").val()+'</td><td>'+classinfo[i].classCode+'</td><td>'+classinfo[i].className+'</td><td>'+classinfo[i].major+'</td><td>'+classinfo[i].scheduleInfo+'</td><td>'+classinfo[i].semester+'</td><td>'+classinfo[i].term+'</td><td>'+classinfo[i].times+'</td></tr>'
                          $("tbody").append(info);
                          $(".printDiv").append("<table><tr><td>姓名</td><td>"+$("#stuName").val()+"</td></tr><tr><td>班级代码</td><td>"+classinfo[i].classCode+"</td></tr><tr><td>班级名称</td><td>"+classinfo[i].className+"</td></tr><tr><td>专业</td><td>"+classinfo[i].major+"</td></tr><tr><td>课程表</td><td>"+classinfo[i].scheduleInfo+"</td></tr><tr><td>学期</td><td>"+classinfo[i].semester+"</td></tr><tr><td>学年</td><td>"+classinfo[i].term+"</td></tr><tr><td>开课次数</td><td>"+classinfo[i].times+"</td></tr><tr><td>学费</td><td>"+classinfo[i].cost+"</td></tr></table><hr>");
                     */
                        $("#print_img").attr("src","<%=path %>/static/img/printButton.png");
                    }

                }else{
                    layer.msg("暂无打印信息", {
                        icon : 5
                    });
                }
            },
            error:function(){
                layer.msg("网络异常，请前往打印界面打印课表", {
                    icon : 5
                });
                window.location.href="<%=basePath %>index.jsp";
            }
        });
    });
</script>
</body>
</html>
