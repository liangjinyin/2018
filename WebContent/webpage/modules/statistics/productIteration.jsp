<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			
			laydate({
	            elem: '#beginTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
	        laydate({
	            elem: '#endTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
			
		});
		$(document).ready(function(){
			$("#contentTable tr td").mouseover(function(){
				$(this).css("background-color","#DDE9F1");
			}).mouseout(function(){
				$(this).css("background-color","#FFFFFF");
			});
		});
	</script>

</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>产品迭代统计表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="ProductIteration" action="${ctx}/statistics/statistics/productIteration" method="post" class="form-inline form-box">

					<div class="form-group">
					<label>产品名称：</label>
						<input id="product"  name="product"  maxlength="64"  class=" form-control input-sm" value="${product }"/>
						
						<label>迭代起止时间：</label>
						<input id="beginTime" name="beginTime" type="text" maxlength="20" class="laydate-icon form-control layer-date"
								value="<fmt:formatDate value="${beginTime}" pattern="yyyy-MM-dd"/>"/>
						至
						<input id="endTime" name="endTime" type="text" maxlength="20" class="laydate-icon form-control layer-date"
								value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd"/>"/>
					</div>
				
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button id="reset" class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->


			<!-- B 表格 -->
			<table id="contentTable" class="table table-bordered dataTables-example dataTable">
				<thead>				
				<tr>
					<th>产品名称</th>
					<th>产品负责人</th>
					<th>迭代</th>
					<th>总预计</th>
					<th>总消耗</th>
					<th>偏差</th>
					<th>偏差率</th>
				</tr>
				</thead>
				<c:forEach items="${productIterations}" var="productIteration">
					<c:set var="estimate" value="${fns:sumEstimateByIterater(productIteration.iteraters[0].id) }"></c:set>
					<c:set var="consumed" value="${fns:sumConsumedByIterater(productIteration.iteraters[0].id) }"></c:set>
					<c:set var="deviation" value="${consumed - estimate }"></c:set>
					<c:set var="rows" value="${productIteration.iteraters.size() }"></c:set>
					<c:if test="${rows > 1 }">
						<c:set var="rows" value="${rows*2 -1}"></c:set>
					</c:if>
					<c:choose>
						<c:when test="${estimate == null }">
							<c:set var="estimate" value="0"></c:set>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${consumed == null }">
							<c:set var="consumed" value="0"></c:set>
						</c:when>
					</c:choose>
					<tr>
						<td align="center" rowspan="${rows }">${productIteration.product }</td>
						<td align="center" rowspan="${rows }">${productIteration.proManager }</td>
						<td align="center">${productIteration.iteraters[0].name }</td>
						<td align="center">${estimate }</td>
						<td align="center">${consumed }</td>
						<c:choose>
							<c:when test="${deviation < 0 }">
								<td align="center"><span class="glyphicon glyphicon-arrow-down" style="color:#90EE90"></span> <fmt:formatNumber value="${deviation*(-1) }" pattern="#,##0.00"/></td>
							</c:when>
							<c:when test="${deviation == 0 }">
								<td align="center"><span class="glyphicon glyphicon-resize-horizontal" style="color:#00EE00"></span> <fmt:formatNumber value="${deviation }" pattern="#,##0.00"/></td>
							</c:when>
							<c:otherwise>
								<td align="center"><span class="glyphicon glyphicon-arrow-up" style="color:red"></span> <fmt:formatNumber value="${deviation }" pattern="#,##0.00"/></td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${estimate != 0 }">
								<c:choose>
									<c:when test="${deviation/estimate < 0 }">
										<td align="center" style="color:#90EE90"><fmt:formatNumber value="${deviation/estimate*(-100) }" pattern="#,##0.00"/>%</td>
									</c:when>
									<c:when test="${deviation/estimate == 0 }">
										<td align="center" style="color:#00EE00"><fmt:formatNumber value="0" pattern="#,##0.00"/>%</td>
									</c:when>
									<c:when test="${deviation/estimate > 0 }">
										<td align="center" style="color:red"><fmt:formatNumber value="${deviation/estimate*100 }" pattern="#,##0.00"/>%</td>
									</c:when>
								</c:choose>
							</c:when>
							<c:otherwise>
								<td align="center" style="color:#00EE00"><fmt:formatNumber value="0" pattern="#,##0.00"/>%</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<c:forEach items="${productIteration.iteraters }" var="iterater" varStatus="status">
						<c:set var="estimate" value="${fns:sumEstimateByIterater(iterater.id) }"></c:set>
						<c:set var="consumed" value="${fns:sumConsumedByIterater(iterater.id) }"></c:set>
						<c:set var="deviation" value="${consumed - estimate }"></c:set>
						<c:choose>
							<c:when test="${estimate == null }">
								<c:set var="estimate" value="0"></c:set>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${consumed == null }">
								<c:set var="consumed" value="0"></c:set>
							</c:when>
						</c:choose>
						<c:if test="${status.count != 1 }">
							<tr>
								<!-- <td align="center"></td>
								<td align="center"></td> -->
								<td align="center">${iterater.name }</td>
								<td align="center">${estimate }</td>
								<td align="center">${consumed }</td>
								<c:choose>
									<c:when test="${deviation < 0 }">
										<td align="center"><span class="glyphicon glyphicon-arrow-down" style="color:#90EE90"></span> <fmt:formatNumber value="${deviation*(-1) }" pattern="#,##0.00"/></td>
									</c:when>
									<c:when test="${deviation == 0 }">
										<td align="center"><span class="glyphicon glyphicon-resize-horizontal" style="color:#00EE00"></span> <fmt:formatNumber value="${deviation }" pattern="#,##0.00"/></td>
									</c:when>
									<c:otherwise>
										<td align="center"><span class="glyphicon glyphicon-arrow-up" style="color:red"></span> <fmt:formatNumber value="${deviation }" pattern="#,##0.00"/></td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${estimate != 0 }">
										<c:choose>
											<c:when test="${deviation/estimate < 0 }">
												<td align="center" style="color:#90EE90"><fmt:formatNumber value="${deviation/estimate*(-100) }" pattern="#,##0.00"/>%</td>
											</c:when>
											<c:when test="${deviation/estimate == 0 }">
												<td align="center" style="color:#00EE00"><fmt:formatNumber value="0" pattern="#,##0.00"/>%</td>
											</c:when>
											<c:when test="${deviation/estimate > 0 }">
												<td align="center" style="color:red"><fmt:formatNumber value="${deviation/estimate*100 }" pattern="#,##0.00"/>%</td>
											</c:when>
										</c:choose>
									</c:when>
									<c:otherwise>
										<td align="center" style="color:#00EE00"><fmt:formatNumber value="0" pattern="#,##0.00"/>%</td>
									</c:otherwise>
								</c:choose>
							<tr>
						</c:if>
					</c:forEach>	
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