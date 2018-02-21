package com.zhi.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.BaseDao;
import com.zhi.entity.PageBean;
import com.zhi.entity.Song;
import com.zhi.service.SongService;
import com.zhi.util.StringUtil;

@Service("songService")
public class SongServiceImpl implements SongService {

	@Resource
	BaseDao<Song> baseDao;
	
	@Override
	public List<Song> songList(PageBean pageBean, Song s_song) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Song");
		if(s_song!=null){
			if(StringUtil.isNotEmpty(s_song.getSongName())){
				hql.append(" and songName like ?");
				param.add("%"+s_song.getSongName()+"%");
			}
		}
		if(pageBean!=null){
			return baseDao.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return baseDao.find(hql.toString().replaceFirst("and", "where"), param);
		}
	}

	@Override
	public long songCount(Song s_song) {
		// TODO Auto-generated method stub
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from Song");
		if(s_song!=null){
			if(StringUtil.isNotEmpty(s_song.getSongName())){
				hql.append(" and songName like ?");
				param.add("%"+s_song.getSongName()+"%");
			}
		}
		return baseDao.count(hql.toString().replaceFirst("and", "where"), param);
	}

	@Override
	public void saveSong(Song song) {
		// TODO Auto-generated method stub
		baseDao.merge(song);
	}

	@Override
	public void deleteSong(Song song) {
		// TODO Auto-generated method stub
		baseDao.delete(song);
	}

	@Override
	public Song findObjectById(int songId) {
		// TODO Auto-generated method stub
		return baseDao.get(Song.class, Integer.valueOf(songId));
	}

}
