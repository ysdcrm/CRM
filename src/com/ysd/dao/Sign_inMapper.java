package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Sign_in;

public interface Sign_inMapper {
	/**
	 * 查询每一天的签到人数
	 * @param sign_in
	 * @return
	 */
	Integer selectSignCountBytime(Sign_in sign_in);
	
	//签到
	Integer addSign_in(Sign_in sign_in);
	
	//查询当天是否已经签到
	Sign_in selectBySigntime(Sign_in sign_in);
	
	//签退
	Integer updateSign(Sign_in sign_in);
			
	//根据id查询签到数据
	Sign_in selectSignByUserid(Sign_in sign_in);
			
	//查询该用户当天签到信息
	Sign_in selectSignByUserids(Sign_in sign_in);
	//签到成功：修改用户签到状态
	Integer UpdateUserSignstate(Sign_in sign_in);
	//签退成功：修改用户签到状态
	Integer UpdateUserSignstateIn(Sign_in sign_in);
	/**
	 * 	批量签退
	 * @param user_id
	 * @return
	 */
	Integer upsignon(Integer user_id);
	/**
	 * 查询当天签到的员工总数
	 * @param fenye
	 * @return
	 */
	Integer SelectAllSignEmpByDayCount(Fenye<Sign_in> fenye);
	
	/**
	 * 查询当天签到的员工集合
	 * @param fenye
	 * @return
	 */
	List<Sign_in> SelectAllSignEmpByDay(Fenye<Sign_in> fenye);
	
	//每天签到的统计图
	/**
	 * 所有员工
	 * @return
	 */
	Integer SignEmpByDayCountAll();
	/**
	 * 所有签到员工
	 * @param sign_in
	 * @return
	 */
	Integer SignEmpByDayCountQD(Sign_in sign_in);
	/**
	 * 所有未签到员工
	 * @param sign_in
	 * @return
	 */
	Integer SignEmpByDayCountWQD(Sign_in sign_in);
	/**
	 * 所有签到正常员工
	 * @param sign_in
	 * @return
	 */
	Integer SignEmpByDayCountZC(Sign_in sign_in);/**
	 * 所有签到早退员工
	 * @param sign_in
	 * @return
	 */
	Integer SignEmpByDayCountZT(Sign_in sign_in);
	/**
	 * 所有签到迟到员工
	 * @param sign_in
	 * @return
	 */
	Integer SignEmpByDayCountCD(Sign_in sign_in);
	
}
