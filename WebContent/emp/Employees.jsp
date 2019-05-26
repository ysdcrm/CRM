<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>员工分量</title>
<script src="../js/global.js"></script>
<script type="text/javascript">
$(function(){
	initUsers();
})
function initUsers(){
	$("#dg").datagrid({
		url:'/CRM/AllUsersEmployees',
		method:'post',
		pagination:true,
		singleSelects:true,
		queryParams:{
			login_name:$("#login_name").val(),
			sign_in_state:$('#sign_in_state').combobox('getValue'),
			allotSetting:$('#allotSetting').combobox('getValue'),
			startcreat_time:$('#startcreat_time').datetimebox('getValue'),
			endcreat_time:$('#endcreat_time').datetimebox('getValue')
		}
	});
	$("#usertabfrm").form("reset");
}
//格式化操作 
function formatterCZ2(value,row,index) {
	if(value==0){
		return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="OpenAllotSetting('+index+')" >已关闭自动分配</a>';
	}else{
		 return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="CloseAllotSetting('+index+')" >已开启自动分配</a>';
	}
}
//分量关闭
function CloseAllotSetting(index) {
	var data = $("#dg").datagrid("getData");
   	var row = data.rows[index];
   	var user_id=row.user_id;
   	$.post("/CRM/CloseAllotSetting",{
   		user_id:user_id
   	},function(res){
   		if(res>0){
   			$.messager.alert("提示", "关闭成功！");
   			$("#dg").datagrid("reload");
   		}
   	},"json")
	
}
//分量开启
function OpenAllotSetting(index) {
	var data = $("#dg").datagrid("getData");
   	var row = data.rows[index];
   	var user_id=row.user_id;
   	$.post("/CRM/OpenAllotSetting",{
   		user_id:user_id
   	},function(res){
   		if(res>0){
   			$.messager.alert("提示", "开启成功！");
   			$("#dg").datagrid("reload");
   		}
   	},"json")
	
}
	//是否签到
function formatterQD(value,row,index) {
		return value==0? "否":"是"
	}
</script>
</head>
<body>
<div id="usertab">
		<form id="usertabfrm" class="easyui-form">
        	登录名：<input id="login_name" type= "text" class= "easyui-textbox">  
        	是否签到：<select id="sign_in_state" class="easyui-combobox" name="sign_in_state" style="width:120px;">   
					    <option value="">----请选择-----</option>   
					    <option value="0">否</option>   
					   <option value="1">是</option>  
				</select>
			是否开启自动分配：<select id="allotSetting" class="easyui-combobox" name="allotSetting" style="width:120px;">   
					    <option value="">----请选择-----</option>   
					    <option value="0">否</option>   
					   <option value="1">是</option>  
			</select>
        	创建时间：<input id="startcreat_time"  type= "text" class= "easyui-datetimebox">~<input id="endcreat_time"  type= "text" class= "easyui-datetimebox"></input>   
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initUsers()" data-options="iconCls:'icon-search'">搜索</a> 
		</form>
	</div>
<table id="dg" class="easyui-datagrid" style="width:100%;height:480px"   
        data-options="toolbar:'#usertab'">   
    <thead>   
        <tr>   
			<th data-options="field:'xz',checkbox : true"></th>  
            <th data-options="field:'user_id'">用户id</th>   
            <th data-options="field:'login_name'">登录名</th> 
            <th data-options="field:'last_time_login'">最后一次登录时间</th> 
            <th data-options="field:'create_time'">创建时间</th> 
            <th data-options="field:'sign_in_state',formatter:formatterQD">签到状态</th> 
            <th data-options="field:'allotSetting',formatter:formatterCZ2">分量设置</th>
        </tr>   
    </thead>   
</table> 
</body>
</html>