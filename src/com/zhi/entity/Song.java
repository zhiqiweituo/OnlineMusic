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
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="t_song")
public class Song {
	private Integer songId;
	private String songName;
	private String location;
	private String songLanguage;
	private String songStyle;
	private Singer singer;
	
	private List<User> userList=new ArrayList<User>(); //一首歌曲可以被多个用户所收藏
	
	private Admin admin; //一首歌曲被某一个管理员所上传
	
	public Song() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	@Column(name="song_id")
	public Integer getSongId() {
		return songId;
	}
	public void setSongId(Integer songId) {
		this.songId = songId;
	}
	@Column(name="song_name",length=30)
	public String getSongName() {
		return songName;
	}
	public void setSongName(String songName) {
		this.songName = songName;
	}
	@Column(name="location",length=100)
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	@Column(name="song_language",length=30)
	public String getSongLanguage() {
		return songLanguage;
	}
	public void setSongLanguage(String songLanguage) {
		this.songLanguage = songLanguage;
	}
	@Column(name="song_style",length=30)
	public String getSongStyle() {
		return songStyle;
	}
	public void setSongStyle(String songStyle) {
		this.songStyle = songStyle;
	}
	@ManyToOne
	@JoinColumn(name="singer_id")
	public Singer getSinger() {
		return singer;
	}
	public void setSinger(Singer singer) {
		this.singer = singer;
	}
	@ManyToMany
	@JoinTable(name="favorite_user_song",
			joinColumns={@JoinColumn(name="user_no")},
			inverseJoinColumns={@JoinColumn(name="song_id")})
	public List<User> getUserList() {
		return userList;
	}
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}
	@ManyToOne
	@JoinColumn(name="admin_no")
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	
}
