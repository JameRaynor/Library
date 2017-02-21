package com.valerian.bean;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("t_manager")
public class Manager {

	@Id(auto=false)
	private int m_jobNo;
	@Column
	private String m_name;
	@Column("sex")
	private String m_sex;
	@Column("birth")
	private Date m_birth;
	@Column("entry")
	private Date m_entry;
	@Column("id_no")
	private int m_id;
	@Column("passwd")
	private String m_password;
	@Column("department")
	private String m_department;
	@Column("type")
	private String m_type;

	public int getM_jobNo() {
		return m_jobNo;
	}

	public void setM_jobNo(int m_jobNo) {
		this.m_jobNo = m_jobNo;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_sex() {
		return m_sex;
	}

	public void setM_sex(String m_sex) {
		this.m_sex = m_sex;
	}

	public Date getM_birth() {
		return m_birth;
	}

	public void setM_birth(Date m_birth) {
		this.m_birth = m_birth;
	}

	public Date getM_entry() {
		return m_entry;
	}

	public void setM_entry(Date m_entry) {
		this.m_entry = m_entry;
	}

	public int getM_id() {
		return m_id;
	}

	public void setM_id(int m_id) {
		this.m_id = m_id;
	}

	public String getM_password() {
		return m_password;
	}

	public void setM_password(String m_password) {
		this.m_password = m_password;
	}

	public String getM_dapartment() {
		return m_department;
	}

	public void setM_dapartment(String m_dapartment) {
		this.m_department = m_dapartment;
	}

	public String getM_type() {
		return m_type;
	}

	public void setM_type(String m_type) {
		this.m_type = m_type;
	}
}
