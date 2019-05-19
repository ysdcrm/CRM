package com.ysd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.StudentsMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

@Service
public class StudentsServiceImp implements StudentsService {
    @Autowired
	private StudentsMapper studentsMapper;
	@Override
	public Fenye<Students> selectAllStu(Fenye<Students> fenye) {
		Integer total = studentsMapper.selectCountStu(fenye);
		List<Students> selectAllStu = studentsMapper.selectAllStu(fenye);
		
		fenye.setTotal(total);
		fenye.setRows(selectAllStu);
		return fenye;
	}
	//查询我的所有学生
	@Override
	public Fenye<Students> selectMyAllStu(Fenye<Students> fenye) {
		// TODO Auto-generated method stub
		List<Students> selectAllMyStu = studentsMapper.selectAllMyStu(fenye);
		Integer selectCountMyStu = studentsMapper.selectCountMyStu(fenye);
		fenye.setRows(selectAllMyStu);
		fenye.setTotal(selectCountMyStu);
		return fenye;
	}
	//查询所有的咨询师
		@Override
		public List<Users> selectAllRolesUsers() {
			// TODO Auto-generated method stub
			List<Users> selectAllRolesUsers = studentsMapper.selectAllRolesUsers();
			return selectAllRolesUsers;
		}
		
}
