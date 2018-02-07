<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>案场管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		
		laydate({
	            elem: '#b_times', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'click', //响应事件。如果没有传入event，则按照默认的click
            	
			
	        });

		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>案场列表 </h5>
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
	<form:form id="searchForm" modelAttribute="cases" action="${ctx}/cases/cases/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>案场负责人：</span>
				<form:input path="charge" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>所属集团：</span>
				<form:input path="company" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>开盘时间：</span>
				<input id="b_times" name="beginTime" type="text" maxlength="20" style="width:200px;"  class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${cases.beginTime}" pattern="yyyy-MM-dd"/>"/>
		 </div>
		 <div class="btn-form-box">
			<button  class="btn btn-blue btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-blue btn-sm " onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
		 	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="cases:cases:add">
				<table:addRow url="${ctx}/cases/cases/form" title="案场"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			</div>
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column name">案场名称</th>
				<th  class="sort-column address">案场位置</th>
				<th  class="sort-column company">所属集团</th>
				<th  class="sort-column beginTime">开盘时间</th>
				<th  class="sort-column charge">负责人</th>
				<th  class="sort-column phone">负责人电话</th>
				<th  class="sort-column createBy.name">创建者</th>
				<th  class="sort-column updateDate">更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cases">
			<tr>
				<td class="text-center"> <input type="checkbox" id="${cases.id}" class="i-checks"></td>
				<td class="text-center">
					${cases.name}
				</td>
				<td class="text-center">
					${cases.address}
				</td>
				<td class="text-center">
					${cases.company}
				</td>
				<td class="text-center">
					<fmt:formatDate value="${cases.beginTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td class="text-center">
					${cases.charge}
				</td>
				<td class="text-center">
					${cases.phone}
				</td>
				<td class="text-center"><a  href="#" onclick="openDialogView('查看案场', '${ctx}/cases/cases/form?id=${cases.id}','540px', '600px')">
					${cases.createBy.name}
				</a></td>
				<td class="text-center">
					<fmt:formatDate value="${cases.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="text-center">
					<shiro:hasPermission name="cases:cases:view">
						<a href="#" onclick="openDialogView('查看案场', '${ctx}/cases/cases/form?id=${cases.id}','540px', '600px')" > 查看</a><span> |</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="cases:cases:edit">
    					<a href="#" onclick="openDialog('修改案场', '${ctx}/cases/cases/form?id=${cases.id}','1000px', '800px')"  > 修改</a><span> |</span>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="cases:cases:del">
						<a href="${ctx}/cases/cases/delete?id=${cases.id}" onclick="return confirmx('确认要删除该案场吗？', this.href)"> 删除</a>
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