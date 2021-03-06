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
	
	<title>借阅信息</title>
	
	<script type="text/javascript">
	
		var table;
		
		$(function () {
			table = $('#data_list').DataTable({
				"info": false,
				"paging": false,
				"searching": false,
				
				"ajax" : {
		            "url": "/Library/reader/borrowInfo",
		            "type": "POST",
		            "data": function (d) {
		                return {
		                    "hello" : "hello"
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
		            {"data": null}
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
								        return (new Date(convertDateFromString(c.lend_time).getTime()+c.lendLimit*24*3600*1000)).format('yyyy-MM-dd');
								    }
								},
								{
								    targets: 8,
								    render: function (a, b, c, d) {
								    	var outDays = ((new Date).diff(new Date(convertDateFromString(c.lend_time).getTime()+c.lendLimit*24*3600*1000)));
								  		if(outDays>0){
								  			return outDays+"天";
								  		}else{
								  			return "0天";
								  		}
								    }
								}
			                 ]
		    });
		 });
		
		function convertDateFromString(dateString) { 
			if (dateString) { 
			var arr1 = dateString.split(" "); 
			var sdate = arr1[0].split('-'); 
			var date = new Date(sdate[0], sdate[1]-1, sdate[2]); 
			return date;
			}
		}
		
		Date.prototype.diff = function(date){
			return parseInt((this.getTime() - date.getTime())/(24 * 60 * 60 * 1000));
		}
				
	</script>
</head>
<body style="padding-top: 0px">
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
					<li><a href="/Library/reader/person_info"><strong>个人资料管理</strong></a></li>
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
                    <a href="/Library/reader/book" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right" ></i> 图书查询</a>
                </li>
                <li class="active">
                    <a href="/Library/reader/borrow" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right"></i> 借阅信息</a>
                </li>
            </ul>
        </div>
   	
   	 <!-- content -->
        <div class="col-md-10">
            <div class="row">
                <div class="col-lg-12">
                <div class="panel panel-default bootstrap-admin-no-table-panel">
	                <div class="panel-heading">
	                    <div class="text-muted bootstrap-admin-box-title" style="font-size: large;">借阅信息</div>
	                </div>
                    <table id="data_list" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>图书编号</th>
                            <th>图书名称</th>
                            <th>作者</th>
                            <th>价格</th>
                            <th>学号</th>
                            <th>姓名</th>
                            <th>借阅日期</th>
                            <th>还书日期</th>
                            <th>超期天数</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
             </div>
        </div>
    </div>
</div>
</body>
</html>