package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Rolemodules {
	private Integer rolemodules_id;
	private Integer role_id;//角色id
	private Integer module_id;//模块id
	public Integer getRolemodules_id() {
		return rolemodules_id;
	}
	public void setRolemodules_id(Integer rolemodules_id) {
		this.rolemodules_id = rolemodules_id;
	}
	public Integer getRole_id() {
		return role_id;
	}
	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}
	public Integer getModule_id() {
		return module_id;
	}
	public void setModule_id(Integer module_id) {
		this.module_id = module_id;
	}
	@Override
	public String toString() {
		return "Rolemodules [rolemodules_id=" + rolemodules_id + ", role_id=" + role_id + ", module_id=" + module_id
				+ "]";
	}
	public Rolemodules() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
}
