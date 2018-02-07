<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>需求管理</title>
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
			<h5>需求列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="requirements" action="${ctx}/require/requirements/" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
					<div class="form-group">
					<label>需求名称：</label>
						<form:input id="search_name" path="name" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
					<%-- <label>最新状态评价：</label>
						<form:select id="search_evaluation" path="evaluation" class="form-control input-sm">
								<form:option value="" label="请选择"/>
								<form:options items="${fns:getDictList('requirement_evaluation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>		 --%>
					</div>	
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button id="reset" class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->

			<!-- B 工具栏 -->
			<div class="control-box">
				<shiro:hasPermission name="require:requirements:add">
					<table:addRow url="${ctx}/require/requirements/form" title="需求" width="540px;" height="600px;"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				<!-- <shiro:hasPermission name="require:requirements:edit">
				    <table:editRow url="${ctx}/require/requirements/form" title="需求" id="contentTable"></table:editRow>编辑按钮
				</shiro:hasPermission> -->
				<shiro:hasPermission name="require:requirements:del">
					<table:delRow url="${ctx}/require/requirements/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="require:requirements:import">
					<table:importExcel url="${ctx}/require/requirements/import"></table:importExcel><!-- 导入按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="require:requirements:export">
		       		<table:exportExcel url="${ctx}/require/requirements/export"></table:exportExcel><!-- 导出按钮 -->
		       	</shiro:hasPermission>
		       <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
			</div>
			<!-- E 表格 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
					<tr>
						<th><input type="checkbox" class="i-checks"></th>
						<th class="sort-column name">需求名称</th>
						<th class="sort-column project">产品/服务</th>
						<th class="sort-column project">需求联系人</th>
						<th class="sort-column phone">需求联系人电话</th>
						<!-- <th class="sort-column evaluation">最新状态评价</th> -->
						<!-- <th class="sort-column core">核心需求</th>
						<th class="sort-column solution">解决方案</th> -->
						<th class="sort-column updateDate">更新时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="requirements">
					<tr>
						<td class="text-center"><input type="checkbox" id="${requirements.id}" class="i-checks"></td>
							<td  
								 class="text-center"
							>
								<a href="javascript:;" onclick="openDialogView('查看需求', '${ctx}/require/requirements/form?id=${requirements.id}&&op=1','540px;', '600px;')">
									${requirements.name}
								</a>
							</td>
							<td  
								 class="text-center"
							>
								
									${requirements.product}
								
							</td>
							<td  
								 class="text-center"
							>
								
								<c:forEach items="${fns:getCustomerList()}" var="customer"  varStatus="status">

											<c:if test="${customer.id  == requirements.customer}">

												${customer.contacts}

											</c:if>

									</c:forEach>
								
							</td>
							<td  
								 class="text-center"
							>
								
									<c:forEach items="${fns:getCustomerList()}" var="customer"  varStatus="status">

											<c:if test="${customer.id  == requirements.customer}">

												${customer.phone}

											</c:if>

									</c:forEach>
								
							</td>
					<%-- 
							<td  
								 class="text-center " id="evaluations" >
									
								
									
									<c:set var="evaluation" value=' ${requirements.evaluation}' />

        							<c:forEach var="test" items="${fn:split(evaluation,',')}" varStatus="last">
        								<c:if test="${last.last}">
        									${test}
        								</c:if>		
           									
      							 	</c:forEach>
									
										
													
							</td>  --%>
							<td  
								 class="text-center"  >
								
									<fmt:formatDate value="${requirements.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
						<td class="btn-control text-center">
							<%-- <shiro:hasPermission name="require:requirements:view">
								<a href="#" onclick="openDialogView('查看需求', '${ctx}/require/requirements/form?id=${requirements.id}&&op=1','100%', '100%')"><i class="fa fa-search-plus"></i> 查看</a>
							</shiro:hasPermission>
							<span>丨</span> --%>
							<shiro:hasPermission name="require:requirements:edit">
		    					<a href="#" onclick="openDialog('修改需求', '${ctx}/require/requirements/form?id=${requirements.id}','540px;', '600px;')"><i class="fa fa-edit"></i> 修改</a>
		    				</shiro:hasPermission>
		    				<span>丨</span>
							<shiro:hasPermission name="require:requirements:edit">
		    					<a href="#" onclick="openDialog('添加项目', '${ctx}/project/project/form?requirements=${requirements.id}','540px;', '600px;')"><i class="fa fa-edit"></i> 项目启用</a>
		    				</shiro:hasPermission>
		    				<span>丨</span>
		    				<shiro:hasPermission name="require:requirements:del">
								<a href="${ctx}/require/requirements/delete?id=${requirements.id}" onclick="return confirmx('确认要删除该需求吗？', this.href)"><i class="fa fa-trash"></i> 删除</a>
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