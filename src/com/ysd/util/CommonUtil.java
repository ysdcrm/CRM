package com.ysd.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.ysd.entity.SingleTree;


@Component
public class CommonUtil {
	
	public static Map<String, Object> getResultMap(){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", "");
		map.put("message", "");
		map.put("remark", "");
		return map;
	}
	
	/**
	 * 
	 * @param list 所有模块的树类集合
	 * @param id   父ID 0
	 * @return
	 */
	  public static List<SingleTree> changeSingleTototal(List<SingleTree> list,int id){ 
		  //创建一个树类集合
		  List<SingleTree> list1=new ArrayList<SingleTree>(); 
		  //循环 传来的 所有模块的树类集合 list
		  for (SingleTree st :list) { 
			  //创建一个树类对象 将每次循环的值，存放在对象里
			  SingleTree tree=new SingleTree(); 
			  tree.setId(st.getId());
			  tree.setText(st.getText()); 
			  tree.setPath(st.getPath());
			  tree.setP_id(st.getP_id());
			  tree.setChecked(st.isChecked());
			  //判断循环出来的P_ID是否是父ID，如果是，那么将再次进行递归循环再次判断，直到判断出没有
			  if(id==st.getP_id()){
				  tree.setChildren(CommonUtil.changeSingleTototal(list, st.getId()));
				  list1.add(tree); 
			  } 
		  } 
		  return list1;
		  }
	 
	
	
}
