<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务信息</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/select2-master/dist/js/select2.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/select2-master/dist/css/select2.min.css">
	<script type="text/javascript">
		$(document).ready(function() {
				 $(".js-example-basic-single").select2();
				 laydate({
		            elem: '#orderDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            format: 'YYYY-MM-DD',
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        	});
		});
	</script>
	<style type="text/css">
		span.select2-container--default .select2-selection--single{
			height:30px;
			border:1px solid #ccc;
		}
	</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>个人任务列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="project" action="${ctx}/project/project/projects-process" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<!-- <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/> --><!-- 支持排序 -->
					<div class="form-group">
					  <label>人员名称：</label>
						<form:select path="name" class="form-control input-sm js-example-basic-single">
							<form:option value="" label="请选择"/>
							<c:forEach items="${fns:fundEmployee()}" var="emp">
								<form:option value="${emp.userName}" label="${emp.zwName}"/>
							</c:forEach>
						</form:select>
					  <label>时间：</label>
						<input id="orderDate" name="orderDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
							value="<fmt:formatDate value="${project.orderDate}" pattern="yyyy-MM-dd"/>"/>
					</div>

				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<!-- <button class="btn btn-blue btn-sm" onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button> -->
				</div>
			</form:form>
			<!-- E 查询条件 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<colgroup>
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 20%;">
					<col style="width: 8%;">
					<col style="width: 8%;">
					<col style="width: 8%;">
					<col style="width: 8%;">
					<col style="width: 16%;">
				</colgroup>
				<thead>
					<tr>
						<th >项目名称</th>
						<th >任务名称</th>
						<th >工作内容</th>
						<th >消耗时间（小时）</th>
						<th >剩余时间</th>
						<th >负责人</th>
						<th >时间</th>
						<th >操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${projects}" var="project">
					<tr>
						   <td    class="text-center" >
								<a href="javascript:;" onclick="openDialogView('查看任务信息', '${ctx}/project/project/jobs?id=${project.pid}&&createBy.name=${project.account}','100%', '100%')">
									${project.pname}
								</a>
							</td>
							<td   class="text-center" >
							        <c:choose>
	                      			<c:when test="${fn:length(project.jname)>15}"> 
				                         ${fn:substring(project.jname, 0,14)}... 

				                        <a onclick="showDetail(this,'描述')" style="color: #ccc" >详情 </a>
				                        <textarea style="display: none;">${project.jname}</textarea>
				           			</c:when>
				                     <c:otherwise>   
				                           ${project.jname}
				                     </c:otherwise>
						        	</c:choose>
							</td>
							<td   class="text-center" >
							         ${project.works}
							</td>
							<td   class="text-center" >
									${project.consumed}
							</td>
							<td   class="text-center" >
								${project.left}
							</td>
							<td   class="text-center" >
								  ${project.account}
							</td>
							<td   class="text-center" >
								<fmt:formatDate value="${project.date}" pattern="yyyy-MM-dd"/>
							 </td>
						<td class="btn-control text-center">
								<a href="#" onclick="openDialogView('任务信息', '${ctx}/project/project/jobs?id=${project.pid}&&createBy.name=${project.account}','55%', '70%')"><i class="fa fa-search-plus"></i> 任务查看</a>
								<span>丨</span>
								<a href="#" onclick="openDialogView('BUG信息', '${ctx}/project/project/bugs?id=${project.pid}&&createBy.name=${project.account}','55%', '70%')"><i class="fa fa-search-plus"></i> BUG查看</a>

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