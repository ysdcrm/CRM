<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="../js/global.js"></script>
<script type="text/javascript">
$(function(){
	$("#tre").tree({
		lines:true,
		url:"/CRM/Allmodules",
		onContextMenu:function(e,node){
			e.preventDefault();
			$("#tre").tree('select',node.target);
			$("#mm").menu('show',{
				left:e.pageX,
				top:e.pageY
			});
		}
	})
})
function append(){
	var nodes = $('#tre').tree('getSelected');
	if(nodes!=null){
		$("#parentModulename").text(nodes.text);
    	$("#add").window("open");
	}else{
		$.messager.alert("请选择父节点！");
	}
}
function subimtaddfm(){
	var nodes = $('#tre').tree('getSelected');
	var flag=$("#append-fm").form("validate");
	var Modulename=$("#Modulename").val();
	var weight=$("#Moduleweight").val();
	var path=$("#ModuleUrl").val();
	if(flag){
		$.post("/CRM/addmodules", {
		module_name:Modulename,
		parent_id:nodes.id,
		path:path,
		weight:weight
	}, function(res) {
		if(res.success){
			$.messager.alert("提示", "添加成功!");
			$("#add").window("close");
			$("#tre").tree("reload");
		}
	}, "json")
	}
}
function exitfm(){
	$("#add").window("close");
	$("#edit").window("close");
}
function edit(){
	var nodes = $('#tre').tree('getSelected');
	if(nodes!=null){
	$.post("/CRM/modulesById", {
		module_id:nodes.id,
	}, function(res) {
		if(res.success==true){
			msg=res.message;
			$("#edit-fm").form("load", msg)
			$("#edit").window("open");
		}
	}, "json")
	}else{
		$.messager.alert("请选择要修改的节点！")
	}
}
function subimtEditfm(){
	var nodes = $('#tre').tree('getSelected');
	var flag=$("#edit-fm").form("validate");
	var module_name=$("#module_name").val();
	var path=$("#path").val();
	var weight=$("#weight").val();
	var parent_id=$("#parent_id").val();
	if(flag){
		$.post("/CRM/setmodulesById", {
		module_id:nodes.id,
		module_name:module_name,
		parent_id:parent_id,
		path:path,
		weight:weight
	}, function(res) {
		if(res>0){
			$.messager.alert("提示", "修改成功!");
			$("#edit").window("close");
			$("#tre").tree("reload");
		}else{
			$.messager.alert("提示", "修改失败!");
		}
	}, "json")
	}
}
function del(){
	var nodes = $('#tre').tree('getSelected');
	if(nodes!=null){
		$.post("/CRM/delmodulesById", {
		module_id:nodes.id
	}, function(res) {
		if(res.success){
			$.messager.alert("提示", "删除成功!");
			$("#edit").window("close");
			$("#tre").tree("reload");
		}
	}, "json")
	}else{
		$.messager.alert("请选择要删除的节点！")
	}
}
</script>
</head>
<body>
		<div>
			<ul id="tre" class="easyui-tree"></ul>
		</div>
		<div id="mm" class="easyui-menu"  style="width: 160px;">
			<div onclick="append()"  data-options="iconCls:'icon-add'">添加</div>
			<div onclick="edit()"  data-options="iconCls:'icon-edit'">修改</div>
			<div onclick="del()"  data-options="iconCls:'icon-remove'">删除</div>
		</div>
		<div id="add" class="easyui-window" title="添加信息" style="width:400px;height:300px" data-options="iconCls:'icon-save',modal:true,closed:true">
			<form id="append-fm" class="easyui-form" style="text-align: center;">
				<table cellpadding="5">
					<tr>
						<td>父节点名称：</td>
						<td>
							<div id="parentModulename"></div>
						</td>
					</tr>
					<tr>
						<td>权重：</td>
						<td>
							<input type="text" class="easyui-textbox" id="Moduleweight" name="Moduleweight" style="width:120px" required="true" >
						</td>
					</tr>
					<tr>
						<td>url：</td>
						<td>
						<input type="text" class="easyui-textbox" id="ModuleUrl" name="ModuleUrl" style="width:120px"required="true" >
						</td>
					</tr>
					<tr>
						<td>模块名称：</td>
						<td>
							<input type="text" class="easyui-textbox" id="Modulename" name="Modulename" style="width:120px"required="true" >
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="subimtaddfm()">提交</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="exitfm()">取消</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 修改模块 -->
		<div id="edit" class="easyui-window" title="修改模块信息" style="width:400px;height:300px" data-options="iconCls:'icon-save',modal:true,closed:true">
			<form id="edit-fm" class="easyui-form" style="text-align: center;">
				<table cellpadding="5">
					<tr>
						<td>父节点ID：</td>
						<td>
							<input type="text" class="easyui-textbox" id="parent_id" name="parent_id" style="width:120px" data-options="readonly:true" >
						</td>
					</tr>
					<tr>
						<td>模块名称：</td>
						<td>
							<input type="text" class="easyui-textbox" id="module_name" name="module_name" style="width:120px"required="true" >
						</td>
					</tr>
					<tr>
						<td>权重：</td>
						<td>
							<input type="text" class="easyui-textbox" id="weight" name="weight" style="width:120px" required="true" >
						</td>
					</tr>
					<tr>
						<td>url：</td>
						<td>
						<input type="text" class="easyui-textbox" id="path" name="path" style="width:120px"required="true" >
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="subimtEditfm()">提交</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="exitfm()">取消</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
</body>
</html>