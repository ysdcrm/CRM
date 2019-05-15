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
		initRoles();
	})
	function initRoles(){
		$("#dg").datagrid({
			url:'/CRM/show',
			method:'post',
			pagination:true,
			singleSelect:true,
			queryParams:{
				role_name:$("#role_name").val()
			}
		});
		$("#usertabfrm").form("reset");
	}
	//格式化操作 
	function formatterCZ(value,row,index){
		  return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="UpdateRoles('+index+')">编辑</a>    <a  href="javascript:void(0)" class="easyui-linkbutton" onclick="delRoles('+index+')">删除</a>   <a  href="javascript:void(0)" class="easyui-linkbutton" onclick="setQXRoles('+index+')">设置权限</a>';
	}
	//删除
	function delRoles(index) {
		var data = $("#dg").datagrid("getData"); 
	    var row = data.rows[index]; 
		$.messager.confirm('确认', '您想要删除:'+row.role_name+':该角色吗？', function(r){
			if (r){
				$.post("/CRM/delRoles",{
					role_id:row.role_id,
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
	function addRoles(){
	 $('#addDialog').dialog("open");
	}
	function submitAdd(){
		 var flag=$("#addForm").form("validate");//验证
	     var role_name=$("#role_names").val();
	     if(flag){
	    	 $.post(
	    		'/CRM/addRoles',
	    		{
	    			role_name:role_name
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
	function UpdateRoles(index){
	      var data = $("#dg").datagrid("getData");
		  var row = data.rows[index];
		  /* $("#cidss").textbox("setValue",row.tushucogy.cid);  */
		  $("#updateForm").form("load",row);//填充进表单
		  $("#updateDialog").dialog("open"); 
		}	
	function submitUpdate(){
		 var flag=$("#updateForm").form("validate");
		 var data = $("#dg").datagrid("getSelected");//获取选中行
		 var role_name=$("#role_namess").val();
		 if(flag){
		     $.post(
		    	'/CRM/updateRoles',
		    	{ 
		    		role_id:data.role_id,
		    		role_name:role_name
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
//设置权限
function setQXRoles(index) {
	var data = $("#dg").datagrid("getData");
	var row = data.rows[index];
 	var Name=row.role_name;
 	var id=row.role_id;
		$.post("/CRM/selectRolesByIdQX", {
 			role_id:id
 			}, function(res) {
 				checked:true;
 				$("#tre").tree("loadData",res);
 		}, "json")
 		$("#quqnxian").dialog({
 			closed:false,
 			title:"您正在设置："+Name,
 			toolbar:[{
 				text:"提交",
 				iconCls:'icon-ok',
 				handler:function(){
 					var data = $("#dg").datagrid("getSelected");
 					var nodes=$("#tre").tree('getChecked',['checked','indeterminate']);
 					var n="";
 					for(var i=0;i<nodes.length;i++){
 						if(n==""){
 							n+=nodes[i].id;
 						}else{
 							n += ",";
 							n += nodes[i].id;
 						}
 					}
 					$.post(
 						"/CRM/addRolesQX",
 						{
 							module_id:n,
 							role_id:id
						}, function(res){
							if(res>0){
								$.messager.alert("消息","保存权限成功！");
								$("#quqnxian").window("close");
								$("#dg").datagrid("reload");
							}else{
								$.messager.alert("消息",res.Message);
							}
					}, "json")
 				}
 			},{
 				text:"取消",
 				iconCls:'icon-cancel',
 				handler:function(){
 					$("#quqnxian").window("close");
 				}
 			}]
 		});
	} 
</script>
</head>
<body>
 <div id="usertab">
		<form id="usertabfrm" class="easyui-form">
        	角色名称：<input class="easyui-validatebox" type="text" id="role_name"  />   
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initRoles()" data-options="iconCls:'icon-search'">搜索</a> 
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addRoles()" data-options="iconCls:'icon-add'">添加</a> 
		</form>
	</div>
<table id="dg" class="easyui-datagrid" style="width:1000px;height:400px"   
        data-options="toolbar:'#usertab'">   
    <thead>   
        <tr>   
            <th data-options="field:'role_id'">编码</th>   
            <th data-options="field:'role_name'">名称</th>   
            <th data-options="field:'CZ',formatter:formatterCZ">操作</th>
        </tr>   
    </thead>   
</table> 
<!-- 添加角色 -->
<div id="addDialog" class="easyui-dialog" title="添加" style="width:300px;height:200px;"   
        data-options="iconCls:'icon-save',resizable:true,closed:true,modal:false">   
		<form id="addForm" class="easyui-form">
			<table cellpadding="5">
				<tr>
					<td>名称:</td>
					<td><input class="easyui-textbox" type="text" id="role_names"
						data-options="required:true"></input></td>
				</tr>
			</table>
		</form>
		   <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAdd()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeAdd()" data-options="iconCls:'icon-no'">取消</a>
		</div>
	</div>
<!-- 修改 -->
 <div id="updateDialog" class="easyui-dialog" title="修改" style="width:300px;height:200px;"   
        data-options="iconCls:'icon-save',resizable:true,closed:true,modal:false">   
		<form id="updateForm" class="easyui-form">
			<table cellpadding="5">
				<tr>
					<td>名称:</td>
					<td><input class="easyui-textbox" type="text" id="role_namess"
						name="role_name" data-options="required:true"></input></td>
				</tr>
			</table>
		</form>
		   <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUpdate()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeUpdate()" data-options="iconCls:'icon-no'">取消</a>
		</div>
	</div>
 <!--权限设置-->
		<div id="quqnxian" class="easyui-dialog"  style="width:300px;height:500px" data-options="iconCls:'icon-save',modal:true,closed:true">
			<ul id="tre" class="easyui-tree" checkbox="true"></ul>
		</div>	
</body>
</html>