package com.ysd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Fenye;
import com.ysd.entity.Tracking;
import com.ysd.entity.Users;
import com.ysd.service.TrackingService;

@Controller
public class TrackingController {
	@Autowired
	private TrackingService trackingService;
	@Autowired
	private Fenye<Tracking> fenye;
	//分页查询所有数据
	@RequestMapping(value="/GetTracking",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Tracking> GetTracking(Integer page,Integer rows){
		  fenye.setPage((page-1)*rows); 
		  fenye.setPageSize(rows);
		Fenye<Tracking> selectTrack = trackingService.selectTrack(fenye);
		return selectTrack;
	}
	//添加跟踪记录
	@RequestMapping(value="/genzongStu",method=RequestMethod.POST)
	@ResponseBody
	 public Integer addTracking(Tracking tracking,HttpSession session) {
		Integer user_id=(Integer) session.getAttribute("user_id");
		 tracking.setUser_id(user_id);
		 Integer i = trackingService.addTracking(tracking);
		return i;
	 }

}
