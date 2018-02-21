package com.zhi.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.BaseDao;
import com.zhi.entity.PageBean;
import com.zhi.entity.User;
import com.zhi.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{

	@Resource
	BaseDao<User> baseDao;
	
	@Override
	public List<User> userList(PageBean pageBean, User user) {
		// TODO Auto-generated method stub
		return baseDao.find("from User");
	}

	@Override
	public int userCount(User user) {
		// TODO Auto-generated method stub
		Long count=baseDao.count("select count(*) from User"); //dao返回Long
		return Integer.parseInt(count+""); //前台使用int型
	}

	@Override
	public int userDelete(Integer userNo) {
		// TODO Auto-generated method stub
		baseDao.delete(baseDao.get(User.class, Integer.valueOf(userNo)));
		return 1;
	}

	@Override
	public User findObjectById(int userNo) {
		// TODO Auto-generated method stub
		return baseDao.get(User.class, Integer.valueOf(userNo));
	}
	
	@Override
	public int saveUser(User user) {
		// TODO Auto-generated method stub
		baseDao.saveOrUpdate(user);
		return 1;
	}

}
