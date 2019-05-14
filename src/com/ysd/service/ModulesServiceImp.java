package com.ysd.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.ModulesMapper;
import com.ysd.entity.Modules;
import com.ysd.entity.SingleTree;

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
		//当前登录的用户的所有父模块
		List<Modules> module2 = modulesMapper.getModules(login_name);
		List<SingleTree> trees=new ArrayList<SingleTree>();
		for(int i=0;i<module2.size();i++) {
			SingleTree tree = new SingleTree();
			tree.setId(module2.get(i).getModule_id());
			tree.setText(module2.get(i).getModule_name());
			tree.setPath(module2.get(i).getPath());
			List<SingleTree> trees1=new ArrayList<SingleTree>();
			for(int j=0;j<modules.size();j++) {
				if(module2.get(i).getModule_id()==modules.get(j).getParent_id()) {
					SingleTree singleTree = new SingleTree();
					singleTree.setId(modules.get(j).getModule_id());
					singleTree.setText(modules.get(j).getModule_name());
					singleTree.setPath(modules.get(j).getPath());
					trees1.add(singleTree);
				}
			}
			tree.setChildren(trees1);
			trees.add(tree);
		}
		return trees;
	}
	//所有模块信息
	@Override
	public List<SingleTree> getAllModules() {
		// TODO Auto-generated method stub
		//所有模块
		List<Modules> allModule = modulesMapper.getAllModule();
		//所有1级父模块
		List<Modules> allFaterModule = modulesMapper.getAllFaterModule();
		List<SingleTree> tree=new ArrayList<SingleTree>();
		for(int i=0;i<allFaterModule.size();i++) {
			SingleTree tree1 = new SingleTree();
			tree1.setId(allFaterModule.get(i).getModule_id());
			tree1.setText(allFaterModule.get(i).getModule_name());
			tree1.setPath(allFaterModule.get(i).getPath());
			List<SingleTree> tree2=new ArrayList<SingleTree>();
			for(int j=0;j<allModule.size();j++) {
				if(allFaterModule.get(i).getModule_id()==allModule.get(j).getParent_id()) {
					SingleTree tree3 = new SingleTree();
					tree3.setId(allModule.get(j).getModule_id());
					tree3.setText(allModule.get(j).getModule_name());
					tree3.setPath(allModule.get(j).getPath());
					tree2.add(tree3);
				}
			}
			tree1.setChildren(tree2);
			tree.add(tree1);
		}
		return tree;
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
		// TODO Auto-generated method stub
		Integer addModules = modulesMapper.addModules(modules);
		return addModules;
	}
	//根据ID删除模块信息
	@Override
	public Integer delmodulesById(Integer module_id) {
		// TODO Auto-generated method stub
		Integer delmodulesById = modulesMapper.delmodulesById(module_id);
		return delmodulesById;
	}


}
