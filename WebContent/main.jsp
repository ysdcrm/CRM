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
</script>
</head>
<body>
		<div data-option="region:'north'" style="height: 50px;">
			CRM系统&nbsp;&nbsp;&nbsp;	欢迎您：&nbsp;<span id="UName"></span>&nbsp;&nbsp;
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearTuichu()" data-options="iconCls:'icon-cancel'">安全退出</a>
			<a href="javascript:void(0)" style="float:content;" class="easyui-linkbutton" onclick="personal()" data-options="iconCls:'icon-man'">个人中心</a>    
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
									<a href="javascript:void(0)" class="easyui-linkbutton" onclick="" data-options="iconCls:'icon-edit'">编辑个人资料</a>
								</td>
							</tr>
							<tr>
								<td>
									<a href="javascript:void(0)" class="easyui-linkbutton" onclick="" data-options="iconCls:'icon-edit'">修改密码</a>
								</td>
							</tr>
							<tr>
								<td>
									<a href="javascript:void(0)" class="easyui-linkbutton" onclick="" data-options="iconCls:'icon-edit'">编辑个人资料</a>
								</td>
							</tr>
						</table>
			</div>
</body>
</html>