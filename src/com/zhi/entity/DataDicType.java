package com.zhi.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 数据字典类别表
 * @author 秩序员
 */
@Entity
@Table(name="sys_data_dic_type")
public class DataDicType {

	private Integer ddTypeId;
	private String ddTypeName;
	private String ddTypeDesc;
	
	private List<DataDic> dataDicList=new ArrayList<DataDic>();
	
	public DataDicType() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DataDicType(String ddTypeName) {
		super();
		this.ddTypeName = ddTypeName;
	}

	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	@Column(name="dd_type_id")
	public Integer getDdTypeId() {
		return ddTypeId;
	}
	public void setDdTypeId(Integer ddTypeId) {
		this.ddTypeId = ddTypeId;
	}
	@Column(name = "dd_type_name", length = 20)
	public String getDdTypeName() {
		return ddTypeName;
	}
	public void setDdTypeName(String ddTypeName) {
		this.ddTypeName = ddTypeName;
	}
	@Column(name = "dd_type_desc", length = 50)
	public String getDdTypeDesc() {
		return ddTypeDesc;
	}
	public void setDdTypeDesc(String ddTypeDesc) {
		this.ddTypeDesc = ddTypeDesc;
	}
	@OneToMany(mappedBy="dataDicType",fetch=FetchType.EAGER)
	public List<DataDic> getDataDicList() {
		return dataDicList;
	}
	public void setDataDicList(List<DataDic> dataDicList) {
		this.dataDicList = dataDicList;
	}
	
}
