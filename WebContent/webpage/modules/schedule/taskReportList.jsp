<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务日报管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			laydate({
	            elem: '#finisheddate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            min: laydate.now(-90), //-1代表昨天，-2代表前天，以此类推
  				max: laydate.now(-1),//+1代表明天，+2代表后天，以此类推
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });

		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>任务日报列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="taskReport" action="${ctx}/project/project/task-report/" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
				
					<div class="form-group">
					<label>责任人：</label>
						<form:select path="assignedto"  class="form-control m-b" style="height:30px;">
							<form:option value="" label="请选择"/>
							<c:forEach items="${fns:fundEmployee()}" var="emp">
								<form:option value="${emp}" label="${emp}"/>
							</c:forEach>
						</form:select>
					</div>
					<div class="form-group">
					<label>完成时间：</label>
						<input id="finisheddate" name="finisheddate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
							value="<fmt:formatDate value="${taskReport.finisheddate}" pattern="yyyy-MM-dd"/>"/>
					</div>
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button class="btn btn-blue btn-sm" onclick="resetForm()" ><i class="fa fa-refresh"></i> 重置</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">

				<colgroup> 
					<col style="width: 4%;"> 
					<col style="width: 8%;"> 
					<col style="width: 8%;"> 
					<col style="width: 8%;"> 
					<col style="width: 5%;"> 
					<col style="width: 5%;"> 
					<col style="width: 5%;"> 
					<col style="width: 5%;"> 
					<col style="width: 5%;"> 
					<col style="width: 4%;"> 
					<col style="width: 9%;"> 
					<col style="width: 9%;"> 
					<col style="width: 9%;"> 
					<col style="width: 5%;"> 
					<col style="width: 5%;">
					<col style="width: 6%;">   
				</colgroup>
				<thead>
					<tr>
						<th >责任人</th>
						<th >项目名称</th>
						<th >任务名称</th>
						<th >描述</th>
						<th  >任务类型</th>
						<th  >状态</th>
						<th >进度</th>
						<th  >开始时间</th>
						<th  >截止时间</th>
						<th >创建者</th>
						<th  >估计时间（小时）</th>
						<th  >耗费时间（小时）</th>
						<th  >剩余时间（小时）</th>
						<th  >开始键建</th>
						<th  >完成时间</th>
						<th  >完成人</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="taskReport">
					<tr>
						
							<td  
								 class="text-left"
							>
								 
									 ${taskReport.assignedto}
								 
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.projectname}
								
							</td>
							
							<td   class="text-left" >
								
								   <c:choose>
	                      			<c:when test="${fn:length(taskReport.taskname)>4}"> 
				                         ${fn:substring(taskReport.taskname, 0, 4)}... 
				                        <a onclick="showDetail(this,'描述')" style="color: #ccc" >详情 </a>
				                        <input type="hidden" value=" ${taskReport.taskname}" />
				           			</c:when>
				                     <c:otherwise>   
				                           ${taskReport.taskname}
				                     </c:otherwise>
						        	</c:choose>
								
							</td>
							<td  
								 class="text-left"
							>
								<c:choose>
	                      			<c:when test="${fn:length(taskReport.desc)>4}"> 
				                         ${fn:substring(taskReport.desc, 0, 4)}... 
				                        <a onclick="showDetail(this,'描述')" style="color: #ccc" >详情 </a>
				                        <input type="hidden" value=" ${taskReport.desc}" />
				           			</c:when>
				                     <c:otherwise>   
				                           ${taskReport.desc}
				                     </c:otherwise>
						        </c:choose>
								
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.tasktype}
								
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.status}
								
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.procesed}
								
							</td>
							<td  
								 class="text-center" 
															>
								
									<fmt:formatDate value="${taskReport.eststarted}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
							<td  
								 class="text-center" 
															>
								
									<fmt:formatDate value="${taskReport.deadline}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.openedby}
								
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.estimate}
								
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.consumed}
								
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.left}
								
							</td>
							<td  
								 class="text-center" 
															>
								
									<fmt:formatDate value="${taskReport.realstarted}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
							<td  
								 class="text-center" 
															>
								
									<fmt:formatDate value="${taskReport.finisheddate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
							<td  
								 class="text-left"
							>
								
									${taskReport.finishedby}
								
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