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
	@Override
	public Fenye<Roles> selectshowAll(Fenye<Roles> fenye) {
		Integer selectCountRoles = rolesMapper.selectCountRoles(fenye);
		List<Roles> selectShowAll = rolesMapper.selectShowAll(fenye);
		fenye.setTotal(selectCountRoles);
		fenye.setRows(selectShowAll);
		return fenye;
	}
	@Override
	public Integer delRoles(int role_id) {
		return rolesMapper.delRoles(role_id);
	}
	@Override
	public Integer addRoles(Roles roles) {
		return rolesMapper.addRoles(roles);
	}
	@Override
	public Integer updateRoles(Roles roles) {
		return rolesMapper.UpdateRoles(roles);
	}
}
