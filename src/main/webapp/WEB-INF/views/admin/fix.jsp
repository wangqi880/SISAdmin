<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/admin/layui/css/layui.css?t=1510786361436"  media="all">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <jsp:include page="./common/header.jsp"></jsp:include>
    <jsp:include page="./common/leftNav.jsp"></jsp:include>

    <!--body-->
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <blockquote class="layui-elem-quote layui-text">
                修改系统是否展示维护界面，如果开关为开，那么表示需要展示，如果为关表示不变展示
            </blockquote>
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">维护开关</label>
                    <div class="layui-input-block">
                        <input type="checkbox" id="open" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="ON|OFF">
                    </div>
                </div>

            </form>
        </div>
    </div>

    <jsp:include page="./common/footer.jsp"></jsp:include>

</div>
<script src="<%=request.getContextPath()%>/static/admin/layui/layui.js?t=1510786361436" charset="utf-8"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
        var $= layui.jquery;
        var fix=${fixIs};
        if(fix=="1"){
            $("#open").attr("checked",true);
        }
    });
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        //日期
        laydate.render({
            elem: '#date'
        });
        laydate.render({
            elem: '#date1'
        });

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,content: function(value){
                layedit.sync(editIndex);
            }
        });

        //监听指定开关
        form.on('switch(switchTest)', function(data){
            var $= layui.jquery;
            var status=this.checked;
            $.ajax({
                type: 'get',
                url:'<%=request.getContextPath()%>/admin/fixStatus?status='+status,
                async:false,
                success:function (resp) {
                    if("000000"==resp.code){
                        layer.msg('系统维护：'+ (status ? '开启' : '关闭'), {
                            offset: '6px'
                        });
                        layer.tips('温馨提示：开启状态，前段会进入维护界面。'+resp.info, data.othis)
                    }else{
                        layer.tips('修改失败'+resp.info, data.othis)
                    }
                },
                error:function (resp) {
                    layer.tips('修改失败', resp.info)
                }

            });



        });

        //监听提交
        form.on('submit(demo1)', function(data){
            layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })
            return false;
        });


    });
</script>
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>
</body>
</html>
