$(function(){
    TableInit();
    ButtonInit();
});

var info = {
    URL:{
        classList:function(major){
            return Utils.root()+'/info/showClass?major='+major;
        },
    }
}
function TableInit(){
    var majorInfo = $("#majorInfo").val();
    $('#classTable').bootstrapTable({
        url:info.URL.classList(majorInfo),
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
                field:'area',
                title:'区域',
                align:'center',
                // sortable:true,
            },
            {
                field:'major',
                title:'专业',
                align:'center',
            },
            {
                field:'classCode',
                title:'班级代码',
                align:'center',
            },
            {
                field:'className',
                title:'班级名称',
                align:'center',
            },
            {
                field:'age',
                title:'年龄段',
                align:'center',
            },
            {

                field:'classInfo',
                title:'班级信息',
                align:'center',
                formatter:"classInfo",
            },
            {
                field:'cost',
                title:'总费用',
                align:'center',
                // sortable:true,
            },
            {
                field:'scheduleInfo',
                title:'上课时间',
                align:'center',
            },
            {
                field:'term',
                title:'季节',
                align:'center',
            },
            {
                field:'date',
                title:'开课时间',
                align:'center',
            },
            {
                field:'',
                title:'报名',
                align:'center',
                formatter:"actionFormatter",
                events:"actionEvents",
            }]
    });
}

function ButtonInit()
{
    // $('#search').click(function () {
    // alert("test");
    // });
}

function actionFormatter(value,row,index)
{
    return '<a class="pay" >报名</a>';
}

function classInfo(value,row,index)
{
    var root = Utils.root();
    return '<a class="showInfo" href="'+root+'/info/classDetail.do?classCode='+row.classCode+'">班级详细信息</a>';
}

window.actionEvents = {
    'click .pay': function(e, value, row, index) {
        $("#classId").val(row.classCode);
        $(".container-fluid").slideUp("slow",function(){
                $(".page-header button").attr("class","button yellow round").text("请填写手机号码").css("width","320px");
                $("#phoneNumberDIV").slideDown("slow");
        });
    }

}
