<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>销售人员管理</title>
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
			<h5>销售人员列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="salesMan" action="${ctx}/sales/salesMan/" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
				
				
				
					<div class="form-group">
					<label>销售人名：</label>
						<form:input path="name" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
					</div>				
					<div class="form-group">
					<label>所属区域：</label>
						<form:input path="area" htmlEscape="false" maxlength="500"  class=" form-control input-sm"/>
					</div>	
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->

			<!-- B 工具栏 -->
			<div class="control-box">
				<shiro:hasPermission name="sales:salesMan:add">
					<table:addRow url="${ctx}/sales/salesMan/form" title="销售人员" height="60%"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				
				<shiro:hasPermission name="sales:salesMan:del">
					<table:delRow url="${ctx}/sales/salesMan/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="sales:salesMan:import">
					<table:importExcel url="${ctx}/sales/salesMan/import"></table:importExcel><!-- 导入按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="sales:salesMan:export">
		       		<table:exportExcel url="${ctx}/sales/salesMan/export"></table:exportExcel><!-- 导出按钮 -->
		       	</shiro:hasPermission>
		       <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
			</div>
			<!-- E 表格 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
					<tr>
						<th><input type="checkbox" class="i-checks"></th>
						<th class="sort-column name">销售人名</th>
						<th class="sort-column salesTarget">销售指标</th>
						<th class="sort-column area">所属区域</th>
						<th class="sort-column phone">联系人电话</th>
						<th class="sort-column updateDate">更新时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="salesMan">
					<tr>
						<td class="text-center"><input type="checkbox" id="${salesMan.id}" class="i-checks"></td>
							<td  
								 class="text-center"
							>
								<a href="javascript:;" onclick="openDialogView('查看销售人员', '${ctx}/sales/salesMan/form?id=${salesMan.id}','800px', '500px')">
									${salesMan.name}
								</a>
							</td>
							<td  
								 class="text-center"
							>
								<fmt:formatNumber value="${salesMan.salesTarget}" pattern="#,###.00"/>
								
							</td>
							<td  
								 class="text-center"
							>
								
									${salesMan.area}
								
							</td>
							<td  
								 class="text-center"
							>
								
									${salesMan.phone}
								
							</td>
							<td  
								 class="text-center" 
															>
								
									<fmt:formatDate value="${salesMan.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
						<td class="btn-control text-center">
							<shiro:hasPermission name="sales:salesMan:view">
								<a href="#" onclick="openDialogView('查看销售人员', '${ctx}/sales/salesMan/form?id=${salesMan.id}','800px', '500px')"><i class="fa fa-search-plus"></i> 查看</a>
							</shiro:hasPermission>
							<span>丨</span>
							<shiro:hasPermission name="sales:salesMan:edit">
		    					<a href="#" onclick="openDialog('修改销售人员', '${ctx}/sales/salesMan/form?id=${salesMan.id}','800px', '500px')"><i class="fa fa-edit"></i> 修改</a>
		    				</shiro:hasPermission>
		    				<span>丨</span>
		    				<shiro:hasPermission name="sales:salesMan:del">
								<a href="${ctx}/sales/salesMan/delete?id=${salesMan.id}" onclick="return confirmx('确认要删除该销售人员吗？', this.href)"><i class="fa fa-trash"></i> 删除</a>
							</shiro:hasPermission>
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