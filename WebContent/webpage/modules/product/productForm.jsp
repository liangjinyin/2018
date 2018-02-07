<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>产品管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

		// $.post('${ctx}/product/product/listIterater',function(data){	 });
		var pid = ${fns:getProductId()};
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			
			 if(pid=="0"){
				
				$("#pid").val("P1");
			}else{
				$("#pid").val("P"+(pid+1));
			}  
			
			$("#name").blur(function(){
				var name = $("#name").val();
				console.log(name);	
				if(name){
					$.post('${ctx}/product/product/getProductName',function(data){
 						console.log(data.productName);
 						$.each(data.productName,function(i,product){
 							if(name==product.name){
 								
 							/* 	alert("该产品已经存在！");
 							 top.document.location.href = "${ctx}";
 								//window.history.back(); */
 								top.layer.alert('该产品已经存在!(3秒后跳回主页!)',{icon:0,title:'警告'});
 								window.setTimeout("top.document.location.href = '${ctx}'",3000);
 								/* top.document.location.href = "${ctx}"; */
 							}
 						});
 						
 					});
				}
			});

			
			
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
	</style>
</head>
<body  class="pop-window">

		
		<form:form id="inputForm" modelAttribute="product" action="${ctx}/product/product/save" method="post" >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table">
		   <tbody>
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>产品名称:</label></td>
					<td >
						<form:input id="name" path="name"  htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
			
				<tr>	
					<td ><label class="pull-right"><span class="star">*</span>产品代号:</label></td>
					<td >
						<form:input id="pid" path=""  htmlEscape="false" maxlength="64" class="form-control required" readonly="true"/>
					</td>
				</tr>
			
				<tr>	
					<td ><label class="pull-right"><span class="star">*</span>产品负责人:</label></td>
					<td >
						<form:input path="proManager" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
			
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>测试负责人:</label></td>
					<td>
						<form:input path="testManager"  htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>发布负责人:</label></td>
					<td >
						<form:input path="issueManager"  htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
			
				
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>产品状态:</label></td>
					<td >
						<form:select path="status" class="form-control required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('pro_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
			
				<tr>	
					<td ><label class="pull-right"><span class="star">*</span>产品类型:</label></td>
					<td >
						<form:select path="type" class="form-control required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('pro_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>产品描述:</label></td>
					<td >
						<form:textarea rows="4" path="describe" htmlEscape="false" maxlength="1024" class="form-control required"/>
					</td>
				</tr>
				<tr>	
					<td ><label class="pull-right"><span class="star">*</span>访问控制:</label></td>
					<td >
						<%-- <form:radiobuttons path="interview"  items="${fns:getDictList('interview')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/> --%>
						<form:radiobutton path="interview" value="默认设置（  有产品视图权限，即可访问）" 
											label="默认设置（  有产品视图权限，即可访问）"/>	</br>				
						<form:radiobutton path="interview" value="私有产品（ 有产品相关人员和迭代人员访问）" 
											label="私有产品（ 有产品相关人员和迭代人员访问）"/>	
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
				

</body>
</html>