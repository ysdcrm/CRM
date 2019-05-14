package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Users {
	private Integer user_id;//用户id
	private String login_name;//登录名
	private String password;//密码
	private Integer psd_wrong_time;//密码错误次数
	private String is_Lockout;//是否锁定
	private String last_time_login;//最后一次登录时间
	//创建时间搜索区间
		private String create_time;//创建时间
		private String startcreat_time;//创建开始时间
		private String endcreat_time;//创建结束时间
	//
	private String lock_time;//被锁定时间
	private String protect_email;//注册邮箱
	private String protect_tel;//手机号
	private Integer weight;//权重
	private String sign_in_state;//签到状态
	
	private Roles roles;
	private Userroles userRoles;
	
	
	public Roles getRoles() {
		return roles;
	}
	public void setRoles(Roles roles) {
		this.roles = roles;
	}
	public Userroles getUserRoles() {
		return userRoles;
	}
	public void setUserRoles(Userroles userRoles) {
		this.userRoles = userRoles;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getLogin_name() {
		return login_name;
	}
	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getPsd_wrong_time() {
		return psd_wrong_time;
	}
	public void setPsd_wrong_time(Integer psd_wrong_time) {
		this.psd_wrong_time = psd_wrong_time;
	}
	public String getIs_Lockout() {
		return is_Lockout;
	}
	public void setIs_Lockout(String is_Lockout) {
		this.is_Lockout = is_Lockout;
	}
	public String getLast_time_login() {
		return last_time_login;
	}
	public void setLast_time_login(String last_time_login) {
		this.last_time_login = last_time_login;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public String getStartcreat_time() {
		return startcreat_time;
	}
	public void setStartcreat_time(String startcreat_time) {
		this.startcreat_time = startcreat_time;
	}
	public String getEndcreat_time() {
		return endcreat_time;
	}
	public void setEndcreat_time(String endcreat_time) {
		this.endcreat_time = endcreat_time;
	}
	public String getLock_time() {
		return lock_time;
	}
	public void setLock_time(String lock_time) {
		this.lock_time = lock_time;
	}
	public String getProtect_email() {
		return protect_email;
	}
	public void setProtect_email(String protect_email) {
		this.protect_email = protect_email;
	}
	public String getProtect_tel() {
		return protect_tel;
	}
	public void setProtect_tel(String protect_tel) {
		this.protect_tel = protect_tel;
	}
	public Integer getWeight() {
		return weight;
	}
	public void setWeight(Integer weight) {
		this.weight = weight;
	}
	public String getSign_in_state() {
		return sign_in_state;
	}
	public void setSign_in_state(String sign_in_state) {
		this.sign_in_state = sign_in_state;
	}
	@Override
	public String toString() {
		return "Users [user_id=" + user_id + ", login_name=" + login_name + ", password=" + password
				+ ", psd_wrong_time=" + psd_wrong_time + ", is_Lockout=" + is_Lockout + ", last_time_login="
				+ last_time_login + ", create_time=" + create_time + ", startcreat_time=" + startcreat_time
				+ ", endcreat_time=" + endcreat_time + ", lock_time=" + lock_time + ", protect_email=" + protect_email
				+ ", protect_tel=" + protect_tel + ", weight=" + weight + ", sign_in_state=" + sign_in_state + "]";
	}
	
	
	
	
	
}
