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
})
function initMyStu(){
	
	$("#dg").datagrid({
		url:'/CRM/getZXSMyStu',
		method:'post',
		pagination:true,
		singleSelects:true,
		columns : columns,
		queryParams:{
			name:$("#name").textbox('getValue'),
			sex:$("#sexs").combobox('getValue'),
			startcreat_time:$("#startcreat_time").datetimebox('getValue'),
			endcreat_time:$("#endcreat_time").datetimebox('getValue'),
		}
	});
	$("#usertabfrm").form("reset");
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
	if(title!=null && title!=''){
		JSONToCSVConvertor(data, title , true);
		$("#win-daochu").window("close");
	}else{
		$.messager.alert("系统信息", "请填写Excel标题");
	}
}
/* 设置tab-dongtai里面复选框的值为已显示列 */
 var columns = [ [
	{
		field : 'xz',
		checkbox : true
	},
	{
		field : 'student_id',
		title : 'ID'
	},
	{
		field : 'name',
		title : '姓名'
	},
	{
		field : 'age',
		title : '年龄'
	},
	{
		field : 'sex',
		title : '性别',
		formatter:function(value, row, index) {
			return value==1? "男":"女";
		}
	},
	{
		field : 'phone',
		title : '手机号'
	},
	{
		field : 'education',
		title : '学历'
	},
	{
		field : 'state',
		title : '个人状态'
	},
	{
		field : 'sources',
		title : '来源渠道'
	},
	{
		field : 'create_time',
		title : '创建时间'
	},
	{
		field : 'source_site',
		title : '来源网址'
	},
	{
		field : 'sourcekeyword',
		title : '来源关键词'
	},
	{
		field : 'qq',
		title : '学员QQ'
	},
	{
		field : 'we_chat',
		title : '微信'
	},
	{
		field : 'cz',
		title : '操作',
		 formatter : function(value, row, index) {
			return "<span onclick='update(" + index
					+ ")'>修改</span>&nbsp;&nbsp;"
					+"<span onclick='TailAfter(" + index + ")'>跟踪</span>&nbsp;&nbsp";
		} 
	},
	{
		field : 'ck',
		title : '查看记录',
		formatter : function(value, row, index) {
			return "<span onclick='CKTailAfter(" + index + ")'>查看跟踪记录</span>&nbsp;&nbsp";
		}
	} ] ]; 
	//动态显示列
 function dongtai() {
		var html = new Array()
		for (var i = 1; i < columns[0].length - 1; i++) {
			if (columns[0][i].hidden !== true) {
				html[i - 1] = columns[0][i].title;
			}
		}
		var che = $("#tab-dongtai :checkbox");
		for (var i = 0; i < che.length; i++) {
			for (var k = 0; k < html.length; k++) {
				if (che[i].value == html[k]) {
					var name = che[i].name;//已显示的列名
					$("#tab-dongtai :checkbox[name='" + name + "']").attr("checked", "checked");//设置为已选中
					break;
				}
			}
		}
		$("#win-dongtai").window("open");
	}
	/* 根据tab-dongtai里面复选框的选中值显示列 */
	function dongtai2() {
		var che = $("#tab-dongtai :checkbox");
		var columns = [[{field : "xz",checkbox : true}]];
		for (var i = 0; i < che.length; i++) {
			if (che[i].checked) {
				columns[0][columns[0].length] = {field : che[i].name ,title : che[i].value};
			}
		}
		columns[0][columns[0].length] = {field : "users",title : "咨询师",formatter:function(value, row, index) {return row.users.login_name;}};
		columns[0][columns[0].length] = {field : "sex",title : "性别",formatter:function(value, row, index) {return value==1? "男":"女";}};
		columns[0][columns[0].length] = {field : "cz",title : "操作",formatter : function(value, row, index) {return "<span onclick='update(" + index+ ")'>修改</span>&nbsp;&nbsp;"+ "<span onclick='del(" + index + ")'>删除</span>&nbsp;&nbsp;&nbsp;"+"<span onclick='detail(" + index + ")'>查看</span>&nbsp;&nbsp;"+"<span onclick='TailAfter(" + index + ")'>跟踪</span>&nbsp;&nbsp"}};
		$("#dg").datagrid({
			columns : columns
		});
	}
