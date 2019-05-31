package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Sign_in {
	private Integer sign_in_id;
	private Integer user_id;//用户id
	private String create_time;//用户签到时间
	private String sign_in_end_time;//用户签退时间
	private String start;//用户签到状态
	private String endstart;
	private String startcreate_time;//开始时间
	private String endcreate_time;//结束时间
	
	

	private Users users;



	public Integer getSign_in_id() {
		return sign_in_id;
	}



	public void setSign_in_id(Integer sign_in_id) {
		this.sign_in_id = sign_in_id;
	}



	public Integer getUser_id() {
		return user_id;
	}



	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}



	public String getCreate_time() {
		return create_time;
	}



	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}



	public String getSign_in_end_time() {
		return sign_in_end_time;
	}



	public void setSign_in_end_time(String sign_in_end_time) {
		this.sign_in_end_time = sign_in_end_time;
	}



	public String getStart() {
		return start;
	}



	public void setStart(String start) {
		this.start = start;
	}



	public String getEndstart() {
		return endstart;
	}



	public void setEndstart(String endstart) {
		this.endstart = endstart;
	}



	public String getStartcreate_time() {
		return startcreate_time;
	}



	public void setStartcreate_time(String startcreate_time) {
		this.startcreate_time = startcreate_time;
	}



	public String getEndcreate_time() {
		return endcreate_time;
	}



	public void setEndcreate_time(String endcreate_time) {
		this.endcreate_time = endcreate_time;
	}



	public Users getUsers() {
		return users;
	}



	public void setUsers(Users users) {
		this.users = users;
	}



	public Sign_in(Integer sign_in_id, Integer user_id, String create_time, String sign_in_end_time, String start,
			String endstart, String startcreate_time, String endcreate_time, Users users) {
		super();
		this.sign_in_id = sign_in_id;
		this.user_id = user_id;
		this.create_time = create_time;
		this.sign_in_end_time = sign_in_end_time;
		this.start = start;
		this.endstart = endstart;
		this.startcreate_time = startcreate_time;
		this.endcreate_time = endcreate_time;
		this.users = users;
	}



	public Sign_in() {
		super();
		// TODO Auto-generated constructor stub
	}



	@Override
	public String toString() {
		return "Sign_in [sign_in_id=" + sign_in_id + ", user_id=" + user_id + ", create_time=" + create_time
				+ ", sign_in_end_time=" + sign_in_end_time + ", start=" + start + ", endstart=" + endstart
				+ ", startcreate_time=" + startcreate_time + ", endcreate_time=" + endcreate_time + ", users=" + users
				+ "]";
	}
	
	

	
}
