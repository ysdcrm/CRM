<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>CRM教育系统</title>
<script src="js/global.js"></script>
<script type="text/javascript">
	$(function() {
        var login_name=window.localStorage.getItem("login_name");
        $('#menuTree').tree({
			url :'modules',
			method:'post',
			queryParams:{
				login_name:login_name
			},
			onClick : function(node) {
				var text=node.module_name
				var flag = $("#tt").tabs('exists',node.text);
				var isLeaf = $('#menuTree').tree('isLeaf', node.target); //是否是叶子节点
				if(isLeaf) { //只有叶子节点才会在选项卡中创建选项页（每个选项页对应1个功能）
					if(!flag) {
						$('#tt').tabs('add', { //在选项卡中，创建1个选项页
							title: node.text, //选项卡中，选项页的标题（在同一个选项卡中，选项页需要保持一致）。
							closable: true,
							fit: true,
							content: "<iframe style='width:100%;height:500px' src='"+node.path+".jsp'/>" //此处做了调整，推荐使用iframe的方式实现
						});
					} else {
						$("#tt").tabs('select', node.text); //直接选中title对应的选项卡
					}
				}
			}
		})
		$("#UName").text(login_name);
	})
	function clearTuichu() {
		$.messager.confirm('确认','您确认要退出吗？',function(r){    
		    if (r){
		    	$.post("loginTo",{},function(res){
		    		if(res>0){
		    			window.location.href="login.jsp";
		    		}
		    	},"json")
		    }
		});
	}
	function personal() {
		$("#personal-window").window("open");
		/* $.post("personal",{},function(res){
			alert(res.usersAll);
		},"json") */
	}
	//签到
	function qiandao(){
		$.post("/CRM/signon",{},function(res){
			if(res>0){
				 $.messager.show({
						title : '提示信息',	
						msg : "签到成功",
						showType : 'show'
					});
				 $("#qiandaodiv").html("<a href='javascript:void(0)' onclick='qiantui()' class='easyui-linkbutton' data-options='iconCls:'icon-cut''>签退</a>");
			}else if(res<0){
				$.messager.show({
					title : '提示信息',	
					msg : "亲，你今天已经签到过啦！",
					showType : 'show'
				});
				$("#qiandaodiv").html("<a href='javascript:void(0)' onclick='qiantui()' class='easyui-linkbutton' data-options='iconCls:'icon-cut''>签退</a>");
			}else{
				 $.messager.show({
						title : '提示信息',	
						msg : "签到失败",
						showType : 'show'
					});
			}
		},"json")
	}
	//签退
	function qiantui(){
		$.post("/CRM/signback",{},function(res){
			if(res>0){
				 $.messager.show({
						title : '提示信息',	
						msg : "签退成功",
						showType : 'show'
					});
				 $("#qiandaodiv").html("<a href='javascript:void(0)' onclick='yiqiantui()' class='easyui-linkbutton' data-options='iconCls:'icon-cut''>已签退</a>");
			}else if(res<0){
				 $.messager.show({
						title : '提示信息',	
						msg : "亲，你今天已经签退过啦",
						showType : 'show'
					});
				 $("#qiandaodiv").html("<a href='javascript:void(0)' onclick='yiqiantui()' class='easyui-linkbutton' data-options='iconCls:'icon-cut''>已签退</a>");
			}else{
				 $.messager.show({
						title : '提示信息',	
						msg : "签到十分钟内不能签退！",
						showType : 'show'
					});
			}
		},"json")
	}
	//已签退
	function yiqiantui(){
		$.messager.alert("温馨提示","亲，你今天已经签到签退过啦！")
	}
	//修改个人资料
	function UpdatePerson(){
		$('#updateDialog').dialog("open");
	}
	 function submitUpdatePer() {
	  var protect_email = $("#protect_email").val();
	  var protect_tel = $("#protect_tel").val();
		     $.post(
		    	'/CRM/updatePersion',
		    	{ 
		 			protect_email:protect_email,
		 			protect_tel:protect_tel
	 	},function(res){
	 		if(res>0){
					$("#updateDialog").dialog("close");//关闭弹窗
					$.messager.alert("提示","修改成功");//提示
				}
	  },'json')
	 
	 }
	 
	function closeUpdatePer() {
		$('#updateDialog').dialog("close");
	}	
	//修改密码
	function UpdatePassword() {
		$('#updateMMDialog').dialog("open");
	}
	function submitUpdateMM() {
		var password=$("#password").val();
		var newPW=$("#newPW").val();
		var querenPW=$("#querenPW").val();
			$.post(
			    	'/CRM/updatePersionMM',
			    	{ 
			    		password:password,
			    		newPW:newPW,
			    		querenPW:querenPW
		 	},function(res){
		 		 if(res>0){
		 			$.messager.alert("提示","修改成功");//提示
		 			$("#updateMMDialog").dialog("close");//关闭弹窗
					}else{
						$.messager.alert("提示","修改失败");//提示
					} 
		  },'json')
	}
	function closeUpdateMM() {
		$('#updateMMDialog').dialog("close");
	}	
