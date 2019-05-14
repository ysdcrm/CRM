package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Tracking {
	private Integer tracking_id;
	private Integer student_id;//学生id
	private Integer user_id;//用户id
	private String tracking_time;//跟踪开始时间
	private String tracking_end_time;//跟踪结束时间
	private String tracking_way;//跟踪方式
	private String content_time;//回访时间
	private String content_visit;//回访情况
	private String remark;//备注
	public Integer getTracking_id() {
		return tracking_id;
	}
	public void setTracking_id(Integer tracking_id) {
		this.tracking_id = tracking_id;
	}
	public Integer getStudent_id() {
		return student_id;
	}
	public void setStudent_id(Integer student_id) {
		this.student_id = student_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getTracking_time() {
		return tracking_time;
	}
	public void setTracking_time(String tracking_time) {
		this.tracking_time = tracking_time;
	}
	public String getTracking_end_time() {
		return tracking_end_time;
	}
	public void setTracking_end_time(String tracking_end_time) {
		this.tracking_end_time = tracking_end_time;
	}
	public String getTracking_way() {
		return tracking_way;
	}
	public void setTracking_way(String tracking_way) {
		this.tracking_way = tracking_way;
	}
	public String getContent_time() {
		return content_time;
	}
	public void setContent_time(String content_time) {
		this.content_time = content_time;
	}
	public String getContent_visit() {
		return content_visit;
	}
	public void setContent_visit(String content_visit) {
		this.content_visit = content_visit;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Tracking() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Tracking [tracking_id=" + tracking_id + ", student_id=" + student_id + ", user_id=" + user_id
				+ ", tracking_time=" + tracking_time + ", tracking_end_time=" + tracking_end_time + ", tracking_way="
				+ tracking_way + ", content_time=" + content_time + ", content_visit=" + content_visit + ", remark="
				+ remark + "]";
	}
	
	
	
	
	
}
