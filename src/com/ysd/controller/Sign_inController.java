package com.ysd.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Sign_in;
import com.ysd.service.Sign_inService;

@Controller
public class Sign_inController {
 @Autowired
	 private Sign_inService sign_inService;
 @Autowired
     private Sign_in sign_in;
 
//签到
	@RequestMapping(value="/signon",method=RequestMethod.POST)
	@ResponseBody
	public Integer signon(HttpSession session){
		//获取登陆用户的id
		Integer user_id = (Integer)session.getAttribute("user_id");
		//获取系统时间
		String Signtime = "";
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");   
		Signtime = sdf.format(date);
		//截取时间字符串
		String str = Signtime.substring(0, 10);
		//拼接为当前时间00:00:00
		String isSigntime = str+" 00:00:00";
		sign_in.setUser_id(user_id);
		sign_in.setCreate_time(isSigntime);
		Sign_in selectBySigntime = sign_inService.selectBySigntime(sign_in);
		if(selectBySigntime==null){
			sign_in.setCreate_time(Signtime);
			Integer i = sign_inService.addSign_in(sign_in);
			return i;
		}else{
			return -1;
		}
	}
	//签退
		@RequestMapping(value="/signback",method=RequestMethod.POST)
		@ResponseBody
		public Integer signback(HttpSession session){
			//获取登陆用户的id
			Integer user_id = (Integer)session.getAttribute("user_id");
			String Signbacktime = "";
			//当前时间
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			Signbacktime = sdf.format(date);
			//去除日期格式里的 ‘--和：’
			long longstr1 = Long.valueOf(Signbacktime.replaceAll("[-\\s:]",""));
			//判断签到日期
			String substring = Signbacktime.substring(0, 10);  //截取时间字符串
			substring=substring+" 00:00:00";  //拼接为当前时间00:00:00
			sign_in.setUser_id(user_id);
			sign_in.setCreate_time(substring);
			Sign_in selectSignByUserids = sign_inService.selectSignByUserids(sign_in);//查询出签到信息
			
			//用户当天签到时间比较加十分钟后的当前时间
			Sign_in selectSignByUserid = sign_inService.selectSignByUserid(selectSignByUserids);
			String signtime2 = selectSignByUserid.getCreate_time().substring(0,19); //截取字符串
			long longstr2 = Long.valueOf(signtime2.replaceAll("[-\\s:]",""));  //去除日期格式里的 ‘--和：’
			long times = 1000;
			long time = longstr2+times;//获取签到时间加10分钟后的系统时间
			if(longstr1<time){
				System.out.println("签到十分钟内不能签退！");
				return 0;
			}
			else if(selectSignByUserid.getSign_in_end_time()!=null){
				System.out.println("今天已经签退过啦！");
				return -1;
			}else{
				selectSignByUserids.setSign_in_end_time(Signbacktime);
				Integer i = sign_inService.updateSign(selectSignByUserids);
				return i;
			}
		}	
}
