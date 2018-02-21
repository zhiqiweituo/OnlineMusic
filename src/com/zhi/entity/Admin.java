package com.zhi.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="t_admin")
public class Admin{
	private Integer adminNo; //管理员编号
	private Boolean adminState; //管理员状态（正常、锁定）
	private String adminName; //管理员登录用户名
	private String password; //管理员登录密码
	private String realName; //真实姓名
	private Boolean gender; //性别
	private String mobileNo; //手机号码
	private String note; //备注
	
	private List<Song> songOfUpload=new ArrayList<Song>(); //一个管理员可以上传多首歌曲
	
	public Admin() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	@Column(name="admin_no")
	public Integer getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(Integer adminNo) {
		this.adminNo = adminNo;
	}
	@Column(name="admin_state")
	public Boolean getAdminState() {
		return adminState;
	}
	public void setAdminState(Boolean adminState) {
		this.adminState = adminState;
	}
	@Column(name="admin_name",length=30)
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	@Column(name="password",length=30)
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Column(name="real_name",length=30)
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	@Column(name="gender")
	public Boolean getGender() {
		return gender;
	}
	public void setGender(Boolean gender) {
		this.gender = gender;
	}
	@Column(name="mobile_no",length=20)
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	@Column(name="note",length=100)
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	@OneToMany(mappedBy="admin")
	public List<Song> getSongOfUpload() {
		return songOfUpload;
	}
	public void setSongOfUpload(List<Song> songOfUpload) {
		this.songOfUpload = songOfUpload;
	}

}
