package com.valerian.module;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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

import com.sun.istack.internal.logging.Logger;
import com.valerian.bean.Book;
import com.valerian.bean.Config;
import com.valerian.bean.Lend;
import com.valerian.bean.Manager;
import com.valerian.bean.Student;
import com.valerian.result.LendResult;


@IocBean
@Filters(@By(type=CheckSession.class, args={"id", "/"}))
@At("manager")
public class ManagerModule {
	private static Logger logger = Logger.getLogger(ManagerModule.class); 
		
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
		Config config = dao.fetch(Config.class,Cnd.where("no","=","1"));
		
		//学号、图书编号判空
		if(lend_sno.equals("")|lend_bno.equals("")){
			LendResult lr = new LendResult();
			lr.setSuccess("请同时输入图书编号和学号");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
			return nm;
		}
		
		//查询数据库
		Student stu = dao.fetch(Student.class,Cnd.where("r_Stuno","=",lend_sno));
		Book book = dao.fetch(Book.class,Cnd.where("book_no","=",lend_bno));
		
		//查询学生与对应的书目是否存在
		if(stu==null){
			LendResult lr = new LendResult();
			lr.setSuccess("该学生不存在！");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
			return nm;
		}
		if(book==null){
			LendResult lr = new LendResult();
			lr.setSuccess("该图书不存在！");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
			return nm;
		}
		
		//判断学生借阅数量是否未超过限制
		if(stu.getR_borrow()>=config.getBooksLimit()){
			LendResult lr = new LendResult();
			lr.setSuccess("该学生借阅数量超过限制");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
			return nm;
		}
		
		//判断学生是否已经借阅了本书目
		Lend lendDone = dao.fetch(Lend.class,Cnd.where("stu_no","=",stu.getR_StuNo()).and("book_no","=",book.getBook_no()));
		if(lendDone!=null){
			LendResult lr = new LendResult();
			lr.setSuccess("该学生已借阅本书");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
			return nm;
		}
		
		//进行借出事务
		Lend lend = new Lend();
		book.setInlib(book.getInlib()-1);
		stu.setR_borrow(stu.getR_borrow()+1);
		lend.setBook_no(Integer.parseInt(lend_bno));
		lend.setStu_no(Integer.parseInt(lend_sno));
		lend.setLend_time(new Date());
    	Book b = dao.fetch(Book.class,Cnd.where("book_no","=",lend_bno));
		Trans.exec(new Atom(){
		    public void run() {
		    	if(b.getInlib()>0){
		    		dao.insert(lend);
			    	dao.update(book);
			    	dao.update(stu);
		    	}
		    }
		});
		
		//判断库存数量是否足够
    	if(b.getInlib()<=0){
    		LendResult lr = new LendResult();
			lr.setSuccess("该书馆藏数量不足");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
			return nm;
    	}
		
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
		lr.setSuccess("操作成功");
		String rData = Json.toJson(lr);
		rData = "[" + rData + "]";
		nm.put("data", Json.fromJson(rData));
		
