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
	var modelMno;
	var modelMname;
	$(function () {
	    table = $('#data_list').DataTable({
	    	"info": false,
			"paging": false,
			"searching": false,
			
			"fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
				if(aData.success=="查询成功"){
					alert(aData.success);
					modelMno=aData.mno;
					modelMname=aData.mname;
				}else{
					alert("请输入工号以及对应的管理员姓名！");
				}
	        },
	    	
	    	"ajax": {
	            "url": "/Library/systemModule/managerQuery",
	            "type": "POST",
	            "data": function (d) {
	                return {
	                    "mno": $('#query_mno').val(),
	                    "mname": $('#query_mname').val()
	                };
	            }
	        },
	        "columns": [
	            {"data": "mno"},
	            {"data": "mname"},
	            {"data": "password"},
	            {"data": null}
	        ],
	        columnDefs: [
	            {
	                targets: 3,
	                render: function (a, b, c, d) {
	                    return "<button type='button' class='btn btn-xs btn-warning' id='btn_edit' onclick='showUpdate()'>信息修改</button>&nbsp" +
	                        "<button type='button' class='btn btn-xs btn-danger' id='btn_del' onclick='del()'>删除</button>";
	                }
	            }
	        ],
	    });
	});
	

	function query() {
	    table.ajax.reload();
	}

	function add() {
		var param = {
	        mno: $.trim($("#add_mno").val()),
	        mname: $.trim($("#add_mname").val()),
	        password: $.trim($("#add_password").val())
	    }

	    jQuery.ajax({
	        type: 'POST',
	        url: '/Library/systemModule/managerAdd',
	        cache: false,
	        data: param,
	        success: function (data) {
	        	if(data==true){
	        		alert("添加成功！");
	        	}
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	        	alert("链接错误，请检查您的网络状况！")
	        }
	    });
	}
	
	function showAdd() {
	    $('#modal_add').modal('show');
	}	
	
	function showUpdate() {
		$('#update_mno').val(modelMno);
		$('#update_mname').val(modelMname);
		$('#modal_update').modal('show');
	}
	
	function update() {
		var param = {
		        mno: $.trim($("#update_mno").val()),
		        mname: $.trim($("#update_mname").val()),
		        password: $.trim($("#update_password").val())
		    }
		
		jQuery.ajax({
	        type: 'POST',
	        url: '/Library/systemModule/managerUpdate',
	        cache: false,
	        data: param,
	        success: function (data) {
	        	if(data==true){
	        		alert("修改成功！");
	        	}else{
	            	alert("操作失败！");
	            }
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	            showInfo("链接错误，请检查您的网络状况!");
	        }
	    });
	}

	function del() {
	    jQuery.ajax({
	        type: 'POST',
	        url: '/Library/systemModule/managerDelete',
	        cache: false,
	        data: {
	            id: modelMno
	        },
	        success: function (data) {
	            if (data==true) {
	            	alert("删除成功！");
	            }else{
	            	alert("操作失败！");
	            }
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	            showInfo("网络错误，请检查您的链接是否正常！");
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
                <li class="active">
                    <a href="/Library/systemModule/manager" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right"></i> 管理员管理</a>
                </li>
                 <li>
                    <a href="/Library/systemModule/systemConfig" style="font-size: large;"><i class="glyphicon glyphicon-chevron-right" ></i> 系统设置</a>
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
                                 <div class="col-lg-5 form-group">
                                     <label class="col-lg-4 control-label" for="query_mno">管理员编号</label>
                                     <div class="col-lg-8">
                                         <input class="form-control" id="query_mno" type="text" value="">
                                         <label class="control-label" for="query_mno" style="display: none;"></label>
                                     </div>
                                 </div>
                                 <div class="col-lg-5 form-group">
                                     <label class="col-lg-4 control-label" for="query_mname">管理员姓名</label>
                                     <div class="col-lg-8">
                                         <input class="form-control" id="query_mname" type="text" value="">
                                         <label class="control-label" for="query_mname" style="display: none;"></label>
                                     </div>
                                 </div>
                                 <div class="col-lg-2 form-group">
                                     <button type="button" class="btn btn-primary" id="btn_query" onclick="query()">查询</button>
                                     <button type="button" class="btn btn-primary" id="btn_add" onclick="showAdd()">添加</button>
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
                            <th>编号</th>
                            <th>姓名</th>
                            <th>密码</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_add" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true" data-backdrop="false">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addModalLabel">添加</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal" id="form_add">
                        <div class="row">
                            <div class="col-lg-12 form-group">
                                <label class="col-lg-3 control-label" for="add_mno">*&nbsp;工号</label>
                                <div class="col-lg-9">
                                    <input class="form-control" id="add_mno" type="text" value="">
                                    <label class="control-label" for="add_mno"></label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 form-group has">
                                <label class="col-lg-3 control-label" for="add_mname">*&nbsp;姓名</label>
                                <div class="col-lg-9">
                                    <input class="form-control" id="add_mname" type="text" value="">
                                    <label class="control-label" for="add_mname"></label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 form-group">
                                <label class="col-lg-3 control-label" for="add_password">*&nbsp;密码</label>
                                <div class="col-lg-9">
                                    <input class="form-control" id="add_password" type="text" value="">
                                    <label class="control-label" for="add_password"></label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btn_add_close" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="btn_add_save" onclick="add()">保存</button>
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
                            <div class="col-lg-12 form-group">
                                <label class="col-lg-3 control-label" for="update_mno">*&nbsp;工号</label>
                                <div class="col-lg-9">
                                    <input class="form-control" id="update_mno" type="text" value="" disabled>
                                    <label class="control-label" for="update_mno"></label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 form-group has">
                                <label class="col-lg-3 control-label" for="update_mname">*&nbsp;姓名</label>
                                <div class="col-lg-9">
                                    <input class="form-control" id="update_mname" type="text" value="">
                                    <label class="control-label" for="update_mname"></label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 form-group">
                                <label class="col-lg-3 control-label" for="update_password">*&nbsp;密码</label>
                                <div class="col-lg-6">
                                    <input class="form-control" id="update_password" type="text" value="">
                                    <label class="control-label" for="update_password"></label>
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