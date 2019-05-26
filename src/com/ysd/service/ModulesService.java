package com.ysd.service;

import java.util.List;
import java.util.Map;

import com.ysd.entity.Modules;
import com.ysd.entity.SingleTree;

public interface ModulesService {
	//查询登录用户的相应模块
	List<SingleTree> getModules(String login_name);
	//查询所有模块
	List<SingleTree> getAllModules();
	//根据ID查询模块信息
	Modules getAModulesById(Integer module_id);
	//根据ID进行修改模块信息
	Integer setModulesById(Modules modules);
	//添加模块信息
	Integer addModules(Modules modules);
	//根据ID删除模块信息
	Integer delmodulesById(Integer module_id);
}	
