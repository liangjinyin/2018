<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>基线测试管理</title>
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
			var eid = ${fns:getBaseTestId()};//数据库最大基线编号
			console.log(eid);
			var id=${fns:toJson(baseTest.id)};//已存在基线编号
			var pid=${fns:toJson(baseTest.product)};//产品id
			
			//回显产品名称
			$("#product").val(pid);



			//基线编号自增长
			if(id){
				
				$("#eid").val("BL"+id);	
				

				//修改时回显迭代名称
				$.post('${ctx}/product/product/getProduct',{id:pid},function(data){
	 				
	 				$("#iteration").val(data.iterater);
	 				
	 				
	 				
	 			});
				
			}else{
				if(eid=="0"){
					
					$("#eid").val("BL1");
				}else{
					$("#eid").val("BL"+(eid+1));
				}  
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
			laydate({
	            elem: '#finishtime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
			
			laydate({
	            elem: '#updateDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
			laydate({
	            elem: '#createDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
			
		});

			function change(obj){
				
				var option=$(obj).find("option:selected");
				var item = option.text();
				console.log(option[0]);
				$("#iteration").val($(option[0]).attr("iterater"));
				console.log($(option[0]).attr("iterater"));
				console.log($(option[0]).attr("value"));
				var pid = $(option[0]).attr("value");

				
			}
	</script>
	<style type="text/css">
		.star{
			color:red;
		}
	</style>
</head>
<body>
		<form:form id="inputForm" modelAttribute="baseTest" action="${ctx}/basetest/baseTest/save" method="post" >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table">
		   <tbody>
				<tr>
					<td class="width-15% "><label class="pull-right"><span class="star">*</span>基线标题：</label></td>
					<td class="width-35%">
						<form:input path="title" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					<td class="width-15"><label class="pull-right"><span class="star">*</span>测试轮次：</label></td>
					<td class="width-35">
						<form:input path="testtime" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>基线编号：</label></td>
					<td class="width-35">
						<form:input id="eid" path="" htmlEscape="false" maxlength="64" class="form-control required " readonly="true"/>
					</td>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>产品名称：</label></td>
					<td class="width-35">
						<form:select id="product" path="product" class="form-control  required" onchange="change(this)">
								<form:option value="" label=""/>
								 <c:forEach items="${fns:getProductList()}" var="product"  varStatus="status">
									<option id="pid" value="${product.id}" iterater="${product.iterater }" >${product.name}</option>
								</c:forEach>
						</form:select>
					</td>
					
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>发布版本号：</label></td>
					<td class="width-35">
						<form:input  path="edition" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>系统测试人员：</label></td>
					<td class="width-35">
						<form:input path="testMan" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>关联迭代：</label></td>
					<td class="width-35">
						<form:input id="iteration" path="" htmlEscape="false" maxlength="64" class="form-control " readonly="true"/>
					</td>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>是否跟新数据库：</label></td>
					<td class="width-35">
						<form:radiobutton path="dataupdate" value="是" label="是" class=" required "/>
						<form:radiobutton path="dataupdate" value="否" label="否" class=" required "/>
					</td>
					
					
				</tr>
				<tr>
					<td colspan="1" class="width-15 "><label class="text-right"><span class="star">*</span>本次上线内容及测试内容描述：</label></td>
					
					<td colspan="3" class="width-80">
						<form:textarea path="testDescribe" htmlEscape="false" rows="4" maxlength="1024" class="form-control required "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>测试工作量：</label></td>
					<td class="width-35">
						<form:input path="workload" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>第一轮执行用例数：</label></td>
					<td class="width-35">
						<form:input path="testExecute" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
				</tr>
				<tr>	
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>第一轮通过用例数：</label></td>
					<td class="width-35">
						<form:input path="pass" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>第一轮N/A用例数：</label></td>
					<td class="width-35">
						<form:input path="casenumber" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>新增Bug数：</label></td>
					<td class="width-35">
						<form:input path="newbug" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>严重Bug数：</label></td>
					<td class="width-35">
						<form:input path="seriousbug" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>一般Bug数：</label></td>
					<td class="width-35">
						<form:input path="commonbug" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>轻微Bug数：</label></td>
					<td class="width-35">
						<form:input path="slightbug" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>建议Bug数：</label></td>
					<td class="width-35">
						<form:input path="suggestbug" htmlEscape="false" maxlength="64" class="form-control required "/>
					</td>
					
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>测试结论：</label></td>
				
					<td colspan="3" class="width-85">
						<form:textarea path="conclusion" htmlEscape="false" rows="4" maxlength="1024" class="form-control required "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 "><label class="pull-right"><span class="star">*</span>系统测试完成时间：</label></td>
					<td class="width-35">
						
						<input id="finishtime" name="finishtime" type="text" maxlength="20"  class="laydate-icon form-control  layer-date required"
									value="<fmt:formatDate value="${baseTest.finishtime}" pattern="yyyy-MM-dd"/>"/>
					</td>
					<td class="width-15 "></td>
		   			<td class="width-35" ></td>
		  		</tr>
		  		
		  		<c:choose>
		  				<c:when test="${ baseTest.op==1}">
		  					<tr>
								<td class="width-15 "><label class="pull-right"><span class="star">*</span>创建人：</label></td>
								<td class="width-35">
									<form:input path="createBy.name" htmlEscape="false" class="form-control  "/>
								</td>
								<td class="width-15 "><label class="pull-right"><span class="star">*</span>创建时间：</label></td>
					   			<td class="width-35" >
					   				
					   				<input id="createDate" name="createDate" type="text" maxlength="20"  class="laydate-icon form-control  layer-date required"
									value="<fmt:formatDate value="${baseTest.createDate}" pattern="yyyy-MM-dd"/>"/>
					   			</td>
					  		</tr>
		  					<tr>
								<td class="width-15 "><label class="pull-right"><span class="star">*</span>修改人：</label></td>
								<td class="width-35">
									<form:input path="updateBy.name" htmlEscape="false" class="form-control  "/>
								</td>
								<td class="width-15 "><label class="pull-right"><span class="star">*</span>修改时间：</label></td>
					   			<td class="width-35" >
					   				
					   				<input id="updateDate" name="updateDate" type="text" maxlength="20"  class="laydate-icon form-control  layer-date required"
									value="<fmt:formatDate value="${baseTest.updateDate}" pattern="yyyy-MM-dd"/>"/>
					   			</td>
					  		</tr>
		  				</c:when>
		  		</c:choose>
		  		
		 	</tbody>
		</table>
	</form:form>
</body>
</html>