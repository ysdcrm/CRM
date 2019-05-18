package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Students {
	private Integer student_id;//学生id
	private String name;//学生姓名
	private Integer age;//年龄
	private String sex;//性别
	private String phone;//手机号
	private String education;//学历
	private String state;//状态
	private String qq;//qq号
	private String we_chat;//微信号
	private String area;//地区
	private String sources;//来源渠道
	private String source_site;//来源网站
	private String sourcekeyword;//来源关键词
	private String is_report;//是否报道
	private String course;//课程
	private String remark;//备注
	private Integer refer_user_id;//咨询师ID
	private Integer network_user_id;//网络咨询师id
	public Integer getNetwork_user_id() {
		return network_user_id;
	}
	public void setNetwork_user_id(Integer network_user_id) {
		this.network_user_id = network_user_id;
	}
	//创建时间搜索区间
	private String create_time;//创建时间
	private String startcreat_time;//创建开始时间
	private String endcreat_time;//创建结束时间
	//
	private String is_effective;//是否有效
	private String scoring;//打分
	private String is_visit;//是否回访
	private String first_visit_time;//首次回访时间
	private String is_door;//是否上门
	private String door_time;//上门时间
	private String Is_invalid;//是否有效
	private String invalid_reason;//无效原因
	private String is_pay;//是否缴费
	private String pay_time;//缴费时间
	private String amount;//金额
	private String is_refund;//是否退费
	private String refund_reason;//退费原因
	private String is_class_entry;//是否进班
	private String class_entry_time;//进班时间
	private String class_entry_remark;//进班备注
	private String is_deposit;//是否定金
	private String deposit_amount;//定金金额
	private String deposit_time;//定金时间
	//链表引入用户角色//
	private Users users;
	public Integer getStudent_id() {
		return student_id;
	}
	public void setStudent_id(Integer student_id) {
		this.student_id = student_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getWe_chat() {
		return we_chat;
	}
	public void setWe_chat(String we_chat) {
		this.we_chat = we_chat;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getSources() {
		return sources;
	}
	public void setSources(String sources) {
		this.sources = sources;
	}
	public String getSource_site() {
		return source_site;
	}
	public void setSource_site(String source_site) {
		this.source_site = source_site;
	}
	public String getSourcekeyword() {
		return sourcekeyword;
	}
	public void setSourcekeyword(String sourcekeyword) {
		this.sourcekeyword = sourcekeyword;
	}
	public String getIs_report() {
		return is_report;
	}
	public void setIs_report(String is_report) {
		this.is_report = is_report;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getRefer_user_id() {
		return refer_user_id;
	}
	public void setRefer_user_id(Integer refer_user_id) {
		this.refer_user_id = refer_user_id;
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
	public String getIs_effective() {
		return is_effective;
	}
	public void setIs_effective(String is_effective) {
		this.is_effective = is_effective;
	}
	public String getScoring() {
		return scoring;
	}
	public void setScoring(String scoring) {
		this.scoring = scoring;
	}
	public String getIs_visit() {
		return is_visit;
	}
	public void setIs_visit(String is_visit) {
		this.is_visit = is_visit;
	}
	public String getFirst_visit_time() {
		return first_visit_time;
	}
	public void setFirst_visit_time(String first_visit_time) {
		this.first_visit_time = first_visit_time;
	}
	public String getIs_door() {
		return is_door;
	}
	public void setIs_door(String is_door) {
		this.is_door = is_door;
	}
	public String getDoor_time() {
		return door_time;
	}
	public void setDoor_time(String door_time) {
		this.door_time = door_time;
	}
	public String getIs_invalid() {
		return Is_invalid;
	}
	public void setIs_invalid(String is_invalid) {
		Is_invalid = is_invalid;
	}
	public String getInvalid_reason() {
		return invalid_reason;
	}
	public void setInvalid_reason(String invalid_reason) {
		this.invalid_reason = invalid_reason;
	}
	public String getIs_pay() {
		return is_pay;
	}
	public void setIs_pay(String is_pay) {
		this.is_pay = is_pay;
	}
	public String getPay_time() {
		return pay_time;
	}
	public void setPay_time(String pay_time) {
		this.pay_time = pay_time;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getIs_refund() {
		return is_refund;
	}
	public void setIs_refund(String is_refund) {
		this.is_refund = is_refund;
	}
	public String getRefund_reason() {
		return refund_reason;
	}
	public void setRefund_reason(String refund_reason) {
		this.refund_reason = refund_reason;
	}
	public String getIs_class_entry() {
		return is_class_entry;
	}
	public void setIs_class_entry(String is_class_entry) {
		this.is_class_entry = is_class_entry;
	}
	public String getClass_entry_time() {
		return class_entry_time;
	}
	public void setClass_entry_time(String class_entry_time) {
		this.class_entry_time = class_entry_time;
	}
	public String getClass_entry_remark() {
		return class_entry_remark;
	}
	public void setClass_entry_remark(String class_entry_remark) {
		this.class_entry_remark = class_entry_remark;
	}
	public String getIs_deposit() {
		return is_deposit;
	}
	public void setIs_deposit(String is_deposit) {
		this.is_deposit = is_deposit;
	}
	public String getDeposit_amount() {
		return deposit_amount;
	}
	public void setDeposit_amount(String deposit_amount) {
		this.deposit_amount = deposit_amount;
	}
	public String getDeposit_time() {
		return deposit_time;
	}
	public void setDeposit_time(String deposit_time) {
		this.deposit_time = deposit_time;
	}
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	@Override
	public String toString() {
		return "Students [student_id=" + student_id + ", name=" + name + ", age=" + age + ", sex=" + sex + ", phone="
				+ phone + ", education=" + education + ", state=" + state + ", qq=" + qq + ", we_chat=" + we_chat
				+ ", area=" + area + ", sources=" + sources + ", source_site=" + source_site + ", sourcekeyword="
				+ sourcekeyword + ", is_report=" + is_report + ", course=" + course + ", remark=" + remark
				+ ", refer_user_id=" + refer_user_id + ", network_user_id=" + network_user_id + ", create_time="
				+ create_time + ", startcreat_time=" + startcreat_time + ", endcreat_time=" + endcreat_time
				+ ", is_effective=" + is_effective + ", scoring=" + scoring + ", is_visit=" + is_visit
				+ ", first_visit_time=" + first_visit_time + ", is_door=" + is_door + ", door_time=" + door_time
				+ ", Is_invalid=" + Is_invalid + ", invalid_reason=" + invalid_reason + ", is_pay=" + is_pay
				+ ", pay_time=" + pay_time + ", amount=" + amount + ", is_refund=" + is_refund + ", refund_reason="
				+ refund_reason + ", is_class_entry=" + is_class_entry + ", class_entry_time=" + class_entry_time
				+ ", class_entry_remark=" + class_entry_remark + ", is_deposit=" + is_deposit + ", deposit_amount="
				+ deposit_amount + ", deposit_time=" + deposit_time + ", users=" + users + "]";
	}
	
	
	
	
	
	
}
