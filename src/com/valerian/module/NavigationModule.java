package com.valerian.module;

import javax.servlet.http.HttpSession;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;

import com.valerian.bean.Manager;
import com.valerian.bean.Reader;
import com.valerian.bean.TypeReturn;


@IocBean
@Ok("raw:json")
public class NavigationModule {
	
	@Inject
	protected Dao dao;

	@At
	public Object readerLogin(@Param("id") int id, @Param("password") String password,
			@Param("optionsRadios") String type, HttpSession session) {
		if (type.equals("student")) {
			Reader reader = dao.fetch(Reader.class, Cnd.where("r_StuNo", "=", id).and("r_password", "=", password));
			if (reader == null) {
				return false;
			} else {
				session.setAttribute("user", reader.getR_name());
				session.setAttribute("id", reader.getR_StuNo());
				TypeReturn tr = new TypeReturn();
				tr.setType("student");
				Object ob = Json.toJson(tr);
				return ob;
			}
		} else if (type.equals("manager")) {
			Manager manager = dao.fetch(Manager.class, Cnd.where("m_jobNo", "=", id).and("passwd", "=", password));
			if (manager == null) {
				return false;
			} else {
				session.setAttribute("user", manager.getM_name());
				session.setAttribute("id", manager.getM_jobNo());
				TypeReturn tr = new TypeReturn();
				tr.setType("manager");
				Object ob = Json.toJson(tr);
				return ob;
			}
		} else {
			return false;
		}

	}
	
	@At
	@Ok(">>:/")
	public void logout(HttpSession session){
		session.invalidate();
	}
	
	@At
	public Object regist(@Param("id_regist") int id, @Param("name_regist") String name,
			@Param("password_regist") String passwd, @Param("password_repeat") String repeat, HttpSession session) {
		
		//判断两次密码是否输入的一样
		if (!(passwd.equals(repeat))) {
			return false;
		}
		
		Reader reader = new Reader();
		Reader reader_regist = new Reader();
		reader = dao.fetch(Reader.class, Cnd.where("r_StuNo", "=", id));
		// 判断是否已被注册
		if (reader != null) {
			return false;
		}else{
			reader_regist.setR_StuNo(id);
			reader_regist.setR_name(name);
			reader_regist.setR_password(passwd);
			dao.insert(reader_regist);
			return true;
		}
	}

	@At
	@Ok("jsp:pages.recommendation")
	public void recommendation() {
	}

	@At
	@Ok("jsp:pages.comments")
	public void forum() {
	}

	@At
	@Ok("jsp:pages.question")
	public void question() {
	}

	@At
	@Filters(@By(type=CheckSession.class, args={"id", "/"}))
	@Ok("jsp:pages.student")
	public void student(HttpSession session){
	}
	
	@At
	@Filters(@By(type=CheckSession.class, args={"id", "/"}))
	@Ok("jsp:pages.manager")
	public void manager(HttpSession session){
	}
	
}
