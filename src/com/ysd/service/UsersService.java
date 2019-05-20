package com.ysd.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;
import com.ysd.entity.Userroles;
import com.ysd.entity.Users;

public interface UsersService {
	//登录功能
	Map<String, Object>  getLogin(Users users,HttpSession session);
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
	Map<String, Object> addUserRoles(Userroles userRoles);
	//移除角色
	Integer delUserRoles(Integer role_id);
	//修改个人资料
	Integer updatePerson(Users users);	 
	//修改密码
	Integer updatePw(Users users);
	
	//
	Users selectByPrimaryKey(Integer user_id);
	/**
	  * 自动分配时候得到要分配的咨询师用户
	 * @return
	 */
	List<Users> getAlotInfo();
}
