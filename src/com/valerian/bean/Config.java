package com.valerian.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("t_config")
public class Config {
	
	@Id
	private int no;
	@Column
	private int daysLimit;
	@Column
	private int booksLimit;

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getDaysLimit() {
		return daysLimit;
	}

	public void setDaysLimit(int daysLimit) {
		this.daysLimit = daysLimit;
	}

	public int getBooksLimit() {
		return booksLimit;
	}

	public void setBooksLimit(int booksLimit) {
		this.booksLimit = booksLimit;
	}

}
