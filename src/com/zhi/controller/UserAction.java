package com.zhi.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionSupport;
import com.zhi.entity.PageBean;
import com.zhi.entity.User;
import com.zhi.service.UserService;
import com.zhi.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class UserAction extends ActionSupport implements ServletRequestAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String page;
	private String rows;
	private User user;
	
	//图片上传所需属性
	private File headImg;
	private String headImgContentType;
	private String headImgFileName;
	
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
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public File getHeadImg() {
		return headImg;
	}
	public void setHeadImg(File headImg) {
		this.headImg = headImg;
	}
	public String getHeadImgContentType() {
		return headImgContentType;
	}
	public void setHeadImgContentType(String headImgContentType) {
		this.headImgContentType = headImgContentType;
	}
	public String getHeadImgFileName() {
		return headImgFileName;
	}
	public void setHeadImgFileName(String headImgFileName) {
		this.headImgFileName = headImgFileName;
	}

	private HttpServletRequest request;
	
	@Resource
	private UserService userService;
	
	public String list(){
		//构建分页
 		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
				
		JSONObject result=new JSONObject();

		//解决构造JSON时的级联和日期问题
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"songOfFavorite"}); //处理级联
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd")); //处理日期
		
		//添加JSON数据
		JSONArray rows=JSONArray.fromObject(userService.userList(pageBean, null), jsonConfig);
		
		result.put("rows", rows); //easyUI规定的json键rows
		result.put("total", userService.userCount(null)); //easyUI规定的json键total
		
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	//跳转到新增页面
	public String addUI(){
		return "addUI";
	}
	
	/**
	 * 用户类别的下拉ComboBox，为节省练习时间这里写死，不再构建数据表
	 * easyUI需要接受的JSON格式
	 * [{
	 *		"id":1,
	 *		"text":"Java",
	 *		"desc":"Write once, run anywhere"
	 *	},{
	 *		"id":2,
	 *		"text":"C#",
	 *		"desc":"One of the programming languages designed for the Common Language Infrastructure"
	 *	}]
	 */	
	public String userTypeComboBox(){
		JSONArray jSONArray=new JSONArray();
		
		JSONObject jSONObject0=new JSONObject();
		jSONObject0.put("id", "");
		jSONObject0.put("text", "请选择...");
		jSONObject0.put("selected", true);
		jSONObject0.put("desc", "选择您所属的用户类别");
		jSONArray.add(jSONObject0);
		
		JSONObject jSONObject1=new JSONObject();
		jSONObject1.put("id", "A");
		jSONObject1.put("text", "普通用户");
		jSONObject1.put("desc", "非付费用户仅提供基础功能");
		jSONArray.add(jSONObject1);
		
		JSONObject jSONObject2=new JSONObject();
		jSONObject2.put("id", "B");
		jSONObject2.put("text", "VIP用户");
		jSONObject2.put("desc", "根据会员制度享有不同的优质服务");
		jSONArray.add(jSONObject2);
		
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), jSONArray);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//保存新增
	public String add(){
		if(user!=null){
			if(headImg!=null){ //处理头像
				//1、保存头像到后台upload/user
				//获取保存路径的绝对地址
				String filePath=ServletActionContext.getServletContext().getRealPath("/background/upload/user");
				System.out.println(filePath);
				String fileName=UUID.randomUUID().toString().replaceAll("-", "")+headImgFileName.substring(headImgFileName.lastIndexOf("."));
				System.out.println(fileName);
				
				//复制文件
				File saveFile=new File(filePath, fileName);
				try {
					FileUtils.copyFile(headImg, saveFile);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				//2、设置用户头像路径
				user.setHeadImg("user/"+fileName);
			}
			userService.saveUser(user); //根据Spring事务命名方法
		}

		//保存成功后返回JSON，再由页面进行Ajax操作
		JSONObject result=new JSONObject();
		result.put("flag", true);
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//跳转到编辑页面
	public String editUI(){
		//本次不查，只用session保存一个ID，然后跳转页面，页面Ajax请求时再查数据
		HttpSession session=request.getSession();
		session.setAttribute("userNo", user.getUserNo());
		return "editUI";
	}
	
	//保存编辑前
	public String preEdit(){
		HttpSession session=request.getSession();
		Integer userNo=(Integer)session.getAttribute("userNo");
		session.removeAttribute("userNo");
		user=userService.findObjectById(userNo);
		
		//查找成功后返回JSON，再由页面进行Ajax操作
		JSONObject result=new JSONObject();
		result.put("success", true);
		
		result.put("userNo", user.getUserNo());
		result.put("userType", user.getUserType());

		result.put("userName", user.getUserName());
		result.put("password", user.getPassword());
		result.put("headImg", user.getHeadImg());
		result.put("gender", user.getGender()+"");
		result.put("userState", user.getUserState()+"");
		result.put("mobileNo", user.getMobileNo());
		result.put("email", user.getEmail());
		result.put("note", user.getNote());
		
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//保存编辑(修改操作)
	public String edit(){
		if(user!=null){
			//处理头像
			if(headImg!=null){
				//1、保存头像到upload/user
				//获取保存路径的绝对地址
				String filePath=ServletActionContext.getServletContext().getRealPath("/background/upload/user");
				String fileName=UUID.randomUUID().toString().replaceAll("-", "") + headImgFileName.substring(headImgFileName.lastIndexOf("."));
				
				//复制文件
				try {
					FileUtils.copyFile(headImg, new File(filePath, fileName));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				//2、设置用户头像路径
				user.setHeadImg("user/" + fileName);
			}
			userService.saveUser(user);
		}
		//修改成功后返回JSON，再由页面进行Ajax操作
		JSONObject result=new JSONObject();
		result.put("success", true);
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

//	//批量删除
//	public String deleteSelected(){
//		JSONObject result=new JSONObject();
//		String []idsStr=selectedRow.split(",");
//		for(int i=0;i<idsStr.length;i++){
//			userService.delete(idsStr[i]);				
//		}
//		result.put("success", true);
//		try {
//			ResponseUtil.write(ServletActionContext.getResponse(), result);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return null;
//	}
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}
}
