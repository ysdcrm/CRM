<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>员工签到</title>
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
			sign_state:$('#sign_state').combobox('getValue'),
			startcreat_time:$('#startcreat_time').datetimebox('getValue'),
			endcreat_time:$('#endcreat_time').datetimebox('getValue')
		}
	});
	$("#usertabfrm").form("reset");
}
//格式化操作 
function formatterCZ2(value,row,index) {
		return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="OpenAllotSetting('+index+')" >签到</a>';
	/* }else{
		 return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="CloseAllotSetting('+index+')" >签退</a>';
	} */
}
//签到
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
//签退
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
//签到状态
function formatterQDsign_state(value,row,index) {
		if(value==0){
			return value==0? "正常":"";
		}else if(value==1){
			return value==1? '迟到':"";
		}else{
			return value==2? '早退':"";
		}
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
			签到状态：<select id="sign_state" class="easyui-combobox" name="sign_state" style="width:120px;">   
					    <option value="">----请选择-----</option>   
					    <option value="0">正常</option>   
					   <option value="1">迟到</option>
					   <option value="2">早退</option>   
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
            <th data-options="field:'sign_in_state',formatter:formatterQD">是否签到</th>
            <th data-options="field:'sign_state',formatter:formatterQDsign_state">签到状态</th>  
            <th data-options="field:'aa',formatter:formatterCZ2">签到设置</th>
        </tr>   
    </thead>   
</table> 
</body>
</html>