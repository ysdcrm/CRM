package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;

public interface StudentsMapper {
	
	Integer selectCountStu(Fenye fenye);
	
    List<Students> selectAllStu(Fenye fenye);
	
	Integer addStu(Students students);
	
	Integer updateStu(Students students);
	
	Integer delStu(Integer student_id);
	

}
