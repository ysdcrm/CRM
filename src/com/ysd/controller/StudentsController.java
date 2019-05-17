package com.ysd.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Fenye;
import com.ysd.entity.Students;
import com.ysd.service.StudentsService;

@Controller
public class StudentsController {
	@Autowired
	private StudentsService studentsService;
	@Autowired
	private Fenye<Students> fenye;
	
	@RequestMapping(value="/showStu",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Students> showStu(Integer page,Integer rows) {
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		Fenye<Students> selectAllStu = studentsService.selectAllStu(fenye);
		return selectAllStu;
	}
	
	
	@RequestMapping(value="/getMyStu",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Students> getMyStu(Integer page,Integer rows,Students students,HttpSession session) {
		Integer user_id=(Integer) session.getAttribute("user_id");
		students.setUser_id(user_id);
		System.out.println();
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		fenye.setStudents(students);
		Fenye<Students> selectMyAllStu = studentsService.selectMyAllStu(fenye);
		System.out.println(selectMyAllStu);
		return selectMyAllStu;
	}

}
