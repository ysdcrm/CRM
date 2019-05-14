package com.ysd.entity;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class Fenye<T> {
	private Integer page;
	private Integer pageSize;
	private Integer total;
	private List<T> rows;
	private Rolemodules rolemodules;
	private Modules modules;
	private Roles roles;
	private Sign_in sign_ins;
	private Students students;
	private Tracking trackings;
	private Userroles userroles;
	private Users users;
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
	public Rolemodules getRolemodules() {
		return rolemodules;
	}
	public void setRolemodules(Rolemodules rolemodules) {
		this.rolemodules = rolemodules;
	}
	public Modules getModules() {
		return modules;
	}
	public void setModules(Modules modules) {
		this.modules = modules;
	}
	public Roles getRoles() {
		return roles;
	}
	public void setRoles(Roles roles) {
		this.roles = roles;
	}
	public Sign_in getSign_ins() {
		return sign_ins;
	}
	public void setSign_ins(Sign_in sign_ins) {
		this.sign_ins = sign_ins;
	}
	public Students getStudents() {
		return students;
	}
	public void setStudents(Students students) {
		this.students = students;
	}
	public Tracking getTrackings() {
		return trackings;
	}
	public void setTrackings(Tracking trackings) {
		this.trackings = trackings;
	}
	public Userroles getUserroles() {
		return userroles;
	}
	public void setUserroles(Userroles userroles) {
		this.userroles = userroles;
	}
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	@Override
	public String toString() {
		return "Fenye [page=" + page + ", pageSize=" + pageSize + ", total=" + total + ", rows=" + rows
				+ ", rolemodules=" + rolemodules + ", modules=" + modules + ", roles=" + roles + ", sign_ins="
				+ sign_ins + ", students=" + students + ", trackings=" + trackings + ", userroles=" + userroles
				+ ", users=" + users + "]";
	}
	
	
	
}
