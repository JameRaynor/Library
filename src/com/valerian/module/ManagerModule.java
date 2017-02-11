package com.valerian.module;

import java.util.Date;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;
import org.nutz.trans.Atom;
import org.nutz.trans.Trans;

import com.valerian.bean.Book;
import com.valerian.bean.Lend;
import com.valerian.bean.Manager;
import com.valerian.bean.Student;
import com.valerian.result.LendResult;


@IocBean
@Filters(@By(type=CheckSession.class, args={"id", "/"}))
@At("manager")
public class ManagerModule {
		
	@Inject
	Dao dao;
	
	@At
	@Ok("jsp:pages.manager.person_info")
	public void person_info(){
		
	}
	
	@At
	@Ok("jsp:pages.manager.manage")
	public void manage(){
		
	}
	
	@At
	@Ok("jsp:pages.manager.lend")
	public void lend(){
		
	}
	
	@At
	@Ok("jsp:pages.manager.query")
	public void query(){
		
	}
	
	@At
	@Ok("jsp:pages.manager.returning")
	public void returning(){
		
	}
	
	@At
	public Object update(@Param("update_jobNo") String m_jobno, @Param("update_mname") String m_name,
			@Param("update_password") String origin_passwd, @Param("update_password_new") String new_passwd,
			@Param("update_password_confirm") String confirm_passwd) {

		Manager manager = dao.fetch(Manager.class,
				Cnd.where("m_jobno", "=", m_jobno).and("passwd", "=", origin_passwd));
		
		if (manager == null) {
			return false;
		}
		
		if (!new_passwd.equals(confirm_passwd)) {
			return false;
		}
		
		manager.setM_password(new_passwd);
		dao.update(manager);
		
		return true;
	}
	
	@At
	@Ok("json")
	public Object lendout(@Param("lend_sno")String lend_sno,@Param("lend_bno")String lend_bno){
		
		
		NutMap nm = new NutMap();
		
		//学号、图书编号判空
		if(lend_sno.equals("")|lend_bno.equals("")){
			nm.put("ok", "学号或者图书编号为空");
			return nm;
		}
		
		//查询数据库
		Student stu = dao.fetch(Student.class,Cnd.where("r_Stuno","=",lend_sno));
		Book book = dao.fetch(Book.class,Cnd.where("book_no","=",lend_bno));
		
		//查询学生与对应的书目是否存在
		if(stu==null){
			nm.put("ok", "学生不存在");
			return nm;
		}
		if(book==null){
			nm.put("ok", "书目不存在");
			return nm;
		}
		
		//进行借出事务
		book.setInlib(book.getInlib()-1);
		stu.setR_borrow(stu.getR_borrow()+1);
		Lend lend = new Lend();
		lend.setBook_no(Integer.parseInt(lend_bno));
		lend.setStu_no(Integer.parseInt(lend_sno));
		lend.setLend_time(new Date());
		Trans.exec(new Atom(){
		    public void run() {
		    	dao.insert(lend);
		    	dao.update(book);
		    	dao.update(stu);
		    }
		});
		
		//将返回结果包装
		LendResult lr = new LendResult();
		lr.setBook_no(book.getBook_no());
		lr.setBook_name(book.getBook_name());
		lr.setAuthor(book.getAuthor());
		lr.setPrice(book.getPrice());
		lr.setStu_no(stu.getR_StuNo());
		lr.setStu_name(stu.getR_name());
		lr.setLend_time(lend.getLend_time());
		lr.setLend_no(lend.getLend_no());
		String rData = Json.toJson(lr);
		rData = "[" + rData + "]";
		nm.put("ok","success");
		nm.put("data", Json.fromJson(rData));
		
		return nm;
	}
	
	@At
	@Ok("json")
	public Object returnBook(@Param("query_stuno")String stuNo,@Param("query_bno")String bookNo){
		
		NutMap nm = new NutMap();
		
		//学号、图书编号判空
		if(stuNo.equals("")|bookNo.equals("")){
			nm.put("ok", "学号或者图书编号为空");
			return nm;
		}
		
		Lend lend = dao.fetch(Lend.class,Cnd.where("stu_no","=",stuNo).and("book_no","=",bookNo));
		Student stu = dao.fetch(Student.class,Cnd.where("r_Stuno","=",stuNo));
		Book book = dao.fetch(Book.class,Cnd.where("book_no","=",bookNo));
		
		if(lend==null){
			nm.put("ok", "未查询到借阅记录");
			return nm;
		}
		
		//进行还书事务
		book.setInlib(book.getInlib()+1);
		stu.setR_borrow(stu.getR_borrow()-1);
		Trans.exec(new Atom(){
		    public void run() {
		    	dao.delete(lend);
		    	dao.update(book);
		    	dao.update(stu);
		    }
		});
		
		//将返回结果包装
		LendResult lr = new LendResult();
		lr.setBook_no(book.getBook_no());
		lr.setBook_name(book.getBook_name());
		lr.setAuthor(book.getAuthor());
		lr.setPrice(book.getPrice());
		lr.setStu_no(stu.getR_StuNo());
		lr.setStu_name(stu.getR_name());
		lr.setLend_time(lend.getLend_time());
		lr.setLend_no(lend.getLend_no());
		lr.setLendLimit(10);
		String rData = Json.toJson(lr);
		rData = "[" + rData + "]";
		nm.put("ok","success");
		nm.put("data", Json.fromJson(rData));
		
		return nm;
	}
}
