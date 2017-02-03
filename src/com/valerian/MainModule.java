package com.valerian;

import org.nutz.mvc.annotation.IocBy;
import org.nutz.mvc.annotation.Modules;
import org.nutz.mvc.annotation.SetupBy;
import org.nutz.mvc.ioc.provider.ComboIocProvider;

@SetupBy(value=MainSetup.class)
@IocBy(type=ComboIocProvider.class,args={"*js", "ioc/",
        "*anno", "com.valerian",
        "*tx"})
@Modules(scanPackage=true)
public class MainModule {
}
