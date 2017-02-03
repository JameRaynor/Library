package com.valerian.bean;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("t_reader")
public class Reader {
	
	@Id
	private int r_StuNo;
	@Column
	private String r_name;
	@Column("sex")
	private String r_sex;
	@Column("birth")
	private Date r_birth;
	@Column("entry")
	private Date r_entry;
	@Column("id_no")
	private int r_id;
	@Column("passwd")
	private String r_password;
	@Column("clazz")
	private String r_clazz;
	@Column("borrow")
	private String r_borrow;

	public int getR_StuNo() {
		return r_StuNo;
	}

	public void setR_StuNo(int r_StuNo) {
		this.r_StuNo = r_StuNo;
	}

	public String getR_name() {
		return r_name;
	}

	public void setR_name(String r_name) {
		this.r_name = r_name;
	}

	public String getR_sex() {
		return r_sex;
	}

	public void setR_sex(String r_sex) {
		this.r_sex = r_sex;
	}

	public Date getR_birth() {
		return r_birth;
	}

	public void setR_birth(Date r_birth) {
		this.r_birth = r_birth;
	}

	public Date getR_entry() {
		return r_entry;
	}

	public void setR_entry(Date r_entry) {
		this.r_entry = r_entry;
	}

	public int getR_id() {
		return r_id;
	}

	public void setR_id(int r_id) {
		this.r_id = r_id;
	}

	public String getR_password() {
		return r_password;
	}

	public void setR_password(String r_password) {
		this.r_password = r_password;
	}

	public String getR_clazz() {
		return r_clazz;
	}

	public void setR_clazz(String r_clazz) {
		this.r_clazz = r_clazz;
	}

	public String getR_borrow() {
		return r_borrow;
	}

	public void setR_borrow(String r_borrow) {
		this.r_borrow = r_borrow;
	}

}
