package com.zhi.controller;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.zhi.entity.PageBean;
import com.zhi.entity.Singer;
import com.zhi.service.SingerService;
import com.zhi.util.ResponseUtil;
import com.zhi.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class SingerAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String page;
	private String rows;
	private String s_singerName;
	private Singer singer;
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
	public String getS_singerName() {
		return s_singerName;
	}
	public void setS_singerName(String s_singerName) {
		this.s_singerName = s_singerName;
	}
	public Singer getSinger() {
		return singer;
	}
	public void setSinger(Singer singer) {
		this.singer = singer;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}

	@Resource
	private SingerService singerService;
	
	public String list(){
		//构建分页
 		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		
 		//构建搜索条件
 		Singer searchSinger=new Singer();
 		if(StringUtil.isNotEmpty(s_singerName)){
 			searchSinger.setSingerName(s_singerName);
 		}
 		
		JSONObject result=new JSONObject();

		//解决构造JSON时的级联和日期问题
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"songList"}); //处理级联
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd")); //处理日期
		
		//添加JSON数据
		JSONArray rows=JSONArray.fromObject(singerService.singerList(pageBean, searchSinger), jsonConfig);
		
		result.put("rows", rows); //easyUI规定的json键rows
		result.put("total", singerService.singerCount(searchSinger)); //easyUI规定的json键total
		
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public String save() {
		singerService.saveSinger(singer);
		JSONObject result=new JSONObject();
		result.put("success", true);
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public String delete() {
		JSONObject result=new JSONObject();
		String[] idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){ //删除多行记录（多个对象）
			singer=singerService.findObjectById(Integer.parseInt(idsStr[i]));
			singerService.deleteSinger(singer);		
		}
		result.put("success", true);
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
