package com.valerian.result;

public class SysManagerResult {
	
	private int mno;
	private String mname;
	private String password;
	private String success;
	
	public SysManagerResult(){
		this.mno=0;
		this.mname="0";
		this.success="0";
		this.password="0";
	}
	
	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

}
