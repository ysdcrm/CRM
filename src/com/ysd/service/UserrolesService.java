package com.ysd.service;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

public interface UserrolesService {
	/**
	 * 查询出所有员工（网络咨询师、咨询师）
	 * @param fenye
	 * @return
	 */
	Fenye<Users> selectAllUsers(Fenye<Users> fenye);
	/**
	 * 关闭分量
	 * @param user_id
	 * @return
	 */
	Integer CloseAllotSetting(Integer user_id);
	/**
	 * 开启分量
	 * @param user_id
	 * @return
	 */
	Integer OpenAllotSetting(Integer user_id);
	/**
	 * 查询出所有员工（网络咨询师）
	 * @param fenye
	 * @return
	 */
	Fenye<Users> selectAllNetworkEmp(Fenye<Users> fenye);
	/**
	 * 	查询网络咨询师该用户下拥有的学生
	 * @param fenye
	 * @return
	 */
	Fenye<Students> selectAllNetworkEmpByIdStu(Fenye<Students> fenye);
	/**
	 * 查询出所有员工（咨询师）
	 * @param fenye
	 * @return
	 */
	Fenye<Users> selectAllReferEmp(Fenye<Users> fenye);
	/**
	 * 	查询咨询师该用户下拥有的学生
	 * @param fenye
	 * @return
	 */
	Fenye<Students> selectAllReferEmpByIdStu(Fenye<Students> fenye);
}	
