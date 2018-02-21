package com.zhi.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.BaseDao;

import com.zhi.entity.PageBean;
import com.zhi.entity.Singer;
import com.zhi.service.SingerService;
import com.zhi.util.StringUtil;

@Service("singerService")
public class SingerServiceImpl implements SingerService {

	@Resource
	BaseDao<Singer> baseDao;

	@Override
	public List<Singer> singerList(PageBean pageBean, Singer s_singer) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Singer");
		if(s_singer!=null){
			if(StringUtil.isNotEmpty(s_singer.getSingerName())){
				hql.append(" and singerName like ?");
				param.add("%"+s_singer.getSingerName()+"%");
			}
		}
		if(pageBean!=null){
			return baseDao.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return baseDao.find(hql.toString().replaceFirst("and", "where"), param);
		}
	}

	@Override
	public long singerCount(Singer s_singer) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from Singer");
		if(s_singer!=null){
			if(StringUtil.isNotEmpty(s_singer.getSingerName())){
				hql.append(" and singerName like ?");
				param.add("%"+s_singer.getSingerName()+"%");
			}
		}
		return baseDao.count(hql.toString().replaceFirst("and", "where"), param);
	}

	@Override
	public void saveSinger(Singer singer) {
		// TODO Auto-generated method stub
		baseDao.merge(singer);
	}

	@Override
	public void deleteSinger(Singer singer) {
		// TODO Auto-generated method stub
		baseDao.delete(singer);
	}

	@Override
	public Singer findObjectById(int singerId) {
		// TODO Auto-generated method stub
		return baseDao.get(Singer.class, Integer.valueOf(singerId));
	}
	
}
