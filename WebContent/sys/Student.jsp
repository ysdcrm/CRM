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
	initStu();
})
function initStu(){
	$("#dg").datagrid({
		url:'/CRM/showStu',
		method:'post',
		pagination:true,
		singleSelect:true
		
	});
	$("#usertabfrm").form("reset");
}

</script>
</head>
<body>
    <div id="usertab">
		<form id="usertabfrm" class="easyui-form">
        	学生姓名：<input id="name" type= "text" class= "easyui-textbox">  
        	创建时间：<input id="startcreat_time"  type= "text" class= "easyui-datetimebox">~<input id="endcreat_time"  type= "text" class= "easyui-datetimebox"></input>   
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initUsers()" data-options="iconCls:'icon-search'">搜索</a> 
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addUsers()" data-options="iconCls:'icon-add'">添加</a> 
		</form>
	</div>
<table id="dg" class="easyui-datagrid" style="width:100%;height:480px"   
        data-options="toolbar:'#usertab'">   
    <thead>   
        <tr>   
            <th data-options="field:'student_id'">学生id</th>   
            <th data-options="field:'name'">学生姓名</th>   
            <th data-options="field:'age'">年龄</th>
            <th data-options="field:'sex'">性别</th> 
            <th data-options="field:'phone'">手机号</th> 
            <th data-options="field:'education'">学历</th> 
            <th data-options="field:'state'">状态</th> 
            <th data-options="field:'qq'">qq号</th> 
            <th data-options="field:'we_chat'">微信号</th> 
            <th data-options="field:'area'">地区</th> 
            <th data-options="field:'sources'">来源渠道</th> 
            <th data-options="field:'source_site'">来源网站</th> 
            <th data-options="field:'sourcekeyword'">来源关键词</th> 
            <th data-options="field:'is_report'">是否报道</th> 
            <th data-options="field:'course'">课程</th> 
            <th data-options="field:'remark'">备注</th> 
        </tr>   
    </thead>   
</table> 
</body>
</html>