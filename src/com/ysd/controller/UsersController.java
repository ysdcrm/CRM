package com.ysd.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;
import com.ysd.entity.Userroles;
import com.ysd.entity.Users;
import com.ysd.service.UsersService;
import com.ysd.util.Md5;

@Controller
public class UsersController {
	@Autowired
	private UsersService usersService;
  //用户登录
	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getLogin(Users users,HttpServletRequest request) {
		String buildTreeEncryption = Md5.buildTreeEncryption(users.getPassword());
		users.setPassword(buildTreeEncryption);
		Map<String, Object> login = usersService.getLogin(users);
		HttpSession session = request.getSession();
		session.setAttribute("login_name", users.getLogin_name());
		
		
		List<Users> usersAll = usersService.getUsersAll(users.getLogin_name());
		session.setAttribute("user_id", usersAll.get(0).getUser_id());
		session.setAttribute("user", usersAll);
		return login;
	}
  //安全退出
	@RequestMapping(value="/loginTo",method=RequestMethod.POST)
	@ResponseBody
	public Integer  getLogintTO(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("login_name");
		return 1;
	}
	@Autowired
	private Fenye<Users> fenye;
//所有
    @RequestMapping(value="/showUsers",method=RequestMethod.POST)
	@ResponseBody
    public Fenye<Users> selectAll(Integer page,Integer rows,Users users){
		  fenye.setPage((page-1)*rows);
		  fenye.setPageSize(rows);
		  fenye.setUsers(users);
		  Fenye<Users> selectAllUsers = usersService.selectAllUsers(fenye);
    	return selectAllUsers;
    }
 //删除   
    @RequestMapping(value="/delUsers",method=RequestMethod.POST)
	@ResponseBody
	public Integer delUsers(int user_id){
		return usersService.delUsers(user_id);
	  }
 //添加   
	@RequestMapping(value="/addUsers",method=RequestMethod.POST)
	@ResponseBody
	public Integer addUsers(Users users){
		String buildTreeEncryption = Md5.buildTreeEncryption(users.getPassword());
		users.setPassword(buildTreeEncryption);
		return usersService.addUsers(users);
	  }
//修改	
	@RequestMapping(value="/updateUsers",method=RequestMethod.POST)
	@ResponseBody
	public Integer UpdateUsers(Users users){
		return usersService.UpdateUsers(users);
	  }
 //重置密码
	  @RequestMapping(value="/Setpassword",method=RequestMethod.POST)
	  @ResponseBody
	  public Integer Setpassword(String login_name){
		  return usersService.Setpassword(login_name);
	  }
 //锁定
	  @RequestMapping(value="/YesSouDing",method=RequestMethod.POST)
	  @ResponseBody
	  public Integer YesSouDing(String login_name){
		  return usersService.YesSoudingUser(login_name);
	  }
  //解除锁定
	  @RequestMapping(value="/NoSouding",method=RequestMethod.POST)
	  @ResponseBody
	  public Integer NoSouding(String login_name){
		  return usersService.NoSoudingUser(login_name);
	  }
   //查询当前用户的角色
	  @RequestMapping(value="/selectRoles",method=RequestMethod.POST)
	  @ResponseBody
	  public List<Roles> selectRoles(String login_name){
		  return usersService.selectRoles(login_name);
	  }  
  //设置用户角色
	  @RequestMapping(value="/addUserRoles",method=RequestMethod.POST)
	  @ResponseBody
	  public Map<String, Object> addUserRoles(Userroles userRoles){
		  return usersService.addUserRoles(userRoles);
	  }
	//移除用户角色
	  @RequestMapping(value="/delUserRoles",method=RequestMethod.POST)
	  @ResponseBody
	  public Integer delUserRoles (Integer role_id) {
		  return usersService.delUserRoles(role_id);
	}
	//修改个人资料	
			@RequestMapping(value="/updatePersion",method=RequestMethod.POST)
			@ResponseBody
			public Integer UpdatePersion(Users users,HttpSession session){
				Integer user_id=(Integer) session.getAttribute("user_id");
				users.setUser_id(user_id);
				Integer updatePerson = usersService.updatePerson(users);
				return updatePerson;
			  }
			//修改密码	
	 @RequestMapping(value="/updatePersionMM",method=RequestMethod.POST) // * //
	 @ResponseBody 
	 public Integer UpdatePW(Users users,HttpSession session,String newPW,String querenPW){
	   Integer user_id=(Integer)session.getAttribute("user_id"); 
	   String password = Md5.buildTreeEncryption(users.getPassword());
	   String newPW1 = Md5.buildTreeEncryption(newPW);
	  //1.对参数进行非空验证 
	   if(password==null || password.length()==0){
	   System.out.println("请输入旧密码！"); } 
	   if(newPW==null ||newPW.length()==0){
	   System.out.println("请输入新密码！");} 
	   if(querenPW==null ||querenPW.length()==0) {
	   System.out.println("请确认新密码！");} 
	   if(!newPW.equals(querenPW)) { 
	   System.out.println("新密码和确认密码不一致！"); 
	   return -1;}
	   if(!users.getPassword().equals(password)) { 
	  System.out.println("输入的旧密码不正确！"); } 
	  //2.3判断新旧密码是否一致 // *
	  if(password.equals(newPW)) { 
		System.out.println("新密码不能与旧密码相同！");
		return -1;} 
	   users.setUser_id(user_id); 
	   users.setPassword(newPW1);
	   Integer updatePw = usersService.updatePw(users); return updatePw; } 
     }
