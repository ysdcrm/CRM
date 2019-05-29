package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Tracking;

public interface TrackingMapper {
	         //总条数
			Integer selectCountTrack(Fenye<Tracking> fenye);
			//分页查询所有数据
			List<Tracking> selectTrack(Fenye<Tracking> fenye);
			//添加跟踪记录
			Integer addTracking(Tracking tracking);
			/**
			 * 查看跟踪记录 根据 当前 学生，当前用户 总条数
			 * @param fenye
			 * @return
			 */
			Integer CKzongStuCountTrack(Fenye<Tracking> fenye);
			/**
			 * 查看跟踪记录 根据 当前 学生，当前用户
			 * @param fenye
			 * @return
			 */
			List<Tracking> CKzongStu(Fenye<Tracking> fenye);
			/**
			 * 查看跟踪记录 根据 当前 学生 总条数
			 * @param fenye
			 * @return
			 */
			Integer CCKzongStuBYUserCountTrack(Fenye<Tracking> fenye);
			/**
			 * 查看跟踪记录 根据 当前 学生
			 * @param fenye
			 * @return
			 */
			List<Tracking> CKzongStuBYUser(Fenye<Tracking> fenye);
			
}
