<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务信息管理</title>
	<meta name="decorator" content="default"/>
	<!-- <link rel="stylesheet" href="fonts/iconfont.css"> -->
	<script type="text/javascript">
		$(document).ready(function() {
			var table = document.getElementById("contentTable"); 
			for(var i=1; i<table.rows.length; i++){
				var status = table.rows[i].cells[4].innerText;
				if(status == '未开始' || status == '进行中' || status == '已关闭') {
					document.getElementById("closed_"+i).setAttribute('disabled',true);
				}
			}
			
		});
	</script>
	<style>
		
@font-face {font-family: "iconfont";
  src: url('iconfont.eot?t=1507687367089'); /* IE9*/
  src: url('iconfont.eot?t=1507687367089#iefix') format('embedded-opentype'), /* IE6-IE8 */
  url('data:application/x-font-woff;charset=utf-8;base64,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') format('woff'),
  url('iconfont.ttf?t=1507687367089') format('truetype'), /* chrome, firefox, opera, Safari, Android, iOS 4.2+*/
  url('iconfont.svg?t=1507687367089#iconfont') format('svg'); /* iOS 4.1- */
}

.iconfont {
  font-family:"iconfont" !important;
  font-size:16px;
  font-style:normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.icon-guanbi:before { content: "\e62a"; }

.icon-shouxiangyou:before { content: "\e6b0"; }

.icon-caidan:before { content: "\e671"; }

.icon-rizhi:before { content: "\e681"; }

.icon-down-trangle:before { content: "\e610"; }

.icon-xiangxia:before { content: "\e600"; }


	</style>
</head>
<body class="gray-bg">
			<div class="wrapper wrapper-content">
				<div class="ibox">
				<div class="ibox-title">
					<h5>任务信息列表 </h5>
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
				<form:form id="searchForm" modelAttribute="taskInfo" action="${ctx}/task/taskInfo/" method="post" class="form-inline" cssStyle="display:inline;">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
					<div class="form-group">
						<span>所属迭代：</span>
							<form:select path="iteration"  class="form-control m-b" cssStyle="width:300px">
								<%-- <form:option value="" label=""/> --%>
								<form:options items="${fns:getIteraterList()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
							</form:select>
							&nbsp;&nbsp;
							<span>状态：</span>
							<form:select path="status"  class="form-control m-b" cssStyle="width:150px">
								<form:options items="${fns:getDictList('search_task_status')}" itemLabel="label" itemValue="Value" htmlEscape="false"/>
							</form:select>
					 </div>	
					 <div class="btn-form-box">
						<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					</div>
				</form:form>
				<div class="pull-right" style="display: inline;">
						<shiro:hasPermission name="task:taskInfo:add">
							<table:addRow url="${ctx}/task/taskInfo/form" title="建任务" width="540px" height="600px"></table:addRow><!-- 增加按钮 -->
						</shiro:hasPermission>
						<shiro:hasPermission name="task:taskInfo:addMore">
							<a href="#" onclick="openDialog('批量添加任务', '${ctx}/task/taskInfo/addMore','1900px', '920px')" class="btn btn-white btn-sm toolbar" ><i class="fa fa-plus white"></i> 批量添加</a>
						</shiro:hasPermission>
						<shiro:hasPermission name="task:taskInfo:export">
				       		<table:exportExcel url="${ctx}/task/taskInfo/export"></table:exportExcel><!-- 导出按钮 -->
				       	</shiro:hasPermission>
					</div>
				<br/>
				</div>
				</div>
				
				<!-- 工具栏 -->
				<div class="row">
				<div class="col-sm-12">
					<div class="pull-left">
						<shiro:hasPermission name="task:taskInfo:add">
							<table:addRow url="${ctx}/task/taskInfo/form" title="建任务" width="540px" height="600px"></table:addRow><!-- 增加按钮 -->
						</shiro:hasPermission>
						<shiro:hasPermission name="task:taskInfo:del">
							<table:delRow url="${ctx}/task/taskInfo/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
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
							<th  class="sort-column id">ID</th>
							<th  class="sort-column pri">优先级</th>
							<th  class="sort-column name">任务名称</th>
							<th  class="sort-column status">状态</th>
							<th  class="sort-column deadline">截止日期</th>
							<th  class="sort-column createDate">创建日期</th>
							<th  class="sort-column assignedTo">指派给</th>
							<th  class="sort-column consumed">耗时</th>
							<th  class="sort-column surplus">剩余</th>
							<th  class="sort-column updateDate">更新时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="taskInfo" varStatus="status">
						<tr>
							<td align="center"> <input type="checkbox" id="${taskInfo.id}" class="i-checks"></td>
							<td align="center">
								${taskInfo.id}
							</td>
							<td align="center">
								${taskInfo.pri}
							</td>
							<td align="center">
								<a  href="#" onclick="openDialogView('查看任务信息', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')">
								${taskInfo.name}
								</a>
							</td>				
							<td align="center">
								${taskInfo.status}
							</td>
							<td align="center">
								<fmt:formatDate value="${taskInfo.deadline}" pattern="MM-dd"/>
							</td>
							<td align="center">
								<fmt:formatDate value="${taskInfo.createDate}" pattern="MM-dd"/>
							</td>
							<td align="center">
								${taskInfo.assignedTo}
							</td>
							<td align="center">
								<fmt:formatNumber value="${taskInfo.consumed}" pattern="#,###"/>
							</td>
							<td align="center">
							<fmt:formatNumber value="${taskInfo.surplus}" pattern="#,###"/>
								
							</td>
							<td align="center">
								<fmt:formatDate value="${taskInfo.updateDate}" pattern="MM-dd"/>
							</td>
							<td align="center">
								<shiro:hasPermission name="task:taskInfo:assigned">
			    					<a href="#" onclick="openDialog('指派', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=1','540px', '600px')"><i class="iconfont icon-shouxiangyou"></i> 指派</a>
			    				</shiro:hasPermission>
			    				<span>|</span>
								<shiro:hasPermission name="task:taskInfo:edit">
			    					<a href="#" onclick="openDialog('编辑任务信息', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" ><i class="fa fa-edit"></i> 修改</a>
			    				</shiro:hasPermission>
			    				<span>|</span>
								<shiro:hasPermission name="task:taskLog:logs">
			    					<a href="#" onclick="openDialog('新增日志', '${ctx}/task/taskLog/logs?id=${taskInfo.id }','890px', '686px')"><i class="iconfont icon-rizhi"></i> 日志</a>
			    				</shiro:hasPermission>
			    				<span>|</span>
			    				<shiro:hasPermission name="task:taskInfo:closed">
			    				<a id="closed_${status.count }" href="${ctx}/task/taskInfo/closed?id=${taskInfo.id}" onclick="return confirmx('确认要关闭该任务信息吗？', this.href)"><i class="fa fa-close"></i> 关闭</a>
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