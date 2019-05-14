package com.ysd.service;

import java.util.List;
import java.util.Map;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;
import com.ysd.entity.Userroles;
import com.ysd.entity.Users;

public interface UsersService {
	//登录功能
	Map<String, Object>  getLogin(Users users);
	//查询登录当前用户的个人信息
	List<Users>  getUsersAll(String login_name);

	Fenye<Users> selectAllUsers(Fenye<Users> fenye);
	
	Integer addUsers(Users users);
	
	Integer UpdateUsers(Users users);
	
	Integer delUsers(int user_id);
	//重置密码
	Integer Setpassword(String login_name);
	//锁定用户
	Integer YesSoudingUser(String login_name);
	//解锁用户
	Integer NoSoudingUser(String login_name);
	/**
	 * 根据用户名查询该用户的角色
	 * @param login_name
	 * @return
	 */
	List<Roles> selectRoles(String login_name);
	//添加角色
	Integer addUserRoles(Userroles userRoles);
	//移除角色
	Integer delUserRoles(Integer role_id);
	
	
	
}
