package com.ysd.entity;

import java.util.List;

import org.springframework.stereotype.Component;
@Component
public class SingleTree {
	private Integer id;
	private String text;
	private String path;
	private Integer p_id;
	private List<SingleTree> children;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Integer getP_id() {
		return p_id;
	}
	public void setP_id(Integer p_id) {
		this.p_id = p_id;
	}
	public List<SingleTree> getChildren() {
		return children;
	}
	public void setChildren(List<SingleTree> children) {
		this.children = children;
	}
	@Override
	public String toString() {
		return "SingleTree [id=" + id + ", text=" + text + ", path=" + path + ", p_id=" + p_id + ", children="
				+ children + "]";
	}
	
	

}
