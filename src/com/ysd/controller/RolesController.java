package com.ysd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysd.entity.Fenye;
import com.ysd.entity.Roles;
import com.ysd.entity.SingleTree;
import com.ysd.service.RolesService;

@Controller
public class RolesController<T> {
	@Autowired
	private RolesService rolesService;
	@Autowired	
	private Fenye<Roles> fenye;
 //所有角色
	@RequestMapping(value="/show",method=RequestMethod.POST)
	@ResponseBody
	public Fenye<Roles> getRolesAll(Integer page,Integer rows,Roles roles){
		fenye.setPage((page-1)*rows);
		fenye.setPageSize(rows);
		fenye.setRoles(roles);
		Fenye<Roles> selectshowAll = rolesService.selectshowAll(fenye);
		return selectshowAll;
	  }
//删除	
	@RequestMapping(value="/delRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer delRoles(int role_id){
		Integer delRoles = rolesService.delRoles(role_id);
		return delRoles;
	  }
//添加	
	@RequestMapping(value="/addRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer addRoles(Roles roles){
		return rolesService.addRoles(roles);
	  }
//修改	
	@RequestMapping(value="/updateRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateRoles(Roles roles){
		return rolesService.updateRoles(roles);
	  }
   //查询角色权限
	  @RequestMapping(value="/selectRolesByIdQX",method=RequestMethod.POST)
	  @ResponseBody
	  public List<SingleTree> selectRolesQX(Integer role_id){
		  List<SingleTree> selectRolesByIdQX = rolesService.selectRolesByIdQX(role_id);
		  return selectRolesByIdQX;
	  }
	//保存权限
		@RequestMapping(value="/addRolesQX",method=RequestMethod.POST)
		@ResponseBody
		public Integer addRolesQX(Integer role_id,String module_id){
			return rolesService.addRolesQX(role_id, module_id);
		  }
}
