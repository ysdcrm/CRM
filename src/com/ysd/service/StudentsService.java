package com.ysd.service;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

public interface StudentsService {
	//分页查询所有学生
    Fenye<Students> selectAllStu(Fenye<Students> fenye);
    //添加
  	Integer addStu(Students students);
  	//查询已分配的学生
  	Fenye<Students> selectYifenpeiStu(Fenye<Students> fenye);
    //查询未分配的学生
  	Fenye<Students> selectWeifenpeiStu(Fenye<Students> fenye);
    //查询所有用户
    List<Users> selectUserName();
    //批量分配咨询师
    Integer updateUserId(String student_id,Integer refer_user_id);
    // 将学生的有效状态改为失效状态
    Integer delStu(Integer student_id);
    
  	/**
     * 	查询我得学生
     * @param fenye
     * @return
     */
    Fenye<Students> selectMyAllStu(Fenye<Students> fenye);
    /**
     * 查询所有的咨询师
     * @return
     */
    List<Users> selectAllRolesUsers();
    /**
     * 网络咨询师添加学生自动分配
     * @param students
     * @return
     */
    Integer addNetWorkStu(Students students);
}
