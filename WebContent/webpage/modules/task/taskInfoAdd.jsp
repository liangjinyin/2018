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
			            elem: '#estStarted_1', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_1', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_2', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_2', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_3', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_3', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_4', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_4', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_5', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_5', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_6', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_6', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_7', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_7', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_8', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_8', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_9', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_9', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
					laydate({
			            elem: '#estStarted_10', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#deadline_10', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });	
		});
		
		//根据迭代的成员显示指派人员
		function change(obj) {
			var option=$(obj).find("option:selected");
			var num = $(obj).attr("title");
			var table = document.getElementById('table');
			var select = table.rows[num].cells[6].firstElementChild;
			select.length=0;
			var team = $(option[0]).attr("teamMan");
			var man = new Array();
			man = team.split(",");
			for(var i=0; i<man.length; i++) {
				select.options.add(new Option(man[i],man[i])); 
			}
		}
	</script>
</head>
<body>
		<form:form id="inputForm" modelAttribute="taskInfo" action="${ctx}/task/taskInfo/saveAll" method="post" class="form-horizontal">
		<%-- <form:hidden path="id"/> --%>
		<sys:message content="${message}"/>	
		<table id="table" class="table table-bordered table-striped table-hover table-condensed dataTables-example dataTable no-footer">
			<thead>
				<tr>
					<th>ID</th>
					<th width="8%">所属模块</th>
					<th width="8%">相关需求</th>
					<th>所属迭代</th>
					<th>任务名称</th>
					<th>类型</th>
					<th>指派给</th>
					<th width="8%">预计</th>
					<th width="8%">预计开始</th>
					<th width="8%">截止日期</th>
					<th>任务描述</th>
					<th>优先级</th>
				</tr>
			</thead>
		   <tbody>
				<c:forEach  var="i" begin="0" end="9" varStatus="status">
					<tr>
						<td align="center">
							<c:out value="${status.count }"></c:out>
						</td>
						<td>
							<input name="taskInfos[${i }].module"  maxlength="64" class="form-control " value="/" disabled="disabled"/>
						</td>
						<td>
							<input name="taskInfos[${i }].requirement" maxlength="64" class="form-control " value="/" disabled="disabled"/>
						</td>
						<td>
							<select name="taskInfos[${i }].iteration" class="form-control" onchange="change(this)" title="${status.count }">
								<option value="" teamMan="">请选择</option>
								<c:forEach items="${fns:getIteraterList()}" var="iterater"  varStatus="status">
									<option value="${iterater.id}" teamMan="${iterater.teamMan }">${iterater.name}</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<input name="taskInfos[${i }].name" maxlength="255" class="form-control"/>
						</td>
						<td>
							<select name="taskInfos[${i }].type" class="form-control ">
								<c:forEach items="${fns:getDictList('task_type')}" var="type"  varStatus="status">
									<option value="${type.value}">${type.label}</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<select name="taskInfos[${i }].assignedTo" class="form-control ">
								
							</select>
						</td>
						<td>
							<input name="taskInfos[${i }].estimate" class="form-control  number"/>
						</td>
						<td>
							<input id="estStarted_${i+1 }" name="taskInfos[${i }].estStarted" type="text" maxlength="20" class="laydate-icon form-control layer-date"
								value=""/>
						</td>
						<td>
							<input id="deadline_${i+1 }" name="taskInfos[${i }].deadline" type="text" maxlength="20" class="laydate-icon form-control layer-date"
							value=""/>
						</td>
						<td>
							<textarea name="taskInfos[${i }].description" rows="4" class="form-control "></textarea>
						</td>
						<td>
							<select name="taskInfos[${i }].pri" path="pri"  class="form-control ">
								<c:forEach items="${fns:getDictList('task_pri')}" var="pri"  varStatus="status">
									<option value="${pri.value}">${pri.label}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</c:forEach>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>