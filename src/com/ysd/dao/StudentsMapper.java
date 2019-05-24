package com.ysd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;

public interface StudentsMapper {
	//分页查询总条数
	Integer selectCountStu(Fenye<Students> fenye);
	//分页查询所有数据
    List<Students> selectAllStu(Fenye<Students> fenye);
    //查询已分配的学生
    List<Students> selectYifenpeiStu(Fenye<Students> fenye);
    Integer selectYifenpeiStuCount(Fenye<Students> fenye);
    //查询未分配的学生
    List<Students> selectWeifenpeiStu(Fenye<Students> fenye);
    //查询所有用户
    List<Users> selectUserName();
    //批量分配咨询师
    Integer updateUserId(Students students);
    //添加
	Integer addStu(Students students);
	//将学生的有效状态改为失效状态
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
    /**
     * 网络咨询师添加学生自动分配
     * @param students
     * @return
     */
    Integer addNetWorkStu(Students students);
    
}
