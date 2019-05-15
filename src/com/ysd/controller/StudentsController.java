package com.ysd.controller;

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
	private Fenye fenye;
	
	@RequestMapping(value="/showStu",method=RequestMethod.POST)
	@ResponseBody
	public Fenye showStu(Integer page,Integer rows) {
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		Fenye selectAllStu = studentsService.selectAllStu(fenye);
		return selectAllStu;
		
	}
	/*
	 * @RequestMapping(value="/addStu",method=RequestMethod.POST)
	 * 
	 * @ResponseBody public Integer addStu(Students students) {
	 * 
	 * Integer i = studentsService.addStu(students); return i;
	 * 
	 * }
	 * 
	 * @RequestMapping(value="/addStu",method=RequestMethod.POST)
	 * 
	 * @ResponseBody public Integer updatetu(Students students) {
	 * 
	 * Integer i = studentsService.updateStu(students); return i;
	 * 
	 * }
	 * 
	 * @RequestMapping(value="/delStu",method=RequestMethod.POST)
	 * 
	 * @ResponseBody public Integer delStu(Integer student_id) {
	 * 
	 * Integer i = studentsService.delStu(student_id); return i;
	 * 
	 * }
	 */

}
