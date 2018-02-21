package com.zhi.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionSupport;
import com.zhi.entity.Admin;
import com.zhi.service.AdminService;
import com.zhi.util.ResponseUtil;

import net.sf.json.JSONObject;

public class AdminAction extends ActionSupport implements ServletRequestAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Admin admin;
	
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	private HttpServletRequest request;
	
	@Resource
	private AdminService adminService;
	
	public String login(){
		JSONObject jSONObject=new JSONObject();
		Admin currentAdmin=adminService.login(admin);
		if(currentAdmin==null){
			jSONObject.put("flag", "false");
			jSONObject.put("info", "用户名或密码错误");
		}else{
			//获取session保存当前管理员
			HttpSession session=request.getSession();
			session.setAttribute("currentAdmin", currentAdmin);
			jSONObject.put("flag", "true");
		}
		try {
			ResponseUtil.write(ServletActionContext.getResponse(), jSONObject);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null; //Ajax与SUCCESS不能共存，登录成功后由JS跳转页面
	}
	public String logout(){
		//清空session，重定向至登录页面
		HttpSession session=request.getSession();
		session.removeAttribute("currentAdmin");
		return SUCCESS;
	}
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}
}
