<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>需求管理</title>
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


			var customer=${fns:toJson(requirements.customer)};	
          	var requirements = $(".id").val();

          	//console.log(requirements);
            //console.log(customer);
			//加载客户的信息
			 $.post('${ctx}/require/requirements/getCustomer',{id:customer},function(data){

					$("#address").val(data.address);
                    $("#industry").val(data.industry);
                    $("#projectBelong").val(data.projectBelong);
                    $("#contacts").val(data.contacts);
                    $("#phone").val(data.phone);
			 });
			
			
			
            if(customer){
				$("select[name=customer]").val(customer);
            }
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
				
			//回显销售负责人信息
			var saleManager=${fns:toJson(requirements.saleManager)};
			//console.log(saleManager);
			$("#saleManager").val(saleManager);
		});

		function changeCustomer(obj){
			var option=$(obj).find("option:selected");
			var item = option.text();
			console.log(option[0]);
			$(".phone").val($(option[0]).attr("phone"));
			$(".contacts").val($(option[0]).attr("contacts"));
			$(".address").val($(option[0]).attr("address"));
			$(".industry").val($(option[0]).attr("industry"));
			$(".projectBelong").val($(option[0]).attr("projectBelong"));
			$(".contacts").val($(option[0]).attr("contacts"));
			$(".phone").val($(option[0]).attr("phone"));
			
			if(!$(".name").val()){
				$(".name").val(item);
			}	
		}
			
	</script>
	<style type="text/css">
		.star{
			color:red;
		}
	</style>
</head>
<body class="pop-window">
	<form:form id="inputForm" modelAttribute="requirements" action="${ctx}/require/requirements/save" method="post">
	<form:hidden path="id" class="id"/>
	<sys:message content="${message}"/>

	<div class="ibox-content" style="border: none;overflow: hidden;" id="container">

	<table class="table">
		
		
	   	    <tbody>
					<tr>
						<td align="right"><span class="star">*</span>需求名称：</td>
						<td>
							<form:input path="name" htmlEscape="false" maxlength="64" class="form-control name required"/>
						</td>
					</tr>	
					<tr>	
						<td align="right"><span class="star">*</span>所属客户：</td>
						<td>
							<form:select path="customer" class="form-control required" onchange="changeCustomer(this)">
								<option value=" " contacts=""  phone=""></option>
					
								<c:forEach items="${fns:getCustomerList()}" var="custom"  varStatus="status">
									<option value="${custom.id}" contacts="${custom.contacts}" address = "${custom.address }" 
														industry = "${custom.industry }" projectBelong = "${custom.projectBelong }" 	
														 phone="${custom.phone}">${custom.name}</option>
								</c:forEach>
							</form:select>
						</td>
					</tr>	
					
					<tr>
						<td align="right">客户地址：</td>
						<td>
							 <form:input id="address" path="" htmlEscape="false" maxlength="64" class="form-control address" readonly="true"/> 
							
						</td>
					</tr>
					<tr>
						<td align="right">所属行业：</td>
						<td>
							<form:input id="industry" path="" htmlEscape="false" maxlength="64" class="form-control industry" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td align="right">需求联系人：</td>
						<td>
							<form:input  id="contacts" path="" htmlEscape="false" maxlength="64" class="form-control contacts" readonly="true"/>
						</td>
					</tr>
					<tr>	
						<td align="right">需求联系人电话：</td>
						<td>
							<form:input  id="phone" path="" htmlEscape="false" maxlength="11" class="form-control phone" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td align="right">项目所属区域：</td>
						<td>
							<form:input id="projectBelong" path="" htmlEscape="false" maxlength="64" class="form-control projectBelong" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>销售负责人：</td>
						<td>
						
						
							<form:select id="saleManager" path="saleManager" class="form-control required">
								 
								 <c:forEach items="${fns:fundSalesMans()}" var="saleManager"  varStatus="status">
									<option  value="${saleManager.name}" >${saleManager.name}</option>
								</c:forEach>
						</form:select>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>售前负责人：</td>
						<td>
							<form:input path="preSaleManager" htmlEscape="false" maxlength="64" class="form-control required"/>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>需求部门：</td>
						<td>
							<form:input path="department" htmlEscape="false" maxlength="64" class="form-control required"/>
						</td>
					</tr>
					
					
					<tr>	
						<td align="right"><span class="star">*</span>产品/服务： </td>
						<td>
							<form:select path="product" class="form-control required">
								
								<form:options items="${fns:getDictList('requirement')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>现状/瓶颈：</td>
						<td>
							<form:textarea path="situation" htmlEscape="false" rows="4" maxlength="1024" class="form-control required"/>
						</td>
					</tr>
					
					<tr>
						<td align="right"><span class="star">*</span>核心需求：</td>
						<td>
							<form:textarea path="core" htmlEscape="false" rows="4" maxlength="1024" class="form-control required"/>
						</td>
					</tr>
					<tr>	
						<td align="right"><span class="star">*</span>解决方案：</td>
						<td>
							<form:textarea path="solution" htmlEscape="false" rows="4" maxlength="1024" class="form-control required"/>
						</td>
					</tr>
					<%-- <tr>	
						<td align="right"><span class="star">*</span>状态评价：</td>
						<td>
							
							<form:checkbox class="a" path="evaluation" value="有了针对性方案" label="有了针对性方案"/>   
				            <form:checkbox class="b" path="evaluation" value="进行了二次拜访" label="进行了二次拜访"/>  </br> 
							<form:checkbox class="c" path="evaluation" value="进行了商务谈判" label="进行了商务谈判"/>   
				            <form:checkbox class="d" path="evaluation" value="达成合同几率很大" label="达成合同几率很大"/>  </br> 
							<form:checkbox class="e" path="evaluation" value="签合同几率很大" label="签合同几率很大"/>   
				            <form:checkbox class="f" path="evaluation" value="closeed" label="closeed"/>    
				            
				              <form:checkboxes items="${evaluationMap}" path="evaluation"/>  
				           
						</td>
						
					</tr> --%>
					<!-- <tr>
						<td><span class="star">*</span>所属项目：</td>
						<td>
							<form:input path="project" htmlEscape="false" maxlength="11" class="form-control required"/>
						</td>
					<td></td>
					<td></td>
					</tr> -->
					
					
	 		</tbody>
	 
	</table>

	</div>
	</form:form>
</body>
</html>