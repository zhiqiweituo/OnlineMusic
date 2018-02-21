package com.zhi.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.zhi.entity.DataDic;
import com.zhi.entity.DataDicType;
import com.zhi.entity.PageBean;
import com.zhi.service.DataDicService;
import com.zhi.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class DataDicAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String page;
	private String rows;
	private DataDic dataDic;
	private DataDic s_dataDic;
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
	public DataDic getDataDic() {
		return dataDic;
	}
	public void setDataDic(DataDic dataDic) {
		this.dataDic = dataDic;
	}
	public DataDic getS_dataDic() {
		return s_dataDic;
	}
	public void setS_dataDic(DataDic s_dataDic) {
		this.s_dataDic = s_dataDic;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	@Resource
	private DataDicService dataDicService;
	
	public String list() {
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		List<DataDic> dataDicTypeList=dataDicService.findDataDicList(pageBean,s_dataDic);
		long total=dataDicService.getDataDicCount(s_dataDic);
		
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{""}); //处理级联
		jsonConfig.registerJsonValueProcessor(DataDicType.class,new ObjectJsonValueProcessor(new String[]{"ddTypeId","ddTypeName"}, DataDicType.class));
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
		dataDicService.saveDataDic(dataDic);
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
			dataDic=dataDicService.getDataDicById(Integer.parseInt(idsStr[i]));
			dataDicService.deleteDataDic(dataDic);				
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
	
	/**
	 * 数据字典（所属地区）下拉框
	 */
	public String regionComboList() throws Exception{
		JSONArray jsonArray=new JSONArray();
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("ddId", "");
		jsonObject.put("ddValue", "请选择...");
		jsonArray.add(jsonObject);
		
		s_dataDic=new DataDic();
		s_dataDic.setDataDicType(new DataDicType("所属地区")); //此处跟数据库里的字典顺序一致才有效
		
		List<DataDic> dataDicList=dataDicService.findDataDicList(null,s_dataDic);
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"dataDicType"}); //处理级联
		JSONArray rows=JSONArray.fromObject(dataDicList, jsonConfig);
		jsonArray.addAll(rows);
		ResponseUtil.write(ServletActionContext.getResponse(), jsonArray);
		return null;
	}
//	
//	/**
//	 * 设备类型的下拉框（数据字典里查）
//	 * @return
//	 * @throws Exception 
//	 */
//	public String devTypeComboList() throws Exception{
//		JSONArray jsonArray=new JSONArray();
//		JSONObject jsonObject=new JSONObject();
//		jsonObject.put("ddId", "");
//		jsonObject.put("ddValue", "请选择...");
//		jsonArray.add(jsonObject);
//		
//		s_dataDic=new DataDic();
//		s_dataDic.setDataDicType(new DataDicType(8));//此处跟数据库里的字典顺序一致才有效
//		
//		List<DataDic> dataDicList=dataDicService.findDataDicList(null,s_dataDic);
//		JsonConfig jsonConfig=new JsonConfig();
//		jsonConfig.setExcludes(new String[]{"dataDicType"});//处理级联
//		JSONArray rows=JSONArray.fromObject(dataDicList, jsonConfig);
//		jsonArray.addAll(rows);
//		ResponseUtil.write(ServletActionContext.getResponse(), jsonArray);
//		return null;
//	}
//	
//	/**
//	 * 设备状态的下拉框（数据字典里查）
//	 * @return
//	 * @throws Exception 
//	 */
//	public String devStateComboList() throws Exception{
//		JSONArray jsonArray=new JSONArray();
//		JSONObject jsonObject=new JSONObject();
//		jsonObject.put("ddId", "");
//		jsonObject.put("ddValue", "请选择...");
//		jsonArray.add(jsonObject);
//		
//		s_dataDic=new DataDic();
//		s_dataDic.setDataDicType(new DataDicType(9));//此处跟数据库里的字典顺序一致才有效
//		
//		List<DataDic> dataDicList=dataDicService.findDataDicList(null,s_dataDic);
//		JsonConfig jsonConfig=new JsonConfig();
//		jsonConfig.setExcludes(new String[]{"dataDicType"});//处理级联
//		JSONArray rows=JSONArray.fromObject(dataDicList, jsonConfig);
//		jsonArray.addAll(rows);
//		ResponseUtil.write(ServletActionContext.getResponse(), jsonArray);
//		return null;
//	}
	
//	/**
//	 * 根据数据字典ID返回数据字典值
//	 * @throws Exception 
//	 */
//	public String getDdValue() throws Exception{
//		dataDic=dataDicService.getDataDicById(Integer.parseInt(ids));
//		JSONObject result=new JSONObject();
//		result.put("ddValue", dataDic.getDdValue());
//		ResponseUtil.write(ServletActionContext.getResponse(), result);
//		return null;
//	}
	
}
