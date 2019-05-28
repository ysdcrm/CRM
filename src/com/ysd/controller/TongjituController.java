package com.ysd.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.dao.StudentsMapper;
import com.ysd.entity.Highchartsbingzhuang;
import com.ysd.entity.Highchartsquxian;
import com.ysd.entity.Sign_in;
import com.ysd.entity.Students;
import com.ysd.entity.Users;
import com.ysd.service.Sign_inService;
import com.ysd.service.StudentsService;
import com.ysd.service.UsersService;

@Controller
public class TongjituController {
		@Autowired
		private Highchartsquxian highchartsquxian;
		@Autowired
		private Highchartsbingzhuang highchartsbingzhuang;
		
		@Autowired
		private StudentsMapper studentsMapper;
		@Autowired
		private UsersService usersService;
		@Autowired
		private StudentsService studentsService;
		
		
		
		
		//所以学生
		@RequestMapping(value="wangluotongjitubing",method=RequestMethod.POST)
		@ResponseBody
		public Highchartsbingzhuang wangluotongjitubing(){
			Integer selectYFPCountStu = studentsMapper.selectYFPCountStu();
			Integer selectWFPCountStu = studentsMapper.selectWFPCountStu();
			Integer selectALLCountStu = studentsMapper.selectALLCountStu();
			Highchartsbingzhuang[] data = new Highchartsbingzhuang[selectALLCountStu];
			DecimalFormat df=new DecimalFormat("0.00");
			Double tongji = 0.0;
			int i = 0;
				Double format =Double.parseDouble(df.format((float)selectYFPCountStu/selectALLCountStu))*100;
				tongji+=(format/100);
				data[i] = new Highchartsbingzhuang("已分配",format);
				data[i+1] = new Highchartsbingzhuang("未分配",(1-tongji)*100);
			Highchartsbingzhuang highchartsbingzhuang2 = new Highchartsbingzhuang(null, null,data);
			return highchartsbingzhuang2;
		}
		

		
		
		
}
