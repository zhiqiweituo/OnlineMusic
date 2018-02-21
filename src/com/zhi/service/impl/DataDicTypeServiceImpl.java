package com.zhi.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.BaseDao;
import com.zhi.entity.DataDicType;
import com.zhi.entity.PageBean;
import com.zhi.service.DataDicTypeService;
import com.zhi.util.StringUtil;

@Service("dataDicTypeService")
public class DataDicTypeServiceImpl implements DataDicTypeService {

	@Resource
	private BaseDao<DataDicType> baseDao;
	
	@Override
	public List<DataDicType> findAllList() {
		// TODO Auto-generated method stub
		return baseDao.find("from DataDicType");
	}
	
	@Override
	public List<DataDicType> findDataDicTypeList(PageBean pageBean, DataDicType s_dataDicType) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from DataDicType");
		if(s_dataDicType!=null){
			if(StringUtil.isNotEmpty(s_dataDicType.getDdTypeName())){
				hql.append(" and ddTypeName like ?");
				param.add("%"+s_dataDicType.getDdTypeName()+"%");
			}
		}
		if(pageBean!=null){
			return baseDao.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return baseDao.find(hql.toString().replaceFirst("and", "where"), param);
		}
	}

	@Override
	public Long getDataDicTypeCount(DataDicType s_dataDicType) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from DataDicType");
		if(s_dataDicType!=null){
			if(StringUtil.isNotEmpty(s_dataDicType.getDdTypeName())){
				hql.append(" and ddTypeName like ?");
				param.add("%"+s_dataDicType.getDdTypeName()+"%");
			}
		}
		return baseDao.count(hql.toString().replaceFirst("and", "where"), param);
	}

	@Override
	public void saveDataDicType(DataDicType dataDicType) {
		// TODO Auto-generated method stub
		baseDao.merge(dataDicType);
	}

	@Override
	public void deleteDataDicType(DataDicType dataDicType) {
		// TODO Auto-generated method stub
		baseDao.delete(dataDicType);
	}

	@Override
	public DataDicType getDataDicTypeById(int id) {
		// TODO Auto-generated method stub
		return baseDao.get(DataDicType.class, id);
	}
	
}
