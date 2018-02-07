<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
			var table = document.getElementById('contentTable');
			//获取表格中全部标签为span对象
			var span = table.getElementsByTagName("span");
			//为项目所处阶段列的值加背景色
			


			for(var j=0;j<span.length;j++) {
				switch(span[j].innerText) {
	                case '潜在客户':
	                	span[j].style.background = '#09B299';
	                    break;
	                case '正在跟进客户':
	                	span[j].style.background = '#63C613';
	                    break;
	                case '已成交客户':
	                	span[j].style.background = '#FFA602';
						
	                    break;
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
			text-align:center; 
			
		}
	</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>客户列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/> 
			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="customer" action="${ctx}/customer/customer/" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
				<div class="form-group">
					<label>客户名称：</label>
						<form:input id="search_name" path="name" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
					
					<label>客户状态：</label>
						 <form:select id="search_status" path="status" class="form-control input-sm" >
							<form:option value=""></form:option>
							<form:option value="潜在客户">潜在客户</form:option>
							<form:option value="正在跟进客户">正在跟进客户</form:option>
							<form:option value="已成交客户">已成交客户 </form:option>
						</form:select> 
						
					</div>			
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button id="reset" class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->

			<!-- B 工具栏 -->
			<div class="control-box">
				<shiro:hasPermission name="customer:customer:add">
					<table:addRow url="${ctx}/customer/customer/form" title="客户" width="540px;" height="600px;"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
				<!-- <shiro:hasPermission name="customer:customer:edit">
				    <table:editRow url="${ctx}/customer/customer/form" title="客户" id="contentTable"></table:editRow>编辑按钮
				</shiro:hasPermission> -->
				<shiro:hasPermission name="customer:customer:del">
					<table:delRow url="${ctx}/customer/customer/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="customer:customer:import">
					<table:importExcel url="${ctx}/customer/customer/import"></table:importExcel><!-- 导入按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="customer:customer:export">
		       		<table:exportExcel url="${ctx}/customer/customer/export"></table:exportExcel><!-- 导出按钮 -->
		       	</shiro:hasPermission>
		       <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
			</div>
			<!-- E 表格 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
					<tr>
						<th><input type="checkbox" class="i-checks"></th>
						<th class="sort-column name">客户名称</th>
						<th class="sort-column address">案场位置</th>
						<th class="sort-column address">目标户型</th>
						<th class="sort-column contacts">置业顾问</th>
						<th class="sort-column phone">置业顾问电话</th>
						<th class="sort-column updateDate">客户状态</th>
						<th class="sort-column updateDate">更新时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="customer">
					<tr>
						<td class="text-center"><input type="checkbox" id="${customer.id}" class="i-checks"></td>
							<td  
								 class="text-center"
							>
								<a href="javascript:;" onclick="openDialogView('查看客户', '${ctx}/customer/customer/form?id=${customer.id}&&op=1','540px;', '600px;')">
									${customer.name}
								</a>
							</td>
							<td  
								 class="text-center"
							>
								
									${customer.address}
								
							</td>
							<td  
								 class="text-center"
							>
								
									${customer.target}
								
							</td>
							<td  
								 class="text-center"
							>
								
									${customer.contacts}
								
							</td>
							<td  
								 class="text-center"
							>
								
									${customer.phone}
								
							</td>
							<td  
								 class="text-left"
							>
									<span class="stage-content">${customer.status}</span>
								
							</td>
							
							<td  
								 class="text-center"
															>
								
									<fmt:formatDate value="${customer.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
						<td class="btn-control text-center">
							<shiro:hasPermission name="customer:customer:edit">
		    					<a id="xiu" href="#" onclick="openDialog('修改客户', '${ctx}/customer/customer/form?id=${customer.id}','540px;', '600px;')"><i class="fa fa-edit"></i> 修改</a>
		    				</shiro:hasPermission>
		    				<span>丨</span>
		    				<shiro:hasPermission name="customer:customer:del">
								<a href="${ctx}/customer/customer/delete?id=${customer.id}" onclick="return confirmx('确认要删除该客户吗？', this.href)"><i class="fa fa-trash"></i> 删除</a>
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