<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.min.css">
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
			 $("#tar").text(a.target);
			 $("#tar").val(a.target);
			  $("#tea").text(a.contacts);
			 $("#tea").val(a.contacts);
			 console.log(a.target);
			
			 $('.selectpicker').selectpicker({
                'selectedText': 'cat'
            });
			
			//回显团队成员
			var users=${fns:toJson(cases.team)};
			if(users){
				console.log(users);
				var oldnumber = users.split(",");
				console.log(oldnumber);

			    //$('.teamMans selectpicker').text(teamMan);
			     //$(".pull-left").text(teamMan);
			    $('.selectpicker').selectpicker('val', oldnumber);//默认选中
			    $('.selectpicker').selectpicker('refresh');
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
		});

		//级联案场和房型
		function changeCases(obj){
			var option=$(obj).find("option:selected");
			var item = option.text();
			var temp = option.attr("value");
			console.log(temp);
			$("#address").val($(option[0]).attr("address"));
			
			//发送请求
			$.post('${ctx}/customer/customer/getHouses',{name:temp},function(data){
					

					console.log(data);
					
					console.log(data.typeList);
					var typeList = data.typeList;
					var teamList = data.teamList;
					 $("#target > *").remove();
					for(var i=0;i<typeList.length;i++){
						var t = $("<option value="+typeList[i]+" >"+typeList[i]+"</option>")
						$("#target").append(t);
						
					}
					
					$("#contacts > *").remove();
					for(var j=0;j<teamList.length;j++){
						var e = $("<option value="+teamList[j]+" >"+teamList[j]+"</option>")
						$("#contacts").append(e);
						
					} 
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
						<td align="right"><span class="star">*</span>案场位置：</td>
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
									<option value="${cases.name}" address = "${cases.address}" >${cases.name}</option>
								</c:forEach> 
							</form:select>
							
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span>目标户型：</td>
						<td>
							
							<form:select  path="target" class="form-control required" multiple="" >
								<option id="tar" value=" "></option>										
								
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
						<td align="right"><span class="star">*</span>置业顾问：</td>
						<td>
							<!-- <form:input path="contacts" htmlEscape="false" maxlength="64" class="form-control required"/> -->
							<!-- <form:select path="contacts" class="form-control selectpicker" multiple="true" data-live-search="true">
									<form:options items="${fns:fundUsers()}" itemLabel="name" itemValue="name" htmlEscape="false"/>
								</form:select>	 -->	
							<form:select  path="contacts" class="form-control required" multiple="" >
								<option id="tea" value=" "></option>										
								
							</form:select>	
						</td>
					</tr>
					<tr>	
						<td align="right"><span class="star">*</span>置业顾问电话：</td>
						<td>
							<form:input path="phone" htmlEscape="false" maxlength="11" class="form-control required"/>
						</td>
					</tr>
					
					<tr>
						<td align="right"><span class="star">*</span>邮箱：</td>
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
					
					
	 	</tbody>
	 	
	
	</table>
	</div>
	</form:form>
</body>
</html>