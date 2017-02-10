package com.valerian.bean;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("t_lend")
public class Lend {

	@Id
	private int lend_no;
	@Column
	private int stu_no;
	@Column
	private int book_no;
	@Column
	private Date lend_time;

	public int getLend_no() {
		return lend_no;
	}

	public void setLend_no(int lend_no) {
		this.lend_no = lend_no;
	}

	public int getStu_no() {
		return stu_no;
	}

	public void setStu_no(int stu_no) {
		this.stu_no = stu_no;
	}

	public int getBook_no() {
		return book_no;
	}

	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}

	public Date getLend_time() {
		return lend_time;
	}

	public void setLend_time(Date lend_time) {
		this.lend_time = lend_time;
	}

}
