package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Modules;

public interface ModulesMapper {
	//查询登录用户的相应父模块
	List<Modules> getModules(String login_name);
	//查询登录用户的相应模块
	List<Modules> getModule(String login_name);
}
