package com.zhi.util;

public class StringUtil {
	
	public static boolean isEmpty(String str){
		if(str.isEmpty() || str==null){
			return true;
		}else{
			return false;
		}
	}
	
	public static boolean isNotEmpty(String str){
		if(str!=null && !str.isEmpty()){
			return true;
		}else{
			return false;
		}
	}
}
