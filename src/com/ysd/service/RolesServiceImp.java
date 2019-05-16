package com.ysd.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.ModulesMapper;
import com.ysd.dao.RolesMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Modules;
import com.ysd.entity.Rolemodules;
import com.ysd.entity.Roles;
import com.ysd.entity.SingleTree;
import com.ysd.util.CommonUtil;

@Service
public class RolesServiceImp implements RolesService {
	@Autowired
	private RolesMapper rolesMapper;
	@Autowired
	private ModulesMapper modulesMapper;
	//查询所有
	@Override
	public Fenye<Roles> selectshowAll(Fenye<Roles> fenye) {
		Integer selectCountRoles = rolesMapper.selectCountRoles(fenye);
		List<Roles> selectShowAll = rolesMapper.selectShowAll(fenye);
		fenye.setTotal(selectCountRoles);
		fenye.setRows(selectShowAll);
		return fenye;
	}
	//删除
	@Override
	public Integer delRoles(int role_id) {
		return rolesMapper.delRoles(role_id);
	}
	//添加
	@Override
	public Integer addRoles(Roles roles) {
		return rolesMapper.addRoles(roles);
	}
	//修改
	@Override
	public Integer updateRoles(Roles roles) {
		return rolesMapper.UpdateRoles(roles);
	}
	@Override
	public List<SingleTree> selectRolesByIdQX(Integer role_id) {
		// TODO Auto-generated method stub
		List<SingleTree> singleTrees=new ArrayList<SingleTree>();
		List<Modules> selectRolesByIdQX = rolesMapper.selectRolesByIdQX(role_id);
		List<Modules> allModule = modulesMapper.getAllModule();
		List<Integer> tre=new ArrayList<Integer>();
		for(Modules RM:selectRolesByIdQX) {
			tre.add(RM.getModule_id());
		}
		for(Modules M:allModule) {
			SingleTree tree=new SingleTree();
				if(tre.contains(M.getModule_id())&&M.getParent_id()!=0) {
					  tree.setId(M.getModule_id());
					  tree.setText(M.getModule_name());
					  tree.setPath(M.getPath());
					  tree.setP_id(M.getParent_id());
					  tree.setChecked(true);
				}else {
					  tree.setId(M.getModule_id());
					  tree.setText(M.getModule_name());
					  tree.setPath(M.getPath());
					  tree.setP_id(M.getParent_id());
					  tree.setChecked(false);
				}
					
				singleTrees.add(tree);
		}
		List<SingleTree> singleTree=CommonUtil.changeSingleTototal(singleTrees, 0);
		return singleTree;
	}
	@Override
	public Integer addRolesQX(Integer role_id,String module_id){
		
		rolesMapper.delRolesQX(role_id);
		String[] pp = module_id.split(",");
		Integer j = 0;
		for(int i=0;i<pp.length;i++) {
			Rolemodules rolemodules=new Rolemodules();
			Integer qq=Integer.parseInt(pp[i]);
			rolemodules.setModule_id(qq);
			rolemodules.setRole_id(role_id);
			j=rolesMapper.addRolesQX(rolemodules);
		}
		
		
		return j;
	}
}
