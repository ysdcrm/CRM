package com.ysd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;
import com.ysd.entity.Userroles;
import com.ysd.entity.Users;

public interface UsersMapper {
	 //登录用户
	 Users getLogin(Users users);
	 //添加密码输入次数
	 Integer psdInsert(Users users);
	 //密码输入次数超过5次用户被锁定
	 Integer is_LockoutInsert(Users users);
	 //登录成功查询该用户的相应角色
	 List<Roles> getRolesAll(Users users);
	 //查询当前登录用户的个人信息
	 List<Users>  getUsersAll(String login_name);
	 //登录成功记录登录时间
	 Integer updateUsersLast_time(Users users);
	 /**
	  * 总条数
	  * @param fenye
	  * @return
	  */
	 	Integer selectUsersCounts(Fenye<Users> fenye);
	 	/**
	 	 * 查询
	 	 * @param fenye
	 	 * @return
	 	 */
	 	List<Users> selectShowAllUsers(Fenye<Users> fenye);
	 	/**
	 	 * 添加
	 	 * @param users
	 	 * @return
	 	 */
	 	Integer addUsers(Users users);
	 	//查询已添加的用户名
	 	List<Users> selectByName(Users users);
	 	/**
	 	 * 修改
	 	 * @param users
	 	 * @return
	 	 */
	 	Integer UpdateUsers(Users users);
	 	/**
	 	 * 删除
	 	 * @param user_id
	 	 * @return
	 	 */
	 	Integer delUsers(int user_id);
	 	/**
	 	 * 重置密码
	 	 * @param login_name
	 	 * @return
	 	 */
	 	Integer Setpassword(String login_name);
	 	/**
	 	 * 锁定用户
	 	 * @param login_name
	 	 * @return
	 	 */
	 	Integer YesSoudingUser(Users users);
	 	/**
	 	 * 解锁用户
	 	 * @param login_name
	 	 * @return
	 	 */
	 	Integer NoSoudingUser(String login_name);
	 	/**
	 	 * 根据用户名查询该用户的角色
	 	 * @param login_name
	 	 * @return
	 	 */
	 	List<Roles> selectRoles(String login_name);
	 	/**
	 	 * 为用户设置角色
	 	 * @param users
	 	 * @return
	 	 */
	 	Integer addUserRoles(Userroles userRoles);
	 	//查询已设置的角色名
	 	List<Userroles> selectUserrolesByName(Userroles userroles);
	 	/**
	 	 * 移除用户角色
	 	 * @param role_id
	 	 * @return
	 	 */
	 	Integer delUserRoles(Integer role_id);
	 	 //修改当前登陆的用户的个人信息
	    Integer updatePerson(Users users);
	    //修改密码
	    Integer updatePw(Users users);
}
