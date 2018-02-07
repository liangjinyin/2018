<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>基线测试管理</title>
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
		<h5>基线测试列表 </h5>
		<div class="ibox-tools">
			<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-wrench"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#">选项1</a>
				</li>
				<li><a href="#">选项2</a>
				</li>
			</ul>
			<a class="close-link">
				<i class="fa fa-times"></i>
			</a>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="baseTest" action="${ctx}/basetest/baseTest/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>产品名称：</span>
				<form:input path="product" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
		 </div>	
		 <div class="btn-form-box">
			<button  class="btn btn-blue btn-sm" onclick="search()" > 查询</button>
			<button  class="btn btn-blue btn-sm" onclick="resetForm()" > 重置</button>
		</div>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="basetest:baseTest:add">
				<table:addRow url="${ctx}/basetest/baseTest/form" title="基线测试" width="1058" height="702"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			
			<shiro:hasPermission name="basetest:baseTest:del">
				<table:delRow url="${ctx}/basetest/baseTest/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
			</div>
		
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column id">基线编号</th>
				<th  class="sort-column product">产品名称</th>
				<th  class="sort-column title">基线标题</th>
				<th  class="sort-column testtime">测试轮次</th>
				<th  class="sort-column updateBy">创建者</th>
				<th  class="sort-column updateDate">更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseTest">
			<tr>
				<td class="text-center"> <input type="checkbox" id="${baseTest.id}" class="i-checks"></td>
				<td class="text-center"><a  href="#" onclick="openDialogView('查看基线测试', '${ctx}/basetest/baseTest/form?id=${baseTest.id}','800px', '500px')">
					BL${baseTest.id}
				</a></td>
				<td class="text-center">
					<c:forEach items="${fns:getProductList()}" var="product"  varStatus="status">
						<c:if test="${product.id  == baseTest.product}">
							${product.name}
						</c:if>
					</c:forEach>
				</td>
				<td class="text-center">
					${baseTest.title}
				</td>
				<td class="text-center">
					${baseTest.testtime}
				</td>
				<td class="text-center">
					${baseTest.createBy.name}
				</td>
				<td class="text-center">
					
					<fmt:formatDate value="${baseTest.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="text-center">
				
					<shiro:hasPermission name="basetest:baseTest:edit">
    					<a href="#" onclick="openDialog('修改基线测试', '${ctx}/basetest/baseTest/form?id=${baseTest.id}&op=1','1200px', '702px')" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="basetest:baseTest:del">
						<a href="${ctx}/basetest/baseTest/delete?id=${baseTest.id}" onclick="return confirmx('确认要删除该基线测试吗？', this.href)" >| <i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>