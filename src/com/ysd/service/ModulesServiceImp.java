package com.ysd.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.ModulesMapper;
import com.ysd.entity.Modules;
import com.ysd.entity.Rolemodules;
import com.ysd.entity.SingleTree;
import com.ysd.util.CommonUtil;

@Service
public class ModulesServiceImp implements ModulesService {
	@Autowired
	private ModulesMapper modulesMapper;
	//当前登录用户的信息
	@Override
	public List<SingleTree> getModules(String login_name) {
		// TODO Auto-generated method stub
		//当前登录的用户的所有模块
		List<Modules> modules = modulesMapper.getModule(login_name);
		List<SingleTree> trees=new ArrayList<SingleTree>();
		for(Modules module:modules) {
			SingleTree tree=new SingleTree();
			tree.setId(module.getModule_id());
			tree.setText(module.getModule_name());
			tree.setP_id(module.getParent_id());
			tree.setPath(module.getPath());
			trees.add(tree);
		}
		List<SingleTree> singleTrees=CommonUtil.changeSingleTototal(trees, 0);
		return singleTrees;
	}
	//所有模块信息
	@Override
	public List<SingleTree> getAllModules() {
		// TODO Auto-generated method stub
		//所有模块
		List<Modules> allModule = modulesMapper.getAllModule();
		
		List<SingleTree> trees=new ArrayList<SingleTree>();
		for(Modules module:allModule) {
			SingleTree tree=new SingleTree();
			tree.setId(module.getModule_id());
			tree.setText(module.getModule_name());
			tree.setP_id(module.getParent_id());
			tree.setPath(module.getPath());
			trees.add(tree);
		}
		List<SingleTree> singleTrees=CommonUtil.changeSingleTototal(trees, 0);
		return singleTrees;
	}
	//根据ID查询模块信息
	@Override
	public Modules getAModulesById(Integer module_id) {
		// TODO Auto-generated method stub
		Modules aModulesById = modulesMapper.getAModulesById(module_id);
		return aModulesById;
	}
	//根据ID修改模块信息
	@Override
	public Integer setModulesById(Modules modules) {
		// TODO Auto-generated method stub
		Integer setModulesById = modulesMapper.setModulesById(modules);
		return setModulesById;
	}
	//添加模块信息
	@Override
	public Integer addModules(Modules modules) {
		Integer addModules=null;
		List<Modules> selectModulesByName = modulesMapper.selectModulesByName(modules);
		if(selectModulesByName.size()==0){
			addModules = modulesMapper.addModules(modules);
		}else {
			return -1;
		}
		return addModules;
	}
	//根据ID删除模块信息
	@Override
	public Integer delmodulesById(Integer module_id) {
		Integer delModules=null;
		List<Rolemodules> selectRoleModulesById = modulesMapper.selectRoleModulesById(module_id);
		List<Modules> selectChildren = modulesMapper.selectChildren(module_id);
		if(selectRoleModulesById.size()==0 && selectChildren.size()==0){
			delModules = modulesMapper.delmodulesById(module_id);
		}else {
			return -1;
		}
		return delModules;
	}


}
