package com.ysd.service;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;

public interface RolesService {
	
  Fenye<Roles> selectshowAll(Fenye<Roles> fenye);
  Integer delRoles(int role_id);
  Integer addRoles(Roles roles);
  Integer updateRoles(Roles roles);
  List<Roles> selectRolesQX(String role_name);
}
