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
		   Genzong(); 
	})
	function Genzong(){
		   $("#dg").datagrid({
				url : "/CRM/GetTracking",
				method : "post",
				pagination : true,
				singleSelect:false
		   })
	}
	function formatterXS(value,row,index) {
		return row.students.name;
	}
  function formatterFZ(value,row,index) {
	  return row.users.login_name;
	}
  //导出表格
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
	//确认导出
	function qrdaochu() {
		var rows = $("#dg").datagrid("getSelections");
		var ches = $("#daochu-checkbox :checkbox");//要导出显示的列
		var datarows = [];//空数组
		var row = {};//空json对象
		for (var i = 0; i < rows.length; i++) {
			for (var k = 0; k < ches.length; k++) {
				var na = ches[k].name;//name:字段名
				var isOk = ches[k].checked;
				if(isOk && na == "tracking_id"){row.ID = rows[i].tracking_id;}
				if(isOk && na == "students.name"){row.学生姓名 = rows[i].students.name;}
				if(isOk && na == "users.login_name"){row.负责人姓名 = rows[i].users.login_name;}
				if(isOk && na == "tracking_time"){row.跟踪时间 = rows[i].tracking_time;}
				if(isOk && na == "tracking_way"){row.跟踪方式 = rows[i].tracking_way;}
				if(isOk && na == "content_time"){row.回访时间 = rows[i].content_time;}
				if(isOk && na == "content_visit"){row.回访情况 = rows[i].content_visit;}
				if(isOk && na == "remark"){row.回访内容 = rows[i].remark;}
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
			<a href="javascript:void(0)" style="float: right;" class="easyui-linkbutton" onclick="btnExport()" data-options="iconCls:'icon-print'">导出Excel</a>    
		</form>
	</div>
	    <table id="dg" class="easyui-datagrid" style="width:100%;height:300px;">   
    <thead>   
        <tr> 
        	<th data-options="field:'s',checkbox:true"></th>  
            <th data-options="field:'tracking_id'">ID</th>   
            <th data-options="field:'student_id',formatter:formatterXS">学生姓名</th>   
            <th data-options="field:'user_id',formatter:formatterFZ">负责人姓名</th>
            <th data-options="field:'tracking_time'">跟踪时间</th>
            <th data-options="field:'tracking_way'">跟踪方式</th> 
            <th data-options="field:'content_time'">回访时间</th> 
            <th data-options="field:'content_visit'">回访情况</th>
            <th data-options="field:'remark'">回访内容</th>
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
							<td><input type="checkbox" name="tracking_id" value="ID" checked="checked"/>ID</td>
							<td><input type="checkbox" name="students.name" value="学生姓名" checked="checked"/>姓名</td>
							<td><input type="checkbox" name="users.login_name" value="负责人姓名" checked="checked"/>性别</td>
							<td><input type="checkbox" name="tracking_time" value="跟踪时间" checked="checked"/>跟踪时间</td>
							<td><input type="checkbox" name="tracking_way" value="跟踪方式" checked="checked" />跟踪方式</td>
						</tr>
						<tr>
							<td><input type="checkbox" name="content_time" value="回访时间" checked="checked"/>回访时间</td>
							<td><input type="checkbox" name="content_visit" value="回访情况" checked="checked"/>回访情况</td>
							<td><input type="checkbox" name="remark" value="回访内容" checked="checked"/>回访内容</td>
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