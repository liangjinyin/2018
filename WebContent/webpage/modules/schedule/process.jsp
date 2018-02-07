<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/select2-master/dist/js/select2.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/select2-master/dist/css/select2.min.css">
	<script type="text/javascript">
		$(document).ready(function() {
				 $(".js-example-basic-single").select2();
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>项目列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="project" action="${ctx}/project/project/projects" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<!-- <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/> --><!-- 支持排序 -->
					<div class="form-group">
					<!-- <label>项目</label>
						<form:select path="createBy.name" class="form-control input-sm js-example-basic-single">
							<form:option value="" label="请选择"/>
							<c:forEach items="${fns:fundEmployee()}" var="emp">
								<form:option value="${emp}" label="${emp}"/>
							</c:forEach>
						</form:select>
					</div> -->
				<!-- <div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button class="btn btn-blue btn-sm" onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
				</div> -->
			</form:form>
			<!-- E 查询条件 -->
			
			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<colgroup>
					<col style="width: 23%;">
					<col style="width: 7%;">
					<col style="width: 7%;">
					<col style="width: 7%;">
					<col style="width: 7%;">
					<col style="width: 7%;">
					<col style="width: 7%;">
					<col style="width: 7%;">
					<col style="width: 15%;">		
					<col style="width: 13%;">
				</colgroup>
				<thead>
					<tr>
						<th >项目名称</th>
						<th >项目负责人</th>
						<th >预计工作量(天)</th>
						<th >实际工作量(天)</th>
						<th >开始时间</th>
						<th >任务数量</th>
						<th >BUG数量</th>
						<th title="（任务处理进度+BUG处理进度）/2">项目进度</th>
						<th >所属团队</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${projects}" var="project">
					<tr>
						
							<td    class="text-center" >
								<a href="javascript:;" onclick="openDialogView('查看任务信息', '${ctx}/project/project/jobs?id=${project.id}&&createBy.name=${username}','100%', '100%')">
									${project.projectName}
								</a>
							</td>
							<td   class="text-center" >
									${project.projectManager}
							</td>
							<td   class="text-center" >
									${project.days}
							</td>
							<td   class="text-center" >
									${project.realdays}
							</td>
							<td   class="text-center" >
								<fmt:formatDate value="${project.begin}" pattern="yyyy-MM-dd"/>
							 </td>
							<td   class="text-center" >
								${project.jobNum}
							</td>
							<td   class="text-center" >
								  ${project.bugNum}
							</td>
							<td  title="(任务处理进度+BUG处理进度)/2" class="text-center" >
								${project.projectProcess} &nbsp;%
							</td>
							<td   class="text-center" >
								  ${project.team}
							</td>
						<td class="btn-control text-center">
								<a href="#" onclick="openDialogView('任务信息', '${ctx}/project/project/jobs?id=${project.id}&&createBy.name=${username}','55%', '70%')"><i class="fa fa-search-plus"></i> 任务查看</a>
								<span>丨</span>
								<a href="#" onclick="openDialogView('BUG信息', '${ctx}/project/project/bugs?id=${project.id}&&createBy.name=${username}','55%', '70%')"><i class="fa fa-search-plus"></i> BUG查看</a>

						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<!-- E 表格 -->
			
		</div>
	</div>
	</div>
</body>
</html>