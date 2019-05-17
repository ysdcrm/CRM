package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Sign_in {
	private Integer sign_in_id;
	private Integer user_id;//用户id
	private String create_time;//用户签到时间
	private String sign_in_end_time;//用户签退时间
	private String sign_state;//用户签到状态
	
	
	public String getSign_state() {
		return sign_state;
	}
	public void setSign_state(String sign_state) {
		this.sign_state = sign_state;
	}
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
	@Override
	public String toString() {
		return "Sign_in [sign_in_id=" + sign_in_id + ", user_id=" + user_id + ", create_time=" + create_time
				+ ", sign_in_end_time=" + sign_in_end_time + "]";
	}
	
	
}
