package com.valerian.module;

import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.mvc.annotation.At;

@At("sysManager")
public class SystemManagerModule {
	
	@Inject
	protected Dao dao;
	
	
	
}
