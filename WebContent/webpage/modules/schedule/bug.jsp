<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>BUG信息</title>
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
			
			<table class="table table-bordered table-condensed table-inform">
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
							<td >已处理：</td>
							<td >
								${project.resolveNum}
							</td>
							<td >待处理：</td>
							<td >
								${project.actNum}
							</td>
				</tr>

				<tr>
							<td >BUG数：</td>	
							<td >
								  ${project.bugNum}
							</td>
							<td >BUG修复进度：</td>
							<td  >
								${project.resolveRate}&nbsp;&nbsp;%
							</td>
				</tr>
				<tr>
							
							<td >开始时间：</td>
							<td >
								<fmt:formatDate value="${project.begin}" pattern="yyyy-MM-dd"/>
							 </td>
							<td >所属团队：</td>	
							<td >
								  ${project.team}
							</td>
				</tr>
			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="bug" action="${ctx}/project/project/bugs" method="post" class="form-inline form-box">
				<input  name="id"  type="hidden" value="${bug.id}"/>

				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	 			<div class="form-group">
					<label>BUG所属人：</label>
						${bug.createBy.name}
						<input  name="createBy.name"  type="hidden" value="${bug.createBy.name}"/>
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
					<!-- <col style="width:15%">
					<col style="width:35%">
					<col style="width:15%">
					<col style="width:35%">
					<col style="width:15%">
					<col style="width:35%">
					<col style="width:15%">
					<col style="width:35%"> -->
				</colgroup>
				<thead>
					<tr>
						<th >名称</th>
						<th >状态</th>
						<th >创建人</th>
						<th >接收人</th>
						<th >处理人</th>
						<th >指派时间</th>
						<th >解决时间</th>
						<th >关闭时间</th>
						<!-- <th>操作</th> -->
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="job">
					<tr>
							<td  title="${job.title}"  class="text-center" >
								 <c:choose>
			                     <c:when test="${fn:length(job.title)>8}"> 
			                         ${fn:substring(job.title, 0, 7)}... 
			                        <!-- <a onclick="showDetail(this,'详情')" style="color: #ccc" >详情 </a> -->
			                        <a style="color:#ccc">详情</a>
			                        <input type="hidden" value=" ${job.title}" />
			                     </c:when>
			                     <c:otherwise>   
			                           ${job.title}
			                     </c:otherwise>
			                 </c:choose>
							</td>
							<td   class="text-center" >
								 ${job.status}
							</td>
							<td   class="text-center" >
								
								${job.openedBy}
							</td>
							<td   class="text-center" >
								
								${job.assignedTo}
							</td>
							<td   class="text-center" >
								
								${job.resolvedBy}
							</td>
							<td   class="text-center" >
								<fmt:formatDate value="${job.assignedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td   class="text-center" >
								<fmt:formatDate value="${job.resolvedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td   class="text-center"  >
								<fmt:formatDate value="${job.closedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
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