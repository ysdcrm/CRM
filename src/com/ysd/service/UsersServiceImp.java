package com.ysd.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.UsersMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;
import com.ysd.entity.Userroles;
import com.ysd.entity.Users;
import com.ysd.util.CommonUtil;
@Service
public class UsersServiceImp implements UsersService {
	@Autowired
	private UsersMapper usersMapper;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
	String last_time_login=sdf.format(new Date());
	@Override
	public java.util.Map<String, Object> getLogin(Users users) {
		// TODO Auto-generated method stub
		Map<String, Object> map = CommonUtil.getResultMap();
		Users login = usersMapper.getLogin(users);
		if(login!=null) {
			if(login.getPassword().equals(users.getPassword())) {
				if(login.getIs_Lockout().equals("1")) {
					map.put("success", true);
					map.put("message", login);
					Integer psd_wrong_time=0;
					Users user=new Users();
					user.setLast_time_login(last_time_login);
					user.setPsd_wrong_time(psd_wrong_time);
					user.setLogin_name(login.getLogin_name());
					usersMapper.updateUsersLast_time(user);
				}else {
					map.put("success", false);
					map.put("message", "您的账户在锁定状态，请联系管理员！");
				}
			}else {
				if(login.getPsd_wrong_time()>=5) {
					Users user=new Users();
					user.setLock_time(last_time_login);
					user.setLogin_name(users.getLogin_name());
					usersMapper.is_LockoutInsert(user);
					map.put("success", false);
					map.put("message", "您的账户已被锁定！！！");
				}else {
					usersMapper.psdInsert(login);
					map.put("success", false);
					map.put("message", "输入密码错误！超过5次账户将被锁定！当前密码错误"+(login.getPsd_wrong_time()+1)+"次");
				}
			}
		}else {
			map.put("message", "你登录的用户不存在！！！");
		}
		return map;
	}
	@Override
	public List<Users> getUsersAll(String login_name) {
		// TODO Auto-generated method stub
		List<Users> usersAll = usersMapper.getUsersAll(login_name);
		return usersAll;
	}
	@Override
	public Fenye<Users> selectAllUsers(Fenye<Users> fenye) {
		List<Users> selectShowAllUsers = usersMapper.selectShowAllUsers(fenye);
		Integer selectUsersCounts = usersMapper.selectUsersCounts(fenye);
		fenye.setTotal(selectUsersCounts);
		fenye.setRows(selectShowAllUsers);
		return fenye;
	}
	@Override
	public Integer addUsers(Users users) {
		Integer addUsers = usersMapper.addUsers(users);
		return addUsers;
	}

	@Override
	public Integer UpdateUsers(Users users) {
		Integer updateUsers = usersMapper.UpdateUsers(users);
		return updateUsers;
	}

	@Override
	public Integer delUsers(int user_id) {
		Integer delUsers = usersMapper.delUsers(user_id);
		return delUsers;
	}
	@Override
	public Integer Setpassword(String login_name) {
		return usersMapper.Setpassword(login_name);
	}
	//锁定用户
	@Override
	public Integer YesSoudingUser(String login_name) {
		Users users=new Users();
		users.setLogin_name(login_name);
		users.setLock_time(last_time_login);
		return usersMapper.YesSoudingUser(users);
	}
	//解锁用户
	@Override
	public Integer NoSoudingUser(String login_name) {
		return usersMapper.NoSoudingUser(login_name);
	}
	@Override
	public List<Roles> selectRoles(String login_name) {
		return usersMapper.selectRoles(login_name);
	}
	@Override
	public Integer addUserRoles(Userroles userRoles) {
		return usersMapper.addUserRoles(userRoles);
	}
	@Override
	public Integer delUserRoles(Integer role_id) {
		return usersMapper.delUserRoles(role_id);
	}
}
