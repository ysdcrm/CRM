package com.ysd.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;
import com.ysd.service.StudentsService;
import com.ysd.service.UsersService;
import com.ysd.util.AlotSetting;

@Controller
public class StudentsController {
	@Autowired
	private StudentsService studentsService;
	@Autowired
	private Fenye<Students> fenye;
	@Autowired
	private UsersService usersService;
	
	@RequestMapping(value="/showStu",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Students> showStu(Integer page,Integer rows) {
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		Fenye<Students> selectAllStu = studentsService.selectAllStu(fenye);
		return selectAllStu;
	}
	
	//查询网络学生
	@RequestMapping(value="/getMyStu",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Students> getMyStu(Integer page,Integer rows,Students students,HttpSession session) {
		Integer network_user_id=(Integer) session.getAttribute("user_id");
		students.setNetwork_user_id(network_user_id);
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		fenye.setStudents(students);
		Fenye<Students> selectMyAllStu = studentsService.selectMyAllStu(fenye);
		return selectMyAllStu;
	}
	//所有的咨询师
    @RequestMapping(value="/selectAllRolesUsers",method=RequestMethod.POST)
	@ResponseBody
    public  List<Users> selectAllRolesUsers(){
    	List<Users> selectAllRolesUsers = studentsService.selectAllRolesUsers();
		return selectAllRolesUsers;
    }
    //添加学生并自动分配
    @RequestMapping(value="/addStudents",method=RequestMethod.POST)
	@ResponseBody
    public  Integer addStudents(Students students,HttpSession session){
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String creatTime = sdf.format(new Date());
		System.out.println(creatTime);
		Integer network_user_id = (Integer) session.getAttribute("user_id");
		System.out.println(network_user_id);
		students.setNetwork_user_id(network_user_id);
		AlotSetting as =  new AlotSetting();
		int alot = as.alot(network_user_id, usersService);
		if(alot!=0) {
			students.setRefer_user_id(alot);
		}
		return studentsService.addNetWorkStu(students);
    }
    //修改
    @RequestMapping(value="/updateStudent",method=RequestMethod.POST)
	@ResponseBody
    public  Integer updateStudent(Students students){
		return studentsService.updateStudent(students);
    }
}
