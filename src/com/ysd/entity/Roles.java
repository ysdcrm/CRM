package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Roles {
	private Integer role_id;//角色id	
	private String role_name;//角色名称
	
	
	
	
	
	
	
	public Integer getRole_id() {
		return role_id;
	}
	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	@Override
	public String toString() {
		return "Roles [role_id=" + role_id + ", role_name=" + role_name + "]";
	}
	
}
