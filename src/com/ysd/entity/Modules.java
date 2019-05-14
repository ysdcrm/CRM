package com.ysd.entity;

import org.springframework.stereotype.Component;

@Component
public class Modules {
	private Integer module_id;//模块ID
	private String module_name;//模块名称
	private Integer parent_id;//模块父编号
	private String path;//模块路径
	private Integer weight;//模块权重
	
	
	
	
	
	
	public Integer getModule_id() {
		return module_id;
	}
	public void setModule_id(Integer module_id) {
		this.module_id = module_id;
	}
	public String getModule_name() {
		return module_name;
	}
	public void setModule_name(String module_name) {
		this.module_name = module_name;
	}
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Integer getWeight() {
		return weight;
	}
	public void setWeight(Integer weight) {
		this.weight = weight;
	}
	@Override
	public String toString() {
		return "Modules [module_id=" + module_id + ", module_name=" + module_name + ", parent_id=" + parent_id
				+ ", path=" + path + ", weight=" + weight + "]";
	}
	
	
	
}