//修改
	function update(index) {
		var data = $("#dg").datagrid("getData"); 
		var row = data.rows[index];
		$("#form-update").form("load",row);
		$("#win-update").window("open");
	}	
function submitStudent() {
		 var flag=$("#form-update").form("validate");//验证
		 var data = $("#dg").datagrid("getSelected");
	     var gzname=$("#gzname").val();
	     var pay_time=$('#pay_time').datetimebox('getValue'); 
		 var is_pay=$("#is_pay").combobox('getValue');
		 var amount=$("#amount").val();
		 var is_refund=$("#is_refund").combobox('getValue');
		 var refund_reason=$("#refund_reason").val();
		 var class_entry_remark=$("#class_entry_remark").val();
		 var is_class_entry=$("#is_class_entry").combobox('getValue');
		 var class_entry_time=$('#class_entry_time').datetimebox('getValue');
		 var is_deposit=$("#is_deposit").combobox('getValue');
		 var deposit_amount=$("#deposit_amount").val();
		 var deposit_time=$('#deposit_time').datetimebox('getValue');
 if(flag){
	 $.post(
		'/CRM/updateStudent',
		{
			student_id:data.student_id,
			gzname:gzname,
			pay_time:pay_time,
			is_pay:is_pay,
			amount:amount,
			is_refund:is_refund,
			refund_reason:refund_reason,
			is_class_entry:is_class_entry,
			class_entry_time:class_entry_time,
			is_deposit:is_deposit,
			class_entry_remark:class_entry_remark,
			deposit_amount:deposit_amount,
			deposit_time:deposit_time
		},function(res){
			 if(res>0){
	                 $.messager.alert("提示","修改成功");
	                 $('#dg').datagrid('reload'); //刷新
	                 $("#win-update").dialog("close");
	              }else{
		            	 $.messager.alert("提示","修改失败！");
		              }
	   	    },'json')
	    }
 $("#form-genzong").form("reset");
	}
	function closeupdate(){
		 $("#win-update").window("close");
	} 
	//网络跟踪
	function TailAfter(index){
		 var data = $("#dg").datagrid("getData");
		 var row = data.rows[index];
		 $("#form-genzong").form("load",row);//填充进表单
		 $("#win-genzong").window("open");
	}
	function submitGenzong(){
		 var flag=$("#form-genzong").form("validate");//验证
		 var student_id=$("#student_id").val();
		 var tracking_time=$("#tracking_time").datetimebox("getValue");
		 var tracking_way=$("#tracking_way").combobox("getValue");
		 var content_time=$("#content_time").datetimebox("getValue");
		 var remark=$("#remark").val();
		 var content_visit =$("#content_visit").combobox("getValue");
		 if(flag){
		   	 $.post(
		   		'/CRM/genzongStu',
		   		{   student_id:student_id,
		   			tracking_time:tracking_time,
		   			tracking_way:tracking_way,
		   			content_time:content_time,
		   			remark:remark,
		   			content_visit:content_visit
		   		},function(res){
		   			 if(res>0){
			                 $.messager.alert("提示","添加成功");
			                 $('#dg').datagrid('reload'); //刷新
			                 $("#form-genzong").form("clear");
			                 $("#win-genzong").window("close");
			              }
		   	    },'json')
		    }
	}
	function closeadd() {
		 $("#win-genzong").window("close");
	}
 
	//查看跟踪记录
	function CKTailAfter(index) {
		var data = $("#dg").datagrid("getData");
		 var row = data.rows[index];
		 $("#win-CKTailAfter").window("open");
		 initCKTailAfter(row);
	}
	function initCKTailAfter(row) {
		var student_id=0;
		if(row!=null){
			student_id=row.student_id;
		}else{
			var data = $("#dg").datagrid("getSelected");//获取选中行
			student_id=data.student_id;
		}
		$("#CKTailAfter").datagrid({
			url:'/CRM/CKzongStu',
			method:'post',
			pagination:true,
			singleSelects:true,
			queryParams:{
				student_id:student_id,
				starttracking_time:$('#starttracking_time').datetimebox('getValue'),
				endtracking_time:$('#endtracking_time').datetimebox('getValue')
			}
		});
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
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initMyStu()" data-options="iconCls:'icon-search'">搜索</a> 
		    <a href="javascript:void(0)" style="float: right;" class="easyui-linkbutton" onclick="btnExport()" data-options="iconCls:'icon-print'">导出Excel</a>    
			<a href="javascript:void(0)" style="float: right;" class="easyui-linkbutton" onclick="dongtai()" data-options="iconCls:'icon-cut'">动态显示列</a> 
		</form>
	</div>
	<table id="dg" class="easyui-datagrid" style="width:100%;height:480px" data-options="toolbar:'#usertab'">   
	</table>
<!-- 修改 -->
	<div id="win-update" class="easyui-window" title="修改学生" style="width:550px;height:450px;"    
         data-options="iconCls:'icon-save',modal:true,closed:true"> 
         <form id="form-update"  method="post">
          <table  cellpadding="5">
             <tr>
					<td>学生名:</td>
					<td><input class="easyui-textbox" type="text" readonly="readonly" id="gzname" name="name"  data-options="required:true"></input></td>
				</tr>
             <tr>
              <td>是否缴费</td>
              <td>
                  <select id="is_pay" class="easyui-combobox" data-options="required:true,showSeconds:false">   
	    			<option>----请选择----</option> 
	    			<option value="0">是</option>
	    			<option value="1">否</option>    
	    		  </select> 
              </td>
            </tr>
            <tr>
              <td> 缴费时间</td>
              <td>
                 <input class="easyui-datetimebox" id="pay_time" data-options="required:true,showSeconds:false" >  
              </td>
            </tr>
            <tr>
              <td> 金额</td>
              <td>
                 <input class="easyui-textbox" id="amount" data-options="required:true,showSeconds:false" >  
              </td>
            </tr>
            <tr>
              <td>是否退费</td>
              <td>
               	  <select id="is_refund" class="easyui-combobox"  style="width:80px" data-options="required:true,showSeconds:false">   
	    			<option>----未知-----</option>   
	    			<option value="0">是</option>
	    			<option value="1">否</option>   
	    		  </select>
              </td>
            </tr>
            <tr>
              <td>退费原因</td>
              <td>
                 <input class="easyui-textbox" id="refund_reason" data-options="required:true,showSeconds:false" >  
              </td>
            </tr>
            <tr>
              <td>是否进班</td>
              <td>
               	  <select id="is_class_entry" class="easyui-combobox"  style="width:80px" data-options="required:true,showSeconds:false">   
	    			<option>----未知-----</option>   
	    			<option value="0">是</option>
	    			<option value="1">否</option>   
	    		  </select>
              </td>
            </tr>
            <tr>
              <td>进班时间</td>
              <td>
                 <input class="easyui-datetimebox" id="class_entry_time" data-options="required:true,showSeconds:false" >  
              </td>
            </tr>
             <tr>
              <td>进班备注</td>
              <td>
                 <input class="easyui-textbox" id="class_entry_remark" data-options="required:true,showSeconds:false" >  
              </td>
            </tr>
            <tr>
              <td>是否定金</td>
              <td>
               	  <select id="is_deposit" class="easyui-combobox"  style="width:80px" data-options="required:true,showSeconds:false">   
	    			<option>----未知-----</option>   
	    			<option value="0">是</option>
	    			<option value="1">否</option>   
	    		  </select>
              </td>
            </tr>
            <tr>
              <td>定金金额</td>
              <td>
               	<input id="deposit_amount" class="easyui-textbox"  type="text" data-options="required:true,showSeconds:false">
              </td>
            </tr>
            <tr>
              <td>定金时间</td>
              <td>
                 <input class="easyui-datetimebox" id="deposit_time" data-options="required:true,showSeconds:false" >  
              </td>
            </tr>
          </table>
         </form>
         <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitStudent()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeupdate()" data-options="iconCls:'icon-no'">取消</a>
		</div>  
   </div>
   <!-- 网络跟踪 -->
	<div id="win-genzong" class="easyui-window" title="跟踪学生" style="width:500px;height:400px;"    
         data-options="iconCls:'icon-save',modal:true,closed:true"> 
         <form id="form-genzong"  method="post">
          <table  cellpadding="5">
            <tr>
					<td><input class="easyui-textbox" type="hidden" id="student_id" name="student_id"></input></td>
				</tr>
             <tr>
					<td>学生名:</td>
					<td><input class="easyui-textbox" type="text" readonly="readonly" id="gzname" name="name"  ></input></td>
				</tr>
             <!-- <tr>
              <td>跟踪人</td>
              <td><input class="easyui-textbox" type="text" id="gzuser" 
						 data-options="reload:true"></input>
                  <select id="gz" class="easyui-combobox"  >   
	    			<option>----请选择----</option>     
	    		  </select> 
              </td>
            </tr> -->
            <tr>
              <td> 跟踪时间</td>
              <td>
                 <input class="easyui-datetimebox" id="tracking_time" data-options="required:true,showSeconds:false" >  
              </td>
            </tr>
            <tr>
              <td>跟踪方式</td>
              <td>
               	  <select id="tracking_way" class="easyui-combobox"  style="width:80px">
               	     <option>--请选择--</option> 
	    			<option value="上门">上门</option>   
	    			<option value="邮箱">邮箱</option>
	    			<option value="电话">电话</option>   
	    		  </select>
              </td>
            </tr>
            <tr>
              <td>回访时间</td>
              <td>
                 <input class="easyui-datetimebox" id="content_time" data-options="required:true,showSeconds:false" >  
              </td>
            </tr>
            <tr>
              <td>回访内容</td>
              <td>
               	<input id="remark" class="easyui-textbox" type="text" data-options="required:true,showSeconds:false">
              </td>
            </tr>
            <tr>
             <td>回访情况 </td>
             <td>
              <select id="content_visit" class="easyui-combobox" style="width:80px">
                    <option>---请选择--</option>   
	    			<option value="有效">有效</option>   
	    			<option value="非常有效">非常有效</option>
	    			<option value="无效">无效</option>   
	    			<option value="下次跟进">下次跟进</option> 
    		   </select>
             </td>
            </tr>
          </table>
         </form>
         <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitGenzong()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeadd()" data-options="iconCls:'icon-no'">取消</a>
		</div>  
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
	<%-- 动态显示列窗口 --%>
	<div class="easyui-window"
		data-options="iconCls:'icon-save',closed:true,width:500,height:300"
		id="win-dongtai" title="动态显示列">
		<table cellpadding="10" id="tab-dongtai">
			<tr>														
				<td>
					ID<input type="checkbox" onclick="dongtai2()" name="student_id" value="ID" />
					姓名<input type="checkbox" onclick="dongtai2()" name="name" value="姓名" />
					年龄<input type="checkbox" onclick="dongtai2()" name="age" value="年龄" />
					性别<input type="checkbox" onclick="dongtai2()" name="sex" value="性别" />
					手机号<input type="checkbox" onclick="dongtai2()" name="phone" value="手机号" />
					学历<input type="checkbox" onclick="dongtai2()" name="education" value="学历" />
					个人状态<input type="checkbox" onclick="dongtai2()" name="state" value="个人状态" />&nbsp;
					来源渠道<input type="checkbox" onclick="dongtai2()" name="sources" value="来源渠道" />&nbsp;
					来源网址<input type="checkbox" onclick="dongtai2()" name="source_site" value="来源网址" />
					
				</td>
			</tr>
			<tr>														
				<td>
					来源关键词<input type="checkbox" onclick="dongtai2()" name="sourcekeyword" value="来源关键词" />
					学员QQ<input type="checkbox" onclick="dongtai2()" name="qq" value="学员QQ" />
					微信<input type="checkbox" onclick="dongtai2()" name="we_chat" value="微信" />
					是否报道 <input type="checkbox" onclick="dongtai2()" name="is_report" value="是否报道" />
					备注<input type="checkbox" onclick="dongtai2()" name="remark" value="备注" />
				</td>
			</tr>
			<tr>														
				<td>
					创建时间<input type="checkbox" onclick="dongtai2()" name="create_time" value="创建时间" />&nbsp;
					地区<input type="checkbox" onclick="dongtai2()" name="area" value="地区" />&nbsp;&nbsp;
					课程方向<input type="checkbox" onclick="dongtai2()" name="course" value="课程方向" />&nbsp;
					是否有效<input type="checkbox" onclick="dongtai2()" name="is_effective" value="是否有效" />&nbsp;
					打分<input type="checkbox" onclick="dongtai2()" name="scoring" value="打分" />&nbsp;
					是否回访<input type="checkbox" onclick="dongtai2()" name="is_visit" value="是否回访" />&nbsp;
				</td>
			</tr>
			<tr>														
				<td>
					首次回访时间<input type="checkbox" onclick="dongtai2()" name="first_visit_time" value="首次回访时间" />&nbsp;
					是否上门<input type="checkbox" onclick="dongtai2()" name="is_door" value="是否上门" />
					上门时间<input type="checkbox" onclick="dongtai2()" name="door_time" value="上门时间" />&nbsp;
					无效原因<input type="checkbox" onclick="dongtai2()" name="invalid_reason" value="无效原因" />
					是否缴费<input type="checkbox" onclick="dongtai2()" name="is_pay" value="是否缴费" />&nbsp;
					缴费时间<input type="checkbox" onclick="dongtai2()" name="pay_time" value="缴费时间" />
				</td>
			</tr>
			<tr>														
				<td>
					是否退费<input type="checkbox" onclick="dongtai2()" name="is_refund" value="是否退费" />&nbsp;&nbsp;
					进班时间<input type="checkbox" onclick="dongtai2()" name="class_entry_time" value="进班时间" />&nbsp;&nbsp;
					是否进班<input type="checkbox" onclick="dongtai2()" name="is_class_entry" value="是否进班" />&nbsp;&nbsp;
					进班备注<input type="checkbox" onclick="dongtai2()" name="class_entry_remark" value="进班备注" />&nbsp;&nbsp;
					退费原因<input type="checkbox" onclick="dongtai2()" name="refund_reason" value="退费原因" />&nbsp;
					定金金额<input type="checkbox" onclick="dongtai2()" name="deposit_amount" value="定金金额" />
					
				</td>
			</tr>
			<tr>														
				<td>
					金额<input type="checkbox" onclick="dongtai2()" name="amount" value="金额" />
					定金时间<input type="checkbox" onclick="dongtai2()" name="is_deposit" value="定金时间" />
					<!-- 录入人<input type="checkbox" onclick="dongtai2()" name="enteringName" value="录入人" />
					动态的<input type="checkbox" onclick="dongtai2()" name="dynamic" value="动态的" /> -->
				</td>
			</tr>
		</table>
	</div> 
   
   <!-- 查看跟踪记录 -->
<div id="win-CKTailAfter" class="easyui-window" title="查看跟踪记录" style="height:450px;width:1000px" data-options="iconCls:'icon-save',modal:true,closed:true">
	<div id="CKTailAftertab">
		<form id="CKTailAfterfrm" class="easyui-form">
        	跟踪时间：<input id="starttracking_time"  type= "text" class= "easyui-datetimebox">~<input id="endtracking_time"  type= "text" class= "easyui-datetimebox"></input>   
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initCKTailAfter()" data-options="iconCls:'icon-search'">搜索</a> 
		</form>
	</div>
	<table id="CKTailAfter" class="easyui-datagrid"  data-options="toolbar:'#stutab'">   
     <thead>   
        <tr>   
            <th data-options="field:'tracking_time'">跟踪时间</th>
            <th data-options="field:'tracking_way'">跟踪方式</th> 
            <th data-options="field:'content_time'">回访时间</th> 
            <th data-options="field:'content_visit'">回访情况</th>
            <th data-options="field:'remark'">回访内容</th>
        </tr>   
    </thead> 
</table>
</div>
</body>
</html>