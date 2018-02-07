<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>产品管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var table = document.getElementById('contentTable');
			//获取表格中全部标签为span对象
			var span = table.getElementsByTagName("span");
			//为项目所处阶段列的值加背景色
			
			for(var j=0;j<span.length;j++) {
				switch(span[j].innerText) {
	                case '正常':
	                	span[j].style.background = '#63C613';
	                    break;
	                case '结束':
	                	span[j].style.background = 'red';
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
		<h5>产品列表 </h5>
		<div class="ibox-tools">
			<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<!-- <a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-wrench"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#">选项1</a>
				</li>
				<li><a href="#">选项2</a>
				</li>
			</ul> -->
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
	<form:form id="searchForm" modelAttribute="product" action="${ctx}/product/product/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>产品名称：</span>
				<form:input path="name" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>产品状态：</span>
				<form:select path="status" style="width:200px;" class="form-control m-b">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('pro_status')}"  itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
		 </div>	
		 <div class="btn-form-box">
						<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
						<button class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="product:product:add">
				<table:addRow url="${ctx}/product/product/add" width="540px;" height="600px;" title="产品"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			
			<shiro:hasPermission name="product:product:del">
				<table:delRow url="${ctx}/product/product/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
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
				<th  class="sort-column id">产品代号</th>
				<th  class="sort-column name">产品名称</th>
				<th  class="sort-column proManager">产品负责人</th>
				<th  class="sort-column iterNum">迭代数</th>
				<th  class="sort-column status">产品状态</th>
				<th  class="sort-column updateDate">更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="product">
			<tr>
				<td class="text-center"> <input type="checkbox" id="${product.id}" class="i-checks"></td>
				<td  class="text-center">
					P${product.id}
				</td>
				<td  class="text-center">
					${product.name}
				</td>
				<td  class="text-center">
					${product.proManager}
				</td>
				<td  class="text-center">
					<c:choose>
						<c:when test="${product.iterNum==null}">
							0
						</c:when>
						<c:otherwise>
						${product.iterNum}
						</c:otherwise>
					</c:choose>
					
				</td>
				<td  class="text-center">
					<span class="stage-content">${product.status}</span>
					
				</td>
				<td  class="text-center">
					<fmt:formatDate value="${product.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="text-center">
					<shiro:hasPermission name="product:product:view">
						<a href="#" onclick="openDialogView('查看产品', '${ctx}/product/product/look?id=${product.id}','1058px', '702px')"><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<span>|</span>
					<shiro:hasPermission name="product:product:edit">
    					<a href="#" onclick="openDialog('修改产品', '${ctx}/product/product/form?id=${product.id}','1058px', '702px')"><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<span>|</span>
					<shiro:hasPermission name="iterater:iterater:add">
    					<a href="#" onclick="openDialog('新建迭代', '${ctx}/product/product/iterForm?id=${product.id}','540px', '600px')"><i class="fa fa-black-tie"></i> 新建迭代</a>
    				</shiro:hasPermission>
    				<span>|</span>
    				<shiro:hasPermission name="product:product:del">
						<a href="${ctx}/product/product/delete?id=${product.id}" onclick="return confirmx('确认要删除该产品吗？', this.href)"><i class="fa fa-trash"></i> 删除</a>
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