package com.zhi.service;

import java.util.List;

import com.zhi.entity.PageBean;
import com.zhi.entity.Singer;

public interface SingerService {
	public List<Singer> singerList(PageBean pageBean,Singer s_singer);
	public long singerCount(Singer s_singer);
	public void saveSinger(Singer singer);
	public void deleteSinger(Singer singer);
	public Singer findObjectById(int singerId);
}
