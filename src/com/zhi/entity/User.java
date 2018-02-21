package com.zhi.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="t_user")
public class User{
	private Integer userNo; //用户编号
	private String userType; //用户类型
	private String userName; //用户名
	private String password; //密码
	private String headImg; //头像
	private Boolean gender; //性别
	private Boolean userState; //状态
	private String mobileNo; //手机号码
	private String email; //电子邮箱
	private String note; //备注
	
	private List<Song> songOfFavorite=new ArrayList<Song>(); //一个用户可以收藏多首歌曲
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	@Column(name="user_no")
	public Integer getUserNo() {
		return userNo;
	}
	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}
	@Column(name="user_type",length=30)
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	@Column(name="user_name",length=30)
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	@Column(name="password",length=30)
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Column(name="head_img",length=60)
	public String getHeadImg() {
		return headImg;
	}
	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}
	@Column(name="gender")
	public Boolean getGender() {
		return gender;
	}
	public void setGender(Boolean gender) {
		this.gender = gender;
	}
	@Column(name="user_state")
	public Boolean getUserState() {
		return userState;
	}
	public void setUserState(Boolean userState) {
		this.userState = userState;
	}
	@Column(name="mobile_no",length=20)
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	@Column(name="email",length=50)
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Column(name="note",length=200)
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	@ManyToMany
	@JoinTable(name="favorite_user_song",
		joinColumns={@JoinColumn(name="song_id")},
		inverseJoinColumns={@JoinColumn(name="user_no")})
	public List<Song> getSongOfFavorite() {
		return songOfFavorite;
	}
	public void setSongOfFavorite(List<Song> songOfFavorite) {
		this.songOfFavorite = songOfFavorite;
	}
	
}
