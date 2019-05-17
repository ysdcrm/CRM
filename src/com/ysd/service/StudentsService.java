package com.ysd.service;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;

public interface StudentsService {
	
    Fenye<Students> selectAllStu(Fenye<Students> fenye);
    /**
     * 	查询我得学生
     * @param fenye
     * @return
     */
    Fenye<Students> selectMyAllStu(Fenye<Students> fenye);
}
