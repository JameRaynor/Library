package com.valerian.result;

import java.util.Date;

public class LendResult {

	private int book_no;
	private String book_name;
	private String author;
	private int price;
	private int stu_no;
	private String stu_name;
	private Date lend_time;
	private int lend_no;
	private int lendLimit;

	public int getBook_no() {
		return book_no;
	}

	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}

	public String getBook_name() {
		return book_name;
	}

	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStu_no() {
		return stu_no;
	}

	public void setStu_no(int stu_no) {
		this.stu_no = stu_no;
	}

	public String getStu_name() {
		return stu_name;
	}

	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}

	public Date getLend_time() {
		return lend_time;
	}

	public void setLend_time(Date lend_time) {
		this.lend_time = lend_time;
	}

	public int getLend_no() {
		return lend_no;
	}

	public void setLend_no(int lend_no) {
		this.lend_no = lend_no;
	}

	public int getLendLimit() {
		return lendLimit;
	}

	public void setLendLimit(int lendLimit) {
		this.lendLimit = lendLimit;
	}
	
}
