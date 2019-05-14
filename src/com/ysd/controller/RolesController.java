package com.ysd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;
import com.ysd.service.RolesService;

@Controller
public class RolesController<T> {
	@Autowired
	private RolesService rolesService;
	@Autowired	
	private Fenye<Roles> fenye;
	@RequestMapping(value="/show",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Roles> getRolesAll(Integer page,Integer rows,Roles roles){
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		fenye.setRoles(roles);
		Fenye<Roles> selectshowAll = rolesService.selectshowAll(fenye);
		return selectshowAll;
	  }
	@RequestMapping(value="/delRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer delRoles(int role_id){
		Integer delRoles = rolesService.delRoles(role_id);
		return delRoles;
	  }
	@RequestMapping(value="/addRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer addRoles(Roles roles){
		return rolesService.addRoles(roles);
	  }
	@RequestMapping(value="/updateRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateRoles(Roles roles){
		return rolesService.updateRoles(roles);
	  }
}
