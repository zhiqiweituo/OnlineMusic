package com.zhi.service;

import java.util.List;

import com.zhi.entity.DataDicType;
import com.zhi.entity.PageBean;

public interface DataDicTypeService {
	//查询列表
	public List<DataDicType> findAllList();
	//分页查询
	public List<DataDicType> findDataDicTypeList(PageBean pageBean,DataDicType s_dataDicType);
	//分页查询对应的数量
	public Long getDataDicTypeCount(DataDicType s_dataDicType);
	//保存
	public void saveDataDicType(DataDicType dataDicType); //merge合并
	//删除
	public void deleteDataDicType(DataDicType dataDicType);
	//根据主键查找单个对象
	public DataDicType getDataDicTypeById(int id);
}
