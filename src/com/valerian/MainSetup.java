package com.valerian;

import org.nutz.dao.Dao;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.Ioc;
import org.nutz.mvc.NutConfig;
import org.nutz.mvc.Setup;

import com.valerian.bean.Manager;
import com.valerian.util.Date_ymd;

public class MainSetup implements Setup{

	@Override
	public void init(NutConfig config) {
		Ioc ioc = config.getIoc();
		Dao dao = ioc.get(Dao.class);
		/*
		 * 批量建表，扫描com.valerian下的每个bean，为每一个注解上@Table的bean建表，
		 * false表示如果有表则忽略此步操作，如若改为true而数据库中有同名的表，表会被覆盖
		 */
		Daos.createTablesInPackage(dao, "com.valerian", false);
		
		if (dao.count(Manager.class) == 0) {
			Date_ymd ymd;
			Manager manager = new Manager();

			manager.setM_jobNo(0);
			manager.setM_name("valerian");
			manager.setM_sex("男");
			manager.setM_dapartment("tech");
			manager.setM_type("system");
			ymd = new Date_ymd(1995, 3, 30);
			manager.setM_birth(ymd.getDate());
			ymd = new Date_ymd(2016, 9, 24);
			manager.setM_entry(ymd.getDate());
			manager.setM_password("valerian3690166");
			manager.setM_id(1021935579);
			dao.insert(manager);
		}
	}
	
	@Override
	public void destroy(NutConfig arg0) {
		
	}

}
