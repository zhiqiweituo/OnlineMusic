package com.zhi.service;

import java.util.List;

import com.zhi.entity.DataDic;
import com.zhi.entity.PageBean;

public interface DataDicService {
	//分页查询
	public List<DataDic> findDataDicList(PageBean pageBean,DataDic s_dataDic);
	//分页查询对应的数量
	public Long getDataDicCount(DataDic s_dataDic);
	
	public void saveDataDic(DataDic dataDic);//merge合并
	
	public void deleteDataDic(DataDic dataDic);
	
	public DataDic getDataDicById(int id);
}
