<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务看板</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		  
		$(document).ready(function() {
			
			
			 $(".btn-info-toggle").click(function(){
			        if($(this).parent().parent().next().css("display") == "block"){
			        $(this).parent().parent().next().toggle(300);
			      }else{
			        $(this).parent().parent().next().toggle(300);
			      }
			   });
		});
		
		function onclickss(){
			 $("#te").hide(0);
		}

	</script>
	<style>
		*{
		  margin: 0;
		  padding: 0;
		}
		@font-face {font-family: "iconfont";
		  src: url('iconfont.eot?t=1504604644859'); /* IE9*/
		  src: url('iconfont.eot?t=1504604644859#iefix') format('embedded-opentype'), /* IE6-IE8 */
		  url('data:application/x-font-woff;charset=utf-8;base64,d09GRgABAAAAAAaQAAsAAAAACagAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAABHU1VCAAABCAAAADMAAABCsP6z7U9TLzIAAAE8AAAARAAAAFZW7kieY21hcAAAAYAAAAB1AAAByJwH0bBnbHlmAAAB+AAAAnYAAAMUotZtE2hlYWQAAARwAAAALwAAADYOyGnOaGhlYQAABKAAAAAcAAAAJAfeA4dobXR4AAAEvAAAABMAAAAYF+kAAGxvY2EAAATQAAAADgAAAA4DQgJ2bWF4cAAABOAAAAAfAAAAIAEVAHhuYW1lAAAFAAAAAUUAAAJtPlT+fXBvc3QAAAZIAAAARgAAAF3C+5lEeJxjYGRgYOBikGPQYWB0cfMJYeBgYGGAAJAMY05meiJQDMoDyrGAaQ4gZoOIAgCKIwNPAHicY2Bk/sM4gYGVgYOpk+kMAwNDP4RmfM1gxMjBwMDEwMrMgBUEpLmmMDgwVDzbwNzwv4EhhrmBoQEozAiSAwAxuA0geJzFkcEJgDAQBOeMiogPC7ESsRk/4sOirOra0L1EH1bghgnZJUcCCzRAEpOowQ6M0KbUcp7oc14zyw90VDrvjo+++nldSr/ulen2u8I1mkuaxlp+k/339FdD3pfHRQ/7g77oFCL3sRD9+FqIzvwsUN0vxxwPAAAAeJxVUr9v00AUvndu/IvaSeyzL7FjJ7ab2E2pKWniULVNWqhUGiGKxISYqjKBqNi6AOpSiYGhMxMgJBb+hA4w8EewINF2AySmwoAMd6mKhPWs++69d9/d995DBYT+fBEOhQoyUYIuozV0CyEQZyDUsQdB3E3xDFhBwaJEF+IoDqQoTIVloKFI7E7WbVFREouggw/zQSeLUxxDrzvAi9CxPYCq69w2mjVDOAC1Evv7+Qi/Bqse1YqD2Xzj4pB0Gqa8O2kYVcN4LouFgozxRFGHh9RWCooq5m8KRcc6rE/jOkxWY+fGHa3hGlvPujtekyoAe3tgug397bDslJk9dmzTqEolTa44WjRFYPfkQsWc9FrHiH2Yaf0kfBDmUIweINTUQQpTvAzdrJ8NIfOBCQl8IKIU2RYL2gzZtMmUDaDbiqOwxTLnuegzvAjcz0rF8HwwzgnC1pB5U5CsjFVF8FhdKN6FLLn/7smaSvr7v6c2YhLuwN2k10teaBDWiswg3154dY+4LqGqpqnrpuualTEijkPWOYIOD+cHl/TpvbJKYgOufLy+2VCE1VY/6UF0bWvp20Ts37z6tERWRyYTtJmB5dTnVLrEfr/oN8BJXNCIBm7isFXne51tubtvj9SoocoA7nZzJXXx14WRiZDAavYDj4QSUtiEeGw2uE7efMpKdDYCcfkfwqjebg/a7fr/C34Es2uzzODlOcjfnyMEvDnCAk5RiXUFGE8oKcAvoWB3sAm+XKZKfpr/UmhZhppKP4PPYX4Kyjh0LHOKM54lPMN5FOAD2leAPyxmbPA9P+LJoII8PnyiUhzmR2NONf85jnmM6C9+5HqeAAB4nGNgZGBgAOIM+4nF8fw2Xxm4WRhA4OqVSU8Q9P+bLAzMBkAuBwMTSBQARdsLswB4nGNgZGBgbvjfwBDDwgACQJKRARWwAQBHDAJveJxjYWBgYH7JwMDCgIoBEp8BAQAAAAAAAHYBEAFCAWYBigAAeJxjYGRgYGBjyGFgZQABJiDmAkIGhv9gPgMAE+sBjgB4nGWPTU7DMBCFX/oHpBKqqGCH5AViASj9EatuWFRq911036ZOmyqJI8et1ANwHo7ACTgC3IA78EgnmzaWx9+8eWNPANzgBx6O3y33kT1cMjtyDRe4F65TfxBukF+Em2jjVbhF/U3YxzOmwm10YXmD17hi9oR3YQ8dfAjXcI1P4Tr1L+EG+Vu4iTv8CrfQ8erCPuZeV7iNRy/2x1YvnF6p5UHFockikzm/gple75KFrdLqnGtbxCZTg6BfSVOdaVvdU+zXQ+ciFVmTqgmrOkmMyq3Z6tAFG+fyUa8XiR6EJuVYY/62xgKOcQWFJQ6MMUIYZIjK6Og7VWb0r7FDwl57Vj3N53RbFNT/c4UBAvTPXFO6stJ5Ok+BPV8bUnV0K27LnpQ0kV7NSRKyQl7WtlRC6gE2ZVeOEXpc0Yk/KGdI/wAJWm7IAAAAeJxjYGKAAC4G7ICNkYmRmZGFkZWRjZGdgbGCpzgjv7QiMzEvvTK/lC05MTMlMY8nJb88T7ekCCiYk8oBlgQSDAwAlG4QkQAA') format('woff'),
		  url('iconfont.ttf?t=1504604644859') format('truetype'), /* chrome, firefox, opera, Safari, Android, iOS 4.2+*/
		  url('iconfont.svg?t=1504604644859#iconfont') format('svg'); /* iOS 4.1- */
		}
		#kanban{
			margin: 20px;
			border: 1px solid #DDDFE2; 
		}
		.iconfont {
		  font-family:"iconfont" !important;
		  font-size:16px;
		  font-style:normal;
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;
		}
		
		.icon-shouxiangyou:before { content: "\e6b0"; }
		
		.icon-caidan:before { content: "\e671"; }
		
		.icon-down-trangle:before { content: "\e610"; }
		
		.icon-xiangxia:before { content: "\e600"; }
		a{
		  color: inherit !important;
		}
		    #kanbanHeader thead tr{background-color: #F5F5F5;border-bottom: none;}
		    #kanbanHeader thead tr th{text-align: center;}
		    #kanbanWrapper thead{height: 0;border-bottom: none;}
		    #kanbanWrapper tbody td {
		    vertical-align: top;
		    padding: 6px;
		
		}
		    .label-delay-wait {
		    background-color: #d2322d;
		    margin-bottom: 2px;
		}
		.board{
		  padding: 3px 6px;
		    transition: all 0.2s;
		    margin-bottom: 5px;
		}
		.board-bug-wait, .board-task-wait {
		    color: #2b529c;
		    background-color: #E8EAF6;
		    position: relative;
		}
		.board-bug-doing, .board-task-doing {
		    color: #D2322D;
		    background-color: #FFEBEE;
		    position: relative;
		}
		.board-bug-done, .board-task-done {
		    color: #229F24;
		    background-color: #E8F5E9;
		    position: relative;
		}
		.board-bug-closed, .board-task-closed {
		    color: #666;
		    background-color: #ccc;
		    position: relative;
		}
		
		.board-title a{
		    
		   	font-size: 12px;
		}
		.kanbantitle{
			display: inline-block;
		}
		.table{
		  margin-bottom: 0px;
		}
		.board-actions {
		    position: absolute;
		    right: -12px;
		    top: 0;
		}
		.dropdown{
		  float:right;
			margin-top:-4px;
		}
		.btn-info-toggle{
		padding: 1px 5px;
		
		}
		.dropdown-menu{
		margin-right: 4px;
		 min-width: 80px;
		    padding: 4px 0;
		    z-index: 1020;
		} 
		.iconfont:hover{
		  text-decoration: none;
		}
		.dropdown-menu a{
		  display: block;
		  padding: 2px;
		  height:26px;
		}
		.dropdown-menu > a:hover{
		    background: #f1f1f1;
		    color: #1a53ff !important;
		    text-decoration: none;
		}
		.kanbanFrame:hover{
		  text-decoration: none;
		  background: #e7eaec;
		}
		.task-id,.task-pri,.task-assignedTo{
		  margin: 0 4px;
		}
		.board-footer{
		  display: none;
		  margin: 0 -6px -3px -6px;
   		  padding: 5px;
		  background: rgba(0,0,0,.07);
		}
		.kong{
			width: 80px;
			height: 50px;
		}
		.bian{
			margin: 20px;
			border: 1px solid #DDDFE2; 
		}
	</style>
