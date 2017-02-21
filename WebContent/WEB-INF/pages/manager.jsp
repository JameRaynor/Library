<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="author" content="by valerian">
	
	<!-- 导入bootstrap和jQuery -->
	<link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="/Library/plugins/css/bootstrap-admin-theme.css">
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<title>乐图library管理系统</title>
	
	<script type="text/javascript">
	function sign() {
		$.ajax({
    	    url : "http://localhost:8080/Library/systemModule/sign",
    	    type : "POST",
    	    data: {
    	    	"hello":"hello"
    	    },
    	    error: function(request) {
    	        alert("Connection error");
    	    },
    	    dataType:"json",
    	    success: function(data) {
    	        if (data == true) {
    	        	location.href="systemModule/sysManager";
    	        } else {
    	            alert("您没有足够的权限！");
    	        }
    	    }
    	});
	}
	</script>
</head>
<body style="padding-top: 0px;">
	<nav class="navbar navbar-inverse" role="navigation">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="col-lg-offset-1">
						<a class="navbar-brand" href="/Library"><strong>乐图library</strong></a>
					</div>
					<div class="col-lg-offset-10">
					<ul class="nav navbar-nav">
						<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					<%
				  	  HttpSession httpSession = request.getSession();
				    %>
					欢迎，<%=httpSession.getAttribute("user")%>
					<b class="caret"></b>
				</a>
				<ul class="dropdown-menu">
					<li class="divider"></li>
					<li><a href="/Library/manager/person_info"><strong>个人资料管理</strong></a></li>
					<li class="divider"></li>
					<li onclick="sign()"><a><strong>系统设置管理</strong></a></li>
					<li class="divider"></li>
					<li><a href="/Library/logout"><strong>退出乐图系统</strong></a></li>
				</ul>
			</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<br><br><br>
<div class="container">
    <div class="row">
        <div class="col-md-2 bootstrap-admin-col-left">
            <ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
                <li>
                    <a href="/Library/manager/manage" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right" ></i> 图书管理</a>
                </li>
                <li>
                    <a href="/Library/manager/lend" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right"></i> 图书借阅</a>
                </li>
                <li>
                    <a href="/Library/manager/query" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right" ></i> 借阅查询</a>
                </li>
                <li>
                    <a href="/Library/manager/returning" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right" ></i> 图书归还</a>
                </li>
            </ul>
        </div>
        
        <!-- content -->
        <div class="col-md-10" style="font-size: medium;">
            <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="text-muted bootstrap-admin-box-title">图书管理</div>
                            </div>
                            <div class="bootstrap-admin-panel-content">
                                <ul>
                                    <li>根据图书编号、图书名称查询图书基本信息</li>
                                    <li>添加、修改、删除图书</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="text-muted bootstrap-admin-box-title">图书借阅</div>
                            </div>
                            <div class="bootstrap-admin-panel-content">
                                <ul>
                                    <li>根据学号、图书编号借阅图书</li>
                                    <li>展示此学号的借阅信息</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="text-muted bootstrap-admin-box-title">借阅查询</div>
                            </div>
                            <div class="bootstrap-admin-panel-content">
                                <ul>
                                    <li>显示某学生的图书借阅信息</li>
                                    <li>显示某种书的借阅情况</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="text-muted bootstrap-admin-box-title">图书归还</div>
                            </div>
                            <div class="bootstrap-admin-panel-content">
                                <ul>
                                    <li>根据学号和图书编号归还图书</li>
                                </ul>
                                <br>
                            </div>
                        </div>
                    </div>
               </div>
        </div>
    </div>
</div>
</body>
</html>