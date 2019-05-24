package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

public interface UserrolesMapper {
		 /**
		  * 	查询出所有员工（网络咨询师、咨询师）总条数
		  * @param fenye
		  * @return
		  */
	 	Integer selectUsersCounts(Fenye<Users> fenye);
	 	/**
	 	 * 	查询出所有员工（网络咨询师、咨询师）
	 	 * @param fenye
	 	 * @return
	 	 */
	 	List<Users> selectShowAllUsers(Fenye<Users> fenye);
	 	/**
	 	 * 添加
	 	 * @param users
	 	 * @return
	 	 */
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
		  * 	查询出所有员工（网络咨询师）总条数
		  * @param fenye
		  * @return
		  */
	 	Integer selectAllNetworkEmpCounts(Fenye<Users> fenye);
	 	/**
	 	 * 	查询出所有员工（网络咨询师）
	 	 * @param fenye
	 	 * @return
	 	 */
	 	List<Users> selectAllNetworkEmp(Fenye<Users> fenye);
	 	/**
		  * 	查询网络咨询师该用户下拥有的学生）总条数
		  * @param fenye
		  * @return
		  */
	 	Integer selectAllNetworkEmpByIdStuCounts(Fenye<Students> fenye);
	 	/**
	 	 * 	查询网络咨询师该用户下拥有的学生
	 	 * @param fenye
	 	 * @return
	 	 */
	 	List<Students> selectAllNetworkEmpByIdStu(Fenye<Students> fenye);
	 	
	 	
	 	
	 	
	 	 /**
		  * 	查询出所有员工（咨询师）总条数
		  * @param fenye
		  * @return
		  */
	 	Integer selectAllReferEmpCounts(Fenye<Users> fenye);
	 	/**
	 	 * 	查询出所有员工（咨询师）
	 	 * @param fenye
	 	 * @return
	 	 */
	 	List<Users> selectAllReferEmp(Fenye<Users> fenye);
	 	/**
		  * 	查询咨询师该用户下拥有的学生）总条数
		  * @param fenye
		  * @return
		  */
	 	Integer selectAllReferEmpByIdStuCounts(Fenye<Students> fenye);
	 	/**
	 	 * 	查询咨询师该用户下拥有的学生
	 	 * @param fenye
	 	 * @return
	 	 */
	 	List<Students> selectAllReferEmpByIdStu(Fenye<Students> fenye);
	 	
	 	
}
