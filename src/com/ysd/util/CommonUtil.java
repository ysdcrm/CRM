package com.ysd.util;

import java.util.HashMap;
import java.util.Map;



public class CommonUtil {
	
	public static Map<String, Object> getResultMap(){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", "");
		map.put("message", "网络连接失败,请重试!");
		map.put("remark", "");
		return map;
	}
	
	/*
	 * public static List<SingleTree> changeSingleTototal(List<SingleTree> list,int
	 * id){ List<SingleTree> list1=new ArrayList<SingleTree>(); for (SingleTree st :
	 * list) { SingleTree tree=new SingleTree(); tree.setId(st.getId());
	 * tree.setPid(st.getPid()); tree.setText(st.getText()); if(id==st.getPid()){
	 * tree.setChildren(CommonUtil.changeSingleTototal(list, st.getId()));
	 * list1.add(tree); } } return list1; }
	 */
	
	
}
