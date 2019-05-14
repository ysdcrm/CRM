package com.ysd.dao;

import java.util.List;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;

public interface RolesMapper {
	
	  Integer selectCountRoles(Fenye<Roles> fenye);
	  
	  List<Roles> selectShowAll(Fenye<Roles> fenye);
	  
	  Integer addRoles(Roles roles);
	  
	  Integer UpdateRoles(Roles roles);
	  
	  Integer delRoles(int role_id);
}
