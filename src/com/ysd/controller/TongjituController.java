package com.ysd.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.dao.Sign_inMapper;
import com.ysd.dao.StudentsMapper;
import com.ysd.entity.Highchartsbingtu;
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
		@Autowired
		private Sign_inMapper sign_inMapper;
		@RequestMapping(value="signByDay",method=RequestMethod.POST)
		@ResponseBody
		public Highchartsbingtu signByDay() {
			Sign_in sign_in = new Sign_in();
			String Signbacktime = "";
	    	String Signbacktime1 = "";
	    	Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
			Signbacktime = sdf.format(date);
			Calendar calendar = new GregorianCalendar();
			calendar.setTime(date);
			calendar.add(calendar.DATE, 1);
			Signbacktime1 = sdf.format(calendar.getTime());
			sign_in.setStartcreate_time(Signbacktime);
			sign_in.setEndcreate_time(Signbacktime1);
			//所有员工
			Integer signEmpByDayCountAll = sign_inMapper.SignEmpByDayCountAll();
			//签到员工
			Integer signEmpByDayCountQD = sign_inMapper.SignEmpByDayCountQD(sign_in);
		/*
		 * //未签到 Integer signEmpByDayCountWQD =
		 * sign_inMapper.SignEmpByDayCountWQD(sign_in);
		 */			//正常
			Integer signEmpByDayCountZC = sign_inMapper.SignEmpByDayCountZC(sign_in);
			//迟到
			Integer signEmpByDayCountCD = sign_inMapper.SignEmpByDayCountCD(sign_in);
			//早退
			Integer signEmpByDayCountZT = sign_inMapper.SignEmpByDayCountZT(sign_in);
			Integer[] data=new Integer[5] ;
			int i=0;
			data[i]=signEmpByDayCountAll;
			data[i+1]=signEmpByDayCountQD;
		/* data[i+2]=signEmpByDayCountWQD; */
			data[i+2]=signEmpByDayCountZC;
			data[i+3]=signEmpByDayCountCD;
			data[i+4]=signEmpByDayCountZT;
			Highchartsbingtu highchartsbingtu=new Highchartsbingtu(null, data);
			return highchartsbingtu;
		}

		
		
		
}
