<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="WEB-INF/views/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>信息列表</title>
    <!-- Bootstrap -->
    <%@ include file="WEB-INF/views/common/head.jsp" %>
     <script type="text/javascript" src="<%=path %>/static/js/sis/query.js" ></script>
</head>
<body>
<div class="container-fluid">
  	<div class="row">
        <div class="col-sm-12 main" style="height: 100%;">
            <h1 class="page-header">信息列表</h1>
        </div>
    </div>
    <div class="row" style="margin-top: 2em;">
    <div class="col-md-10">
        <div class="col-md-2" style="margin-left: -1em">
			<select class="selectpicker" id="initGoodNo" data-live-search="true" onchange="goodNoRefresh()">
				<option value="商品编号">条件一</option>
				<c:forEach items="${goodNo }" var="goodNo">
					<option value="${goodNo }">${goodNo }</option>
				</c:forEach>
			</select>
		</div>
        <div class="col-md-2" style="margin-left:2em">
			<select class="selectpicker" id="initGoodName" data-live-search="true" onchange="goodNameRefresh()">
				<option value="商品名称">条件二</option>
				<c:forEach items="${goodName }" var="goodName">
					<option value="${goodName }">${goodName }</option>
				</c:forEach>
			</select>
		</div>
        <div class="col-md-2" style="margin-left:2em">
			<select class="selectpicker" id="initUserName" data-live-search="true" onchange="opertorRefresh()">
				<option value="销售员">条件三</option>
				<c:forEach items="${userList }" var="user">
					<option value="${user }">${user }</option>
				</c:forEach>
			</select>
		</div>
		<table class="table table-striped" id="saleTable">
		</table>
	</div>
	</div>
</div>

</body>
</html>
