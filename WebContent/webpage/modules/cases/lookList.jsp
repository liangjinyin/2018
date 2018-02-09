<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		
		
	</script>
	
	
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>案场看板</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/> 
			<!-- B 查询条件 -->
			  <%-- <form:form id="searchForm" modelAttribute="Look" action="${ctx}/cases/cases/lookList" method="post" class="form-inline form-box">
				<div class="form-group">
					<label>客户名称：</label>
						<form:input path="casesName" htmlEscape="false" maxlength="64"  class="form-control input-sm"/>
					</div>			
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button id="reset" class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>  --%> 
			<!-- E 查询条件 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
					<tr>
						<th><input type="checkbox" class="i-checks"></th>
						<th >案场名称</th>
						<th >已售楼房</th>
						<th >剩余楼房</th>
						<th >本月销售额</th>
						<th >本月出售楼房</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${record}" var="record">
					<tr>
						<td class="text-center"><input type="checkbox"  class="i-checks"></td>
							<td class="text-center">
									${record.casesName}
							</td>
							<td class="text-center">
									${record.sold}套
							</td>
							<td class="text-center">
									${record.spare}套
							</td>
							<td class="text-center">
									${record.price}万 
									<c:if test="${record.level == 'down'}">
										<span class="glyphicon glyphicon-arrow-down" style="color:#90EE90"></span>
									</c:if>
									<c:if test="${record.level  == 'up'}">
										<span class="glyphicon glyphicon-arrow-up" style="color:#F00"></span>
									</c:if>
							</td>
							<td class="text-center">
									${record.coun}套
							</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<!-- E 表格 -->
			
		</div>
	</div>
	</div>
</body>
</html>