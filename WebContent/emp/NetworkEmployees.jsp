<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>网络咨询师</title>
<script src="../js/global.js"></script>
<script type="text/javascript">
$(function(){
	initUsers();
})
function initUsers(){
	$("#dg").datagrid({
		url:'/CRM/selectAllNetworkEmp',
		method:'post',
		pagination:true,
		singleSelect:true,
		queryParams:{
			login_name:$("#login_name").val(),
			startcreat_time:$('#startcreat_time').datetimebox('getValue'),
			endcreat_time:$('#endcreat_time').datetimebox('getValue')
		}
	});
	$("#usertabfrm").form("reset");
}


//格式化操作 所拥有的学生
function formattertracking1(value,row,index) {
		return '<a  href="javascript:void(0)" class="easyui-linkbutton" onclick="trackingopen('+index+')" >所拥有的学生</a>';
}
function trackingopen(index) {
	var data=$("#dg").datagrid("getData");
	var rows=data.rows[index];
	$("#win-add").window("open");
	initStu(rows);
}
function initStu(rows) {
	var user_id=0;
	if(rows!=null){
		user_id=rows.user_id;
	}else{
		var data = $("#dg").datagrid("getSelected");//获取选中行
		user_id=data.user_id;
	}
	$("#stu").datagrid({
		url:'/CRM/selectAllNetworkEmpByIdStu',
		method:'post',
		pagination:true,
		singleSelects:true,
		queryParams:{
			network_user_id:user_id,
			name:$("#login_nameStu").val(),
			startcreat_time:$('#startcreat_timeStu').datetimebox('getValue'),
			endcreat_time:$('#endcreat_timeStu').datetimebox('getValue')
		}
	});
	$("#stutabfrm").form("reset");
}
//导出表格
function btnExport() {
	var rows = $("#stu").datagrid("getSelections");
	if (rows.length == 0) {
		$.messager.alert("系统信息", "请选择导出的数据");
		return;
	}
	$("#win-daochu").window("open");
}
function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
	//如果jsondata不是对象，那么json.parse将分析对象中的json字符串。
	var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData)
			: JSONData;
	var CSV = '';
	//在第一行拼接标题
	CSV += ReportTitle + '\r\n\n';
	//产生数据标头
	if (ShowLabel) {
		var row = "";
		//此循环将从数组的第一个索引中提取标签
		for ( var index in arrData[0]) {
			//现在将每个值转换为字符串和逗号分隔
			row += index + ',';
		}
		row = row.slice(0, -1);
		//添加带换行符的标签行
		CSV += row + '\r\n';
	}
	//第一个循环是提取每一行
	for (var i = 0; i < arrData.length; i++) {
		var row = "";
		//第二个循环将提取每个列并将其转换为以逗号分隔的字符串
		for ( var index in arrData[i]) {
			row += '"' + arrData[i][index] + '",';
		}
		row.slice(0, row.length - 1);
		//每行后添加换行符
		CSV += row + '\r\n';
	}
	if (CSV == '') {
		alert("Invalid data");
		return;
	}
	//var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	var uri = 'data:text/csv;charset=utf-8,\ufeff' + encodeURI(CSV);
	//this trick will generate a temp <a /> tag
	var link = document.createElement("a");
	link.href = uri;
	//set the visibility hidden so it will not effect on your web-layout
	link.style = "visibility:hidden";
	link.download = ReportTitle + ".csv";
	//this part will append the anchor tag and remove it after automatic click
	document.body.appendChild(link);
	link.click();
	document.body.removeChild(link);
}
function qrdaochu() {
	var rows = $("#stu").datagrid("getSelections");
	var ches = $("#daochu-checkbox :checkbox");//要导出显示的列
	var datarows = [];//空数组
	var row = {};//空json对象
	for (var i = 0; i < rows.length; i++) {
		for (var k = 0; k < ches.length; k++) {
			var na = ches[k].name;//name:字段名
			var isOk = ches[k].checked;
			if(isOk && na == "student_id"){row.ID = rows[i].student_id;}
			if(isOk && na == "name"){row.姓名 = rows[i].name;}
			if(isOk && na == "age"){row.年龄 = rows[i].age;}
			if(isOk && na == "phone"){row.手机号 = rows[i].phone;}
			if(isOk && na == "education"){row.学历 = rows[i].education;}
			if(isOk && na == "qq"){row.学员QQ = rows[i].qq;}
			if(isOk && na == "we_chat"){row.微信 = rows[i].we_chat;}
		}
		datarows[i] = row;
		row = {};
	}
	var data = JSON.stringify(datarows);//转换数据为json
	var title = $("#daochu-title").textbox("getValue");//获取标题
	if(title!=null && title!=''){
		JSONToCSVConvertor(data, title , true);
		$("#win-daochu").window("close");
	}else{
		$.messager.alert("系统信息", "请填写Excel标题");
	}
}
</script>
</head>
<body>
	<div id="usertab">
		<form id="usertabfrm" class="easyui-form">
        	登录名：<input id="login_name" type= "text" class= "easyui-textbox">  
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
            <th data-options="field:'tracking1',formatter:formattertracking1">所拥有的学生</th>
        </tr>   
    </thead>   
