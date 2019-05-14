package com.ysd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysd.dao.RolesMapper;
import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;

@Service
public class RolesServiceImp implements RolesService {
	@Autowired
	private RolesMapper rolesMapper;
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
  //根据角色名设置角色权限
	@Override
	public List<Roles> selectRolesQX(String role_name) {
		List<Roles> selectRolesQX = rolesMapper.selectRolesQX(role_name);
		System.out.println(selectRolesQX);
		return null;
		
		
		
	}
}
