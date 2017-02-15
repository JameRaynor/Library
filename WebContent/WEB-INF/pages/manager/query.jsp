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
	<link rel="stylesheet" href="/Library/plugins/css/jquery.dataTables.min.css">
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/Library/plugins/js/jquery.dataTables.min.js"></script>
	<script src="/Library/plugins/js/date_formate.js"></script>

	<title>借阅查询</title>
	
	<script type="text/javascript">
		
		var table;
		
		$(function () {
			table = $('#data_list').DataTable({
				"info": false,
				"paging": false,
				"searching": false,
				
				"fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
					if(aData.success!="0"){
						alert(aData.success);
					}
		        },
				
				"ajax" : {
		            "url": "/Library/manager/lendQuery",
		            "type": "POST",
		            "data": function (d) {
		                return {
		                	"query_stuno" : $('#query_stuno').val(),
		                    "query_bookno" : $('#query_bookno').val()
		                };
		            }
		        },
		        "columns": [
		            {"data": "book_no"},
		            {"data": "book_name"},
		            {"data": "author"},
		            {"data": "price"},
		            {"data": "stu_no"},
		            {"data": "stu_name"},
		            {"data": null},
		            {"data": null},
		            {"data": "lend_no"}
		        ],
		        "columnDefs": [
							{
							    targets: 6,
							    render: function (a, b, c, d) {
							        return (new Date(c.lend_time)).format('yyyy-MM-dd');
							    }
							},
							{
							    targets: 7,
							    render: function (a, b, c, d) {
							    	lendLimit = c.lendLimit;
							        return (new Date(convertDateFromString(c.lend_time).getTime()+lendLimit*24*3600*1000)).format('yyyy-MM-dd');
							    }
							}
		                 ]
		    });
		 });	
		
		function query() {
		    table.ajax.reload();
		}
		
		function convertDateFromString(dateString) { 
			if (dateString) { 
			var arr1 = dateString.split(" "); 
			var sdate = arr1[0].split('-'); 
			var date = new Date(sdate[0], sdate[1]-1, sdate[2]); 
			return date;
			} 
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
					<li><a href="/Library/sysManager/sign"><strong>系统设置管理</strong></a></li>
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
                <li  class="active">
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
                            <div class="text-muted bootstrap-admin-box-title">查询</div>
                        </div>
                        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                            <form class="form-horizontal">
                                <div class="row">
                                    <div class="col-lg-5 form-group">
                                        <label class="col-lg-4 control-label" for="query_stuno">学号</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="query_stuno" type="text" value="">
                                            <label class="control-label" for="query_stuno" style="display: none;"></label>
                                        </div>
                                    </div>
                                    <div class="col-lg-5 form-group">
                                        <label class="col-lg-4 control-label" for="query_bookno">图书编号</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="query_bookno" type="text" value="">
                                            <label class="control-label" for="query_bookno" style="display: none;"></label>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 form-group">
                                        <button type="button" class="btn btn-primary" id="btn_query" onclick="query()">查询</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        	<div class="row">
                <div class="col-lg-12">
                    <table id="data_list" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>图书编号</th>
                            <th>图书名称</th>
                            <th>作者</th>
                            <th>价格</th>
                            <th>学生学号</th>
                            <th>学生姓名</th>
                            <th>借阅日期</th>
                            <th>应还日期</th>
                            <th>超期</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>