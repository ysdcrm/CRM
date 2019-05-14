package com.ysd.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Modules;
import com.ysd.entity.SingleTree;
import com.ysd.service.ModulesService;
import com.ysd.util.CommonUtil;

@Controller
public class ModulesController {
	@Autowired
	private ModulesService modulesService;
	//当前登录用户对应的权限模块
	@RequestMapping(value="/modules",method=RequestMethod.POST)
	@ResponseBody
	public List<SingleTree> getModules(String login_name){
		List<SingleTree> modules = modulesService.getModules(login_name);
		return modules;
	}
	//所有模块
	@RequestMapping(value="/Allmodules",method=RequestMethod.POST)
	@ResponseBody
	public List<SingleTree> getAllModules(){
		List<SingleTree> modules = modulesService.getAllModules();
		return modules;
	}
	//根据ID查询模块信息
	@RequestMapping(value="/modulesById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getModulesById(Integer module_id){
		Map<String, Object> map = CommonUtil.getResultMap();
		Modules aModulesById = modulesService.getAModulesById(module_id);
		map.put("success", true);
		map.put("message", aModulesById);
		return map;
	}
	//根据ID修改模块信息
	@RequestMapping(value="/setmodulesById",method=RequestMethod.POST)
	@ResponseBody
	public Integer setModulesById(Modules modules){
		Integer setModulesById = modulesService.setModulesById(modules);
		return setModulesById;
	}
	//添加模块信息
	@RequestMapping(value="/addmodules",method=RequestMethod.POST)
	@ResponseBody
	public Integer addModules(Modules modules){
		Integer addModules = modulesService.addModules(modules);
		return addModules;
	}
	//根据ID删除模块信息
	@RequestMapping(value="/delmodulesById",method=RequestMethod.POST)
	@ResponseBody
	public Integer delmodulesById(Integer module_id){
		Integer delmodulesById = modulesService.delmodulesById(module_id);
		return delmodulesById;
	}
}
