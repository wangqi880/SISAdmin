<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file=common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>班级列表</title>
    <!-- Bootstrap -->
    <%@ include file="common/head.jsp" %>
    <script type="text/javascript" src="<%=path %>/static/js/sis/query.js" ></script>
    <script type="text/javascript" src="<%=path %>/static/js/sis/class_detail.js"></script>
    <style type="text/css">
        body{
            background-image:url("<%=path %>/static/img/background_index.png");
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <%--<div class="row">--%>
        <%--<div class="col-sm-12 main" style="height: 100%;">--%>
            <%--&lt;%&ndash;<h1 class="page-header">班级列表</h1>&ndash;%&gt;--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="row" style="margin-top: 10em;">
        <div class="col-md-10" style="margin-left: 8em">
            <table class="table table-bordered" id="classTable" style="background: white;height: 100%;">
            </table>
        </div>
    </div>
    <div class="row" style="margin-top: 1em;">
         <a href="index.jsp" class="stepBtu"><img src="<%=path %>/static/img/lastStep.png"></a>
    </div>
</div>

</body>
</html>
