<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="WEB-INF/views/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>缴费</title>
    <!-- Bootstrap -->
    <%@ include file="WEB-INF/views/common/head.jsp" %>
	<script type="text/javascript" src="<%=path %>/static/js/sis/pay.js" ></script>
  	<link rel="stylesheet" href="<%=path %>/static/form_wizard/steps/jquery.steps.css" />
  	<link rel="stylesheet" href="<%=path %>/static/datatimepicker/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="<%=path %>/static/datatimepicker/bootstrap-datetimepicker.min.js" ></script>
    <script type="text/javascript" src="<%=path %>/static/datatimepicker/bootstrap-datetimepicker.zh-CN.js" ></script>
  	<script type="text/javascript" src="<%=path %>/static/form_wizard/steps/jquery.steps.min.js" ></script>
	<script type="text/javascript" src="<%=path %>/static/form_wizard/validate/jquery.validate.min.js" ></script>
	<script type="text/javascript" src="<%=path %>/static/form_wizard/validate/messages_zh.min.js" ></script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
    </div>
    <div class="row" style="margin-top: 2em;margin-left:10px;margin-right: 10px">
       <div class="col-sm-12">
           <div class="ibox">
               <div class="ibox-content">
                   <h2>缴费</h2>
                   <form id="form" action="" class="wizard-big">
                       <h1>第一步</h1>
                       <fieldset>

                       </fieldset>
                       <h1>第二步</h1>
                       <fieldset>
                           <h2></h2>
                       </fieldset>

                       <h1>第三步</h1>
                       <fieldset>
                       </fieldset>
                   </form>
               </div>
           </div>
       </div>
   </div>
 </div>
</body>
</html>
