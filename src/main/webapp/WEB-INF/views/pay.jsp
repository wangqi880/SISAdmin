<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>用户列表</title>
    <!-- Bootstrap -->
    <%@ include file="common/head.jsp" %>
	<script type="text/javascript" src="<%=path %>/static/js/sms/stockAdd.js" ></script>
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
                   <h2>商品入库</h2>
                   <form id="form" action="<%=path %>/stock/addGood" class="wizard-big">
                       <h1>商品信息</h1>
                       <fieldset>
                           <div class="row">
                               <div class="col-sm-8">
                                   <div class="form-group">
                                       <label>商品名 *</label>
                                       <input name="name" type="text" class="form-control required">
                                   </div>
                                    <div class="form-group">
                                       <label>商品类型 *</label>
                                       <input name="type" type="text" class="form-control required">
                                   </div>
                                   <div class="form-group">
                                       <label>商品数量 *</label>
                                       <input name="num" type="text" class="form-control required">
                                   </div>
                               </div>
                           </div>

                       </fieldset>
                       <h1>介绍</h1>
                       <fieldset>
                           <h2></h2>
                           <div class="row">
                               <div class="col-sm-8">
                                   <div class="form-group">
                                       <label>单价 *</label>
                                       <input name="price" type="text" class="form-control required">
                                   </div>
                                   <div class="form-group">
                                       <label>生产厂商 *</label>
                                       <input name="factory" type="text" class="form-control required">
                                   </div>
                                   <div class="form-group">
                                       <label>供应商 *</label>
                                       <input name="supplier" type="text" class="form-control required">
                                   </div>
                               </div>
                           </div>
                       </fieldset>

                       <h1>说明</h1>
                       <fieldset>
                       <div class="row">
                          <div class="form-group">
                              <label class="control-label">商品入库时间 *</label>
								<div class='input-group date' id='inputTime' style="width: 500px">  
					                <input type='text' class="form-control" name="date" placeholder="开始时间"/>  
					                <span class="input-group-addon">  
					                    <span class="glyphicon glyphicon-calendar"></span>  
					                </span>  
				            	</div> 
                           </div>
                           <div class="form-group">
                            	<label>商品说明：</label>
                            	<textarea name="instruction" class="form-control" aria-required="false" rows="4"></textarea>
                     		</div>
                     </div>
                       </fieldset>
                   </form>
               </div>
           </div>
       </div>
   </div>
 </div>
</body>
</html>