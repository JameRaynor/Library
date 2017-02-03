package com.valerian.module;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.valerian.bean.Book;



@IocBean
@At("book")
public class BookInfoModule {
	
	@Inject 
	protected Dao dao;
	
	@At
	@Ok("json")
	public Object searchBook(@Param("book_no") String bno, @Param("book_name") String bname) {

		NutMap nm = new NutMap();

		if (bno.equals("") & bname.equals("")) {
			nm.put("ok", "no_info");
			return nm;
		} else if (!bno.equals("")) {
			Book book = dao.fetch(Book.class, Cnd.where("book_no", "=", bno));
			if (book == null) {
				nm.put("ok", "invalid_bname");
			} else {
				System.out.println(Json.toJson(book));
				String jsonStr = Json.toJson(book);
				jsonStr = "[" + jsonStr + "]";
				nm.put("ok", "yes");
				nm.put("data", Json.fromJson(jsonStr));
			}
		} else {  
			Book book = dao.fetch(Book.class, Cnd.where("book_name", "=", bname));
			if (book == null) {
				nm.put("ok", "invalid_bno");
			} else {
				String jsonStr = Json.toJson(book);
				jsonStr = "[" + jsonStr + "]";
				nm.put("ok", "yes");
				nm.put("data", Json.fromJson(jsonStr));
			}
		}
		return nm;
	}
	
	@At
	@Ok("json")
	public Object showLocation(@Param("clc")String clc){
		return true;
	}
}
