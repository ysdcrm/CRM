package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;

public interface RolesMapper {
	//查询总条数
	  Integer selectCountRoles(Fenye<Roles> fenye);
	  //查询总数据
	  List<Roles> selectShowAll(Fenye<Roles> fenye);
	  //添加角色
	  Integer addRoles(Roles roles);
	  //修改角色
	  Integer UpdateRoles(Roles roles);
	  //删除角色
	  Integer delRoles(int role_id);
	  //根据角色名设置角色权限
	  List<Roles> selectRolesQX(String role_name);
}
