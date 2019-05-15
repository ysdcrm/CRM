package com.ysd.service;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Rolemodules;
import com.ysd.entity.Roles;
import com.ysd.entity.SingleTree;

public interface RolesService {
	
  Fenye<Roles> selectshowAll(Fenye<Roles> fenye);
  Integer delRoles(int role_id);
  Integer addRoles(Roles roles);
  Integer updateRoles(Roles roles);
  List<SingleTree> selectRolesByIdQX(Integer role_id);
}
