package com.ysd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.SingleTree;
import com.ysd.service.ModulesService;

@Controller
public class ModulesController {
	@Autowired
	private ModulesService modulesService;
	@RequestMapping(value="/modules",method=RequestMethod.POST)
	@ResponseBody
	public List<SingleTree> getModules(String login_name){
		List<SingleTree> modules = modulesService.getModules(login_name);
		return modules;
	}
}
