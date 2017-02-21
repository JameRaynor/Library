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
	
	<title>欢迎使用乐图library</title>
	
	<script type="text/javascript">
	var table;
	$(function () {
	    table = $('#data_list').DataTable({
	    	"info": false,
			"paging": false,
			"searching": false,
	    	
	    	"ajax": {
	            "url": "/Library/systemModule/list",
	            "type": "POST"
	        },
	        "columns": [
	            {"data": "name"},
	            {"data": "value"},
	            {"data": null}
	        ],
	        columnDefs: [
	            {
	                targets: 2,
	                render: function (a, b, c, d) {
	                    return "<button type='button' class='btn btn-xs btn-warning' id='btn_edit' onclick='showUpdate(\"" + c.id + "\")'>修改</button>";
	                }
	            }
	        ],
	    });
	});


	function showUpdate(id) {
	    jQuery.ajax({
	        type: 'POST',
	        url: '/Library/systemModule/findConfig',
	        cache: false,
	        data: {id: id},
	        success: function (data) {
	            $('#update_id').val(data.id);
	            $('#update_name').val(data.name);
	            $('#update_value').val(data.value);
	            $('#modal_update').modal('show');
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	            showInfo("网络错误，链接失败！");
	        }
	    });
	}

	function update() {
	    var param = {
	        id: $.trim($("#update_id").val()),
	        value: $.trim($("#update_value").val())
	    }

	    jQuery.ajax({
	        type: 'POST',
	        url: '/Library/systemModule/configUpdate',
	        cache: false,
	        data: param,
	        success: function (data) {
	            if (data) {
	                $('#modal_update').modal('hide');
	                alert("操作成功！");
	                table.ajax.reload();
	            } else {
	                alert("网路故障，您的操作未被正确响应");
	            }
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	            showInfo("网络错误，链接失败！");
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
                    <a href="/Library/systemModule/student" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right" ></i> 学生管理</a>
                </li>
                <li>
                    <a href="/Library/systemModule/manager" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right"></i> 管理员管理</a>
                </li>
                 <li class="active">
                    <a href="/Library/systemModule/systemConfig" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right" ></i> 系统设置</a>
                </li>
            </ul>
        </div>
        
        <!-- content -->
        <div class="col-md-10" style="font-size: medium;">
            <div class="row">
                <div class="col-lg-12">
                    <table id="data_list" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>设置项名称</th>
                            <th>设置项值</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
           	</div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal_update" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true" data-backdrop="false">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">修改</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal" id="form_update">
                        <input type="hidden" id="update_id">
                        <div class="row">
                            <div class="col-lg-12 form-group has">
                                <label class="col-lg-3 control-label" for="update_name">*&nbsp;设置项名称</label>
                                <div class="col-lg-9">
                                    <input class="form-control" id="update_name" type="text" value="" disabled>
                                    <label class="control-label" for="update_name"></label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 form-group">
                                <label class="col-lg-3 control-label" for="update_value">*&nbsp;设置项值</label>
                                <div class="col-lg-9">
                                    <input class="form-control" id="update_value" type="text" value="">
                                    <label class="control-label" for="update_value"></label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btn_update_close" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="btn_update_save" onclick="update()">保存</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>