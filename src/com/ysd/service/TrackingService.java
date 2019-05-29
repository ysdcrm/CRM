package com.ysd.service;

import com.ysd.entity.Fenye;
import com.ysd.entity.Tracking;

public interface TrackingService {
	//分页查询所有跟踪数据
    Fenye<Tracking> selectTrack(Fenye<Tracking> fenye);
	
	//添加跟踪记录
	Integer addTracking(Tracking tracking);
	/**
	 * 	查看跟踪记录 根据 当前 学生，当前用户
	 * @param fenye
	 * @return
	 */
    Fenye<Tracking> CKzongStu(Fenye<Tracking> fenye);
    /**
     * 	查看跟踪记录 根据 当前 学生
     * @param fenye
     * @return
     */
    Fenye<Tracking> CKzongStuBYUser(Fenye<Tracking> fenye);
}
