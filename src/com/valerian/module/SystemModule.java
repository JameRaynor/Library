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

import com.valerian.bean.Config;
import com.valerian.bean.Manager;
import com.valerian.bean.Student;
import com.valerian.result.ConfigResult;
import com.valerian.result.SysManagerResult;
import com.valerian.result.SysStuResult;


@IocBean
@Filters(@By(type=CheckSession.class, args={"id", "http://localhost:8080/Library/"}))
@At("systemModule")
@Ok("json")
public class SystemModule {
	
	@Inject
	Dao dao;
	
	@At
	@Ok("jsp:pages.systemManager.sysManager")
	public void sysManager(){
	}
	
	@At
	@Ok("jsp:pages.systemManager.manager")
	public void manager(){
	}

	@At
	@Ok("jsp:pages.systemManager.student")
	public void student(){
	}
	
	@At
	@Ok("jsp:pages.systemManager.systemConfig")
	public void systemConfig(){
	}
	
	@At
	public Object sign(@Param("hello") String hello, HttpSession session) {
		
		int id = (int) session.getAttribute("id");
		Manager manager = dao.fetch(Manager.class,Cnd.where("m_jobNo","=",id));
		if(manager.getM_type().equals("system")){
			return true;
		}
		return false;
	}

	@At
	public Object stuQuery(@Param("sno") String sno, @Param("sname") String sname) {

		NutMap nm = new NutMap();
		List<SysStuResult> listReturn = new ArrayList<SysStuResult>();
		Student stu = dao.fetch(Student.class, Cnd.where("r_StuNo", "=", sno).and("r_name", "=", sname));
		if (stu != null) {
			SysStuResult ssr = new SysStuResult();
			ssr.setSno(stu.getR_StuNo());
			ssr.setSname(stu.getR_name());
			ssr.setPassword(stu.getR_password());
			ssr.setSuccess("查询成功");
			listReturn.add(ssr);
			nm.put("data", listReturn);
			return nm;
		}else {
			SysStuResult ssr = new SysStuResult();
			listReturn.add(ssr);
			nm.put("data", listReturn);
			return nm;
		}
	}

	@At
	public Object stuAdd(@Param("sno") String sno, @Param("sname") String sname, @Param("password") String passwd) {
		NutMap nm = new NutMap();
		Student stu = new Student();
		stu.setR_StuNo(Integer.parseInt(sno));
		stu.setR_name(sname);
		stu.setR_password(passwd);
		dao.insert(stu);
		nm.put("success", "0");
		return nm;
	}
	
	@At
	public Object stuUpdate(@Param("sno") String sno,@Param("sname") String sname,@Param("password") String password){
		Student stu = new Student();
		stu.setR_StuNo(Integer.parseInt(sno));
		stu.setR_name(sname);
		stu.setR_password(password);
		dao.update(stu);
		return true;
	}
	
	@At
	public Object stuDelete(@Param("id") String sno){
		Student stu = new Student();
		stu.setR_StuNo(Integer.parseInt(sno));
		dao.delete(stu);
		return true;
	}
	
	@At
	public Object managerAdd(@Param("mno") String mno, @Param("mname") String mname, @Param("password") String passwd){
		Manager manager = new Manager();
		manager.setM_jobNo(Integer.parseInt(mno));
		manager.setM_name(mname);
		manager.setM_password(passwd);
		manager.setM_type("");
		dao.insert(manager);
		return true;
	}
	
	@At
	public Object managerQuery(@Param("mno") String mno, @Param("mname") String mname){
		NutMap nm = new NutMap();
		List<SysManagerResult> listReturn = new ArrayList<SysManagerResult>();
		Manager manager = dao.fetch(Manager.class,Cnd.where("m_jobNo","=",mno).and("m_name","=",mname));
		SysManagerResult smr = new SysManagerResult();
		
		//如果查询到结果
		if (manager != null) {
			smr.setMno(manager.getM_jobNo());
			smr.setMname(manager.getM_name());
			smr.setPassword(manager.getM_password());
			smr.setSuccess("查询成功");
		}
		
		listReturn.add(smr);
		nm.put("data", listReturn);
		return nm;
	}
	
	@At
	public Object managerDelete(@Param("id") String mno){
		Manager manager = new Manager();
		manager.setM_jobNo(Integer.parseInt(mno));
		dao.delete(manager);
		return true;
	}
	
	@At
	public Object managerUpdate(@Param("mno") String mno,@Param("mname") String mname,@Param("password") String password){
		Manager manager = new Manager();
		manager.setM_jobNo(Integer.parseInt(mno));
		manager.setM_type("");
		manager.setM_name(mname);
		manager.setM_password(password);
		dao.update(manager);
		return true;
	}
	
	@At
	public Object list(){
		@SuppressWarnings("unused")
		int count = 0;
		List<Config> listConfig = new ArrayList<Config>();
		List<ConfigResult> listResult = new ArrayList<ConfigResult>();
		listConfig = dao.query(Config.class, Cnd.where("1","=","1"));
		NutMap nm = new NutMap();
		
		//遍历查询到的所有的配置条目,逐一装入list中
		for(Config c : listConfig){
			ConfigResult cr = new ConfigResult();
			cr.setId(c.getNo());
			cr.setName(c.getItem());
			cr.setValue(c.getValue());
			listResult.add(cr);
			count++;
		}
		
		nm.put("data", listResult);
		return nm;
	}
	
	@At
	public Object findConfig(@Param("id") String id){
		Config c = dao.fetch(Config.class,Cnd.where("no","=",Integer.parseInt(id)));
		ConfigResult cr = new ConfigResult();
		cr.setId(c.getNo());
		cr.setName(c.getItem());
		cr.setValue(c.getValue());
		return cr;
	}
	
	@At
	public Object configUpdate(@Param("id") String id,@Param("value") String value){
		Config config = dao.fetch(Config.class,Cnd.where("no","=",Integer.parseInt(id)));
		config.setValue(Integer.parseInt(value));
		dao.update(config);
		return true;
	}
}