</table>
<!-- 查看所拥有的学生 -->
<div id="win-add" class="easyui-window" title="查看学生" style="height:450px;width:1000px" data-options="iconCls:'icon-save',modal:true,closed:true">
	<div id="stutab">
		<form id="stutabfrm" class="easyui-form">
        	学生名：<input id="login_nameStu" type= "text" class= "easyui-textbox">  
        	创建时间：<input id="startcreat_timeStu"  type= "text" class= "easyui-datetimebox">~<input id="endcreat_timeStu"  type= "text" class= "easyui-datetimebox"></input>   
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initStu()" data-options="iconCls:'icon-search'">搜索</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="btnExport()" data-options="iconCls:'icon-print'">导出Excel</a> 
		</form>
	</div>
	<table id="stu" class="easyui-datagrid"  data-options="toolbar:'#stutab'">   
     <thead>   
        <tr>   
			<th data-options="field:'xz',checkbox : true"></th>  
            <th data-options="field:'student_id'">学生id</th>   
            <th data-options="field:'name'">学生名</th> 
            <th data-options="field:'age'">年龄</th>
            <th data-options="field:'education'">学历</th> 
            <th data-options="field:'qq'">QQ</th>
            <th data-options="field:'we_chat'">微信</th>   
            <th data-options="field:'area'">地区</th>  
            <th data-options="field:'create_time'">创建时间</th> 
        </tr>   
    </thead> 
</table>
</div>
<%-- 导出EXCel窗口 --%>
	<div class="easyui-window"
		data-options="iconCls:'icon-save',closed:true,width:600,height:380,modal:true"
		id="win-daochu" title="导出Excel">
		 <table cellpadding="10" id="tab-daochu">
			<tr>														
				<td>
					<label for="content">填写表名:</label>
               		<input class="easyui-textbox" type="text" id="daochu-title" style="width:200px">
				</td>
			</tr>
			<tr>														
				<td>
					<h3>选列:选择要显示的列</h3>
					<table id="daochu-checkbox" style="border:1px solid #000000;" cellpadding="15">
						<tr>
							<td><input type="checkbox" name="student_id" value="ID" checked="checked"/>ID</td>
							<td><input type="checkbox" name="name" value="姓名" checked="checked"/>姓名</td>
							<td><input type="checkbox" name="age" value="年龄" checked="checked"/>年龄</td>
						</tr>
						<tr>
							<td><input type="checkbox" name="education" value="学历" checked="checked"/>学历</td>
							<td><input type="checkbox" name="qq" value="学员QQ" checked="checked"/>学员QQ</td>
							<td><input type="checkbox" name="we_chat" value="微信" checked="checked"/>微信</td>
							<td><input type="checkbox" name="phone" value="手机号" checked="checked" />手机号</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>														
				<td>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="qrdaochu()" data-options="iconCls:'icon-print'">确认导出Excel</a>    
				</td>
			</tr>
		</table> 
	</div> 
</body>
</html>