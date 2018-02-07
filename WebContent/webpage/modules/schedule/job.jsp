<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
	</script>
	<style>
		.table>tbody>tr>td{
			border:none;
			border-bottom:1px solid #e7eaec;
		}
		.table>tbody>tr>td:nth-child(odd){
			border:none;
		}
		#contentTable tbody tr td{
			border: none;
		}
	</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	    <div class="ibox-content">
			 <sys:message content="${message}"/>
			
			<table style="border:none;" class="table table-bordered table-condensed table-inform">
				<colgroup>
					<col style="width:15%">
					<col style="width:35%">
					<col style="width:15%">
					<col style="width:35%">
				</colgroup>
			  <tbody>
				 <tr>
				 			<td >项目名称：</td>
							<td >
									${project.projectName}
							</td>
							<td >项目负责人：</td>
							<td >
									${project.projectManager}
							</td>
				</tr>
				<tr>
							<td >任务数：</td>	
							<td >
								 ${project.jobNum}
							</td>
							<td >所属团队：</td>	
							<td >
								  ${project.team}
							</td>
				</tr>
				<tr>
							<td >完成任务数/等待：</td>
							<td >
								${project.doneNum}/${project.waitNum} 
							</td>
							<td >正在处理：</td>
							<td >
								${project.doingNum}
							</td>
				</tr>
				<tr>
							<td >开始时间：</td>
							<td >
								<fmt:formatDate value="${project.begin}" pattern="yyyy-MM-dd"/>
							 </td>
							<td >研发进度：</td>
							<td  >
								${project.doneProcess}&nbsp;&nbsp;%
							</td>
				</tr>
				
			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="task" action="${ctx}/project/project/jobs" method="post" class="form-inline form-box">
				<input  name="id"  type="hidden" value="${task.id}"/>

				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	 			<div class="form-group">
					<label>任务所属人：</label>
						${task.createBy.name}
						<input  name="createBy.name"  type="hidden" value="${task.createBy.name}"/>
						<!-- <form:select path="createBy.name" class="form-control input-sm">
							<form:option value="" label="请选择"/>
							<c:forEach items="${fns:fundEmployee()}" var="emp">
								<form:option value="${emp}" label="${emp}"/>
							</c:forEach>
						</form:select> -->
				</div>
				<!-- <div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
				</div> -->
			</form:form>
			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<colgroup>
					<col style="width:17.5%">
					<col style="width:17.5%">
					<col style="width:17.5%">
					<col style="width:15%">
					<col style="width:17.5%">
					<col style="width:15%">	
				</colgroup>
				<thead>
					<tr>
						<th >任务名称</th>
						<th >任务名称</th>
						<th >指派时间</th>
						<th >状态</th>
						<th >完成时间</th>
						<th >项目负责人</th>
						<!-- <th>操作</th> -->
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="job">
					<tr>
							<td   class="text-center" >
								 ${job.projectName}
							</td>
							<td   class="text-center" >
								 ${job.taskName}
							</td>
							<td   class="text-center" >
								<fmt:formatDate value="${job.assignedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td   class="text-center" >
								${job.status}
							</td>
							<td   class="text-center" >
								<fmt:formatDate value="${job.finishedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td   class="text-center"  >
								${job.projectManager}
							</td>
						
					</tr>
				</c:forEach>
				</tbody>
			</table>

			<!-- E 表格 -->
			<!-- 分页代码 -->
			<table:page page="${page}"></table:page>
		</div>
	</div>
	</div>
</body>
</html>