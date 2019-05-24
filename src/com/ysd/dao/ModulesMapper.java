package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Modules;

public interface ModulesMapper {
	/**
	 * 	查询登录用户的相应父模块
	 * @param login_name
	 * @return
	 */
	List<Modules> getModules(String login_name);
	/**
	 * 	查询登录用户的相应子模块
	 * @param login_name
	 * @return
	 */
	List<Modules> getModule(String login_name);
	/**
	 * 	查询所有父模块
	 * @return
	 */
	List<Modules> getAllFaterModule();
	/**
	 * 	查询所有模块
	 * @return
	 */
	List<Modules> getAllModule();
	/**
	 * 	根据ID查询模块信息
	 * @param module_id
	 * @return
	 */
	Modules getAModulesById(Integer module_id);
	/**
	 * 	根据ID修改模块信息
	 * @param modules
	 * @return
	 */
	Integer setModulesById(Modules modules);
	/**
	 * 	添加模块信息
	 * @param modules
	 * @return
	 */
	Integer addModules(Modules modules);
	//查询模块已有的所有模块名
	
	
	
	/**
	 * 	根据ID进行删除模块信息
	 * @param module_id
	 * @return
	 */
	Integer delmodulesById(Integer module_id);
}
