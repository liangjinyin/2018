<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>email管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$(document).ready(function() {
			laydate({
	            elem: '#finishTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            min: laydate.now(-90), //-1代表昨天，-2代表前天，以此类推
  				max: laydate.now(),//+1代表明天，+2代表后天，以此类推
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });

		});
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>email列表</h5>
		</div>

	    <div class="ibox-content">
			<sys:message content="${message}"/>

			<!-- B 查询条件 -->
			<form:form id="searchForm" modelAttribute="emailMessage" action="${ctx}/email/emailMessage/" method="post" class="form-inline form-box">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
				<div class="form-group">
					<label>邮件标题：</label>
						<form:input path="messageTitle" class="form-control m-b" style="height:30px;"/>
				</div>
					<div class="form-group">
					<label>发送时间：</label>
						<input id="finishTime" name="finishTime" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
							value="<fmt:formatDate value="${emailMessage.finishTime}" pattern="yyyy-MM-dd"/>"/>
					</div>
				<div class="btn-form-box">
					<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
				</div>
			</form:form>
			<!-- E 查询条件 -->

			<!-- B 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
					<tr>
						<th class="sort-column messageTitle">邮件标题</th>
						<th class="sort-column messageStatus">状态</th>
						<th  >消息接收人</th>
						<th  >消息抄送人</th>
						<th  >邮件正文</th>
						<th class="sort-column finishTime">消息发送完成时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="emailMessage">
					<tr>
						    <td   class="text-center" >
									${emailMessage.messageTitle}
							</td>
							<td   class="text-center" > 
									<c:choose>
	                      			<c:when test="${emailMessage.messageStatus==1}"> 
				                          成功
				           			</c:when>
				                     <c:otherwise>   
				                          失败
				                     </c:otherwise>
						        	</c:choose>
							</td>
							<td   class="text-center" title="${emailMessage.receiveNum}">
									<c:choose>
	                      			<c:when test="${fn:length(emailMessage.receiveNum)>10}"> 
				                         ${fn:substring(emailMessage.receiveNum, 0,8)}... 

				                        <a onclick="showDetail(this,'描述')" style="color: #ccc" >详情 </a>
				                      <!--   <a class="description" onclick="openDialogView('描述', 'a.description','50%', '50%')">详情</a> -->
				                        <textarea style="display: none;">${emailMessage.receiveNum}</textarea>
				           			</c:when>
				                     <c:otherwise>   
				                           ${emailMessage.receiveNum}
				                     </c:otherwise>
						        	</c:choose>

							</td>
							<td   class="text-center" title="${emailMessage.copytoNum}">
									<c:choose>
	                      			<c:when test="${fn:length(emailMessage.copytoNum)>10}"> 
				                         ${fn:substring(emailMessage.copytoNum, 0,8)}... 

				                        <a onclick="showDetail(this,'描述')" style="color: #ccc" >详情 </a>
				                        <textarea style="display: none;">${emailMessage.copytoNum}</textarea>
				           			</c:when>
				                     <c:otherwise>   
				                           ${emailMessage.copytoNum}
				                     </c:otherwise>
						        	</c:choose>
							</td>
							<td   class="text-center" >
									<c:choose>
	                      			<c:when test="${fn:length(emailMessage.messageContent)>10}"> 
				                         ${fn:substring(emailMessage.messageContent, 0,8)}... 

				                        <a onclick="showDetail(this,'描述')" style="color: #ccc" >详情 </a>
				                        <textarea style="display: none;">${emailMessage.messageContent}</textarea>
				           			</c:when>
				                     <c:otherwise>   
				                           ${emailMessage.messageContent}
				                     </c:otherwise>
						        	</c:choose>
							</td>
							<td   class="text-center"  > 
								<fmt:formatDate value="${emailMessage.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/> 
							</td>
							<td class="btn-control text-center">
			    				 
									<a href="${ctx}/email/emailMessage/send?id=${emailMessage.id}" onclick="return confirmx('确认要重发该email吗？', this.href)"><i class="fa fa-trash"></i> 重发</a>
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