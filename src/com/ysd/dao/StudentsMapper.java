package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

public interface StudentsMapper {
	
	Integer selectCountStu(Fenye<Students> fenye);
	
    List<Students> selectAllStu(Fenye<Students> fenye);
	
	Integer addStu(Students students);
	
	Integer updateStu(Students students);
	
	Integer delStu(Integer student_id);
	/**
	 * 	查询我的所有网络学生总数
	 * @param fenye
	 * @return
	 */
	Integer selectCountMyStu(Fenye<Students> fenye);
	/**
	 * 	查询我的所有网络学生集合
	 * @param fenye
	 * @return
	 */
    List<Students> selectAllMyStu(Fenye<Students> fenye);
    /**
     * 查询所有的网络咨询师
     * @return
     */
    List<Users> selectAllRolesUsers();
   
    
}
