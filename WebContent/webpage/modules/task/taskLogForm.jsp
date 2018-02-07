<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务日志管理</title>
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
	            elem: '#date1', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
			laydate({
	            elem: '#date2', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
			laydate({
	            elem: '#date3', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
			laydate({
	            elem: '#date4', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
			laydate({
	            elem: '#date5', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
		});
		
		//将表格中的文本改为输入框，并填充相应的内容
		function updateLog(row) {
			var table = document.getElementById("contentTable");
			var a = document.getElementById("update_"+row);
			if(a.innerText == '保存'){
				var date = $("#d"+row).val();
				var consumed = $("#c_"+row).val();
				var surplus = $("#s_"+row).val();
				var content = $("#con_"+row).val();
		 		$.post('${ctx}/task/taskLog/save',
		 				{id:table.rows[row].cells[0].innerText,date:date,consumed:consumed,surplus:surplus,content:content},
		 				function(data){
		 				location.href ="${ctx}/task/taskLog/logs?id="+data;
		 		});
		 	}
		 	else{
			 	var dateVal = table.rows[row].cells[1].innerText;
			 	var consumedVal = table.rows[row].cells[2].innerText;
			 	var surplusVal = table.rows[row].cells[3].innerText;
			 	var contentVal = table.rows[row].cells[4].innerText;
			 	table.rows[row].cells[1].innerText="";
			 	table.rows[row].cells[2].innerText="";
			 	table.rows[row].cells[3].innerText="";
			 	table.rows[row].cells[4].innerText="";
			 	var date = document.createElement("input");   
			 	date.value = dateVal;
			 	date.id = "d"+row;
			 	date.setAttribute("class"," form-control layer-date"); 
			 	date.setAttribute("onclick","date("+row+")");
			 	document.getElementById("date_"+row).appendChild(date);
			 	var consumed = document.createElement("input");   
			 	consumed.value = consumedVal;
			 	consumed.id = "c_"+row;
			 	consumed.setAttribute("class","form-control"); 
			 	document.getElementById("consumed_"+row).appendChild(consumed);
			 	var surplus = document.createElement("input");   
			 	surplus.value = surplusVal;
			 	surplus.id = "s_"+row;
			 	surplus.setAttribute("class","form-control"); 
			 	document.getElementById("surplus_"+row).appendChild(surplus);
			 	var content = document.createElement("input");   
			 	content.value = contentVal;
			 	content.id = "con_"+row;
			 	content.setAttribute("class","form-control"); 
			 	document.getElementById("content_"+row).appendChild(content);
			 	a.innerHTML="保存";
		 	}
		}
		
		function date(row){
			laydate({
	            elem: '#d'+row, //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
	        });
		}
	</script>
</head>
<body>
		<form:form id="inputForm" modelAttribute="taskLog" action="${ctx}/task/taskLog/saveAll" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="task"/>
		<sys:message content="${message}"/>	
		<table id="contentTable" class="table table-bordered table-hover table-condensed dataTables-example dataTable">
			<thead>
				<tr>
					<th class="id" width="5%">ID</th>
					<th class="date" width="15%">日期</th>
					<th class="consumed" width="10%">耗时</th>
					<th class="surplus" width="10%">剩余</th>
					<th  class="content">工作内容</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page}" var="taskLog" varStatus="status">
				<c:if test="${taskLog.date != null }">
					<tr>
					<td align="center"> 
						${taskLog.id}
					</td>
					<td align="center" id="date_${status.count }">
						<fmt:formatDate value="${taskLog.date}" pattern="yyyy-MM-dd"/>
					</td>
					<td align="center" id="consumed_${status.count }">${taskLog.consumed }</td>
					<td align="center" id="surplus_${status.count }">${taskLog.surplus }</td>
					<td align="center" id="content_${status.count }">
						${taskLog.content}
					</td>
					<td align="center">
						<shiro:hasPermission name="task:taskLog:edit">
	    					<a id="update_${status.count }" onclick="updateLog(${status.count})"><i class="fa fa-edit"></i>修改</a>
	    				</shiro:hasPermission>
	    				<span>|</span>
	    				<shiro:hasPermission name="task:taskLog:del">
							<a href="${ctx}/task/taskLog/delete?id=${taskLog.id}" onclick="return confirmx('确认要关闭该任务日志吗？', this.href)"><i class="fa fa-close"></i>关闭</a>
						</shiro:hasPermission>
					</td>
				</tr>
				</c:if>
			</c:forEach>
			<c:forEach var="i" begin="1" end="5" varStatus="status">
				<tr>
				<td align="center">
					<c:out value="${status.count }"></c:out>
					<input name="taskLogs[${i }].task" value="${task }" type="hidden"/>
				</td>
				<td>
					<input id="date${i }" name="taskLogs[${i }].date" type="text" maxlength="20" class="form-control layer-date"
								value="${fns:getDate('yyyy-MM-dd') }"/>
				</td>
				<td>
					<input name="taskLogs[${i }].consumed" class="form-control " />
				</td>
				<td>
					<input name="taskLogs[${i }].surplus" class="form-control "/>
				</td>
				<td>
					<input name="taskLogs[${i }].content" class="form-control "/>
				</td>
				<td></td>
				</tr>
			</c:forEach>
			</tbody>
	</table>

	</form:form>
</body>
</html>