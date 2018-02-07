<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			
			laydate({
	            elem: '#finishedDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
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
			<h5>任务汇总统计表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="" action="${ctx}/statistics/statistics/taskCollect" method="post" class="form-inline form-box">
					<div class="form-group">					
						<label>完成时间：</label>
						<input id="finishedDate" name="finishedDate" type="text" maxlength="20" class="laydate-icon form-control layer-date"
								value="<fmt:formatDate value="${finishedDate}" pattern="yyyy-MM-dd"/>"/>
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
					<th>完成者</th>
					<th>编号</th>

					<th>任务名称</th>
					<th>优先级</th>
					<th>预计开始</th>
					<th>实际开始</th>
					<th>截止日期</th>
					<th>完成时间</th>
					<th>最初预计工时</th>
					<th>总消耗</th>
					<th>任务状态</th>
				</tr>
				</thead>
				<c:forEach items="${taskCollects}" var="taskCollect">
					<tr>
						<td align="center" rowspan="${taskCollect.taskInfos.size() }">${taskCollect.finishedBy }</td>
						<td align="center" >${taskCollect.taskInfos[0].id }</td>
						<td align="center" >${taskCollect.taskInfos[0].name }</td>
						<td align="center" >${taskCollect.taskInfos[0].pri }</td>
						<td align="center" ><fmt:formatDate value="${taskCollect.taskInfos[0].estStarted }" pattern="yyyy-MM-dd"/></td>	
						<td align="center" ><fmt:formatDate value="${taskCollect.taskInfos[0].realStarted }" pattern="yyyy-MM-dd"/></td>	
						<td align="center" ><fmt:formatDate value="${taskCollect.taskInfos[0].deadline }" pattern="yyyy-MM-dd"/></td>	
						<td align="center" ><fmt:formatDate value="${taskCollect.taskInfos[0].finishedDate }" pattern="yyyy-MM-dd"/></td>	
						<td align="center" >${taskCollect.taskInfos[0].estimate }</td>	
						<td align="center" >${taskCollect.taskInfos[0].consumed }</td>	
						<td align="center" >${taskCollect.taskInfos[0].status }</td>	
					</tr>
					<c:forEach items="${taskCollect.taskInfos }" var="taskInfo" varStatus="status">
						<c:if test="${status.count != 1 }">
							<tr>
							<td align="center" >${taskInfo.id }</td>
							<td align="center" >${taskInfo.name }</td>
							<td align="center" >${taskInfo.pri }</td>
							<td align="center" ><fmt:formatDate value="${taskInfo.estStarted }" pattern="yyyy-MM-dd"/></td>	
							<td align="center" ><fmt:formatDate value="${taskInfo.realStarted }" pattern="yyyy-MM-dd"/></td>	
							<td align="center" ><fmt:formatDate value="${taskInfo.deadline }" pattern="yyyy-MM-dd"/></td>	
							<td align="center" ><fmt:formatDate value="${taskInfo.finishedDate }" pattern="yyyy-MM-dd"/></td>	
							<td align="center" >${taskInfo.estimate }</td>	
							<td align="center" >${taskInfo.consumed }</td>	
							<td align="center" >${taskInfo.status }</td>
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