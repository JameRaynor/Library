package com.valerian.module;

import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.filter.CheckSession;

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

}
