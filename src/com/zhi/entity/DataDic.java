package com.zhi.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 数据字典表
 * @author 秩序员
 */
@Entity
@Table(name="sys_data_dic")
public class DataDic {
	
	private Integer ddId;
	private DataDicType dataDicType;
	private String ddValue;
	private String ddDesc;
	
	public DataDic() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	@Column(name="dd_id")
	public Integer getDdId() {
		return ddId;
	}
	public void setDdId(Integer ddId) {
		this.ddId = ddId;
	}
	@ManyToOne
	@JoinColumn(name="dd_type_id")
	public DataDicType getDataDicType() {
		return dataDicType;
	}
	public void setDataDicType(DataDicType dataDicType) {
		this.dataDicType = dataDicType;
	}
	@Column(name = "dd_value", length = 20)
	public String getDdValue() {
		return ddValue;
	}
	public void setDdValue(String ddValue) {
		this.ddValue = ddValue;
	}
	@Column(name = "dd_desc", length = 50)
	public String getDdDesc() {
		return ddDesc;
	}
	public void setDdDesc(String ddDesc) {
		this.ddDesc = ddDesc;
	}
	
}
