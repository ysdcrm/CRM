package com.ysd.service;

import java.util.List;
import java.util.Map;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;
import com.ysd.entity.SingleTree;

public interface RolesService {
	
  Fenye<Roles> selectshowAll(Fenye<Roles> fenye);
  Map<String, Object> delRoles(int role_id);
  Integer addRoles(Roles roles);
  Integer updateRoles(Roles roles);
  List<SingleTree> selectRolesByIdQX(Integer role_id);
  //保存角色权限
  Integer addRolesQX(Integer role_id,String module_id);
}
