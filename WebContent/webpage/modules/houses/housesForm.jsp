<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>房型管理</title>
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

			var a = ${fns:toJson(houses)};
			console.log(a);
			 $("#cases").val(a.cases);

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

	<style type="text/css">
		.star{
			color:red;
		}

		.bian{
			margin: 20px;
			border: 1px solid #DDDFE2; 
		}
	</style>
</head>
<body>
<div class="bian">	
		<form:form id="inputForm" modelAttribute="houses" action="${ctx}/houses/houses/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">数目：</label></td>
					<td class="width-35">
						<div class="input-group">
						<form:input path="num" htmlEscape="false" maxlength="64" class="form-control "/>
						<span class="input-group-addon">套</span>
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">房价：</label></td>
					<td class="width-35">
						<div class="input-group">
						<form:input path="price" htmlEscape="false" maxlength="64" class="form-control "/>
						<span class="input-group-addon">万</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">房子类型：</label></td>
					<td class="width-35">
						<form:input path="type" htmlEscape="false" maxlength="64" class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">面积：</label></td>
					<td class="width-35">
						<div class="input-group">
						<form:input path="area" htmlEscape="false" maxlength="64" class="form-control "/>
						<span class="input-group-addon">㎡</span>
						</div>
					</td>
				</tr>
				
		  		<tr>
					<td class="width-15 active"><label class="pull-right">剩余数量：</label></td>
					<td class="width-35">
						<form:input path="spare" htmlEscape="false" maxlength="64" class="form-control " readonly="true"/>
					</td>
					<td class="width-15 active"><label class="pull-right">所属楼盘：</label></td>
					<td class="width-35">
						<form:select  path="cases" class="form-control required" multiple="" >
								<option id="ast" value=" "></option>										
								<c:forEach items="${casesList}" var="cases"  varStatus="status">
									<option value="${cases.name}" >${cases.name}</option>
								</c:forEach>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">备注信息：</label></td>
					<td class="width-85">
						<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control " size="80"/>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
	</div>
</body>
</html>