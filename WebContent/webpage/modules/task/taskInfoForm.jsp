<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务信息管理</title>
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
			var op = $("#op").val();
			if(op == 1 || op == 3 || op == 5){
				var taskInfo = $("#id").val();
				$.post("${ctx}/task/taskInfo/teamMan",{id:taskInfo},function(data){
					var select = document.getElementById("assignedTo");
					var aVal = document.getElementById("aVal").innerText;
					select.length=0;
					var man = new Array();
					man = data.split(",");
					for(var i=0; i<man.length; i++) {
						select.options.add(new Option(man[i],man[i])); 
					}
					for(var j=0; j<select.options.length; j++){
						if(select.options[j].innerHTML == aVal){
							select.options[j].selected = true;
						}
					}
				});
				
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
			
			
			if(op == 3){
				laydate({
		            elem: '#finishedDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });
			}
			else if(op == 2){
				laydate({
		            elem: '#realStarted', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
		        });	
			}
			else{
				laydate({
		            elem: '#estStarted', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });
				laydate({
		            elem: '#deadline', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });	
			}
			
			
				
		});
		
		
		//添加任务信息时根据迭代的成员显示指派人员
		function change(obj) {
			var option=$(obj).find("option:selected");
			var select = document.getElementById("assignedTo");
			select.length=0;
			var team = $(option[0]).attr("teamMan");
			var man = new Array();
			man = team.split(",");
			for(var i=0; i<man.length; i++) {
				select.options.add(new Option(man[i],man[i])); 
			}
		}
		
		//判断总消耗大于等于原来的总消耗值
		function judge(value){
			var consumed = $("#consumed").val();
			if(parseFloat(value) > parseFloat(consumed) ){
				alert("总消耗值应不小于"+value);
				$("#consumed").val(value);
			}
		}
		
	</script>
</head>
<body>
		<form:form id="inputForm" modelAttribute="taskInfo" action="${ctx}/task/taskInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}"/>	
		<table class="table table-condensed dataTables-example dataTable no-footer">
		  	<c:choose>
		  		<c:when test="${taskInfo.op==1  or taskInfo.op==5}">
		  			<form:input path="op" htmlEscape="false" class="form-control" value="${taskInfo.op }" type="hidden"/>
		  			<tbody> 
		  				<tr>
		  					<td width="15%"><label class="pull-right"><font color="red">*</font>指派给：</label></td>
							<td >
								<span id="aVal" hidden="true">${taskInfo.assignedTo }</span>
								<form:select id="assignedTo" path="assignedTo" class="form-control required">
									
								</form:select>
							</td>
		  				</tr>
		  				<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>剩余：</label></td>
							<td class="">
								<form:input path="surplus" htmlEscape="false" class="form-control  number required" placeholder="小时"/>
							</td>
						</tr>
						<tr>
							<td><label class="pull-right">备注：</label></td>
							<td>
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="form-control "/>
							</td>
						</tr>
		  			</tbody>
		  		</c:when>
		  		<c:when test="${taskInfo.op == 2 }">
		  			<form:input path="op" htmlEscape="false" class="form-control" value="${taskInfo.op }" type="hidden"/>
		  			<tbody> 
		  				<tr>
		  					<td width="20%"><label class="pull-right"><font color="red">*</font>实际开始：</label></td>
							<td >
								<input id="realStarted" name="realStarted" type="text"  maxlength="20" class="form-control layer-date laydate-icon"
									value="${fns:getDate('yyyy-MM-dd') }"/>
							</td>
		  				</tr>
		  				<tr>
		  					<td><label class="pull-right"><font color="red">*</font>总消耗：</label></td>
		  					<td class="">
								<form:input path="consumed" htmlEscape="false" class="form-control  number required" placeholder="小时"/>
							</td>
		  				</tr>
		  				<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>预计剩余：</label></td>
							<td class="">
								<form:input path="surplus" htmlEscape="false" class="form-control  number required" placeholder="小时"/>
							</td>
						</tr>
						<tr>
							<td><label class="pull-right">备注：</label></td>
							<td>
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="form-control "/>
							</td>
						</tr>
		  			</tbody>
		  		</c:when>
		  		<c:when test="${taskInfo.op == 3}">
		  			<form:input path="op" htmlEscape="false" class="form-control" value="${taskInfo.op }" type="hidden"/>
		  			<tbody>
		  				<tr>
		  					<td width="20%"><label class="pull-right">已消耗：</label></td>
							<td >
								${taskInfo.consumed } 工时
							</td>
		  				</tr>
		  				<tr>
		  					<td><label class="pull-right"><font color="red">*</font>总消耗：</label></td>
		  					<td class="">
								<form:input path="consumed" htmlEscape="false" class="form-control number required" placeholder="小时" onblur="judge(${taskInfo.consumed })"/>
							</td>
		  				</tr>
		  				<tr>
		  					<td width="15%"><label class="pull-right"><font color="red">*</font>指派给：</label></td>
							<td >
								<span id="aVal" hidden="true">${taskInfo.assignedTo }</span>
								<form:select id="assignedTo" path="assignedTo" class="form-control required">
									
								</form:select>
							</td>
		  				</tr>
		  				<tr>
		  				<td><label class="pull-right"><font color="red">*</font>完成时间：</label></td>
							<td>
								<input id="finishedDate" name="finishedDate" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
								value="${fns:getDate('yyyy-MM-dd') }"/>
							</td>
						</tr>
						<tr>
							<td><label class="pull-right">备注：</label></td>
							<td>
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="form-control "/>
							</td>
						</tr>
		  			</tbody>
		  		</c:when>
		  		<c:when test="${taskInfo.op == 4 or taskInfo.op == 6}">
		  			<form:input path="op" htmlEscape="false" class="form-control" value="${taskInfo.op }" type="hidden"/>
		  			<tbody>
						<tr>
							<td><label class="pull-right">备注：</label></td>
							<td>
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="form-control "/>
							</td>
						</tr>
		  			</tbody>
		  		</c:when>
		  		<c:otherwise>
		  			<tbody>
						<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>所属迭代：</label></td>
							<td class="">
								<form:select path="iteration" class="form-control required" onchange="change(this)">
										<option value="" teamMan="">请选择</option>
										<c:forEach items="${fns:getIteraterList()}" var="iterater"  varStatus="status">
											<option value="${iterater.id}" teamMan="${iterater.teamMan }">${iterater.name}</option>
										</c:forEach>
								</form:select>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right">所属模块：</label></td>
							<td class="">
								<form:input path="module" htmlEscape="false" maxlength="64" class="form-control " value="/" disabled="true"/>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>任务类型：</label></td>
							<td class="">
								<form:select path="type" class="form-control required">
									<form:options items="${fns:getDictList('task_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>指派给：</label></td>
							<td class="">
								<form:select id="assignedTo" path="assignedTo" class="form-control required">
									<%-- <form:options items="${fns:getDictList('task_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
								</form:select>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right">相关需求：</label></td>
							<td class="">
								<form:input path="requirement" htmlEscape="false" maxlength="64" class="form-control " value="/" disabled="true"/>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>任务名称：</label></td>
							<td class="">
								<form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>任务描述：</label></td>
							<td class="">
								<form:textarea path="description" htmlEscape="false" rows="4" class="form-control required"/>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>优先级：</label></td>
							<td class="">
								<form:select path="pri" class="form-control required">
									<form:options items="${fns:getDictList('task_pri')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>预计时长：</label></td>
							<td class="">
								<form:input path="estimate" htmlEscape="false" class="form-control  number required" placeholder="小时"/>
							</td>
						</tr>
						<tr>
							<td class=""><label class="pull-right"><font color="red">*</font>可用工作日：</label></td>
							<td class="">
								<input id="estStarted" name="estStarted" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${taskInfo.estStarted}" pattern="yyyy-MM-dd HH:mm:ss"/>" style="width:180px"/>
								<span> 至 </span>
								<input id="deadline" name="deadline" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${taskInfo.deadline}" pattern="yyyy-MM-dd HH:mm:ss"/>" style="width:180px;display: inline;"/>
							</td>
						</tr>
					</tbody>
		  		</c:otherwise>
		  	</c:choose>
		</table>
	</form:form>
</body>
</html>