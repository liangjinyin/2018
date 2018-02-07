<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
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
			var a = ${fns:toJson(customer)};
			 $("#houses").val(a.houses);
			 $("#target").val(a.target);
			
			 
			

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

		//级联案场和房型
		function changeCases(obj){
			var option=$(obj).find("option:selected");
			var item = option.text();
			var temp = option.attr("value");
			console.log(temp);
			
			//发送请求
			$.post('${ctx}/customer/customer/getHouses',{name:temp},function(data){

					console.log(data[0].type);
			 });
		}


	</script>
	<style type="text/css">
		.star{
			color:red;
		}
	</style>
</head>
<body class="pop-window">
	<form:form id="inputForm" modelAttribute="customer" action="${ctx}/customer/customer/save" method="post">
	<form:hidden path="id"/>
	<sys:message content="${message}" hideType="3"/>
	<div class="ibox-content" style="border: none;overflow: hidden;" id="container">
	<table class="table">
		
	   		<tbody>
	   		
					<tr>
						<td align="right"><span class="star">*</span>客户名称：</td>
						<td>	
							<form:input path="name" htmlEscape="false" maxlength="64" class="form-control required"/>
						</td>	
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>来源方式：</td>
						<td>
							<form:select path="way" class="form-control required">
								
								<form:options items="${fns:getDictList('way')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>客户地址：</td>
						<td>
							<form:input path="address" htmlEscape="false" maxlength="64" class="form-control required"/>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>当前楼盘：</td>
						<td>
							<form:select  path="houses" class="form-control required" multiple="" onchange="changeCases(this)">
								<option id="houses" value=" "></option>										
								<c:forEach  items="${casesList}" var="cases"  varStatus="status">
									<option value="${cases.name}" >${cases.name}</option>
								</c:forEach>
							</form:select>
							
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>目标户型：</td>
						<td>
							<c:set var="housesList" value=""></c:set>
							<form:select  path="target" class="form-control required" multiple="" >
								<option id="target" value=" "></option>										
								<c:forEach  items="${housesList}" var="houses"  varStatus="status" >
									<option value="${houses.type}" >${houses.type}</option>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>	
						<td align="right"><span class="star">*</span>所属行业：</td>
						<td>
							<form:input path="industry" htmlEscape="false" maxlength="64" class="form-control required"/>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>联系人：</td>
						<td>
							<form:input path="contacts" htmlEscape="false" maxlength="64" class="form-control required"/>
						</td>
					</tr>
					<tr>	
						<td align="right"><span class="star">*</span>联系人电话：</td>
						<td>
							<form:input path="phone" htmlEscape="false" maxlength="11" class="form-control required"/>
						</td>
					</tr>
					
					<tr>
						<td align="right"><span class="star">*</span>公司网址：</td>
						<td>
							<form:input path="url" htmlEscape="false" maxlength="200" class="form-control required"/>
						</td>
					</tr>
					<tr>	
						<td align="right"><span class="star">*</span>客户状态：</td>
						<td>
								
							 <%-- <form:radiobuttons path="status" items="${map }"/>  --%>
							<form:radiobutton path="status" value="潜在客户" label="潜在客户"/>					
							<form:radiobutton path="status" value="正在跟进客户" label="正在跟进客户"/>					
							<form:radiobutton path="status" value="已成交客户" label="已成交客户"/>							
						</td>
					</tr>
					
					<tr>
						<td align="right"><span class="star">*</span>项目所属区域：</td>
						<td><form:input path="projectBelong" htmlEscape="false" maxlength="1024" class="form-control required"/></td>
							
					</tr>
	 	</tbody>
	 	
	
	</table>
	</div>
	</form:form>
</body>
</html>