<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>版本管理</title>
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
			
			//回显产品名称
			var pid=${fns:toJson(edition.product)};
			console.log(pid);
			$("#product").val(pid);
			/*if(pid){
				$.post('${ctx}/product/product/getProduct',{id:pid},function(data){
	 				//$("#product").innerHtml(data.name);
	 				//$("#product").val(data.name);
	 				
	 				console.log(data.name);
	 				
	 			});
			}*/
			/* var product = $("#product").val();
			
			if(!product){
				var pid = $("#pid").attr("value");
				console.log(pid);
				$.post('${ctx}/product/product/getProduct',{id:pid},function(data){
	 				$("#iteration").val(data.iterater);
	 			});
			} */
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
			
			laydate({
	            elem: '#data', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
			
	        });
			
		});
		
		
		
		function change(obj){
			
			var option=$(obj).find("option:selected");
			var item = option.text();
			console.log(option[0]);
			$("#iteration").val($(option[0]).attr("iterater"));
			console.log($(option[0]).attr("iterater"));
		}
	</script>
	<style type="text/css">
		.star{
			color:red;
		}
	</style>
</head>
<body>
		<form:form id="inputForm" modelAttribute="edition" action="${ctx}/edition/edition/save" method="post" >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table ">
		   <tbody>
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>产品名称：</label></td>
					<td>
						<form:select id="product" path="product" class="form-control required" onchange="change(this)">
								
								 <c:forEach items="${fns:getProductList()}" var="product"  varStatus="status">
									<option id="pid" value="${product.id}" iterater="${product.iterater }" >${product.name}</option>
								</c:forEach>
						</form:select>
					</td>
				</tr>	
				<tr>	
					<td ><label class="pull-right"><span class="star">*</span>关联迭代：</label></td>
					<td>
						<form:input id="iteration" path="iteration" htmlEscape="false" maxlength="64" class="form-control required" readonly="true"/>
					</td>
				</tr>
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>发布版本号：</label></td>
					<td>
						<form:input path="editionNum" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>	
				<tr>	
					<td ><label class="pull-right"><span class="star">*</span>构建者：</label></td>
					<td>
						<form:input path="createMan" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>打包日期：</label></td>
					<td>
						 <%-- <form:input id="data" path="date" htmlEscape="false" class="laydate-icon form-control layer-date "/>  --%>

						
							 <input id="data" name="date" type="text" maxlength="20"   class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${edition.date}" pattern="yyyy-MM-dd"/>"/>	
					</td>
				</tr>	
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>源代码地址：</label></td>
					<td>
						<form:textarea path="codeAddress" rows="4"  htmlEscape="false" maxlength="1024" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td ><label class="pull-right"><span class="star">*</span>下载地址：</label></td>
					<td>
						<form:textarea path="loadAddress" rows="4"  htmlEscape="false" maxlength="1024" class="form-control required"/>
					</td>
					
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>