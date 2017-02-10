<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="author" content="by valerian">
	<title>书目查询</title>
	
	<!-- 导入bootstrap和jQuery -->
	<link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="/Library/plugins/css/bootstrap-admin-theme.css">
	<link rel="stylesheet" href="/Library/plugins/css/jquery.dataTables.min.css">
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/Library/plugins/js/jquery.dataTables.min.js"></script>
	<script src="/Library/plugins/js/date_formate.js"></script>
	
	<script type="text/javascript">
		var table;
		var locate;
		$(function () {
			table = $('#data_list').DataTable({
				"info": false,
				"paging": false,
				"searching": false,
				
				 "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
						 locate = aData;
			        },
				
				"ajax" : {
		            "url": "/Library/book/searchBook",
		            "type": "POST",
		            "data": function (d) {
		                return {
		                	"book_no" : $('#query_bno').val(),
		                    "book_name" : $('#query_bname').val()
		                };
		            }
		        },
		        "columns": [
		            {"data": "book_no"},
		            {"data": "book_name"},
		            {"data": "clc"},
		            {"data": "author"},
		            {"data": "price"},
		            {"data": "gross"},
		            {"data": "inlib"},
		            {"data": null},
		            {"data": null}
		        ],
		        "columnDefs": [
		                     {
		                         targets: 7,
		                         render: function (a, b, c, d) {
		                             return (new Date(c.entry_date)).format('yyyy-MM-dd');
		                         }
		                     },
		                     {
		                         targets: 8,
		                         render: function (a, b, c, d) {
		                             return "<button type='button' id='btn_location' class='btn btn-xs btn-success' data-toggle='modal' data-target='#location'>查看位置</button>";
		                         }
		                     }
		                 ]
		    });
			
			$('#location').on('show.bs.modal', function (e) {
				var str;
				str = locate.room+'室'+locate.bookcase+'号柜'+locate.colum+'列';
				document.getElementById("locationLabel").innerHTML = str;
				document.getElementById("columnLabel").innerHTML = "您的书由上至下位于第"+locate.colum+"排";
			});
			
			$('#location').on('shown.bs.modal', function (e) {
				var c = document.getElementById("myCanvas");
				var i = 6;
				var ctx = c.getContext("2d");
				ctx.clearRect(0,0,300,300);
				ctx.fillStyle="#FF0000";
				for(var j=0;j<=i;j++){
					if(j!=locate.colum){
						ctx.beginPath();
						ctx.lineWidth="1";
						ctx.strokeStyle="black";
						ctx.rect(0,28*j,300,28);
						ctx.stroke();
					}else{
						ctx.fillRect(0,28*locate.colum,300,28);
					}
				}
			});
			
		});
		
		
		function query() {
		    table.ajax.reload();
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
                <li class="active">
                    <a href="/Library/reader/book" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right" ></i> 图书查询</a>
                </li>
                <li>
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
                                <div class="text-muted bootstrap-admin-box-title">查询</div>
                            </div>
                            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                                <form class="form-horizontal" id="searchbook">
                                    <div class="col-lg-5 form-group">
                                        <label class="col-lg-4 control-label" for="query_bno">图书编号</label>
                                        <div class="col-lg-8">
                                            <input name="bookNo" class="form-control" id="query_bno" type="text" value="">
                                            <label class="control-label" for="query_bno" style="display: none;"></label>
                                        </div>
                                    </div>
                                    <div class="col-lg-5 form-group">
                                        <label class="col-lg-4 control-label" for="query_bname">图书名称</label>
                                        <div class="col-lg-8">
                                            <input name="bookName" class="form-control" id="query_bname" type="text" value="">
                                            <label class="control-label" for="query_bname" style="display: none;"></label>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 form-group">
                                        <button type="button" class="btn btn-primary" id="btn_query" onclick="query()">查询</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                <br>
                
                <div class="row">
                    <div class="col-lg-12">
                        <table id="data_list" class="table table-striped table-bordered" >
                            <thead>
                            <tr>
                                <th>图书编号</th>
                                <th>图书名称</th>
                                <th>分类</th>
                                <th>作者</th>
                                <th>价格</th>
                                <th>总数量</th>
                                <th>在馆数量</th>
                                <th>上架时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
    </div>
</div>

<div class="modal fade" id="location" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
	<div class="modal-dialog" role="document" style="z-index: 2500"> 
		<div class="modal-content"  style="text-align:center;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					<label id="locationLabel"></label>
				</h4>
			</div>
			<div>
				<br>
				<canvas id="myCanvas" height="220"></canvas>
				<br>
				<label id="columnLabel" style="font-size: medium;"></label>
				<br><br>
			</div>
		</div>
	</div>
</div>

</body>
</html>