package com.ysd.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.ModulesMapper;
import com.ysd.dao.RolesMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Modules;
import com.ysd.entity.Rolemodules;
import com.ysd.entity.Roles;
import com.ysd.entity.SingleTree;
import com.ysd.entity.Userroles;
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
	public Map<String, Object> delRoles(int role_id) {
		Map<String, Object> map = CommonUtil.getResultMap();
		List<Rolemodules> selectRolemodulesByRoleId = rolesMapper.SelectRolemodulesByRoleId(role_id);
		List<Userroles> selectUserRolesById = rolesMapper.selectUserRolesById(role_id);
		if(selectRolemodulesByRoleId.size()!=0 || selectUserRolesById.size()!=0) {   //(   ||或者：满足其一)
			map.put("success", false);
			map.put("message", "该角色已被分配权限或已有用户拥有此角色，不可删除！！！");
		}else {
			rolesMapper.delRoles(role_id);
			map.put("success", true);
			map.put("message", "删除成功！！！");
		}
		return map;
	}
	//添加
	@Override
	public Integer addRoles(Roles roles) {
		Integer addRoles=null;
		List<Roles> selectByName = rolesMapper.selectByName(roles);
		if(selectByName.size()==0) {
			addRoles = rolesMapper.addRoles(roles);
		}else {
			addRoles=-1;
		}
		 return addRoles;
	}
	//修改
	@Override
	public Integer updateRoles(Roles roles) {
		Integer updateRoles=null;
		List<Rolemodules> selectRolemodulesByName = rolesMapper.selectRolemodulesByName(roles);
		if(selectRolemodulesByName.size()==0) {
			updateRoles= rolesMapper.UpdateRoles(roles);
		}else {
			updateRoles=-1;
		}
		return updateRoles;
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
