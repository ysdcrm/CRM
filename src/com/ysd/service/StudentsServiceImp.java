package com.ysd.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.StudentsMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Rolemodules;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

import net.sf.json.JSONArray;

@Service
public class StudentsServiceImp implements StudentsService {
    @Autowired
	private StudentsMapper studentsMapper;
    //分页查询所有学生
	@Override
	public Fenye<Students> selectAllStu(Fenye<Students> fenye) {
		Integer total = studentsMapper.selectCountStu(fenye);
		List<Students> selectAllStu = studentsMapper.selectAllStu(fenye);
		fenye.setTotal(total);
		fenye.setRows(selectAllStu);
		return fenye;
	}
	// 查询已分配的学生
	@Override
	public Fenye<Students> selectYifenpeiStu(Fenye<Students> fenye) {
		Integer selectYifenpeiStuCount = studentsMapper.selectYifenpeiStuCount(fenye);
		List<Students> selectYifenpeiStu = studentsMapper.selectYifenpeiStu(fenye);
		fenye.setTotal(selectYifenpeiStuCount);
		fenye.setRows(selectYifenpeiStu);
		return fenye;
	}

	// 查询未分配的学生 /
	@Override
	public Fenye<Students> selectWeifenpeiStu(Fenye<Students> fenye) {
		Integer total = studentsMapper.selectCountStu(fenye);
		List<Students> selectWeifenpeiStu = studentsMapper.selectWeifenpeiStu(fenye);
		fenye.setTotal(total);
		fenye.setRows(selectWeifenpeiStu);
		return fenye;
	}
	//查询所有用户
	@Override
	public List<Users> selectUserName() {
		List<Users> selectUserName = studentsMapper.selectUserName();
		return selectUserName;
	}

	
	//添加学生信息
	@Override
	public Integer addStu(Students students) {
		Integer i = studentsMapper.addStu(students);
		return i;
	}
	
	//查询所有网络学生
	@Override
	public Fenye<Students> selectMyAllStu(Fenye<Students> fenye) {
		// TODO Auto-generated method stub
		List<Students> selectAllMyStu = studentsMapper.selectAllMyStu(fenye);
		Integer selectCountMyStu = studentsMapper.selectCountMyStu(fenye);
		fenye.setRows(selectAllMyStu);
		fenye.setTotal(selectCountMyStu);
		return fenye;
	}
	//查询咨询师下的我的学生集合
		@Override
		public Fenye<Students> selectAllZXSMyStu(Fenye<Students> fenye) {
			Integer selectCountZXSMyStu = studentsMapper.selectCountZXSMyStu(fenye);
			List<Students> selectAllZXSMyStu = studentsMapper.selectAllZXSMyStu(fenye);
			fenye.setRows(selectAllZXSMyStu);
			fenye.setTotal(selectCountZXSMyStu);
			return fenye;
		}
	//查询所有的咨询师
		@Override
		public List<Users> selectAllRolesUsers() {
			// TODO Auto-generated method stub
			List<Users> selectAllRolesUsers = studentsMapper.selectAllRolesUsers();
			return selectAllRolesUsers;
		}
		//网络咨询师添加学生自动分配
		@Override
		public Integer addNetWorkStu(Students students) {
			// TODO Auto-generated method stub
			return studentsMapper.addNetWorkStu(students);
		}
	//修改
		@Override
		public Integer updateStudent(Students students) {
			return studentsMapper.updateStudent(students);
		}
		
		//批量分配咨询师
		@Override
		public Integer updateUserId(String student_id,Integer refer_user_id) {
			String[] ids = student_id.split(",");
			Integer j = 0;
			for(int i=0;i<ids.length;i++) {
				Students students = new Students();
				int id = Integer.parseInt(ids[i]);
				students.setStudent_id(id);
				students.setRefer_user_id(refer_user_id);
				j=studentsMapper.updateUserId(students);
			}
			return j;
		
		}
		// 将学生的有效状态改为失效状态
		@Override
		public Integer delStu(Integer student_id) {
			Integer i = studentsMapper.delStu(student_id);
			return i;
		}
		
	
		
}
