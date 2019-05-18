package com.ysd.service;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

public interface StudentsService {
	
    Fenye<Students> selectAllStu(Fenye<Students> fenye);
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
}
