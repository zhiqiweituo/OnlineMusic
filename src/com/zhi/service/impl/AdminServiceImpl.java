package com.zhi.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.BaseDao;
import com.zhi.entity.Admin;
import com.zhi.service.AdminService;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

	@Resource
	BaseDao<Admin> baseDao;
	
	@Override
	public Admin login(Admin admin) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		param.add(admin.getAdminName());
		param.add(admin.getPassword());
		StringBuffer hql=new StringBuffer("from Admin where adminName=? and password=?");
		return baseDao.get(hql.toString(), param);
	}

}
