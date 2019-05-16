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
		initUsers();
	})
	function initUsers(){
		$("#dg").datagrid({
			url:'/CRM/showUsers',
			method:'post',
			pagination:true,
			singleSelect:true,
			queryParams:{
				login_name:$("#login_name").val(),
				is_Lockout: $('#is_Lockout').combobox('getValue'),
				sign_in_state:$('#sign_in_state').combobox('getValue'),
				startcreat_time:$('#startcreat_time').datetimebox('getValue'),
				endcreat_time:$('#endcreat_time').datetimebox('getValue')
			}
		});
		$("#usertabfrm").form("reset");
	}
	//格式化操作 
	function formatterCZ(value,row,index){
		  return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="UpdateUsers('+index+')">编辑</a>    <a  href="javascript:void(0)" class="easyui-linkbutton" onclick="delUsers('+index+')">删除</a>  <a  href="javascript:void(0)" class="easyui-linkbutton" onclick="Setpassword('+index+')">重置密码</a>';
	}
	//格式化操作 
	function formatterCZ1(value,row,index) {
		 return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="setUsersRole('+index+')">设置用户角色</a>   <a  href="javascript:void(0)" class="easyui-linkbutton" onclick="YesSouDing('+index+')">锁定</a>   <a  href="javascript:void(0)" class="easyui-linkbutton" onclick="NoSouding('+index+')">解锁</a>';
	}
	 
	//删除
	function delUsers(index) {
		var data = $("#dg").datagrid("getData"); 
	    var row = data.rows[index]; 
		$.messager.confirm('确认', '您想要删除:'+row.login_name+':的用户吗？', function(r){
			if (r){
				$.post("/CRM/delUsers",{
					user_id:row.user_id
				},function(i){
					if(i>0){
						$.messager.alert("提示","删除成功！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("提示","删除失败！");
					}
				},"json")
			}
		});
	}
	//添加
	function addUsers(){
	 $('#addDialog').dialog("open");
	}
	function submitAdd(){
			 var flag=$("#addForm").form("validate");//验证
			  var data = $("#dg").datagrid("getData"); 
			 var create_time=data.create_time;
		     var login_name=$("#login_names").val();
		     var password=$("#passwords").val();
		     /* var create_time=$('#create_times').datetimebox('getValue'); */
			var protect_email=$("#protect_emails").val();
			var protect_tel=$("#protect_tels").val();
			var weight=$("#weights").val();
	     if(flag){
	    	 $.post(
	    		'/CRM/addUsers',
	    		{
	    			login_name:login_name,
	    			password:password,
	    			create_time:create_time,
	    			protect_email:protect_email,
	    			protect_tel:protect_tel,
	    			weight:weight,
	    		},function(res){
	    			 if(res>0){
	 	                 $.messager.alert("提示","添加成功");
	 	                 $('#dg').datagrid('reload'); //刷新
	 	                 $("#addDialog").dialog("close");
	 	              }
	    	    },'json')
	     }
	}
	function closeAdd(){
		 $("#addDialog").dialog("close");
	} 	
	//修改
	function UpdateUsers(index){
	      var data = $("#dg").datagrid("getData");
		  var row = data.rows[index];
		  $("#updateForm").form("load",row);//填充进表单
		  $("#updateDialog").dialog("open"); 
		}	
	function submitUpdate(){
		 var flag=$("#updateForm").form("validate");
		 var data = $("#dg").datagrid("getSelected");//获取选中行
		 var dataRow = $("#dg").datagrid("getData");
		 var login_name=$("#login_namess").val();
	     var password=$("#passwordss").val();
		var protect_email=$("#protect_emailss").val();
		var protect_tel=$("#protect_telss").val();
		var weight=$("#weightss").val();
		 if(flag){
		     $.post(
		    	'/CRM/updateUsers',
		    	{ 
		    		user_id:data.user_id,
		    		login_name:login_name,
	    			password:password,
	    			protect_email:protect_email,
	    			protect_tel:protect_tel,
	    			weight:weight,
	    	},function(res){
	    		if(res>0){
					$('#dg').datagrid('reload'); //刷新
					$("#updateDialog").dialog("close");//关闭弹窗
					$.messager.alert("提示","修改成功");//提示
				}
	     },'json')
	   }
	 }
   function closeUpdate(){
	 $("#updateDialog").dialog("close");
	 }	
 //密码重置
 function Setpassword(index){
				$.messager.confirm('确认','您确认要重置该用户的密码吗？',function(r){    
				    if (r){   
				    	var data = $("#dg").datagrid("getData");
						var row = data.rows[index];
						var login_name=row.login_name;
						$.post("/CRM/Setpassword", {
							login_name:login_name
						}, function(res) {
							if(res>0){
								$.messager.alert("提示", "密码重置成功！");
								$("#dg").datagrid("reload");
							}else{
								$.messager.alert("提示","密码重置失败");
							}
						}, "json")
				    }
				});
			}
//锁定用户
	function YesSouDing(index){
		$.messager.confirm('确认','您确认想要锁定用户吗？',function(r){    
		    if (r){   
		    	var data = $("#dg").datagrid("getData");
				var row = data.rows[index];
				var login_name=row.login_name;
				$.post("/CRM/YesSouDing",{
					login_name:login_name,
				}, function(res) {
					if(res>0){
						$.messager.alert("提示", "锁定成功！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("提示","该用户已被锁定！");
					}
				}, "json")
		    }
		});  
	}
	//解锁用户
	function NoSouding(index){
		$.messager.confirm('确认','您确认想要解锁用户吗？',function(r){    
		    if (r){   
		    	var data = $("#dg").datagrid("getData");
				var row = data.rows[index];
				var login_name=row.login_name;
				$.post("/CRM/NoSouding", {
					login_name:login_name,
				}, function(res) {
					if(res>0){
						$.messager.alert("提示", "解锁成功！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("提示","该用户已解锁！");
					}
				}, "json")
		    }
		});
	}
 //用户角色设置
   function setUsersRole(index) {
	   	var data = $("#dg").datagrid("getData");
	   	var row = data.rows[index];
    	var login_name=row.login_name;
    	var user_id=row.user_id;
    	$("#ToRole").window("open");
    	$("#parentModulenames").text(login_name);
    	//获取系统所有角色信息
		 $("#juese").datagrid({
			url: '/CRM/show', 
			queryParams: { 
				user_id:row.user_id,
			}
		});
		//获取当前用户角色信息
		$("#User-juese").datagrid({
			url: '/CRM/selectRoles', 
			queryParams: { 
				login_name:login_name,
			}
		}); 
   	}
 //格式化角色名称 
	function formatterrole_name(value,row,index) {
		return row.roles.role_name;
	}
  //格式化角色id 
	function formatterrole_id(value,row,index){
		return row.roles.role_id;
	}
 //新增用户角色
	function addUserRole(){
		//获取用户信息
		var data=$("#dg").datagrid("getSelected");
		//获取角色信息
		var roleRow=$("#juese").datagrid("getSelected");
		 if(roleRow){
			$.post(
					"/CRM/addUserRoles",
			{
				user_id:data.user_id,
				role_id:roleRow.role_id
			},function(res){
				if(res>0){
					$.messager.alert("提示","角色设置成功")
					$("#User-juese").datagrid("reload");
				}else{
					$.messager.alert("提示","角色设置失败")
				}
			},"json")
		}else{
			$.messager.alert("提示","请先选择角色！！")
		}
	}
  //删除用户角色
	function deleteUserRole(){
		//获取用户信息
		var data=$("#dg").datagrid("getSelected");
		//获取角色信息
		var roleRow=$("#User-juese").datagrid("getSelected");
		 if(roleRow){
			$.post(
					"/CRM/delUserRoles",
			{
						user_id:data.user_id,
						role_id:roleRow.roles.role_id
			},function(res){
				if(res>0){
					$.messager.alert("提示","角色移除成功")
					$("#User-juese").datagrid("reload");
				}else{
					$.messager.alert("提示","角色移除失败")
				}
			},"json")
		}else{
			$.messager.alert("提示","请先选择角色！！")
		}
	}
  	//是否锁定
  function formatterSD(value,row,index) {
	return value==0? "是":"否"
	}
  	//是否签到
  function formatterQD(value,row,index) {
		return value==0? "是":"否"
	}
</script>
</head>
<body>
<div id="usertab">
		<form id="usertabfrm" class="easyui-form">
        	登录名：<input id="login_name" type= "text" class= "easyui-textbox">  
        	是否锁定：<select id="is_Lockout" class="easyui-combobox" name="is_Lockout" style="width:120px;">   
					    <option value="">----请选择-----</option>   
					    <option value="0">是</option>   
					   <option value="1">否</option>  
					</select> 
        	签到：<select id="sign_in_state" class="easyui-combobox" name="is_Lockout" style="width:120px;">   
					    <option value="">----请选择-----</option>   
					    <option value="0">签到</option>   
					   <option value="1">签退</option>  
				</select>
        	创建时间：<input id="startcreat_time"  type= "text" class= "easyui-datetimebox">~<input id="endcreat_time"  type= "text" class= "easyui-datetimebox"></input>   
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initUsers()" data-options="iconCls:'icon-search'">搜索</a> 
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addUsers()" data-options="iconCls:'icon-add'">添加</a> 
		</form>
	</div>
<table id="dg" class="easyui-datagrid" style="width:100%;height:480px"   
        data-options="toolbar:'#usertab'">   
    <thead>   
        <tr>   
            <th data-options="field:'user_id'">用户id</th>   
            <th data-options="field:'login_name'">登录名</th>   
             <th data-options="field:'password'">密码</th>
              <th data-options="field:'is_Lockout',formatter:formatterSD">是否锁定</th> 
              <th data-options="field:'last_time_login'">最后一次登录时间</th> 
              <th data-options="field:'create_time'">创建时间</th> 
               <th data-options="field:'lock_time'">被锁定时间</th> 
                <th data-options="field:'protect_email'">注册邮箱</th> 
                 <th data-options="field:'protect_tel'">手机号</th> 
                  <th data-options="field:'weight'">权重</th> 
                   <th data-options="field:'sign_in_state',formatter:formatterQD">签到状态</th> 
                     <th data-options="field:'CZ',formatter:formatterCZ">操作</th>
                     <th data-options="field:'CZ1',formatter:formatterCZ1">设置</th>
        </tr>   
    </thead>   
</table> 
<!-- 添加角色 -->
<div id="addDialog" class="easyui-dialog" title="添加" style="width:500px;height:400px;"   
        data-options="iconCls:'icon-save',resizable:true,closed:true,modal:false">   
		<form id="addForm" class="easyui-form">
			<table cellpadding="5">
				<tr>
					<td>用户名:</td>
					<td><input class="easyui-textbox" type="text" id="login_names"
						name="login_names" data-options="required:true"></input></td>
				</tr><tr>
					<td>密码:</td>
					<td><input class="easyui-textbox" type="password" id="passwords"
						name="passwords" data-options="required:true"></input></td>
				</tr>
				<!-- <tr>
					<td>创建时间:</td>
					<td><input class="easyui-datetimebox" type="text" id="create_times"
						name="create_time" data-options="required:true"></input></td>
				</tr> -->
				<tr>
					<td>邮箱:</td>
					<td><input class="easyui-textbox" type="text" id="protect_emails"
						name="protect_emails" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>手机号:</td>
					<td><input class="easyui-textbox" type="text" id="protect_tels"
						name="protect_tels" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>权重:</td>
					<td><input class="easyui-textbox" type="text" id="weights"
						name="weights" data-options="required:true"></input></td>
				</tr>
			</table>
		</form>
		   <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAdd()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeAdd()" data-options="iconCls:'icon-no'">取消</a>
		</div>
	</div>
<!-- 修改 -->
 <div id="updateDialog" class="easyui-dialog" title="修改" style="width:500px;height:400px;"   
        data-options="iconCls:'icon-save',resizable:true,closed:true,modal:false">   
		<form id="updateForm" class="easyui-form">
			<table cellpadding="5">
				<tr>
					<td>用户名:</td>
					<td><input class="easyui-textbox" type="text" id="login_namess"
						name="login_name" data-options="required:true"></input></td>
				</tr><tr>
					<td>密码:</td>
					<td><input class="easyui-textbox" type="password" id="passwordss"
						name="password" data-options="required:true"></input></td>
				</tr>
				<!-- <tr>
					<td>修改时系统时间:</td>
					<td><input class="easyui-datetimebox" type="text" id="create_timess"
						name="create_time" data-options="required:true"></input></td>
				</tr> -->
				<tr>
					<td>邮箱:</td>
					<td><input class="easyui-textbox" type="text" id="protect_emailss"
						name="protect_email" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>手机号:</td>
					<td><input class="easyui-textbox" type="text" id="protect_telss"
						name="protect_tel" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>权重:</td>
					<td><input class="easyui-textbox" type="text" id="weightss"
						name="weight" data-options="required:true"></input></td>
				</tr>
			</table>
		</form>
		   <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUpdate()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeUpdate()" data-options="iconCls:'icon-no'">取消</a>
		</div>
	</div>
 <!--设置用户角色-->
		<div id="ToRole" class="easyui-window" title="设置用户角色" style="width:700px;height:520px" data-options="iconCls:'icon-save',modal:true,closed:true">
			<div style="width:200px;float: left;">
			<table  class="easyui-datagrid" id="juese" title="系统角色列表" data-options="rownumbers:true,singleSelect:true,pagination:true,method:'post',pageSize:10">
			<thead>
				<tr>
					<th data-options="field:'role_id',width:280,hidden:true">角色ID</th>
					<th data-options="field:'role_name',width:100">角色名称</th>
				</tr>
			</thead>
			</table>
			</div>
				<div style="width: 100px;float: left;text-align: center;padding-top: 150px;padding-left: 120px;">
					您当前正在为：<div id="parentModulenames" style="font-size: 25px;color: red;"></div>设置角色！
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addUserRole()">添加角色</a><br />
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteUserRole()">移除角色</a>
				</div>
			<div style="width:200px;float:right;">
			<table  class="easyui-datagrid" id="User-juese" title="当前用户角色列表" data-options="rownumbers:true,singleSelect:true,pagination:true,method:'post',pageSize:10">
			<thead>
				<tr>
					<th data-options="field:'role_id',width:280,hidden:true,formatter:formatterrole_id">角色ID</th>
					<th data-options="field:'role_name',width:100,formatter:formatterrole_name">角色名称</th>
				</tr>
			</thead>
			</table>
			</div>
		</div>	
</body>
</html>