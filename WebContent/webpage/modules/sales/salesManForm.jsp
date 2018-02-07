<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>销售人员管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }

		  return false;
		}
		$(document).ready(function() {
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});

		});
	</script>
</head>
<body class="pop-window">
	<form:form id="inputForm" modelAttribute="salesMan" action="${ctx}/sales/salesMan/save" method="post">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	
	<table class="table table-condensed table-inform">
		<colgroup>
			<col style="width:25%">
			<col style="width:60%">
			<col style="width:15%">
		</colgroup>
	   	<tbody>
					<tr>
						<td><span class="star">*</span>销售人名：</td>
						<td>
							<form:input path="name" htmlEscape="false" maxlength="64" class="form-control required"/>
						</td>
						<td></td>
						</tr><tr>
						<td><span class="star">*</span>销售指标：</td>
						<td>
							<form:input path="salesTarget" htmlEscape="false" class="form-control required number"/>
						</td>
					</tr>
					<tr>
						<td>所属区域：</td>
						<td>
							<form:input path="area" htmlEscape="false" maxlength="500" class="form-control "/>
						</td></tr><tr>
						<td>联系人电话：</td>
						<td>
							<form:input path="phone" htmlEscape="false" maxlength="64" class="form-control "/>
						</td>
					</tr>
	 	</tbody>
	</table>
	</form:form>
</body>
</html>