<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>数据字典管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>数据字典列表 </h5>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<form:form id="searchForm" modelAttribute="dataDictionary" action="${ctx}/dict/dataDictionary/" method="post" class="form-inline form-box">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<label>表名：</label>
			<form:input path="tableName" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
		 </div>
		 <div class="btn-form-box">
			<button  class="btn btn-success btn-rounded btn-sm filter" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<a  class="btn btn-success btn-rounded btn-outline btn-sm filterReset" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</a>
		 </div>
	</form:form>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dict:dataDictionary:export">
	       		<table:exportExcel url="${ctx}/dict/dataDictionary/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	       <!-- <button class="btn btn-white btn-sm toolbar" data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button> -->
		</div>
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-bordered table-hover table-condensed dataTables-example dataTable  table-fixed table-source">
		<colgroup>
			<col style="width:45%">
			<col style="width:45%">
			<col style="width:10%">
		</colgroup>
		<thead>
			<tr>
				<!-- <th> <input type="checkbox" class="i-checks"></th> -->
				<th  class="sort-column tableName">表名</th>
				<th  class="sort-column tableComment">表说明</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dataDictionary">
			<tr>
				<!-- <td> <input type="checkbox" id="${dataDictionary.tableName}" class="i-checks"></td> -->
				<td><a  href="#" onclick="openDialogView('查看数据字典', '${ctx}/dict/dataDictionary/view?tableName=${dataDictionary.tableName}','800px', '500px')">
					${dataDictionary.tableName}
				</a></td>
				<td >
					${dataDictionary.tableComment}
				</td>
				<td class="text-center">
					<shiro:hasPermission name="dict:dataDictionary:view">
						<a href="#" onclick="openDialogView('查看数据字典', '${ctx}/dict/dataDictionary/view?tableName=${dataDictionary.tableName}','800px', '500px')" class="alink">查看</a>
					</shiro:hasPermission>
					<span class="gap-line">|</span>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	</div>
	</div>
</div>
</body>
</html>