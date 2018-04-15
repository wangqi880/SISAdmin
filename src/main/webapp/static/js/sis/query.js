$(function(){
	TableInit();
});

var sale = {
	URL:{
		saleList:function(){
			return Utils.root()+'/sale/salelist';
		},
		saleListByGoodName:function(goodName){
			return Utils.root()+'/sale/'+goodName+'/saleListByGoodName';
		},
		saleListByGoodNo:function(goodNo){
			return Utils.root()+'/sale/'+goodNo+'/saleListByGoodNo';
		},
		saleListByUserName:function(userName){
			return Utils.root()+'/sale/'+userName+'/saleListByUserName';
		},
	}
}
function TableInit(){
	$('#saleTable').bootstrapTable({
		url:sale.URL.saleList(),
		striped: true,  //表格显示条纹
		toolbar: '#toolbar', 
		search: true,  
		pageSize:5,
	    pagination: true,
	    showColumns:true,
	    showRefresh:true,
	    pageList:[],
	    columns:[
	               {
	            	 field:'no',
	            	 title:'列一',
	            	 align:'center',
	               },
		           {
		        	   field:'name',
		        	   title:'列二',
		        	   align:'center',
		           },
		           {
		        	   
		        	   field:'num',
		        	   title:'列三',
		        	   align:'center',
		           },
		           {
		        	   field:'date',
		        	   title:'列四',
		        	   align:'center',
		        	   sortable:true,
		           },
		           {
		        	   field:'opertor',
		        	   title:'列五',
		        	   align:'center',
		           }]
	});
}

function goodNoRefresh(){
	var goodNo = $('#initGoodNo').val();
	var data = {
			url:sale.URL.saleListByGoodNo(goodNo)
	};
	$("#saleTable").bootstrapTable('refresh',data);
	$("#initGoodName option:first").attr("selected","selected"); 
//	$("#initGoodName option").removeAttr("selected");
	alert($('#initGoodName').val());
}

function goodNameRefresh(){
	$('#initGoodNo').val("1001");
	$("#initUserName").val("销售员");
	var goodName = $('#initGoodName').val();
	var data = {
			url:sale.URL.saleListByGoodName(goodName)
	};
	$("#saleTable").bootstrapTable('refresh',data);
}

function opertorRefresh(){
	$("#initGoodName").val("商品名称");
	$("#initGoodNo").val("商品编号");
	var userName = $('#initUserName').val();
	var data = {
			url:sale.URL.saleListByUserName(userName)
	};
	$("#saleTable").bootstrapTable('refresh',data);
}
