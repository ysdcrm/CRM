<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="../js/global.js"></script>
<script type="text/javascript">

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
	columns[0][columns[0].length] = {field : "caozuo",title : "操作",formatter : function(value, row, index) {return "<span onclick='updateStu(" + index+ ")'>修改</span>&nbsp;&nbsp;"+ "<span onclick='delStu(" + index + ")'>删除</span>"}};
	
	$("#dg").datagrid({
		columns : columns
	});
}

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
		formatter : function(value,row,index) {
			return value==1?'男':'女';
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
		field : 'qq',
		title : '学员QQ'
	},
	{
		field : 'we_chat',
		title : '微信'
	},
	{
		field : 'area',
		title : '地区'
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
		field : 'caozuo',
		title : '操作',
		formatter : function(value, row, index) {
			return "<a onclick='delStu(" + index + ")'>失效</a>&nbsp;&nbsp;"+"<a onclick='chakanStu(" + index + ")'>查看</a>&nbsp;&nbsp;";
		}
	},
	{
		field : 'ck',
		title : '查看记录',
		formatter : function(value, row, index) {
			return "<span onclick='CKTailAfter(" + index + ")'>查看跟踪记录</span>&nbsp;&nbsp";
		}
	}  ] ];
	
$(function(){
	initStu();
	$("#zx").combobox({
		url:'/CRM/selectAllRolesUsers',
		method:'post',
		valueField:'user_id',//填充进 <option value='id'>text</option>
		textField:'login_name'//标签中间（<option>text</option>） 
	})
})
	
function initStu() {
	var zxid=$("#zx").combobox("getValue");
	if(zxid=="----请选择----"){
		zxid="";
	} ;
	$("#dg").datagrid({
		url : "/CRM/showStu",
		method : "post",
		toolbar : "#usertab",
		pagination : true,
		singleSelect:false,
		columns:columns,
		queryParams:{
			name:$("#name").val(),
			sex:$("#sex").combobox("getValue"),
			education:$("#education").combobox("getValue"),
			area:$("#area").combobox("getValue"),
			sources:$("#sources").combobox("getValue"),
			startcreat_time:$("#startcreat_time").datetimebox("getValue"),
			endcreat_time:$("#endcreat_time").datetimebox("getValue"),
			refer_user_id:zxid
		}
	});
	$("#usertabfrm").form("reset");
}

//查看
function chakanStu(index){
	  var data = $("#dg").datagrid("getData");
	  var row = data.rows[index];
	  $("#chakanForm").form("load",row);//填充进表单
	  $("#chakanDialog").dialog("open"); 
}
//添加
function addStu(){

	 $("#addDialog").dialog("open");
	 $("#fzr").combobox({
			url:'/CRM/selectAllRolesUsers',
			method:'post',
			valueField:'user_id',//填充进 <option value='id'>text</option>
			textField:'login_name'//标签中间（<option>text</option>） 
		});
}
function submitadd(){
	var fzrid=$("#fzr").combobox("getValue");
	if(fzrid=="----请选择----"){
		fzrid="";
	} ;
	 var flag=$("#addForm").form("validate");//验证
	 var data = $("#dg").datagrid("getData"); 
	 var create_time=data.create_time;
	 var name=$("#stuname").val();
	 var age=$("#stuage").val();
	 var sex=$("#stusex").combobox("getValue");
	 var education =$("#stueducation").combobox("getValue");
	 var state =$("#stustate").combobox("getValue");
	 var phone=$("#stuphone").val();
	 var tel = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/;
	 if(!tel.test(phone)){   //手机号的正则表达式
         $.messager.show({
				title:'提示信息',
				msg:'手机号码有误，请重新输入正常手机号！！！',
				showType:'show'
			});
         return false;
     }
	 var qq=$("#stuqq").val();
	 var qq1 = /^[1-9]\d{4,9}$/
		 if(!qq1.test(qq)){   //正则表达式
	         $.messager.show({
					title:'提示信息',
					msg:'QQ输入错误！请重新输入正常QQ号！！！',
					showType:'show'
				});
	         return false;
	     }
     var area=$("#stuarea").combobox("getValue");
     var sources=$("#stusources").combobox("getValue");
    if(flag){
   	 $.post(
   		'/CRM/addStu',
   		{
   			refer_user_id:fzrid,
   			name:name,
   			age:age,
   			sex:sex,
   			education:education,
   			state:state,
   			phone:phone,
   			qq:qq,
   			area:area,
   			sources:sources,
   			create_time:create_time
   			
   		},function(res){
   			 if(res>0){
	                 $.messager.alert("提示","添加成功");
	                 $('#dg').datagrid('reload'); //刷新
	                 $("#addForm").form("clear");
	                 $("#addDialog").dialog("close");
	              }
   	    },'json')
    }
}
function closeadd(){
	 $("#addDialog").dialog("close");
}
//讲学生改为失效状态
function delStu(index){
	var data = $("#dg").datagrid("getData"); 
    var row = data.rows[index]; 
	$.messager.confirm('确认', '您确定将:'+row.name+'学生改为失效状态吗？', function(r){
		if (r){
			$.post("/CRM/delStu",{
				student_id:row.student_id,
			},function(i){
				if(i>0){
					$.messager.alert("提示","该学生已处于失效状态！");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("提示","修改失败！");
				}
			},"json")
		}
	});
}

