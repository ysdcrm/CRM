package com.ysd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.Sign_inMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Sign_in;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

@Service
public class Sign_inServiceImp implements Sign_inService {
	@Autowired
	private Sign_inMapper sign_inMapper;
//签到
	@Override
	public Integer addSign_in(Sign_in sign_in) {
		sign_inMapper.UpdateUserSignstate(sign_in);
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
		sign_inMapper.UpdateUserSignstateIn(sign_in);
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
	@Override
	public Integer upsignon(String user_id) {
		// TODO Auto-generated method stub
		String[] ids = user_id.split(",");
		Integer j = 0;
		for(int i=0;i<ids.length;i++) {
			Integer user_ids = Integer.parseInt(ids[i]);
			 j = sign_inMapper.upsignon(user_ids);
		}
		return j;
	}
	/**
	 * 查询当天签到的员工
	 */
	@Override
	public Fenye<Sign_in> SelectAllSignEmpByDay(Fenye<Sign_in> fenye) {
		// TODO Auto-generated method stub
		List<Sign_in> selectAllSignEmpByDay = sign_inMapper.SelectAllSignEmpByDay(fenye);
		Integer selectAllSignEmpByDayCount = sign_inMapper.SelectAllSignEmpByDayCount(fenye);
			System.out.println(selectAllSignEmpByDayCount);
		fenye.setTotal(selectAllSignEmpByDayCount);
		fenye.setRows(selectAllSignEmpByDay);
		return fenye;
	}

}
