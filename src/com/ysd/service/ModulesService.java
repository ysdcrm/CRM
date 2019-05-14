package com.ysd.service;

import java.util.List;

import com.ysd.entity.SingleTree;

public interface ModulesService {
	//查询登录用户的相应模块
	List<SingleTree> getModules(String login_name);
}	
