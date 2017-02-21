package com.valerian.module;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;

import com.valerian.bean.Book;
import com.valerian.bean.Lend;
import com.valerian.bean.Student;
import com.valerian.result.LendResult;

@IocBean
@Ok("raw:json")
@Filters(@By(type=CheckSession.class, args={"id", "/"}))
@At("reader")
public class ReaderModule {
	
	@Inject 
	Dao dao;
	
	@At
	@Ok("jsp:pages.student.book")
	public void book(){
	}
		
	@At
	@Ok("jsp:pages.student.borrow")
	public void borrow(){
	}
	
	@At
	@Ok("jsp:pages.student.person_info")
	public void person_info(){
	}
	
	@At
	public Object update(@Param("update_sno") String stu_no, @Param("update_sname") String stu_name,
			@Param("update_password") String origin_passwd, @Param("update_password_new") String new_passwd,
			@Param("update_password_confirm") String confirm_passwd) {

		Student reader = dao.fetch(Student.class,
				Cnd.where("r_StuNo", "=", stu_no).and("r_password", "=", origin_passwd));
		if (reader == null) {
			return false;
		}

		if (!new_passwd.equals(confirm_passwd)) {
			return false;
		}
		
		reader.setR_password(new_passwd);
		dao.update(reader);
		
		return true;
	}
	
	@At
	@Ok("json")
	public Object borrowInfo(HttpSession session){
		@SuppressWarnings("unused")
		int count = 0;
		int id =  (int) session.getAttribute("id");
		NutMap nm = new NutMap();
		Student stu = dao.fetch(Student.class,Cnd.where("r_StuNo","=",id));
		List<LendResult> listResult = new ArrayList<LendResult>();
		List<Lend> listLend = new ArrayList<Lend>();
		listLend = dao.query(Lend.class, Cnd.where("stu_no","=",id));
		for(Lend l : listLend){
			Book book = dao.fetch(Book.class,Cnd.where("book_no","=",l.getBook_no()));
			LendResult lr = new LendResult();
			lr.setAuthor(book.getAuthor());
			lr.setBook_no(book.getBook_no());
			lr.setBook_name(book.getBook_name());
			lr.setLend_time(l.getLend_time());
			lr.setLendLimit(10);
			lr.setPrice(book.getPrice());
			lr.setStu_name(stu.getR_name());
			lr.setStu_no(stu.getR_StuNo());
			listResult.add(lr);
			count++;
		}
		nm.put("data", listResult);
		return nm;
	}
}
