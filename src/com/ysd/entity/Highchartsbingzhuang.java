package com.ysd.entity;

import java.util.Arrays;

import org.springframework.stereotype.Component;

@Component
public class Highchartsbingzhuang {
	private String name;
	private Double y;
	private Highchartsbingzhuang[] data;
	
	public Highchartsbingzhuang[] getData() {
		return data;
	}
	public void setData(Highchartsbingzhuang[] data) {
		this.data = data;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getY() {
		return y;
	}
	public void setY(Double y) {
		this.y = y;
	}
	
	public Highchartsbingzhuang() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Highchartsbingzhuang(String name, Double y,
			Highchartsbingzhuang[] data) {
		super();
		this.name = name;
		this.y = y;
		this.data = data;
	}
	
	public Highchartsbingzhuang(String name, Double y) {
		super();
		this.name = name;
		this.y = y;
	}
	@Override
	public String toString() {
		return "Highchartsbingzhuang [name=" + name + ", y=" + y + ", data="
				+ Arrays.toString(data) + "]";
	}
	
	
}
