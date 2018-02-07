<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>房型管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		
		});
	</script>
</head>
<body class="gray-bg">
	
	<div class="ibox">
	<div class="ibox-title">
		<h5>房型列表 </h5>
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
	<form:form id="searchForm" modelAttribute="houses" action="${ctx}/houses/houses/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>房价：</span>
				<form:input path="price" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>面积：</span>
				<form:input path="area" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>

		</div>	
		<div class="btn-form-box">
			<button  class="btn btn-blue btn-sm " onclick="search()" >查询</button>
			<button  class="btn btn-blue btn-sm " onclick="resetForm()" >重置</button>
		</div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="houses:houses:add">
				<table:addRow url="${ctx}/houses/houses/form" title="房型"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="houses:houses:edit">
			    <table:editRow url="${ctx}/houses/houses/form" title="房型" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="houses:houses:del">
				<table:delRow url="${ctx}/houses/houses/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
					
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column cases">所属楼盘</th>
				<th  class="sort-column type">房子类型</th>
				<th  class="sort-column spare">剩余数量</th>
				<th  class="sort-column price">房价</th>
				
				<th  class="sort-column area">面积</th>
				
				
				<th  class="sort-column createBy.name">创建者</th>
				<th  class="sort-column updateDate">更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="houses">
			<tr>
				<td class="text-center"> <input type="checkbox" id="${houses.id}" class="i-checks"></td>
				
				<td class="text-center">
					${houses.cases}
				</td>
				<td class="text-center">
					${houses.type}
				</td>
				<td class="text-center">
					${houses.spare}
				</td>
				<td class="text-center">
					${houses.price}万
				</td>
				
				<td class="text-center">
					${houses.area}㎡
				</td>
				
				
				<td class="text-center"><a  href="#" onclick="openDialogView('查看房型', '${ctx}/houses/houses/form?id=${houses.id}','800px', '500px')">
					${houses.createBy.name}
				</a></td>
				<td class="text-center">
					<fmt:formatDate value="${houses.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="text-center">
					<shiro:hasPermission name="houses:houses:view">
						<a href="#" onclick="openDialogView('查看房型', '${ctx}/houses/houses/form?id=${houses.id}','800px', '500px')">查看</a><span> |</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="houses:houses:edit">
    					<a href="#" onclick="openDialog('修改房型', '${ctx}/houses/houses/form?id=${houses.id}','800px', '500px')">修改</a><span> |</span>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="houses:houses:del">
						<a href="${ctx}/houses/houses/delete?id=${houses.id}" onclick="return confirmx('确认要删除该房型吗？', this.href)" >删除</a>
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