		return nm;
	}
	
	@At
	@Ok("json")
	public Object returnBook(@Param("query_stuno")String stuNo,@Param("query_bno")String bookNo){
		
		NutMap nm = new NutMap();
		
		//学号、图书编号判空
		if(stuNo.equals("")|bookNo.equals("")){
			LendResult lr = new LendResult();
			lr.setSuccess("请同时输入图书编号和学号");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
			return nm;
		}
		
		Lend lend = dao.fetch(Lend.class,Cnd.where("stu_no","=",stuNo).and("book_no","=",bookNo));
		Student stu = dao.fetch(Student.class,Cnd.where("r_Stuno","=",stuNo));
		Book book = dao.fetch(Book.class,Cnd.where("book_no","=",bookNo));
		
		if(lend==null){
			LendResult lr = new LendResult();
			lr.setSuccess("该借阅记录不存在");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
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
		lr.setSuccess("还书成功！");
		lr.setLendLimit(10);
		String rData = Json.toJson(lr);
		rData = "[" + rData + "]";
		nm.put("data", Json.fromJson(rData));
		
		return nm;
	}
	
	@At
	@Ok("json")
	public Object lendQuery(@Param("query_stuno")String stuNo,@Param("query_bookno")String bookNo){
		
		NutMap nm = new NutMap();
		Lend lend;
		
		if(stuNo.equals("")&bookNo.equals("")){
			LendResult lr = new LendResult();
			lr.setSuccess("请输入图书编号或学号");
			String rData = Json.toJson(lr);
			rData = "[" + rData + "]";
			nm.put("data",Json.fromJson(rData));
			return nm;
		}
		
		

		// 如果学号图书编号均不为空
		if (!(stuNo.equals("") | bookNo.equals(""))) {
			
			Student stu = dao.fetch(Student.class, Cnd.where("r_StuNo", "=",stuNo));
			Book book = dao.fetch(Book.class, Cnd.where("book_no", "=", bookNo));
			lend = (Lend) dao.fetch(Lend.class, Cnd.where("stu_no", "=", stuNo).and("book_no", "=", bookNo));

			if (lend == null) {
				LendResult lr = new LendResult();
				lr.setSuccess("没有对应的借阅记录");
				String rData = Json.toJson(lr);
				rData = "[" + rData + "]";
				nm.put("data", Json.fromJson(rData));
				return nm;
			} else {
				LendResult lr = new LendResult();
				lr.setSuccess("查询成功！");
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
				nm.put("data",Json.fromJson(rData));
				return nm;
			}
		}
		
		//如果图书编号为空
		if(bookNo.equals("")){

			// 判读该stuNo是否有相关借阅
			Lend lendStu = dao.fetch(Lend.class, Cnd.where("stu_no", "=", stuNo));
			if (lendStu == null) {
				LendResult lr = new LendResult();
				lr.setSuccess("该学号没有对应的借阅记录");
				String rData = Json.toJson(lr);
				rData = "[" + rData + "]";
				nm.put("data", Json.fromJson(rData));
				return nm;
			}

			logger.info("查询到相关记录，准备处理");
			int count = 0;
			Student stu = dao.fetch(Student.class, Cnd.where("r_stuno", "=", stuNo));
			List<LendResult> lendResultList = new ArrayList<LendResult>();
			List<Lend> ll = dao.query(Lend.class, Cnd.where("stu_no", "=", stuNo));
			ArrayList<Integer> li = new ArrayList<Integer>();
			for (Lend l : ll) {
				li.add(l.getBook_no());
			}
			List<Book> listBook = dao.query(Book.class, Cnd.where("book_no", "in", li));
			for (Book b : listBook) {
				Lend lendBook = dao.fetch(Lend.class,
						Cnd.where("stu_no", "=", stu.getR_StuNo()).and("book_no", "=", b.getBook_no()));
				LendResult lr = new LendResult();
				lr.setLend_time(lendBook.getLend_time());
				lr.setLendLimit(10);
				lr.setStu_no(stu.getR_StuNo());
				lr.setStu_name(stu.getR_name());
				lr.setPrice(b.getPrice());
				lr.setAuthor(b.getAuthor());
				lr.setBook_name(b.getBook_name());
				lr.setBook_no(b.getBook_no());
				lendResultList.add(count, lr);
				count++;
			}
			nm.put("data", lendResultList);
			return nm;
		}

		// 如果学生编号为空
		if (stuNo.equals("")) {
			
			//判读该bno是否有相关借阅
			Lend lendBook = dao.fetch(Lend.class, Cnd.where("book_no", "=", bookNo));
			if (lendBook == null) {
				LendResult lr = new LendResult();
				lr.setSuccess("未查询到相关记录");
				String rData = Json.toJson(lr);
				rData = "[" + rData + "]";
				nm.put("data", Json.fromJson(rData));
				return nm;
			}

			logger.info("查询到相关记录，准备处理");
			int count = 0;
			Book book = dao.fetch(Book.class, Cnd.where("book_no", "=", bookNo));
			List<LendResult> lendResultList = new ArrayList<LendResult>();
			List<Lend> ll = dao.query(Lend.class, Cnd.where("book_no", "=", bookNo));
			ArrayList<Integer> li = new ArrayList<Integer>();
			for (Lend l : ll) {
				li.add(l.getStu_no());
			}
			List<Student> ls = dao.query(Student.class, Cnd.where("r_StuNo", "in", li));
			for (Student s : ls) {
				Lend lendStu = dao.fetch(Lend.class,
						Cnd.where("stu_no", "=", s.getR_StuNo()).and("book_no", "=", book.getBook_no()));
				LendResult lr = new LendResult();
				lr.setLend_time(lendStu.getLend_time());
				lr.setLendLimit(10);
				lr.setStu_no(s.getR_StuNo());
				lr.setStu_name(s.getR_name());
				lr.setPrice(book.getPrice());
				lr.setAuthor(book.getAuthor());
				lr.setBook_name(book.getBook_name());
				lr.setBook_no(book.getBook_no());
				lendResultList.add(count, lr);
				count++;
			}
			
			nm.put("data", lendResultList);
			return nm;
		}
		
		return null;
	}
}