</head>
<body class="gray-bg">
	<div class="bian">				
	<div class="kong"></div>
	<form:form id="searchForm" modelAttribute="taskInfo" action="${ctx}/task/taskInfo/lookBoard" method="post" class="form-inline" cssStyle="display:inline;">
	<div class="form-group">
		<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所属迭代：</span>
			<form:select   path="iteration"  class="form-control m-b" cssStyle="width:300px" onmousedown = "onclickss()">
				<form:option id="te" value="" label="${iterater.name}"/>
				<form:options  items="${fns:getIteraterList()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
			</form:select>
	 </div>	
	 <div class="btn-form-box">
		<button class="btn btn-blue btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
	</div>
	</form:form>

	<div id="kanban">
		      <table class="boards-layout table table-bordered" id="kanbanHeader" style="width: 100%;">
			    <thead>
			      <tr>
			                <th class="col-wait">未开始</th>
			                <th class="col-doing">进行中</th>
			                <th class="col-done">已完成</th>
			                <th class="col-cancel">已取消</th>
			                <th class="col-closed">已关闭</th>
			      </tr>
			    </thead>
			  </table>
			  <table class="boards-layout table active-disabled table-bordered" id="kanbanWrapper">
			  <colgroup>
			    <col style="width:20%">
			    <col style="width:20%">
			    <col style="width:20%">
			    <col style="width:20%">
			    <col style="width:20%">
			  </colgroup>
			     <tbody>
			        <tr style="height: 500px;min-height: 500px;">
			          <td class="col-droppable col-wait">
			          <c:forEach items="${wait }" var="taskInfo" varStatus="status">
				              	<div class="board board-task board-task-wait">
				                  <div class="board-title">
				                  	<c:set var="now" value="<%=System.currentTimeMillis()%>"></c:set>
				                  	<c:if test="${now - taskInfo.deadline.getTime() > 0  }">
				                  		<span class="label label-badge label-delay-wait  badge">延期</span>
				                  	</c:if>
				                    <a href="#" class="kanbanFrame kanbantitle" onclick="openDialogView('查看任务信息', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" title="${taskInfo.name }">${taskInfo.name }</a>
				                    <div class="board-actions">
				                      <button type="button" class="btn btn-mini btn-link btn-info-toggle"><i class="iconfont icon-down-trangle" style="color: #2b529c;"></i></button>
				                      <div class="dropdown">
				                        <button type="button" class="btn btn-mini btn-link dropdown-toggle" data-toggle="dropdown">
				                          <i class="iconfont icon-caidan"></i>
				                        </button>
				                        <div class="dropdown-menu pull-right">
				                         <shiro:hasPermission name="task:taskInfo:assigned">
				                          	<a href="#"  onclick="openDialog('指派任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=1','540px', '600px')" class="kanbanFrame">指派</a>
				                          </shiro:hasPermission>
				                          <shiro:hasPermission name="task:taskInfo:start">
				                          <a href="#" onclick="openDialog('开始任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=2','540px', '600px')" class="kanbanFrame">开始</a>
				                          </shiro:hasPermission>
				                          <shiro:hasPermission name="task:taskInfo:finished">
				                          <a href="#" onclick="openDialog('完成任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=3','540px', '600px')" class="kanbanFrame">完成</a>
				                          </shiro:hasPermission>
				                          <shiro:hasPermission name="task:taskInfo:cancel">
				                          <a href="#" onclick="openDialog('取消任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=4','540px', '600px')" class="kanbanFrame">取消</a>
				                          </shiro:hasPermission>
				                          <shiro:hasPermission name="task:taskInfo:edit">
				                          	<a href="#" onclick="openDialog('编辑任务', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" class="kanbanFrame">编辑</a>
				                          </shiro:hasPermission>
				                        </div>
				                      </div>
				                    </div>
				                  </div>
				                  <div class="board-footer clearfix">
				              <span class="task-id board-id" title="编号">${taskInfo.id }</span> 
				              <span class="task-pri pri-1" title="优先级">${taskInfo.pri }</span>
				              <span class="task-assignedTo" title="指派给">
				              <shiro:hasPermission name="task:taskInfo:assigned">
				                <a href="#" class="kanbanFrame" onclick="openDialog('指派任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=1','540px', '600px')"><i class="iconfont icon-shouxiangyou"></i></a>
				              </shiro:hasPermission>
				                <small>${taskInfo.assignedTo }</small>
				              </span>
				              <div class="pull-right">
				                <span class="task-left" title="预计剩余"><fmt:formatNumber value="${taskInfo.surplus}" pattern="#,###"/>h </span>
				              </div>
				            </div>
			              </div>
			              </c:forEach>
			              <div class="board-shadow"></div>
			          </td>
			          <td class="col-droppable col-doing">
			          	<c:forEach items="${doing }" var="taskInfo" varStatus="status">
			          		<div class="board board-task board-task-doing">
			                  <div class="board-title">
			                  	<c:set var="now" value="<%=System.currentTimeMillis()%>"></c:set>
			                  	<c:if test="${now - taskInfo.deadline.getTime() > 0  }">
			                  		<span class="label label-badge label-delay-wait  badge">延期</span>
			                  	</c:if>
			                    <a href="#" class="kanbanFrame" onclick="openDialogView('查看任务信息', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" title="${taskInfo.name }">${taskInfo.name }</a>
			                    <div class="board-actions">
			                      <button type="button" class="btn btn-mini btn-link btn-info-toggle"><i class="iconfont icon-down-trangle" style="color: #D2322D;"></i></button>
			                      <div class="dropdown">
			                        <button type="button" class="btn btn-mini btn-link dropdown-toggle" data-toggle="dropdown">
			                          <i class="iconfont icon-caidan"></i>
			                        </button>
			                        <div class="dropdown-menu pull-right">
			                        <shiro:hasPermission name="task:taskInfo:assigned">
			                          <a href="#" onclick="openDialog('指派任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=1','540px', '600px')" class="kanbanFrame">指派</a>
			                        </shiro:hasPermission>
			                         <shiro:hasPermission name="task:taskInfo:finished">
			                          <a href="#" onclick="openDialog('完成任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=3','540px', '600px')" class="kanbanFrame">完成</a>
			                          </shiro:hasPermission>
			                          <shiro:hasPermission name="task:taskInfo:cancel">
			                          <a href="#" onclick="openDialog('取消任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=4','540px', '600px')" class="kanbanFrame">取消</a>
			                          </shiro:hasPermission>
			                          <shiro:hasPermission name="task:taskInfo:edit">
			                          <a href="#" onclick="openDialog('编辑任务', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" class="kanbanFrame">编辑</a>
			                          </shiro:hasPermission>
			                        </div>
			                      </div>
			                    </div>
			                  </div>
			                  <div class="board-footer clearfix">
					              <span class="task-id board-id" title="编号">${taskInfo.id }</span> 
					              <span class="task-pri pri-1" title="优先级">${taskInfo.pri }</span>
					              <span class="task-assignedTo" title="指派给">
					              <shiro:hasPermission name="task:taskInfo:assigned">
						                <a href="#" onclick="openDialog('指派任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=1','540px', '600px')" class="kanbanFrame"><i class="iconfont icon-shouxiangyou"></i></a>
						          </shiro:hasPermission>
						               <small>${taskInfo.assignedTo }</small>
					              </span>
					              <div class="pull-right">
					                <span class="task-left" title="预计剩余"><fmt:formatNumber value="${taskInfo.surplus}" pattern="#,###"/>h </span>
					              </div>
					          </div>
			              </div>
			          	</c:forEach>
			            <div class="board-shadow"></div>
			          </td>
			          <td class="col-droppable col-done">
			              <c:forEach items="${done }" var="taskInfo" varStatus="status">
			              	<div class="board board-task board-task-done">
			                  <div class="board-title">
			                    <a href="#" class="kanbanFrame"  onclick="openDialogView('查看任务信息', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" title="${taskInfo.name }">${taskInfo.name }</a>
			                    <div class="board-actions">
			                      <button type="button" class="btn btn-mini btn-link btn-info-toggle"><i class="iconfont icon-down-trangle" style="color: #229F24;"></i></button>
			                      <div class="dropdown">
			                        <button type="button" class="btn btn-mini btn-link dropdown-toggle" data-toggle="dropdown">
			                          <i class="iconfont icon-caidan"></i>
			                        </button>
			                        <div class="dropdown-menu pull-right">
			                        <%-- <shiro:hasPermission name="task:taskInfo:assigned">
			                          <a href="#" onclick="openDialog('指派任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=1','540px', '600px')" class="kanbanFrame">指派</a>
			                        </shiro:hasPermission> --%>
			                        <shiro:hasPermission name="task:taskInfo:active">
			                          <a href="#" onclick="openDialog('激活任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=5','540px', '600px')" class="kanbanFrame">激活</a>
			                        </shiro:hasPermission>
			                        <shiro:hasPermission name="task:taskInfo:closed">
			                          <a href="#" onclick="openDialog('关闭任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=6','540px', '600px')" class="kanbanFrame">关闭</a>
			                        </shiro:hasPermission>
			                          <shiro:hasPermission name="task:taskInfo:edit">
			                          <a href="#" onclick="openDialog('编辑任务', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" class="kanbanFrame">编辑</a>
			                          </shiro:hasPermission>
			                        </div>
			                      </div>
			                    </div>
			                  </div>
			                  <div class="board-footer clearfix">
					              <span class="task-id board-id" title="编号">${taskInfo.id }</span> 
					              <span class="task-pri pri-1" title="优先级">${taskInfo.pri }</span>
					              <span class="task-assignedTo" title="指派给">
					                <a href="#" onclick="" class="kanbanFrame"><i class="iconfont icon-shouxiangyou"></i></a>
					                <small>${taskInfo.assignedTo }</small>
					              </span>
					              <div class="pull-right">
					                <span class="task-left" title="预计剩余"><fmt:formatNumber value="${taskInfo.surplus}" pattern="#,###"/>h </span>
					              </div>
					          </div>
			              </div>
			              </c:forEach>
			              <div class="board-shadow"></div>
			          </td>
			          <td class="col-droppable col-cancel">
			          	<c:forEach items="${cancel }" var="taskInfo" varStatus="status">
			              <div class="board board-task board-task-closed">
			              	 <div class="board-title">
			                   <a href="#"  onclick="openDialogView('查看任务信息', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" class="kanbanFrame" title="${taskInfo.name }">${taskInfo.name }</a>
			                    <div class="board-actions">
			                      <button type="button" class="btn btn-mini btn-link btn-info-toggle"><i class="iconfont icon-down-trangle" style="color: #666;"></i></button>
			                      <div class="dropdown">
			                        <button type="button" class="btn btn-mini btn-link dropdown-toggle" data-toggle="dropdown">
			                          <i class="iconfont icon-caidan"></i>
			                        </button>
			                        <div class="dropdown-menu pull-right">
			                        <shiro:hasPermission name="task:taskInfo:active">
			                          <a href="#" onclick="openDialog('激活任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=5','540px', '600px')" class="kanbanFrame">激活</a>
			                        </shiro:hasPermission>
			                        <shiro:hasPermission name="task:taskInfo:closed">
			                          <a href="#" onclick="openDialog('关闭任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=6','540px', '600px')" class="kanbanFrame">关闭</a>
			                        </shiro:hasPermission>
			                          <shiro:hasPermission name="task:taskInfo:edit">
			                          <a href="#" onclick="openDialog('编辑任务', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" class="kanbanFrame">编辑</a>
			                          </shiro:hasPermission>
			                        </div>
			                      </div>
			                    </div>
			                  </div>
			                  <div class="board-footer clearfix">
					              <span class="task-id board-id" title="编号">${taskInfo.id }</span> 
					              <span class="task-pri pri-0" title="优先级">${taskInfo.pri }</span>
					              <span class="task-assignedTo" title="指派给">
					                <a href="#" onclick="" class="kanbanFrame"><i class="iconfont icon-shouxiangyou"></i></a>
					                <small>${taskInfo.assignedTo }</small>
					              </span>
					              <div class="pull-right">
					                <span class="task-left" title="预计剩余"><fmt:formatNumber value="${taskInfo.surplus}" pattern="#,###"/>h </span>
					              </div>
					          </div>
				            </div>
			              </c:forEach>  
			              <div class="board-shadow"></div>
			          </td>
			          <td class="col-droppable col-closed">
						<c:forEach items="${closed }" var="taskInfo" varStatus="status">
			              <div class="board board-task board-task-closed">
			              	<div class="board-title">
			                   <a href="#"  onclick="openDialogView('查看任务信息', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" class="kanbanFrame" title="${taskInfo.name }">${taskInfo.name }</a>
			                    <div class="board-actions">
			                      <button type="button" class="btn btn-mini btn-link btn-info-toggle"><i class="iconfont icon-down-trangle" style="color: #666;"></i></button>
			                      <div class="dropdown">
			                        <button type="button" class="btn btn-mini btn-link dropdown-toggle" data-toggle="dropdown">
			                          <i class="iconfont icon-caidan"></i>
			                        </button>
			                        <div class="dropdown-menu pull-right">
			                        <shiro:hasPermission name="task:taskInfo:active">
			                          <a href="#" onclick="openDialog('激活任务', '${ctx}/task/taskInfo/form?id=${taskInfo.id}&&op=5','540px', '600px')" class="kanbanFrame">激活</a>
			                        </shiro:hasPermission>
			                          <shiro:hasPermission name="task:taskInfo:edit">
			                          <a href="#" onclick="openDialog('编辑任务', '${ctx}/task/taskInfo/edit?id=${taskInfo.id}','1900px', '950px')" class="kanbanFrame">编辑</a>
			                          </shiro:hasPermission>
			                        </div>
			                      </div>
			                    </div>
			                  </div>
			                  <div class="board-footer clearfix">
					              <span class="task-id board-id" title="编号">${taskInfo.id }</span> 
					              <span class="task-pri pri-0" title="优先级">${taskInfo.pri }</span>
					              <span class="task-assignedTo" title="指派给">
					                <a href="#" onclick="" class="kanbanFrame"><i class="iconfont icon-shouxiangyou"></i></a>
					                <small>Closed</small>
					              </span>
					              <div class="pull-right">
					                <span class="task-left" title="预计剩余"><fmt:formatNumber value="${taskInfo.surplus}" pattern="#,###"/>h </span>
					              </div>
					          </div>
			              </div>
			              </c:forEach>
			              <div class="board-shadow"></div>
			          </td>
			        </tr>
			     </tbody>
			  </table>
		  </div>
		  </div>
</body>
</html>