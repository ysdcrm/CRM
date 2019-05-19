package com.ysd.util;

import java.util.List;


import com.ysd.entity.Users;
import com.ysd.service.UsersService;

/**
 * 自动分配设置
 * 
 * 1、查询是否自动分配 ①如果是自动分配 1)查询学生数量最少的网络咨询角色 2)根据权重进行分配 ②如果不是自动分配，
 * 则学生不分配，则不设置网络咨询角色id
 * 
 * @author foom
 */
public  class AlotSetting {

	/**
	 * 传入的userid是3) 咨询经理的用户id
	 * 
	 * @param userId
	 */
	public int alot(int user_id, UsersService userService) {
		Users selectByPrimaryKey = userService.selectByPrimaryKey(user_id);
		String allotSetting = selectByPrimaryKey.getAllotSetting();
		Integer alotUser = null;
		if (allotSetting.equals("1")) {
			List<Users> alotInfo = userService.getAlotInfo();
			// 得到要分配给的网络咨询师的用户id
			alotUser = alotInfo.get(0).getUser_id();
		}
		if(alotUser==null){
			alotUser=0;
		}
		return alotUser;
	}
}
