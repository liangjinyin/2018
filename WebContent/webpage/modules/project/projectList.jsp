<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			//获取表格对象
			var table = document.getElementById('contentTable');
			//获取表格中全部标签为span对象
			var span = table.getElementsByTagName("span");
			//为项目所处阶段列的值加背景色
			for(var j=0;j<span.length;j++) {
				switch(span[j].innerText) {
	                case '方案建议':
	                	span[j].style.background = "#09B299";break;
	                case '优势确认':
	                	span[j].style.background = '#63C613';break;
	                case '商务谈判':
	                	span[j].style.background = '#5FDFFF';break;
	                case 'Winned':
	                	span[j].style.background = '#FFA602';break;
	                case 'closed':
	                	span[j].style.background = '#A1A1A1';break;
	            }
			}
		});
	</script>
	<style type="text/css">
		.stage-content {
			display:block;
			line-height:25px;
			color:#FFFFFF;
			border-radius: 5px;
		}
	</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>项目信息列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="project" action="${ctx}/project/project/" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->

					<div class="form-group">
					<label>项目名称：</label>
						<form:input id="search_name" path="name" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
						
						<label>项目区域：</label>
						<form:input id="search_area" path="area" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
					</div>
				
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button id="reset" class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->

			<!-- B 工具栏 -->
			<div class="control-box">
				<shiro:hasPermission name="project:project:add">
					<table:addRow url="${ctx}/project/project/form" title="项目" width="540px" height="600px"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="project:project:del">
					<table:delRow url="${ctx}/project/project/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="project:project:import">
					<table:importExcel url="${ctx}/project/project/import"></table:importExcel><!-- 导入按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="project:project:export">
		       		<table:exportExcel url="${ctx}/project/project/export"></table:exportExcel><!-- 导出按钮 -->
		       	</shiro:hasPermission>
		       <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
			</div>
			<!-- E 表格 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-bordered table-striped table-hover dataTables-example dataTable">
				<thead>				
				<tr>
					<th><input type="checkbox" class="i-checks"></th>
					<th class="name">项目名称</th>
					<th class="projectManager">项目经理</th>
					<th class="saleManager">销售负责人</th>
					<th class="area">项目区域</th>
					<th class="stage">项目所处阶段</th>
					<th class="updateDate">更新时间</th>
					<th>操作</th>
				</tr>
				</thead>
				<c:forEach items="${page.list}" var="project">
					<tr>
						<td class="text-center"><input type="checkbox" id="${project.id}" class="i-checks"></td>
							<td class="text-center">
								<a href="javascript:;" onclick="openDialogView('查看项目', '${ctx}/project/project/form?id=${project.id}&&op=1','80%', '80%')">
									${project.name}
								</a>
							</td>
							<td class="text-center">${project.projectManager }</td>
							<c:forEach items="${fns:getRequireList()}" var="requirements"  varStatus="status">
									<c:if test="${project.requirements == requirements.id}">
										<td class="text-center">${requirements.saleManager}</td>
										<c:forEach items="${fns:getCustomerList()}" var="customer"  varStatus="status">
												<c:if test="${requirements.customer == customer.id}">
													<td class="text-center">${customer.projectBelong }</td>
												</c:if>
										</c:forEach>
									</c:if>
									
							</c:forEach>
							<td class="text-center">
								
								<span class="stage-content">${project.stage}</span>
								
							</td>
							<td class="text-center" >
								
									<fmt:formatDate value="${project.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
						<td class="btn-control text-center">
							<shiro:hasPermission name="project:project:view">
								<a href="#" onclick="openDialogView('查看项目', '${ctx}/project/project/form?id=${project.id}&&op=1','80%', '80%')"><i class="fa fa-search-plus"></i> 查看</a>
							</shiro:hasPermission>
							<span>丨</span>
							<shiro:hasPermission name="project:project:edit">
		    					<a href="#" onclick="openDialog('修改项目', '${ctx}/project/project/form?id=${project.id}','540px', '600px')"><i class="fa fa-edit"></i> 修改</a>
		    				</shiro:hasPermission>
		    				<span>丨</span>
		    				<shiro:hasPermission name="project:project:edit">
		    					<a href="#" onclick="openDialog('项目跟踪', '${ctx}/project/project/logform?id=${project.id}&&op=2','540px', '600px')"><i class="fa fa-edit"></i> 项目跟踪</a>
		    				</shiro:hasPermission>
		    				<span>丨</span>
		    				<shiro:hasPermission name="project:project:del">
								<a href="${ctx}/project/project/delete?id=${project.id}" onclick="return confirmx('确认要删除该项目吗？', this.href)"><i class="fa fa-trash"></i> 删除</a>
							</shiro:hasPermission>
							
						</td>
					</tr>
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