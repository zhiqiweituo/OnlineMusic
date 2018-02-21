package com.zhi.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.zhi.entity.DataDicType;
import com.zhi.entity.PageBean;
import com.zhi.service.DataDicTypeService;
import com.zhi.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class DataDicTypeAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String page;
	private String rows;
	private DataDicType dataDicType;
	private DataDicType s_dataDicType;
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
	public DataDicType getDataDicType() {
		return dataDicType;
	}
	public void setDataDicType(DataDicType dataDicType) {
		this.dataDicType = dataDicType;
	}
	public DataDicType getS_dataDicType() {
		return s_dataDicType;
	}
	public void setS_dataDicType(DataDicType s_dataDicType) {
		this.s_dataDicType = s_dataDicType;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	@Resource
	private DataDicTypeService dataDicTypeService;
	
	public String list() {
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		List<DataDicType> dataDicTypeList=dataDicTypeService.findDataDicTypeList(pageBean,s_dataDicType);
		long total=dataDicTypeService.getDataDicTypeCount(s_dataDicType);
		
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"dataDicList"}); //处理级联
		JSONArray rows=JSONArray.fromObject(dataDicTypeList, jsonConfig);
		JSONObject result=new JSONObject();
			
		result.put("rows", rows);
		result.put("total", total);
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public String save() {
		dataDicTypeService.saveDataDicType(dataDicType);
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
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			dataDicType=dataDicTypeService.getDataDicTypeById(Integer.parseInt(idsStr[i]));
			dataDicTypeService.deleteDataDicType(dataDicType);				
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
	
	//数据字典类别的下拉框
	public String comboList() {
		JSONArray jsonArray=new JSONArray();
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("ddTypeId", "");
		jsonObject.put("ddTypeName", "请选择...");
		jsonArray.add(jsonObject);
		List<DataDicType> dataDicTypeList=dataDicTypeService.findAllList();
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"dataDicList"});//处理级联
		JSONArray rows=JSONArray.fromObject(dataDicTypeList, jsonConfig);
		jsonArray.addAll(rows);
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), jsonArray);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
