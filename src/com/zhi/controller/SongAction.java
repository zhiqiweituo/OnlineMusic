package com.zhi.controller;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.zhi.entity.PageBean;
import com.zhi.entity.Singer;
import com.zhi.entity.Song;
import com.zhi.service.SongService;
import com.zhi.util.ResponseUtil;
import com.zhi.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class SongAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String page;
	private String rows;
	private String s_songName;
	private Song song;
	private String ids;
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getRows() {
		return rows;
	}
	public void setRows(String rows) {
		this.rows = rows;
	}
	public String getS_songName() {
		return s_songName;
	}
	public void setS_songName(String s_songName) {
		this.s_songName = s_songName;
	}
	public Song getSong() {
		return song;
	}
	public void setSong(Song song) {
		this.song = song;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	@Resource
	private SongService songService;
	
	public String list() {
		//构建分页
 		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		
 		//构建搜索条件
 		Song searchSong=new Song();
 		if(StringUtil.isNotEmpty(s_songName)){
 			searchSong.setSongName(s_songName);
 		}
 		
 		JSONObject result=new JSONObject();

		//解决构造JSON时的级联和日期问题
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"userList"}); //处理级联
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd")); //处理日期
		jsonConfig.registerJsonValueProcessor(Singer.class,new ObjectJsonValueProcessor(new String[]{"singerName"}, Singer.class));
		//jsonConfig.registerJsonValueProcessor(Admin.class,new ObjectJsonValueProcessor(new String[]{""}, Admin.class));
		JSONArray rows=JSONArray.fromObject(songService.songList(pageBean, searchSong), jsonConfig);
		long total=songService.songCount(searchSong);
				
		result.put("rows", rows); //easyUI规定的json键rows
		result.put("total", total); //easyUI规定的json键total
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
