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
}
