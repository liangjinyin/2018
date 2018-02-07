<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			
			laydate({
	            elem: '#beginTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
	        laydate({
	            elem: '#endTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
		});
		$(document).ready(function(){
			$("#contentTable tr td").mouseover(function(){
				$(this).css("background-color","#DDE9F1");
			}).mouseout(function(){
				$(this).css("background-color","#FFFFFF");
			});
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>员工负载统计表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="" action="${ctx}/statistics/statistics/employeeLoad" method="post" class="form-inline form-box">

					<div class="form-group">
					<label>姓名：</label>
						<input id="name" name="name" maxlength="64"  class=" form-control input-sm" value="${name }"/>
						
						<label>迭代起止时间：</label>
						<input id="beginTime" name="beginTime" type="text" maxlength="20" class="laydate-icon form-control layer-date"
								value="<fmt:formatDate value="${beginTime}" pattern="yyyy-MM-dd"/>"/>
						至
						<input id="endTime" name="endTime" type="text" maxlength="20" class="laydate-icon form-control layer-date"
								value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd"/>"/>
					</div>
				
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button id="reset" class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->


			<!-- B 表格 -->
			<table id="contentTable" class="table table-bordered dataTables-example dataTable">
				<thead>				
				<tr>
					<th>姓名</th>
					<th>迭代</th>
					<th>任务数</th>
					<th>剩余工时</th>
					<th>总任务数</th>
					<th>总工时</th>
				</tr>
				</thead>
				<c:forEach items="${employeeLoads}" var="employeeLoad">
					<tr>
						<td align="center" rowspan="${employeeLoad.iterationTasks.size() }">${employeeLoad.employee }</td>
						<td align="center">${employeeLoad.iterationTasks[0].iterater }</td>	
						<td align="center">${employeeLoad.iterationTasks[0].taskNum}</td>
						<td align="center">${employeeLoad.iterationTasks[0].timeNum}</td>	
						<td align="center" rowspan="${employeeLoad.iterationTasks.size() }">${employeeLoad.taskTotal }</td>	
						<td align="center" rowspan="${employeeLoad.iterationTasks.size() }">${employeeLoad.timeTotal }</td>
					</tr>
					<c:forEach items="${employeeLoad.iterationTasks }" var="iterationTask" varStatus="status">
						<c:if test="${status.count != 1 }">
							<tr>
							<td align="center">${iterationTask.iterater }</td>	
							<td align="center">${iterationTask.taskNum}</td>
							<td align="center">${iterationTask.timeNum}</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:forEach>
			</table>
			<!-- E 表格 -->
			<!-- 分页代码 -->
			<table:page page="${page}"></table:page>
		</div>
	</div>
	</div>
</body>
</html>