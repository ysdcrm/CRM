package com.ysd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.UserrolesMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
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
	//查询出所有员工（网络咨询师）
	@Override
	public Fenye<Users> selectAllNetworkEmp(Fenye<Users> fenye) {
		// TODO Auto-generated method stub
		List<Users> selectAllNetworkEmp = userrolesMapper.selectAllNetworkEmp(fenye);
		Integer selectAllNetworkEmpCounts = userrolesMapper.selectAllNetworkEmpCounts(fenye);
		fenye.setTotal(selectAllNetworkEmpCounts);
		fenye.setRows(selectAllNetworkEmp);
		return fenye;
	}
	//查询网络咨询师该用户下拥有的学生
	@Override
	public Fenye<Students> selectAllNetworkEmpByIdStu(Fenye<Students> fenye) {
		// TODO Auto-generated method stub
		List<Students> selectAllNetworkEmpByIdStu = userrolesMapper.selectAllNetworkEmpByIdStu(fenye);
		Integer selectAllNetworkEmpByIdStuCounts = userrolesMapper.selectAllNetworkEmpByIdStuCounts(fenye);
		fenye.setTotal(selectAllNetworkEmpByIdStuCounts);
		fenye.setRows(selectAllNetworkEmpByIdStu);
		return fenye;
	}
	//
	//查询出所有员工（咨询师）
	@Override
	public Fenye<Users> selectAllReferEmp(Fenye<Users> fenye) {
		// TODO Auto-generated method stub
		Integer selectAllReferEmpCounts = userrolesMapper.selectAllReferEmpCounts(fenye);
		List<Users> selectAllReferEmp = userrolesMapper.selectAllReferEmp(fenye);
		fenye.setTotal(selectAllReferEmpCounts);
		fenye.setRows(selectAllReferEmp);
		return fenye;
	}
	//
	//查询咨询师该用户下拥有的学生
	@Override
	public Fenye<Students> selectAllReferEmpByIdStu(Fenye<Students> fenye) {
		// TODO Auto-generated method stub
		List<Students> selectAllReferEmpByIdStu = userrolesMapper.selectAllReferEmpByIdStu(fenye);
		Integer selectAllReferEmpByIdStuCounts = userrolesMapper.selectAllReferEmpByIdStuCounts(fenye);
		fenye.setTotal(selectAllReferEmpByIdStuCounts);
		fenye.setRows(selectAllReferEmpByIdStu);
		return fenye;
	}

}
