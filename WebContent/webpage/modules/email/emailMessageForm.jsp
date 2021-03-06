<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>email管理</title>
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
	<form:form id="inputForm" modelAttribute="emailMessage" action="${ctx}/email/emailMessage/save" method="post">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<table class="table table-bordered table-condensed table-inform">
		<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col style="width:35%">
		</colgroup>
	   	<tbody>
	 	</tbody>
	</table>
	</form:form>
</body>
</html>