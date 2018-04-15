<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 %>
<link rel="shortcut icon" href="favicon.ico"> 
<link rel="stylesheet" href="<%=path %>/static/bootstrap/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="<%=path %>/static/bootstrap_table/css/bootstrap-table.min.css"/>
<link rel="stylesheet" href="<%=path %>/static/bootstrap-select/css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="<%=path %>/static/css/sis/link.css"/>

<script type="text/javascript" src="<%=path %>/static/js/jquery-3.1.1.js" ></script>
<script type="text/javascript" src="<%=path %>/static/bootstrap/dist/js/bootstrap.min.js" ></script>
<script type="text/javascript" src="<%=path %>/static/bootstrap_table/js/bootstrap-table.min.js" ></script>
<script type="text/javascript" src="<%=path %>/static/bootstrap_table/js/bootstrap-table-zh-CN.js" ></script>
<script type="text/javascript" src="<%=path %>/static/bootstrap-select/js/bootstrap-select.js" ></script>

<!-- 自定义封装 -->
<script type="text/javascript" src="<%=path %>/static/js/sis/common/common.js" ></script>
<!-- 统一模态框装载容器 -->
<div class="modal fade" id="common_confirm_modal" style="margin-top: 10em">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h5 class="modal-title"><i class="fa fa-exclamation-circle"></i> <span class="title"></span></h5>
			</div>
			<div class="modal-body samll">
				<p><span class="message"></span></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary ok" data-dismiss="modal">确认</button>
                <button type="button" class="btn btn-default cancel" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
