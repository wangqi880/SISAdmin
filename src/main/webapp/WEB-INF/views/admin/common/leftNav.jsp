<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!--left nav-->
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item"><a href="<%=request.getContextPath()%>/admin/fix">维护控制</a></li>
            <li class="layui-nav-item">
                <a class="" href="javascript:;">竞赛模块</a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;">功能一</a></dd>
                    <dd><a href="javascript:;">功能二</a></dd>
                    <dd><a href="javascript:;">功能三</a></dd>
                    <dd><a href="">超链接</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="<%=request.getContextPath()%>/admin/print">打印控制</a></li>
        </ul>
    </div>
</div>
