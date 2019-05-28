package com.ysd.entity;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class Highchartsquxian {
	private String name;
	private Integer[] data;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	public Integer[] getData() {
		return data;
	}
	public void setData(Integer[] data) {
		this.data = data;
	}
	@Override
	public String toString() {
		return "Highchartsquxian [name=" + name + ", data="
				+ Arrays.toString(data) + "]";
	}
	
	
	
}
