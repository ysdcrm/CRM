<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>CRM教育系统</title>
<script src="js/global.js"></script>
<script type="text/javascript">
var login_name;
$(function(){
	createNewCode();
	if (login_name != null) {
		$('#uwin').panel('close');
		$.messager
				.show({
					title : '消息提示',
					timeout : 2000,
					showType : 'slide',
					msg : '<font size=\"2\" color=\"#666666\"><strong>是否登陆上次保存账号?'
							+ '<br clear=left>'
							+ '<br><span  style=\"padding-left:60px\"></span><input type=\"button\" value=\"登陆\" onClick=\"showlogin()\">'
							+ '<span  style=\"padding-left:20px\"></span><input type=\"button\" value=\"清除记录\" onClick=\"closeshow()\">'

				});
		$('#uwin').panel('open');

	}
})
	function showlogin() {
		$('#uwin').panel('close');
		$("#createForm").form("load", {
			login_name : login_name,
			password : password
		});
		login(login_name, password);
	}
	function login(login_name, password) {
		$.post(
				"login",
				{
					login_name:login_name,
					password:password
			},
			function(res){
				if(res.success==true){
					$.messager.alert({
						title:'提示信息',
						msg:'登录成功'
					});
					 window.localStorage.setItem("login_name",res.message.login_name); 
					 window.location.href="main.jsp"; 
				}else{
					$.messager.alert({
						title:'提示信息',
						msg:res.message
					});
				}
			},"json")
	}
	function closeshow() {
		$('#uwin').panel('open');
		$.messager.alert({
			title : '消息提示',
			timeout : 5000,
			showType : 'slide',
			msg : '已清空上次登陆记录'
		});
		setCookie("init","",0);
	}
function createNewCode() {
	var arr = [ '0', '1', '3', '4', '5', '6', '7', '8', '9'];
	/* , 'a', 'b', 'c',
	'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
	'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A',
	'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
	'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'  */
	str = "";
	var strlength = 4;
	for (var i = 0; i < strlength; i++) {
		var num = Math.floor(Math.random() * arr.length);
		str += arr[num];
	}
	;
	var btn = document.getElementById("rightcode");
	btn.value = str;
};
function setCookie(_name, val, expires) {
	var d = new Date();
	d.setDate(d.getDate() + expires);
	document.cookie = _name + "=" + val + ";path=/;expires="
			+ d.toGMTString();
}//获取cookie
function getCookie(_name) {
	var cookie = document.cookie;
	var arr = cookie.split("; ");
	for (var i = 0; i < arr.length; i++) {

		var newArr = arr[i].split("=");
		if (newArr[0] == _name) {
			return newArr[1];
		}
	}
	return "";
}
/*
      如何将json对象转换为字符串
          JSON.stringify(对象);
          返回值是一个字符串
      如何将字符串转换为json对象
          JSON.parse(字符串)
          返回值是对象
 */

if (getCookie("init")) {
	var cookie = JSON.parse(getCookie("init"));
	login_name = cookie.login_name;
	password = cookie.password;
}
function submitForm(){
	
		if ($("#check").is(":checked")) {
			var obj = {};
			obj.login_name = $("#login_name").val();
			obj.password = $("#password").val();
			var a = JSON.stringify(obj);
			setCookie("init", a, 7);
		}
	
	
		var flag=$("#createForm").form("validate");
		var login_name=$("#login_name").val();
		var password=$("#password").val();
		var yan=$("#yan").val();
		if(flag){
			if(str==yan){
				login(login_name, password);
			}else{
				$.messager.alert("提示", "验证码错误");
				$("#createForm").form("clear");
			}
		}
	}
	function clearForm() {
		$("#createForm").form("clear");
	}
</script>
</head>
<body>
<div style="margin:auto auto;width:400px;height: 240px;">
    <div style="margin:200px 0;"></div>
    <div id="uwin" class="easyui-panel" title="欢迎登录" style="width:400px;height: 200px;text-align: center;">
        <div style="padding:10px 60px 20px 60px">
        <form id="createForm" >
            <table cellpadding="2">
                <tr>
                    <td>登录名:</td>
                    <td><input class="easyui-textbox" type="text"  id="login_name" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>密码:</td>
                    <td><input class="easyui-textbox" type="password"  id="password" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>验证码:</td>
                    <td>
                    	<input class="easyui-textbox" type="text"  id="yan" data-options="required:true"></input>
                    </td>
                    <td>
                        <input type="button" id="rightcode" onclick="createNewCode()">
                    </td>
                </tr>
            </table>
        </form>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="submitForm()" data-options="iconCls:'icon-ok'">登陆系统</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" data-options="iconCls:'icon-cancel'">清除输入</a>    
        </div>
        <div style="font-size: 15px;">
				<label for=""><input type="checkbox" id="check" style="width:15px;height:15px;">7天免登陆</label>
		</div>
        </div>
    </div>
    </div>
</body>
</html>