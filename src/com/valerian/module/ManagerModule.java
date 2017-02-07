package com.valerian.module;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;

import com.valerian.bean.Manager;


@IocBean
@Ok("raw:json")
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

}
