package com.ysd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.UserrolesMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Users;

@Service
public class UserrolesServiceImp implements UserrolesService {
	@Autowired
	private UserrolesMapper userrolesMapper;
	//查询出所有员工（网络咨询师、咨询师）
	@Override
	public Fenye<Users> selectAllUsers(Fenye<Users> fenye) {
		// TODO Auto-generated method stub
		Integer selectUsersCounts = userrolesMapper.selectUsersCounts(fenye);
		List<Users> selectShowAllUsers = userrolesMapper.selectShowAllUsers(fenye);
		fenye.setTotal(selectUsersCounts);
		fenye.setRows(selectShowAllUsers);
		return fenye;
	}
	//关闭分量
	@Override
	public Integer CloseAllotSetting(Integer user_id) {
		// TODO Auto-generated method stub
		return userrolesMapper.CloseAllotSetting(user_id);
	}
	//开启分量
	@Override
	public Integer OpenAllotSetting(Integer user_id) {
		// TODO Auto-generated method stub
		return userrolesMapper.OpenAllotSetting(user_id);
	}

}
