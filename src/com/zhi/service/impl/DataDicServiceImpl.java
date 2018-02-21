package com.zhi.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.BaseDao;
import com.zhi.entity.DataDic;
import com.zhi.entity.PageBean;
import com.zhi.service.DataDicService;
import com.zhi.util.StringUtil;

@Service("dataDicService")
public class DataDicServiceImpl implements DataDicService {

	@Resource
	private BaseDao<DataDic> baseDao;
	
	@Override
	public List<DataDic> findDataDicList(PageBean pageBean, DataDic s_dataDic) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from DataDic");
		if(s_dataDic!=null){
			if(StringUtil.isNotEmpty(s_dataDic.getDdValue())){
				hql.append(" and ddValue like ?");
				param.add("%"+s_dataDic.getDdValue()+"%");
			}
			if(s_dataDic.getDataDicType().getDdTypeId()!=null){
				hql.append(" and dataDicType.ddTypeId=?");
				param.add(s_dataDic.getDataDicType().getDdTypeId());
			}
			if(s_dataDic.getDataDicType().getDdTypeName()!=null){
				hql.append(" and dataDicType.ddTypeName=?");
				param.add(s_dataDic.getDataDicType().getDdTypeName());
			}
		}
		if(pageBean!=null){
			return baseDao.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return baseDao.find(hql.toString().replaceFirst("and", "where"), param);
		}
	}

	@Override
	public Long getDataDicCount(DataDic s_dataDic) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from DataDic");
		if(s_dataDic!=null){
			if(StringUtil.isNotEmpty(s_dataDic.getDdValue())){
				hql.append(" and ddValue like ?");
				param.add("%"+s_dataDic.getDdValue()+"%");
			}
			if(s_dataDic.getDataDicType().getDdTypeId()!=null){
				hql.append(" and dataDicType.ddTypeId=?");
				param.add(s_dataDic.getDataDicType().getDdTypeId());
			}
			if(s_dataDic.getDataDicType().getDdTypeName()!=null){
				hql.append(" and dataDicType.ddTypeName=?");
				param.add(s_dataDic.getDataDicType().getDdTypeName());
			}
		}
		return baseDao.count(hql.toString().replaceFirst("and", "where"), param);
	}

	@Override
	public void saveDataDic(DataDic dataDic) {
		// TODO Auto-generated method stub
		baseDao.merge(dataDic);
	}

	@Override
	public void deleteDataDic(DataDic dataDic) {
		// TODO Auto-generated method stub
		baseDao.delete(dataDic);
	}

	@Override
	public DataDic getDataDicById(int id) {
		// TODO Auto-generated method stub
		return baseDao.get(DataDic.class, id);
	}

}