//导出Excel表
function Excelbtn(){
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

	var uri = 'data:text/csv;charset=utf-8,\ufeff' + encodeURI(CSV);
	var link = document.createElement("a");
	link.href = uri;
	link.style = "visibility:hidden";
	link.download = ReportTitle + ".csv";
	document.body.appendChild(link);
	link.click();
	document.body.removeChild(link);
}
function bgdaochu() {
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

  //已分配
  function yiFenpei(){
	  $("#yfp-window").window("open");
	  yfpStu();
	  $("#yfpzx").combobox({
			url:'/CRM/selectAllRolesUsers',
			method:'post',
			valueField:'user_id',//填充进 <option value='id'>text</option>
			textField:'login_name'//标签中间（<option>text</option>） 
		})
  }
  function yfpStu() {
	  var yfpid=$("#yfpzx").combobox("getValue");
		if(yfpid=="----请选择----"){
			yfpid="";
		} ;
	  $("#yfpdg").datagrid({
			url:'/CRM/yifenpeiStu',
			method:'post',
			pagination:true,
			singleSelect:true,
			queryParams:{
				name:$("#yfpname").val(),
				startcreat_time:$("#yfpstartcreat_time").datetimebox("getValue"),
				endcreat_time:$("#yfpendcreat_time").datetimebox("getValue"),
				refer_user_id:yfpid
			}
		});
	  $("#yfpfrm").form("reset");
}
  function formatteryfpSex(value,row,index){
	  return value==1?'男':'女';
  }
  
  function formatteryfpzx(value,row,index){
	  return row.users.login_name;
  }
  //未分配
  function weiFenpei(){
	  $("#wfp-window").window("open");
	  wfpStu();
	 
  }
  function wfpStu(){
		$("#wfpdg").datagrid({
			url:'/CRM/weifenpeiStu',
			method:'post',
			pagination:true,
			singleSelect:false,
			queryParams:{
				name:$("#wfpname").val(),
				startcreat_time:$("#wfpstartcreat_time").datetimebox("getValue"),
				endcreat_time:$("#wfpendcreat_time").datetimebox("getValue")
			}
		});
		$("#wfpfrm").form("reset");
  }
  function formatterwfpSex(value,row,index){
	  return value==1?'男':'女';
  }
  
 //批量分配
 function piliang(){
	 var rows = $("#wfpdg").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("系统信息", "请选择分配的数据");
			return;
		}
	 $("#pl-window").window("open");
	 $("#plname").combobox({
			url:'/CRM/selectAllRolesUsers',
			method:'post',
			valueField:'user_id',//填充进 <option value='id'>text</option>
			textField:'login_name'//标签中间（<option>text</option>） 
		})
 }
 //批量分配保存按钮
 function submitpl(){
	 
	
	 var fpid=$("#plname").combobox("getValue");
		if(fpid=="----请选择----"){
			fpid="";
		} ;
	var ids='';
    var datas= $("#wfpdg").datagrid("getSelections"); 
	for(var i=0;i<datas.length;i++){
        var data=datas[i];
        ids=ids+data.student_id+",";
         var index=$('#wfpdg').datagrid('getRowIndex',data);
         $('#wfpdg').datagrid('deleteRow',index);
    }
	
	$.post("/CRM/fenpeiZXS",{
				student_id:ids,
				refer_user_id:fpid
		},function(i){
				if(i>0){
					$.messager.alert("提示","分配成功！");
					$("#wfpdg").datagrid("reload");
					$("#pl-window").window("close");
					$("#wfp-window").window("close");
					
				}else{
					$.messager.alert("提示","分配失败！");
				}
		},"json") 
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
			url:'/CRM/CKzongStuBYUser',
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
	//负责人
	  function formatterFZ(value,row,index) {
	  return row.users.login_name;
	}
</script>
</head>
<body>
<div id="usertab">
		<form id="usertabfrm" class="easyui-form">
        	学生姓名：<input id="name" type= "text" class= "easyui-textbox" style="width:60px">  
        	性别：<select id="sex" class="easyui-combobox" style="width:90px">
				      <option value="">----请选择----</option>   
					  <option value="1">男</option>
					  <option value="0">女</option>	
				   </select> 
        	学历：<select id="education" class="easyui-combobox" style="width:90px">
				      <option value="">----请选择----</option>   
					  <option value="高中">高中</option> 
				      <option value="专科">专科</option>
					  <option value="本科">本科</option>	
					  <option value="研究生">研究生</option>	
				   </select> 
        	
        	地区：<select id="area" class="easyui-combobox" style="width:90px">
				      <option value="">----请选择----</option>   
					  <option value="郑州">郑州</option>
					  <option value="北京">北京</option>	
					  <option value="上海">上海</option>	
					  <option value="广州">广州</option>	
					  <option value="其他" >其他</option>	
				   </select> 
        	
        	来源渠道：<select id="sources" class="easyui-combobox" style="width:90px">
				      <option value="">----请选择----</option>   
					  <option value="百度">百度</option>
					  <option value="360">360</option>	
					  <option value="微信" >微信</option>	
					  <option value="其他" >其他</option>	
				   </select> 
		        咨询师：<select id="zx" class="easyui-combobox" style="width:90px">
				      <option >----请选择----</option>   
				   </select>
		    
        	创建时间：<input id="startcreat_time"  type= "text" class= "easyui-datetimebox" style="width:100px">~
        	         <input id="endcreat_time"  type= "text" class= "easyui-datetimebox" style="width:100px">  
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="initStu()" data-options="iconCls:'icon-search'">搜索</a><br>
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addStu()" data-options="iconCls:'icon-add'">添加</a> 
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cut" onclick="dongtai()">动态显示列</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="Excelbtn()" data-options="iconCls:'icon-print'">导出Excel</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="yiFenpei()" >已分配</a> 
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="weiFenpei()" >未分配</a>		
		</form>
	</div>
<table id="dg"></table>
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
					网络咨询师<input type="checkbox" onclick="dongtai2()" name="network_user_id" value="网络咨询师" />
					咨询师<input type="checkbox" onclick="dongtai2()" name="refer_user_id" value="咨询师" />
				</td>
			</tr>
			<tr>														
				<td>
					创建时间<input type="checkbox" onclick="dongtai2()" name="create_time" value="创建时间" />&nbsp;
					地区<input type="checkbox" onclick="dongtai2()" name="area" value="地区" />&nbsp;&nbsp;
					课程方向<input type="checkbox" onclick="dongtai2()" name="course" value="课程方向" />&nbsp;
					是否有效<input type="checkbox" onclick="dongtai2()" name="Is_invalid" value="是否有效" />&nbsp;
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
					定金时间<input type="checkbox" onclick="dongtai2()" name="deposit_time" value="定金时间" />
					
				</td>
			</tr>
		</table>
	</div>
	<!-- 查看学生 -->
<div id="chakanDialog" class="easyui-dialog" title="查看" style="width:500px;height:400px;"   
        data-options="iconCls:'icon-save',resizable:true,closed:true,modal:false">   
		<form id="chakanForm" class="easyui-form">
			<table cellpadding="5">
				<tr>
					<td>学生名:</td>
					<td><input class="easyui-textbox" type="text" id="name"
						name="name" data-options="readonly:true"></input></td>
				</tr>
				<tr>
					<td>年龄:</td>
					<td><input class="easyui-textbox" type="text" id="age"
						name="age" data-options="readonly:true"></input></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td><select id="sex" class="easyui-combobox" style="width:80px">
						  <option value="1">男</option>
						  <option value="0">女</option>	
					   </select> 
					</td>
				</tr>
				<tr>
					<td>手机号:</td>
					<td><input class="easyui-textbox" type="text" id="phone"
						name="phone" data-options="readonly:true"></input></td>
				</tr>
				<tr>
					<td>QQ:</td>
					<td><input class="easyui-textbox" type="text" id="qq"
						name="qq" data-options="readonly:true"></input></td>
				</tr>
				<tr>
					<td>来源渠道:</td>
					<td><input class="easyui-textbox" type="text" id="sources"
						name="sources" data-options="readonly:true"></input></td>
				</tr>
				<tr>
					<td>创建时间:</td>
					<td><input class="easyui-datetimebox" type="text" id="create_time"
						name="create_time" data-options="readonly:true"></input></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 添加学生 -->
   <div id="addDialog" class="easyui-dialog" title="添加" style="width:500px;height:400px;"   
        data-options="iconCls:'icon-save',resizable:true,closed:true,modal:false">   
		<form id="addForm" class="easyui-form">
			<table cellpadding="5">
				<tr>
					<td>学生名:</td>
					<td><input class="easyui-textbox" type="text" id="stuname"
						name="stuname" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>年龄:</td>
					<td><input class="easyui-textbox" type="text" id="stuage"
						name="stuage" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td><select id="stusex" class="easyui-combobox" >
					      <option value="">----请选择----</option>   
						  <option value="1">男</option>
						  <option value="0">女</option>	
					   </select> 
					</td>
				</tr>
				<tr>
					<td>学历:</td>
					<td>
					    <select id="stueducation" class="easyui-combobox" >
					      <option value="">----请选择----</option>  
					      <option value="高中">高中</option> 
						  <option value="专科">专科</option>
						  <option value="本科">本科</option>	
						  <option value="研究生">研究生</option>	
						</select>
					</td>
				</tr>
				<tr>
					<td>状态:</td>
					<td>
					    <select id="stustate" class="easyui-combobox" >
					      <option value="">----请选择----</option>  
					      <option value="在读">在读</option> 
						  <option value="在职">在职</option>
						  <option value="未知">未知</option>	
						</select>
					</td>
				</tr>
				<tr>
                        <td>手机号:</td>
                        <td><input type="text" class="easyui-numberbox" id="stuphone" name="stuphone" data-options="required:true"></td>
                    </tr> 
				<tr>
					<td>QQ:</td>
					<td><input class="easyui-textbox" type="text" id="stuqq"
						name="stuqq" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>地区:</td>
					<td>
					    <select id="stuarea" class="easyui-combobox" >
					      <option value="">----请选择----</option>   
						  <option value="郑州">郑州</option>
						  <option value="北京">北京</option>	
						  <option value="上海">上海</option>	
						  <option value="广州">广州</option>	
						  <option value="其他" >其他</option>	
					   </select> 
					</td>
				</tr>
				<tr>
					<td>来源渠道:</td>
					<td><select id="stusources" class="easyui-combobox" >
					      <option value="">----请选择----</option>   
						  <option value="百度">百度</option>
						  <option value="360">360</option>	
						  <option value="微信" >微信</option>	
						  <option value="其他" >其他</option>	
					   </select> 
					</td>
				</tr>
				<tr>
					<td>负责人:</td>
					<td><select id="fzr" class="easyui-combobox" >
					      <option>----请选择----</option>   
					   </select> 
					</td>
				</tr>
			</table>
		</form>
	    <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitadd()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeadd()" data-options="iconCls:'icon-no'">取消</a>
		</div> 
	</div>
	
	
<%-- 导出EXCel窗口 --%>
	<div id="win-daochu" class="easyui-window"
		data-options="iconCls:'icon-save',closed:true,width:600,height:380,modal:true"
		title="导出Excel">
		 <table id="tab-daochu" cellpadding="10" >
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
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="bgdaochu()" data-options="iconCls:'icon-print'">确认导出Excel</a>    
				</td>
			</tr>
		</table> 
	</div> 
<!-- 已分配窗口 -->
 <div id="yfp-window" class="easyui-window" title="已分配的学生信息" style="width:1000px;height:450px;"   
        data-options="iconCls:'icon-save',closed:true,modal:true">
       <div id="yfpbtn">
		<form id="yfpfrm" class="easyui-form">
        	学生姓名：<input id="yfpname" type= "text" class= "easyui-textbox" style="width:80px">  
        	
		        咨询师：<select id="yfpzx" class="easyui-combobox" style="width:110px">
				      <option >----请选择----</option>   
				   </select>
        	创建时间：<input id="yfpstartcreat_time"  type= "text" class= "easyui-datetimebox" style="width:110px">~
        	         <input id="yfpendcreat_time"  type= "text" class= "easyui-datetimebox" style="width:110px">  
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="yfpStu()" data-options="iconCls:'icon-search'">搜索</a><br>
		</form>
	</div>
	<table id="yfpdg" class="easyui-datagrid"    
        data-options="toolbar:'#yfpbtn'">   
    <thead>   
        <tr> 
            <th data-options="field:'student_id'">学生id</th>   
            <th data-options="field:'name'">学生姓名</th>   
            <th data-options="field:'age'">年龄</th>
            <th data-options="field:'sex',formatter:formatteryfpSex">性别</th>
            <th data-options="field:'phone'">手机号</th> 
            <th data-options="field:'education'">学历</th> 
            <th data-options="field:'state'">状态</th> 
            <th data-options="field:'qq'">qq号</th> 
            <th data-options="field:'we_chat'">微信号</th> 
            <th data-options="field:'area'">地区</th> 
            <th data-options="field:'sources'">来源渠道</th> 
            <th data-options="field:'create_time',align:'center'">创建时间</th>
            <th data-options="field:'user_id',formatter:formatteryfpzx">咨询师</th>
        </tr>                                     
    </thead>   
  </table> 
</div>
 <!-- 未分配窗口 -->
 <div id="wfp-window" class="easyui-window" title="未分配的学生信息" style="width:1000px;height:450px;"   
        data-options="iconCls:'icon-save',closed:true,modal:true">
      <div id="wfpbtn">
		<form id="wfpfrm" class="easyui-form">
        	学生姓名：<input id="wfpname" type= "text" class= "easyui-textbox" style="width:80px">  
        	创建时间：<input id="wfpstartcreat_time"  type= "text" class= "easyui-datetimebox" style="width:110px">~
        	         <input id="wfpendcreat_time"  type= "text" class= "easyui-datetimebox" style="width:110px">  
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="wfpStu()" data-options="iconCls:'icon-search'">搜索</a><br>
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="piliang()" data-options="iconCls:'icon-reload'">批量分配</a><br>
		</form>
	</div>
    <table id="wfpdg" class="easyui-datagrid" style="width:100%;height:480px"   
        data-options="toolbar:'#wfpbtn'">   
      <thead>   
        <tr> 
        	<th data-options="field:'s',checkbox:true"></th>  
            <th data-options="field:'student_id'">学生id</th>   
            <th data-options="field:'name'">学生姓名</th>   
            <th data-options="field:'age'">年龄</th>
            <th data-options="field:'sex',formatter:formatterwfpSex">性别</th>
            <th data-options="field:'phone'">手机号</th> 
            <th data-options="field:'education'">学历</th> 
            <th data-options="field:'state'">状态</th> 
            <th data-options="field:'qq'">qq号</th> 
            <th data-options="field:'we_chat'">微信号</th> 
            <th data-options="field:'area'">地区</th> 
            <th data-options="field:'sources'">来源渠道</th> 
            <th data-options="field:'create_time',align:'center'">创建时间</th>
        </tr>   
    </thead>   
  </table>  
  <div id="pl-window" class="easyui-window" title="批量分配" style="width:260px;height:200px;"   
        data-options="iconCls:'icon-save',closed:true,modal:true">
      <form id="plfrm" class="easyui-form">
	      <table cellpadding="5">
	         <tr>
				<td>咨询师:</td>
				<td><select id="plname" class="easyui-combobox" style="width:90px" >
						<option>----请选择----</option>   
					 </select> 
				</td>
			</tr>
	      </table>
	   </form>
       <div style="text-align: center; padding: 5px">
           <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitpl()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closepl()" data-options="iconCls:'icon-no'">取消</a>
		</div>
       </div> 
  </div> 
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
            <th data-options="field:'user_id',formatter:formatterFZ">负责人</th>
        </tr>   
    </thead> 
</table>
</div>
</body>
</html>