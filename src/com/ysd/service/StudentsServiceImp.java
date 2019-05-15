package com.ysd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.StudentsMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Students;

@Service
public class StudentsServiceImp implements StudentsService {
    @Autowired
	private StudentsMapper studentsMapper;
	@Override
	public Fenye selectAllStu(Fenye fenye) {
		Integer total = studentsMapper.selectCountStu(fenye);
		List<Students> selectAllStu = studentsMapper.selectAllStu(fenye);
		
		fenye.setTotal(total);
		fenye.setRows(selectAllStu);
		return fenye;
	}

	/*
	 * @Override public Integer addStu(Students students) { Integer i =
	 * studentsMapper.addStu(students); return i; }
	 * 
	 * @Override public Integer updateStu(Students students) { Integer i =
	 * studentsMapper.updateStu(students); return i; }
	 * 
	 * @Override public Integer delStu(Integer student_id) { Integer i =
	 * studentsMapper.delStu(student_id); return i; }
	 */


}
