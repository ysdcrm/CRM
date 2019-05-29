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
		url:'/CRM/showUsers',
		method:'post',
		pagination:true,
		singleSelects:true,
		queryParams:{
			login_name:$("#login_name").val(),
			sign_in_state:$('#sign_in_state').combobox('getValue'),
			startcreat_time:$('#startcreat_time').datetimebox('getValue'),
			endcreat_time:$('#endcreat_time').datetimebox('getValue')
		}
	});
	$("#usertabfrm").form("reset");
}
/* //格式化操作 
function formatterCZ2(value,row,index) {
		return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="OpenAllotSetting('+index+')" >签到</a>';
} */
//一键签退
function OpenAllotSetting() {
	var ids='';
	var rows = $("#dg").datagrid("getSelections");//获取表格签退数据
	if (rows.length == 0) { //当未选中数据就点击签退时，会提示“请选择要签退的员工”
		$.messager.alert("系统信息", "请选择要签退的员工！");
		return;
	}
	for(var i=0;i<rows.length;i++){ //将获取到的数据循还输出
        var data=rows[i];
        if(data.sign_in_state==0){  //如果选中的数据中存在没有签到的员工，就提示。
        	$.messager.alert("系统信息", "请选择已经签到的员工进行签退！");
        	return;
        }else{
        	ids=ids+data.user_id+",";  //将选中数据的id拼接成字符串给变量ids。
        }
    }
   	$.post("/CRM/upsignon",{
   		user_id:ids
   	},function(res){
   		if(res>0){
   			$.messager.alert("提示", "签退成功！");
   			$("#dg").datagrid("reload");
   		}
   	},"json")
	
}
//格式化签到
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
        	创建时间：<input id="startcreat_time"  type= "text" class= "easyui-datetimebox">~<input id="endcreat_time"  type= "text" class= "easyui-datetimebox"></input>   
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initUsers()" data-options="iconCls:'icon-search'">搜索</a> 
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="OpenAllotSetting()" data-options="iconCls:'icon-redo'">一键签退</a>
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
        </tr>   
    </thead>   
</table> 
</body>
</html>