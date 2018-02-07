<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>招标信息管理</title>
	<meta name="decorator" content="default"/>

	<script type="text/javascript">
		$(document).ready(function() {
			
			laydate({
		            elem: '#r_time', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });
			laydate({
		            elem: '#t_time', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });

			

			 $(".rows").mouseover(function(){
					
				$(this).addClass("tejiao");
			});

			 $(".rows").mouseout(function(){
						
				$(this).removeClass("tejiao");
			})	
			
		});
	</script>
	<style type="text/css">
	
	.tejiao{
		background-color: #DDE9F1;
	}

	.rows{
		margin-top:-2px; 

	}
	.span{
		margin-top:-2px;
	}
	</style>
</head>
<body class="gray-bg">
	  <div class="wrapper wrapper-content">
		<div class="ibox">
			<div class="ibox-title">
				<h5>招标信息列表</h5>
			</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>
			<form:form id="searchForm" modelAttribute="investmentInfo" action="${ctx}/niche/investmentInfo/" method="post" class="form-inline">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
				<div class="form-group">
					<span>项目名称：</span>
						<form:input path="programName" htmlEscape="false"  class=" form-control input-sm"/>
				</div>
				<div>
					<div class="form-group">
						<span>发布时间：</span>
							<input id="r_time" name="time" type="text" maxlength="20"   class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${investmentInfo.time}" pattern="yyyy-MM-dd"/>"/>		 <span>-</span>				 
							
							 <input id="t_time" name="time1" type="text" maxlength="20"   class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${investmentInfo.time1}" pattern="yyyy-MM-dd"/>"/>	
					 </div>
				 </div>	
				<div>
					<div class="form-group">
						 
						<span>所属公司：</span>
						<form:input path="companyBelong" htmlEscape="false" maxlength="11"  class=" form-control input-sm"/>
					</div>
					<div class="btn-form-box">
						<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
						<button class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
					</div>
				</div>
			</form:form>

			<div class="control-box">		
		       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		    </div>
	
		<!-- 表格 -->
	<table id="contentTable" class="table table-striped  table-bordered  table-hover table-condensed dataTables-example dataTable ">
		
		
		<tbody>

		<c:forEach items="${page.list}" var="investmentInfo">
		<tr><td><div class="rows">
			
			<div class="span" style="float:right;width:15%  ;height:150px;text-align:center;padding:60px; ">
				

					<a  href="#" onclick="openDialogView('查看招标信息', '${investmentInfo.url}','100%', '100%')">
						
						<span>查看详情</span>
				    </a>
			</div>

			<div class="span" style="float:left; width:60%; height:150px;padding:40px;">

				<span><strong>项目名称:</strong></span>
				 ${investmentInfo.programName} </br>
				<span><strong>所属公司:</strong></span>
				${investmentInfo.companyBelong}</br>
				
				<span><strong>项目类型:</strong></span>
				<c:if test =  "${investmentInfo.projectType == 1}">
					<c:out  value = "服务类型"/>
					</c:if>
					<c:if test =  "${investmentInfo.projectType == 2} }">
					<c:out  value = "综合"/>
				</c:if>	</br>
				<span><strong>所属行业:</strong></span>
				<c:if test =  "${investmentInfo.trade == 1}">
					<c:out  value = "电力"/>
					</c:if>
					<c:if test =  "${investmentInfo.trade == 2}">
					<c:out  value = "运营商"/>
					</c:if>
					<c:if test =  "${investmentInfo.trade == 3}">
					<c:out  value = "政府"/>
				</c:if>

			</div>

			<div class="span time" style="floar:width:25%; height:150px;text-align:center;padding:60px; ">
				
				<span>发布时间:</span>
				<fmt:formatDate value="${investmentInfo.time}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</div>

			
			</div></td></tr>
		</c:forEach>
		</tbody>
	</table>
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
     </div>
	</div>
</div>
</body>
</html>