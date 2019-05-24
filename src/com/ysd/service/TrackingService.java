package com.ysd.service;

import com.ysd.entity.Fenye;
import com.ysd.entity.Tracking;

public interface TrackingService {
	//分页查询所有跟踪数据
    Fenye<Tracking> selectTrack(Fenye<Tracking> fenye);
	
	//添加跟踪记录
	Integer addTracking(Tracking tracking);
}
