<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>合作伙伴管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			laydate({
	            elem: '#signingTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            format: 'YYYY-MM-DD hh:mm:ss',
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });

		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>合作伙伴列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="partner" action="${ctx}/partner/partner/" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
				
				
				
					<div class="form-group">
					<label>开发商名称：</label>
						<form:input path="name" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
					</div>
				
					<div class="form-group">
					<label>签约时间：</label>
						<input id="signingTime" name="signingTime" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
							value="<fmt:formatDate value="${partner.signingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</div>			
				
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->

			<!-- B 工具栏 -->
			<div class="control-box">
				<shiro:hasPermission name="partner:partner:add">
					<table:addRow url="${ctx}/partner/partner/form" title="合作伙伴" width="540px" height="600px"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="partner:partner:del">
					<table:delRow url="${ctx}/partner/partner/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="partner:partner:import">
					<table:importExcel url="${ctx}/partner/partner/import"></table:importExcel><!-- 导入按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="partner:partner:export">
		       		<table:exportExcel url="${ctx}/partner/partner/export"></table:exportExcel><!-- 导出按钮 -->
		       	</shiro:hasPermission>
		       <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
			</div>
			<!-- E 表格 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
					<tr>
						<th><input type="checkbox" class="i-checks"></th>
						<th class="sort-column name">开发商名称</th>
						<th class="sort-column company">楼盘描述</th>
						<th class="sort-column signingTime">签约时间</th>
						<th class="sort-column project">合作项目</th>
						<th class="sort-column contacts">联系人</th>
						<th class="sort-column phone">联系人电话</th>
						<th class="sort-column updateDate">更新时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="partner">
					<tr>
						<td class="text-center"><input type="checkbox" id="${partner.id}" class="i-checks"></td>
							<td  
								 class="text-center"
							>
								<a href="javascript:;" onclick="openDialogView('查看合作伙伴', '${ctx}/partner/partner/form?id=${partner.id}&&op=1','100%', '100%')">
									${partner.name}
								</a>
							</td>
							<td  
								 class="text-center"
							>
								
									${partner.company}
								
							</td>
							<td  
								 class="text-center" 
															>
								
									<fmt:formatDate value="${partner.signingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
							<td  
								 class="text-center"
							>
								
									${partner.project}
								
							</td>
							<td  
								 class="text-center"
							>
								
									${partner.contacts}
								
							</td>
							<td  
								 class="text-center"
							>
								
									${partner.phone}
								
							</td>
							<td  
								 class="text-center" 
															>
								
									<fmt:formatDate value="${partner.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
						<td class="btn-control text-center">
							<shiro:hasPermission name="partner:partner:view">
								<a href="#" onclick="openDialogView('查看合作伙伴', '${ctx}/partner/partner/form?id=${partner.id}&&op=1','60%', '60%')"><i class="fa fa-search-plus"></i> 查看</a>
							</shiro:hasPermission>
							<span>丨</span>
							<shiro:hasPermission name="partner:partner:edit">
		    					<a href="#" onclick="openDialog('修改合作伙伴', '${ctx}/partner/partner/form?id=${partner.id}','60%', '60%')"><i class="fa fa-edit"></i> 修改</a>
		    				</shiro:hasPermission>
		    				<span>丨</span>
		    				<shiro:hasPermission name="partner:partner:del">
								<a href="${ctx}/partner/partner/delete?id=${partner.id}" onclick="return confirmx('确认要删除该合作伙伴吗？', this.href)"><i class="fa fa-trash"></i> 删除</a>
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