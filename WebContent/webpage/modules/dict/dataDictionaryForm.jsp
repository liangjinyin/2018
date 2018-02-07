<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>数据字典管理</title>
	<meta name="decorator" content="default"/>
</head>
<body class="form-padding">
	<div class="c-well no-border">
		<div class="c-well-title">表信息</div>
		<table class="table table-striped table-bordered table-condensed table-inform" >
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="35%">
			</colgroup>
			<tbody>
				<tr>
					<td>表名称：</td>
					<td>${table.tableName}</td>
					<td>表描述：</td>
					<td>${table.tableComment}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="c-well no-border">
		<div class="c-well-title">字段信息</div>
		<table class="table table-striped table-bordered table-condensed">
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="35%">
			</colgroup>
			<thead>
				<tr>
					<!-- <th class="hide"></th> -->
					<th>名称</th>
					<th>类型</th>
					<th>主键</th>
					<th>描述</th>
					<!-- <th width="10">&nbsp;</th> -->
				</tr>
			</thead>
			<tbody >
				<c:forEach items="${clums}" var="clum">
					<tr >
						<!-- <td class="hide"></td>  -->
						<td class="text-center">${clum.columnName}</td>
						<td>${clum.columnType}</td>
						<td class="text-center">
						<c:choose >
						   <c:when test="${clum.columnKey=='PRI'}"> Yes</c:when>
						   <c:otherwise>No </c:otherwise>
						</c:choose>		
						</td>
						<td>${clum.columnComment}</td>
						<!-- <td width="10">&nbsp;</td> -->
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>