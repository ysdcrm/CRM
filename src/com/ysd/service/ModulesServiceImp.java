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
	@Override
	public List<SingleTree> getModules(String login_name) {
		// TODO Auto-generated method stub
		//所有模块
		List<Modules> modules = modulesMapper.getModule(login_name);
		//父模块
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


}
