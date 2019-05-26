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
</script>
</head>
<body>
	    <table id="dg" class="easyui-datagrid" style="width:100%;height:480px"   
        data-options="toolbar:'#usertab'">   
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
	   
</body>
</html>