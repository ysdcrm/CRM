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
	//查询所有的学生
	@RequestMapping(value="/showStu",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Students> showStu(Integer page,Integer rows,Students students) {
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		fenye.setStudents(students);
		Fenye<Students> selectAllStu = studentsService.selectAllStu(fenye);
		return selectAllStu;
	}
	//查询已分配的学生
	@RequestMapping(value="/yifenpeiStu",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Students> yiFenPeiStu(Integer page,Integer rows,Students students) {
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		fenye.setStudents(students);
		Fenye<Students> selectYifenpeiStu = studentsService.selectYifenpeiStu(fenye);
		return selectYifenpeiStu;
		
	}
	//查询未分配的学生
		@RequestMapping(value="/weifenpeiStu",method=RequestMethod.POST)
		@ResponseBody
		public Fenye<Students> weiFenPeiStu(Integer page,Integer rows,Students students) {
			fenye.setPage((page-1)*rows);
			fenye.setPageSize(rows);
			fenye.setStudents(students);
			Fenye<Students> selectWeifenpeiStu = studentsService.selectWeifenpeiStu(fenye);
			return selectWeifenpeiStu;
		}
	@RequestMapping(value="/getUserName",method=RequestMethod.POST)
	@ResponseBody 	
     public List<Users> selectUserName(){
		List<Users> selectUserName = studentsService.selectUserName();
		
		return selectUserName;
    	 
     }
	
	//添加学生信息
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String creat_time=sdf.format(new Date());
	 @RequestMapping(value="/addStu",method=RequestMethod.POST)
	 @ResponseBody 
	 public Integer addStu(Students students) {
		 students.setCreate_time(creat_time);
	     Integer i = studentsService.addStu(students);
	     return i;
	 
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
    //批量分配咨询师
	
	  @RequestMapping(value="/fenpeiZXS",method=RequestMethod.POST)
	  @ResponseBody
	  public Integer updateUserId(String student_id,Integer refer_user_id){
		
		  Integer i = studentsService.updateUserId(student_id, refer_user_id);
		  return i;
				
		  
	  }
	  
	  //将学生的有效状态改为失效状态
	  @RequestMapping(value="/delStu",method=RequestMethod.POST)
	  @ResponseBody
	  public Integer delStu(Integer student_id){
		
		  Integer i = studentsService.delStu(student_id);
		  return i;
				
		  
	  }
    

    //修改
    @RequestMapping(value="/updateStudent",method=RequestMethod.POST)
	@ResponseBody
    public  Integer updateStudent(Students students){
		return studentsService.updateStudent(students);
    }
}
