package com.valerian.bean;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("t_book")
public class Book {
	
	
	@Id
	private int book_no;
	@Column
	private String book_name;
	@Column
	private String clazz;
	@Column
	private String clc;
	@Column
	private Date entry_date;
	@Column
	private int price;
	@Column
	private String author;
	@Column
	private int gross;
	@Column
	private int inlib;
	@Column
	private int room;
	@Column
	private int bookcase;
	@Column
	private int row;
	@Column
	private int colum;
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
	public String getClazz() {
		return clazz;
	}
	public void setClazz(String clazz) {
		this.clazz = clazz;
	}
	public String getClc() {
		return clc;
	}
	public void setClc(String clc) {
		this.clc = clc;
	}
	public Date getEntry_date() {
		return entry_date;
	}
	public void setEntry_date(Date entry_date) {
		this.entry_date = entry_date;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getGross() {
		return gross;
	}
	public void setGross(int gross) {
		this.gross = gross;
	}
	public int getInlib() {
		return inlib;
	}
	public void setInlib(int inlib) {
		this.inlib = inlib;
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public int getBookcase() {
		return bookcase;
	}
	public void setBookcase(int bookcase) {
		this.bookcase = bookcase;
	}
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public int getColum() {
		return colum;
	}
	public void setColum(int colum) {
		this.colum = colum;
	}

}
