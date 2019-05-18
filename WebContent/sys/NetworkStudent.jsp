<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>我的学生</title>
<script src="../js/global.js"></script>
<script type="text/javascript">
$(function(){
	initMyStu();
	$("#refer_user_id").combobox({
		url: '/CRM/selectAllRolesUsers',
		method: 'post',
		valueField:'user_id',    
	    textField:'login_name'  
	})
})
function initMyStu(){
	var booktype=$("#refer_user_id").combobox("getValue");
	if(booktype=="--请选择--"){
		booktype="";
	}
	$("#dg").datagrid({
		url:'/CRM/getMyStu',
		method:'post',
		pagination:true,
		singleSelects:true,
		queryParams:{
			name:$("#name").textbox('getValue'),
			sex:$("#sexs").combobox('getValue'),
			refer_user_id:booktype,
			startcreat_time:$("#startcreat_time").datetimebox('getValue'),
			endcreat_time:$("#endcreat_time").datetimebox('getValue'),
		}
	});
	$("#usertabfrm").form("reset");
}
//操作列
function formatterOPUser(value, row, index) {
	return "<a href='javascript:void(0)' style='cursor: pointer;' onclick='updateInfo(" + index + ")'>编辑</a>";
}
function formattersex(value, row, index) {
	return value==1? "男":"女";
}
function formatterUsers(value, row, index) {
	return row.users.login_name;
}
function btnExport() {
	var rows = $("#dg").datagrid("getSelections");
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

	//Generate a file name
	//var fileName = "我的学生_";
	//this will remove the blank-spaces from the title and replace it with an underscore
	//fileName += ReportTitle.replace(/ /g, "_");

	//Initialize file format you want csv or xls
	//var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	var uri = 'data:text/csv;charset=utf-8,\ufeff' + encodeURI(CSV);

	// Now the little tricky part.
	// you can use either>> window.open(uri);
	// but this will not work in some browsers
	// or you will not get the correct file extension    

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
	var rows = $("#dg").datagrid("getSelections");
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
			if(isOk && na == "sex"){row.性别 = rows[i].sex.value==0? "男":"女";}
			if(isOk && na == "phone"){row.手机号 = rows[i].phone;}
			if(isOk && na == "education"){row.学历 = rows[i].education;}
			if(isOk && na == "state"){row.个人状态 = rows[i].state;}
			if(isOk && na == "sources"){row.来源渠道 = rows[i].sources;}
			if(isOk && na == "source_site"){row.来源网址 = rows[i].source_site;}
			if(isOk && na == "sourcekeyword"){row.来源关键词 = rows[i].sourcekeyword;}
			if(isOk && na == "qq"){row.学员QQ = rows[i].qq;}
			if(isOk && na == "we_chat"){row.微信 = rows[i].we_chat;}
		}
		datarows[i] = row;
		row = {};
	}
	var data = JSON.stringify(datarows);//转换数据为json
	var title = $("#daochu-title").textbox("getValue");//获取标题
	alert(title);
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
        	学生姓名：<input id="name" type= "text"class= "easyui-textbox">
        	性别: <select id="sexs" class="easyui-combobox" style="width:200px;">   
			    <option value="">--请选择--</option>   
			    <option value="1">男</option>   
			    <option value="0">女</option>   
				</select>
        	创建时间：<input id="startcreat_time"  type="text" class= "easyui-datetimebox">~<input id="endcreat_time"  type= "text" class= "easyui-datetimebox"></input>
        	咨询师: <select id="refer_user_id" class="easyui-combobox" style="width:200px;">   
				    <option>--请选择--</option>   
				 </select><br/>
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initMyStu()" data-options="iconCls:'icon-search'">搜索</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addMyStu()" data-options="iconCls:'icon-add'">添加</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="btnExport()" data-options="iconCls:'icon-print'">导出Excel</a>    
		</form>
	</div>
<table id="dg" class="easyui-datagrid" style="width:100%;height:480px" data-options="toolbar:'#usertab'">   
    <thead>   
        <tr>   
        	<th data-options="field:'checkbox',checkbox:true">学生id</th>   
            <th data-options="field:'student_id'">学生id</th>   
            <th data-options="field:'name'">学生姓名</th>   
            <th data-options="field:'age'">年龄</th>
            <th data-options="field:'sex',formatter:formattersex">性别</th> 
            <th data-options="field:'phone'">手机号</th> 
            <th data-options="field:'education'">学历</th> 
            <th data-options="field:'state'">状态</th> 
            <th data-options="field:'qq'">qq号</th> 
            <th data-options="field:'we_chat'">微信号</th> 
            <th data-options="field:'area'">地区</th> 
            <th data-options="field:'create_time'">创建时间</th> 
            <th data-options="field:'sources'">来源渠道</th> 
            <th data-options="field:'source_site'">来源网站</th> 
            <th data-options="field:'sourcekeyword'">来源关键词</th> 
            <th data-options="field:'is_report'">是否报道</th> 
            <th data-options="field:'course'">课程</th> 
            <th data-options="field:'remark'">备注</th>
            <th data-options="field:'users',formatter:formatterUsers">咨询师</th> 
            <th data-options="field:'setUserAction',align:'center',formatter:formatterOPUser">操作</th>
        </tr>   
    </thead>   
</table>
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
							<td><input type="checkbox" name="sex" value="性别" checked="checked"/>性别</td>
							<td><input type="checkbox" name="age" value="年龄" checked="checked"/>年龄</td>
							<td><input type="checkbox" name="phone" value="手机号" checked="checked" />手机号</td>
						</tr>
						<tr>
							<td><input type="checkbox" name="education" value="学历" checked="checked"/>学历</td>
							<td><input type="checkbox" name="state" value="个人状态" checked="checked"/>个人状态</td>
							<td><input type="checkbox" name="sources" value="来源渠道" checked="checked"/>来源渠道</td>
							<td><input type="checkbox" name="source_site" value="来源网址" checked="checked"/>来源网址</td>
						</tr>
						<tr>
							<td><input type="checkbox" name="sourcekeyword" value="来源关键词" checked="checked"/>来源关键词</td>
							<td><input type="checkbox" name="qq" value="学员QQ" checked="checked"/>学员QQ</td>
							<td><input type="checkbox" name="we_chat" value="微信" checked="checked"/>微信</td>
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