package com.ysd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.entity.Users;
import com.ysd.service.UserrolesService;

@Controller
public class UserrolesController {
	@Autowired
	private UserrolesService userrolesService;
	@Autowired
	private Fenye<Users> fenye;
	@Autowired
	private Fenye<Students> fenyestu;
	//所有员工为（网络咨询师、咨询师）
    @RequestMapping(value="/AllUsersEmployees",method=RequestMethod.POST)
	@ResponseBody
    public Fenye<Users> selectAll(Integer page,Integer rows,Users users){
		  fenye.setPage((page-1)*rows);
		  fenye.setPageSize(rows);
		  fenye.setUsers(users);
		  Fenye<Users> selectAllUsers = userrolesService.selectAllUsers(fenye);
    	return selectAllUsers;
    }
    //关闭分量
	  @RequestMapping(value="/CloseAllotSetting",method=RequestMethod.POST)
	  @ResponseBody
	  public Integer CloseAllotSetting(Integer user_id){
		  return userrolesService.CloseAllotSetting(user_id);
	  }
	  //开启分量
	  @RequestMapping(value="/OpenAllotSetting",method=RequestMethod.POST)
	  @ResponseBody
	  public Integer OpenAllotSetting(Integer user_id){
		  return userrolesService.OpenAllotSetting(user_id);
	  }
	//所有员工为（网络咨询师）
	    @RequestMapping(value="/selectAllNetworkEmp",method=RequestMethod.POST)
		@ResponseBody
	    public Fenye<Users> selectAllNetworkEmp(Integer page,Integer rows,Users users){
			  fenye.setPage((page-1)*rows);
			  fenye.setPageSize(rows);
			  fenye.setUsers(users);
			  Fenye<Users> selectAllUsers = userrolesService.selectAllNetworkEmp(fenye);
	    	return selectAllUsers;
	    }
	    //查询网络咨询师该用户下拥有的学生
	    @RequestMapping(value="/selectAllNetworkEmpByIdStu",method=RequestMethod.POST)
		@ResponseBody
	    public Fenye<Students> selectAllNetworkEmpByIdStu(Integer page,Integer rows,Students students){
	    	fenyestu.setPage((page-1)*rows);
	    	fenyestu.setPageSize(rows);
	    	fenyestu.setStudents(students);
			  Fenye<Students> selectAllNetworkEmpByIdStu = userrolesService.selectAllNetworkEmpByIdStu(fenyestu);
			  return selectAllNetworkEmpByIdStu;
	    }
	  //所有员工为（咨询师）
	    @RequestMapping(value="/selectAllReferEmp",method=RequestMethod.POST)
		@ResponseBody
	    public Fenye<Users> selectAllReferEmp(Integer page,Integer rows,Users users){
			  fenye.setPage((page-1)*rows);
			  fenye.setPageSize(rows);
			  fenye.setUsers(users);
			  Fenye<Users> selectAllReferEmp = userrolesService.selectAllReferEmp(fenye);
	    	return selectAllReferEmp;
	    }
	    //查询咨询师该用户下拥有的学生
	    @RequestMapping(value="/selectAllReferEmpByIdStu",method=RequestMethod.POST)
		@ResponseBody
	    public Fenye<Students> selectAllReferEmpByIdStu(Integer page,Integer rows,Students students){
	    	fenyestu.setPage((page-1)*rows);
	    	fenyestu.setPageSize(rows);
	    	fenyestu.setStudents(students);
	    	Fenye<Students> selectAllReferEmpByIdStu = userrolesService.selectAllReferEmpByIdStu(fenyestu);
			return selectAllReferEmpByIdStu;
	    }
}
