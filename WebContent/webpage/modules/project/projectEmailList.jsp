<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务邮件信息管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.min.css">
	<script type="text/javascript">
		$(document).ready(function() {
			
			$('.selectpicker').selectpicker({
                'selectedText': 'cat'
            });
			var users=${fns:toJson(projectEmail.receiver)};
			if(users){
				console.log(users);
				var oldnumber = users.split(",");
				console.log(oldnumber);
			    $('.selectpicker').selectpicker('val', oldnumber);//默认选中
			    $('.selectpicker').selectpicker('refresh');
			}
		});
		
		function doSubmit(){//回调函数，在编辑和保存动作时
			$("#inputForm").submit();
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>任务邮件信息列表 </h5>
		<div class="ibox-tools">
			<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-wrench"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#">选项1</a>
				</li>
				<li><a href="#">选项2</a>
				</li>
			</ul>
			<a class="close-link">
				<i class="fa fa-times"></i>
			</a>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	<div class="row">
	<div class="col-sm-12">
	<form:form id="inputForm" modelAttribute="projectEmail" action="${ctx}/project/projectEmail/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<table class="table table-condensed dataTables-example dataTable no-footer">
			<div class="form-group">
					<label>项目更新人员通知设置：</label>
					<form:select path="receiver" class="form-control selectpicker" multiple="true" data-live-search="true">
							<form:options items="${fns:fundUsers()}" itemLabel="name" itemValue="name" htmlEscape="false"/>
					</form:select>
			</div>			
			
				
			<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="doSubmit()" > 保存</button>
					
			</div>
		</table>
	</form:form>
	<br/>
	</div>
	</div>
	
	
	</div>
	</div>
</div>
</body>
</html>