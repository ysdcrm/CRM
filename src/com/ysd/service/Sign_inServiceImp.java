package com.ysd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.Sign_inMapper;
import com.ysd.entity.Sign_in;

@Service
public class Sign_inServiceImp implements Sign_inService {
	@Autowired
	private Sign_inMapper sign_inMapper;
//签到
	@Override
	public Integer addSign_in(Sign_in sign_in) {
		return sign_inMapper.addSign_in(sign_in);
	}
////查询当天是否已经签到
	@Override
	public Sign_in selectBySigntime(Sign_in sign_in) {
		return sign_inMapper.selectBySigntime(sign_in);
	}
	//签退	
	@Override
	public Integer updateSign(Sign_in sign_in) {
		return sign_inMapper.updateSign(sign_in);
	}
	//根据id查询签到数据
	@Override
	public Sign_in selectSignByUserid(Sign_in sign_in) {
		return sign_inMapper.selectSignByUserid(sign_in);
	}
	//查询该用户当天签到信息
	@Override
	public Sign_in selectSignByUserids(Sign_in sign_in) {
		return sign_inMapper.selectSignByUserids(sign_in);
	}

}
