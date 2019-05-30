package com.ysd.entity;

import java.util.Arrays;

import org.springframework.stereotype.Component;

@Component
public class Highchartsbingtu {
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
	public Highchartsbingtu(String name, Integer[] data) {
		super();
		this.name = name;
		this.data = data;
	}
	public Highchartsbingtu() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Highchartsbingtu [name=" + name + ", data=" + Arrays.toString(data) + "]";
	}
	
}
