package com.zhi.service;

import java.util.List;

import com.zhi.entity.PageBean;
import com.zhi.entity.User;

public interface UserService {

	public List<User> userList(PageBean pageBean,User user);
	public int userCount(User user);
	public int saveUser(User user);
	public User findObjectById(int userNo);
	public int userDelete(Integer userNo);
}
