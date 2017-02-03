package com.valerian.util;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class Date_ymd {

	private Date date;
	private GregorianCalendar gregorianCalendar;
	private int year;
	private int month;
	private int day;

	public Date_ymd(int year, int month, int day) {

		this.year = year;
		this.month = month;
		this.day = day;
	}

	public Date getDate() {
		gregorianCalendar = new GregorianCalendar();
		date = new Date();
		gregorianCalendar.set(Calendar.YEAR, year);
		gregorianCalendar.set(Calendar.MONTH, month - 1);
		gregorianCalendar.set(Calendar.DAY_OF_MONTH, day);
		date = gregorianCalendar.getTime();
		return date;
	}

}