</script>
</head>
<body>
		<div data-option="region:'north'" style="height: 50px;">
			云时代教育管理系统&nbsp;&nbsp;&nbsp;	欢迎您：&nbsp;<span style="font-size: 20px" id="UName"></span>&nbsp;&nbsp;老师！&nbsp;&nbsp;
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearTuichu()" data-options="iconCls:'icon-cancel'">安全退出</a>
			<a href="javascript:void(0)" style="float:content;" class="easyui-linkbutton" onclick="personal()" data-options="iconCls:'icon-man'">个人中心</a> 
			<div id="qiandaodiv"><a href="javascript:void(0)" class="easyui-linkbutton" onclick="qiandao()" data-options="iconCls:'icon-sum'">签到</a></div>
		</div>
		<div id="" style="margin:20px 0;">
		</div>
    		<div class="easyui-layout" style="width:100%;height:650px;">
	        	<div data-options="region:'north'" style="height:50px">
	        		<h2 id="t">云时代欢迎您！系统当前时间是：<span></span>年<span></span>月<span></span>日<span></span><span></span>时<span></span>分<span></span>秒</h2>
		        		<script>
					        var ss=document.getElementById('t').getElementsByTagName('span');
					        function changetime(){
								var time=new Date();
								var days = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
					            ss[0].innerHTML=time.getFullYear();
					            ss[1].innerHTML=time.getMonth()+1;
					            ss[2].innerHTML=time.getDate();
					            ss[3].innerHTML=days[time.getDay()];
					            ss[4].innerHTML=time.getHours();
					            ss[5].innerHTML=time.getMinutes();
					            ss[6].innerHTML=time.getSeconds();
					        }
					        changetime();
					        setInterval(function(){
					            changetime();
					        },1000)
		    			</script>
	        	</div>
        	<div data-options="region:'south',split:true" style="height:50px;"></div>
        	<div data-options="region:'west',split:true" title="导航应用" style="width:150px;">
           		<div id="menuTree" ><!--这个地方显示树状结构-->
           		</div>
        	</div>
        	<div id="center_1" data-options="region:'center',iconCls:'icon-ok'" style="width: 500px;" >
	            <div id="tt" class="easyui-tabs"  > <!--这个地方采用tabs控件进行布局-->
	            </div>
        	</div>
    		</div>
    		<!-- 个人信息框 -->
			<div id="personal-window" class="easyui-window" title="个人信息" style="width:500px;height:500px" data-options="iconCls:'icon-save',modal:true,closed:true">
						<table align="center" style="font-size: 20px">
						<c:forEach items="${user}" var="u">
							<tr>
								<td>用户名：</td>
								<td>${u.login_name}</td>
							</tr>
							<tr>
								<td>邮箱：</td>
								<td>${u.protect_email}</td>
							</tr>
							<tr>
								<td>手机号：</td>
								<td>${u.protect_tel}</td>
							</tr>
							</c:forEach>
							<tr>
								<td>
									<a href="javascript:void(0)" class="easyui-linkbutton" onclick="UpdatePerson()" data-options="iconCls:'icon-edit'">编辑个人资料</a>
								</td>
							</tr>
							<tr>
								<td>
									<a href="javascript:void(0)" class="easyui-linkbutton" onclick="UpdatePassword()" data-options="iconCls:'icon-edit'">修改密码</a>
								</td>
							</tr>
							
						</table>
			</div>
	<!-- 修改 -->
 <div id="updateDialog" id="UpdatePer" class="easyui-dialog" title="修改个人信息" style="width:400px;height:200px;"   
        data-options="iconCls:'icon-save',resizable:true,closed:true,modal:false">   
		<form id="updateForm" class="easyui-form">
			<table cellpadding="5">
			<c:forEach items="${user}" var="u">
				 <tr>
					<td>邮箱:</td>
					<td><input type="text" id="protect_email" value="${u.protect_email}"></td>
				</tr> 
				<tr>
					<td>手机号:</td>
					<td><input type="text" id="protect_tel" value="${u.protect_tel}"></td>
				</tr>
				</c:forEach>
			</table>
		</form>
		   <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUpdatePer()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeUpdatePer()" data-options="iconCls:'icon-no'">取消</a>
		</div>
	</div>			
<!-- 修改密码 -->
 <div id="updateMMDialog" class="easyui-dialog" title="修改个人密码" style="width:400px;height:200px;"   
        data-options="iconCls:'icon-save',resizable:true,closed:true,modal:false">   
		<form id="updateMMForm" class="easyui-form">
			<table cellpadding="5">
			   <tr>
					<td>原密码:</td>
					<td><input class="easyui-textbox" id="password"
						name="password" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>新密码:</td>
					<td><input class="easyui-textbox" id="newPW"
						name="newPW" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>确认密码:</td>
					<td><input class="easyui-textbox" id="querenPW"
						name="querenPW" data-options="required:true"></input></td>
				</tr>
			</table>
		</form>
		   <div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUpdateMM()" data-options="iconCls:'icon-ok'">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeUpdateMM()" data-options="iconCls:'icon-no'">取消</a>
		</div>
	</div>			
</body>
</html>