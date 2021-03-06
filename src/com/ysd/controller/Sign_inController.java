package com.ysd.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Fenye;
import com.ysd.entity.Sign_in;
import com.ysd.entity.Users;
import com.ysd.service.Sign_inService;

@Controller
public class Sign_inController {
	 @Autowired
	 private Sign_inService sign_inService;
	 @Autowired
     private Sign_in sign_in;
	 @Autowired
	 private Fenye<Users> fenye;
 
//签到
	@RequestMapping(value="/signon",method=RequestMethod.POST)
	@ResponseBody
	public Integer signon(HttpSession session){
		//获取登陆用户的id
		Integer user_id = (Integer)session.getAttribute("user_id");
		//获取系统时间
		String Signtime = "";
		Date date = new Date();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");  //（看当天是否已签过到） 获取年月日
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");   
		Signtime = sdf.format(date);
		String format = sdf1.format(date);
		//截取时间字符串
		String str = Signtime.substring(0, 10);
		//拼接为当前时间00:00:00
		String isSigntime = str+" 00:00:00";
		String LSigntime=str+" 06:00:00";  //拼接为当前时间06:00:00
		String BaTime= str+" 08:00:00";   //拼接为当前时间08:00:00
		sign_in.setUser_id(user_id);
		sign_in.setCreate_time(format);
		 Sign_in selectBySigntime = sign_inService.selectBySigntime(sign_in);  //看当天是否已签过到
		try {
			long ctime1 = sdf.parse(Signtime).getTime(); //把时间转化为毫秒
			long otime2 = sdf.parse(isSigntime).getTime();
			long gtime3 = sdf.parse(BaTime).getTime();
			long ltime4 = sdf.parse(LSigntime).getTime();
		//把签到时间规定到早上六点到八点之间，六点之前不能签到，八点之后可以签到但是为迟到！！
			if((ctime1-ltime4)>0) {  
				if(gtime3-ctime1>0) {
					if(selectBySigntime!=null) {
						return 2;
					}else {
						sign_in.setCreate_time(Signtime);
						String start="正常";
						sign_in.setStart(start);
						Integer i = sign_inService.addSign_in(sign_in);
						return i;
					}
				}else {
					if(selectBySigntime!=null) {
						return 2;
					}else {
						sign_in.setCreate_time(Signtime);
						String start="迟到";
						sign_in.setStart(start);
						sign_inService.addSign_in(sign_in);
						return -1;
					}
				}
			}else {
				return 3;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
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
			
			//用户当天签到时间加上十分钟后的当前时间
			Sign_in selectSignByUserid = sign_inService.selectSignByUserid(selectSignByUserids);
			if(selectSignByUserid.getSign_in_end_time()!=null){
				System.out.println("今天已经签退过啦！");
				return -1;
			}else{
				selectSignByUserids.setSign_in_end_time(Signbacktime);
				String start="早退";
				selectSignByUserids.setEndstart(start);
				Integer i = sign_inService.updateSign(selectSignByUserids);
				return i;
			}
		}
		//批量签退
		@RequestMapping(value="/upsignon",method=RequestMethod.POST)
		@ResponseBody
		public Integer upsignon(String user_id){
			return sign_inService.upsignon(user_id);
		}
		//所有当天签到的员工
	    @RequestMapping(value="/SelectAllSignEmpByDay",method=RequestMethod.POST)
		@ResponseBody
	    public Fenye<Users> SelectAllSignEmpByDay(Integer page,Integer rows,Sign_in sign_in){
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
			  fenye.setPage((page-1)*rows);
			  fenye.setPageSize(rows);
			  Fenye<Users> selectAllSignEmpByDay = sign_inService.SelectAllSignEmpByDay(fenye);
	    	return selectAllSignEmpByDay;
	    }
		
}
