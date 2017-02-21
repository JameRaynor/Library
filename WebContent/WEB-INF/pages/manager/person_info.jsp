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
	
	<title>个人信息管理</title>
	
	<script type="text/javascript">
	 $(function() {
	        $("#btn_update_save").click(function() {
	            $.ajax({
	                url : "/Library/manager/update",
	                cache: false,
	                type: "POST",
	                data:$('#form_update').serialize(),
	                error: function(request) {
	                    alert("Connection error,请检查您的网络是否正常连接");
	                },
	                dataType:"json",
	                success: function(info) {
	                    if (info == true) {
	                        alert("修改成功");
	                        location.reload();
	                    } else {
	                        alert("修改失败")
	                    }
	                }
	            });
	        });
	    });
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
		    	        	location.href="http://localhost:8080/Library/systemModule/sysManager";
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
                    <div class="col-lg-12">
                        <div class="panel panel-default bootstrap-admin-no-table-panel">
                            <div class="panel-heading">
                                <div class="text-muted bootstrap-admin-box-title">基本信息</div>
                            </div>
                            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                                <form class="form-horizontal" id="form_update">
                                    <input type="hidden" id="update_id" value="1"/>
                                    <div class="row">
                                        <div class="col-lg-12 form-group">
                                            <label class="col-lg-3 control-label" for="update_jobNo">*&nbsp;工号</label>
                                            <div class="col-lg-7">
                                                <input class="form-control" id="update_jobNo" name="update_jobNo" type="text" value="<%=httpSession.getAttribute("id")%>" readonly = "readonly">
                                                <label class="control-label" for="update_sno"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 form-group has">
                                            <label class="col-lg-3 control-label" for="update_mname">*&nbsp;姓名</label>
                                            <div class="col-lg-7">
                                                <input class="form-control" id="update_mname" name="update_mname" type="text" value="<%=httpSession.getAttribute("user")%>">
                                                <label class="control-label" for="update_sname"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 form-group">
                                            <label class="col-lg-3 control-label" for="update_password">*&nbsp;原密码</label>
                                            <div class="col-lg-7">
                                                <input class="form-control" id="update_password" name="update_password" type="password" value="">
                                                <label class="control-label" for="update_password"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 form-group">
                                            <label class="col-lg-3 control-label" for="update_password_new">*&nbsp;新密码</label>
                                            <div class="col-lg-7">
                                                <input class="form-control" id="update_password_new" name="update_password_new" type="password" value="">
                                                <label class="control-label" for="update_password_new"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 form-group">
                                            <label class="col-lg-3 control-label" for="update_password_confirm">*&nbsp;确认密码</label>
                                            <div class="col-lg-7">
                                                <input class="form-control" id="update_password_confirm" name="update_password_confirm" type="password" value="">
                                                <label class="control-label" for="update_password_confirm"></label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-12 form-group" style="text-align: center;">
                                            <button type="button" class="btn btn-lg btn-primary" id="btn_update_save" onclick="update()">保&nbsp;&nbsp;存</button>
                                        </div>
                                    </div> 
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
</div>
</body>
</html>