package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Userroles {
	private Integer userroles_id;
	private Integer user_id;//用户id
	private Integer role_id;//角色id
	public Integer getUserroles_id() {
		return userroles_id;
	}
	public void setUserroles_id(Integer userroles_id) {
		this.userroles_id = userroles_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getRole_id() {
		return role_id;
	}
	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}
	@Override
	public String toString() {
		return "Userroles [userroles_id=" + userroles_id + ", user_id=" + user_id + ", role_id=" + role_id + "]";
	}
	
}
