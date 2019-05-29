package com.ysd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.TrackingMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Tracking;

@Service
public class TrackingServiceImp implements TrackingService {


	@Autowired
	private TrackingMapper trackingMapper;
    //查询所有跟踪数据
	@Override
	public Fenye<Tracking> selectTrack(Fenye<Tracking> fenye) {
		Integer total = trackingMapper.selectCountTrack(fenye);
		List<Tracking> selectTrack = trackingMapper.selectTrack(fenye);
		fenye.setTotal(total);
		fenye.setRows(selectTrack);
		return fenye;
	}
    //添加跟踪记录
	@Override
	public Integer addTracking(Tracking tracking) {
		Integer i = trackingMapper.addTracking(tracking);
		return i;
	}
	//查看跟踪记录 根据 当前 学生，当前用户
	@Override
	public Fenye<Tracking> CKzongStu(Fenye<Tracking> fenye) {
		// TODO Auto-generated method stub
		List<Tracking> cKzongStu = trackingMapper.CKzongStu(fenye);
		Integer cKzongStuCountTrack = trackingMapper.CKzongStuCountTrack(fenye);
		fenye.setTotal(cKzongStuCountTrack);
		fenye.setRows(cKzongStu);
		return fenye;
	}
	//查看跟踪记录 根据 当前 学生
	@Override
	public Fenye<Tracking> CKzongStuBYUser(Fenye<Tracking> fenye) {
		// TODO Auto-generated method stub
		Integer ccKzongStuBYUserCountTrack = trackingMapper.CCKzongStuBYUserCountTrack(fenye);
		List<Tracking> cKzongStuBYUser = trackingMapper.CKzongStuBYUser(fenye);
		fenye.setTotal(ccKzongStuBYUserCountTrack);
		fenye.setRows(cKzongStuBYUser);
		return fenye;
	}


}
