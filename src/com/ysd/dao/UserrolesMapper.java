package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Users;

public interface UserrolesMapper {
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
}
