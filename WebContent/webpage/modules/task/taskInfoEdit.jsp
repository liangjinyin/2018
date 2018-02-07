<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>任务信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		
		$(document).ready(function() {
			var iteration = document.getElementById("iteration");
		 	var iterator = document.getElementById("iterator").innerText;
			for(var i=0; i<iteration.options.length; i++){ 
		        if(iteration.options[i].value == iterator){  
		            iteration.options[i].selected = true;
		        }
		    }

			 var taskInfo = $("#id").val();
			 $.post("${ctx}/task/taskInfo/teamMan",{id:taskInfo},function(data){
			    teamMan(data);
			 });
			
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
			
				laydate({
		            elem: '#estStarted', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });
				laydate({
		            elem: '#realStarted', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });		
				laydate({
		            elem: '#deadline', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });
				laydate({
		            elem: '#finishedDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });	
				laydate({
		            elem: '#canceledDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });
				laydate({
		            elem: '#closedDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
		            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
		        });	
					
				$("a.btn-xs").click(function(){	
					if($(this).next().css("display") == "none"){
						$(this).next().toggle(300);	
						$(this).html("一");
					}else{
						$(this).next().toggle(300);
						$(this).html("+");
					}
				})
		});
		
		
		//添加任务信息时根据迭代的成员显示指派人员
		function change(obj) {
			var option=$(obj).find("option:selected");
			var data = $(option[0]).attr("teamMan");
			teamMan(data);
		}
		
		function teamMan(data){
			var select = document.getElementById("assignedTo");
		 	var finished = document.getElementById("finishedBy");
		 	var canceled = document.getElementById("canceledBy");
		 	var closed = document.getElementById("closedBy");
		 	var assignedToVal = document.getElementById("aVal").innerText;
			var finishedByVal = document.getElementById("fVal").innerText;
			var canceledByVal = document.getElementById("cVal").innerText;
			var closedByVal = document.getElementById("closedVal").innerText;
			var fFlag = true;
			var canFlag =  true;
			var cFlag = true;
			
			select.length=0;
		 	finished.length=0;
		 	canceled.length=0;
		 	closed.length=0;
		 	select.options.add(new Option("",""));
		 	finished.options.add(new Option("",""));
		 	canceled.options.add(new Option("",""));
		 	closed.options.add(new Option("",""));

		 	
		 	var man = new Array();
		 	man = data.split(",");
		 	for(var i=0; i<man.length; i++) {
		 		if(finishedByVal == man[i] || finishedByVal == ''){
		 			fFlag = false;
		 		}
		 		if(canceledByVal == man[i] || canceledByVal == ''){
		 			canFlag = false;
		 		}
		 		if(closedByVal == man[i] || closedByVal == ''){
		 			cFlag = false;
		 		}
		 		select.options.add(new Option(man[i],man[i])); 
		 		finished.options.add(new Option(man[i],man[i])); 
		 		canceled.options.add(new Option(man[i],man[i]));
		 		closed.options.add(new Option(man[i],man[i]));
		 	}

		 	if(fFlag){
		        finished.options.add(new Option(finishedByVal,finishedByVal));
		    }
		 	if(canFlag){
		        canceled.options.add(new Option(canceledByVal,canceledByVal));
		    }
		    if(cFlag){
		        closed.options.add(new Option(closedByVal,closedByVal));
		    }

		 	for(var i=0; i<=select.options.length; i++){  
		        if(select.options[i].innerHTML == assignedToVal){  
		            select.options[i].selected = true; 
		            break;
		        }
		 	}
		 	for(var j=0; j<=finished.options.length; j++){  
		 		if(finished.options[j].innerHTML == finishedByVal){
		        	finished.options[j].selected = true;
		        	break;
		        }
		 	}
		 	for(var z=0; z<=canceled.options.length; z++){
		 		if(canceled.options[z].innerHTML == canceledByVal){
		        	canceled.options[z].selected = true;
		        	break;
		        }
		 	}
		 	for(var k=0; k<=closed.options.length; k++){  
		 		 if(closed.options[k].innerHTML == closedByVal){
			        	closed.options[k].selected = true;
			        	break;
			     }
		 	}
		        
		}
		
	</script>
	<style>
	p{
		padding:0;
		margin:0;
		background: #f8f8f8;
		height: 30px;
		line-height: 30px;
	}
	
	button{
		border:0;
		background: #f5f5f5;
	}
		ul{
			margin:0;
			padding:4px;
			display: none;
			list-style: none;
		}
		li{
			line-height:30px;
		}
			.box-content-info{
			border: 1px solid #000;
			height: 400px;
		}
		.box-content-workInfo{
			border: 1px solid #000;
			height: 400px;
		}
		.title{
			border: 1px solid #F2F2F2;
			font-size: 13px;
			font-family: "Arial";
			height: 36px;
			line-height: 36px;
			margin-bottom: 10px;
			margin-top: 10px;
		}
		textarea{
			margin-bottom:30px;
			border-color: #f2f2f2;
		}
		.history{
			border: 1px solid #F2F2F2;
			height: 408px;
			width: 100%;
			margin-bottom: 30px;
			padding: 20px;
			position: relative;
			overflow-y: scroll;
		}
		.history-span{
			position:relative;
			top:10px;
			left:10px;
			z-index: 100;
		}
		.history-content{
			width:90%;
		}
		.history span{
			position: relative;
			top: -30px;
			left: -10px;
			display: block;
			width: 56px;
			background: #fff;
		}
	
		.desc{
			padding-left:10px;
		}
		.describe{
			background: #f5f5f5;
			text-align: left;
		}
		.baseInfo{
			border:1px solid #f2f2f2;
			height: 320px;
			margin-top: -10px;
			margin-bottom: 10px;
		}
		.baseInfo input{
			height: 30px;
		}
		.worktime{
			border:1px solid #f2f2f2;
			height: 270px;
			margin-top: -10px;
			margin-bottom: 10px;
		}
		.life{
			border:1px solid #f2f2f2;
			height: 360px;
			margin-top: -10px;
			margin-bottom: 10px;
		}
		.text-right:{
			line-height: 40px;
		}
		.plus{
			background-color: #F1F1F1;
		}
	</style>
</head>
<body>
	<form:form id="inputForm" modelAttribute="taskInfo" action="${ctx}/task/taskInfo/save" method="post" class="form-horizontal">
	<form:hidden path="id" />
	<form:input path="op" htmlEscape="false" class="form-control" value="${taskInfo.op }" type="hidden"/>
	<div class="ibox-content" style="border: none;overflow: hidden;">
		<div class="ibox-content-info col-sm-8 col-lg-8 col-md-8">
			<div class="title">
				<form:input path="name" htmlEscape="false" class="form-control"/>
			</div>
			<span class="desc">任务描述：</span><br />
			<form:textarea path="description" htmlEscape="false" rows="10" maxlength="500" class="form-control "/>
			<span class="history-span">历史记录</span>
			<div class="history">
				<div class="history-content">
				<div class="history-record">
					<ol>
						<li><fmt:formatDate value="${taskInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 由<strong> ${taskInfo.createBy.name } </strong>创建。</li>
						<c:if test="${taskInfo.openedBy != null }">
							<li><fmt:formatDate value="${taskInfo.openedDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 由<strong> ${taskInfo.openedBy } </strong>启动。<a class="btn btn-xs plus">+</a>
								<ul class="describe">
									<li>修改了<strong><em> 实际开始 </em></strong>，旧值为:"0000-00-00",新值为:"<fmt:formatDate value="${taskInfo.realStarted}" pattern="yyyy-MM-dd"/>"</li>
									<li>修改了<strong><em>预计剩余</em></strong>，旧值为:"0",新值为:"${taskInfo.surplus }"</li>
									<li>修改了<strong><em> 任务状态 </em></strong>，旧值为:"未开始",新值为:"${taskInfo.status }"</li>
								</ul>
							</li>
						</c:if>
						<c:set var="consumedSum" value="0"></c:set>
						<c:set var="surplus" value="0"></c:set>
						<c:forEach items="${taskLogs}" var="taskLog" varStatus="status">
							<c:set var="consumedSum" value="${consumedSum+taskLog.consumed }"></c:set>
							<c:choose>
								<c:when test="${taskLog.status != null }">
									<c:choose>
										<c:when test="${taskLog.lastStatus == '进行中' and (taskLog.status == '已完成' or taskLog.status == '已取消' or taskLog.status == '已关闭')}">
											<li><fmt:formatDate value="${taskLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 由<strong> ${taskLog.createBy.name } </strong>激活任务。<a class="btn btn-xs plus">+</a>
											<ul class="describe">
												<li>修改了<strong><em> 任务状态 </em></strong>，旧值为:"${taskLog.status }",新值为:"${taskLog.lastStatus }"</li>
												<c:if test="${taskLog.assignedTo != null }">
													<li>修改了<strong><em> 指派给 </em></strong>，旧值为:"${taskLog.assignedTo }",新值为:"${taskLog.lastAssignedTo }"</li>
													<li>修改了<strong><em> 指派时间 </em></strong>，旧值为:"<fmt:formatDate value="${taskLog.assignedDate }" pattern="yyyy-MM-dd HH:mm:ss"/>",新值为:"<fmt:formatDate value="${taskLog.lastAssignedDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"</li>
												</c:if>
												<c:if test="${taskLog.surplus != null }">
													<li>修改了<strong><em>总消耗</em></strong>，旧值为:"${consumedSum-taskLog.consumed }",新值为:"${consumedSum }"</li>
													<li>修改了<strong><em>预计剩余</em></strong>，旧值为:"${surplus }",新值为:"${taskLog.surplus }"</li>
												</c:if>
											</ul>
											</li>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${taskLog.lastStatus == '已取消' or taskLog.lastStatus == '已关闭'}">
													<li><fmt:formatDate value="${taskLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 由<strong> ${taskLog.createBy.name } </strong>${fns:substringAfterLast(taskLog.lastStatus,"已")}任务。<a class="btn btn-xs plus">+</a>
												</c:when>
												<c:otherwise>
													<li><fmt:formatDate value="${taskLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 由<strong> ${taskLog.createBy.name } </strong>${fns:substringAfterLast(taskLog.lastStatus,"已")}任务，消耗 ${taskLog.consumed } 小时。<a class="btn btn-xs plus">+</a>
												</c:otherwise>
											</c:choose>
											
											<ul class="describe">
												<li>修改了<strong><em> 任务状态 </em></strong>，旧值为:"${taskLog.status }",新值为:"${taskLog.lastStatus }"</li>
												<c:if test="${taskLog.assignedTo != null }">
													<li>修改了<strong><em> 指派给 </em></strong>，旧值为:"${taskLog.assignedTo }",新值为:"${taskLog.lastAssignedTo }"</li>
													<li>修改了<strong><em> 指派时间 </em></strong>，旧值为:"<fmt:formatDate value="${taskLog.assignedDate }" pattern="yyyy-MM-dd HH:mm:ss"/>",新值为:"<fmt:formatDate value="${taskLog.lastAssignedDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"</li>
												</c:if>
												<c:if test="${taskLog.surplus != null }">
													<li>修改了<strong><em>总消耗</em></strong>，旧值为:"${consumedSum-taskLog.consumed }",新值为:"${consumedSum }"</li>
													<li>修改了<strong><em>预计剩余</em></strong>，旧值为:"${surplus }",新值为:"${taskLog.surplus }"</li>
												</c:if>
											</ul>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${taskLog.status == null && taskLog.assignedTo != null }">
									<li><fmt:formatDate value="${taskLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 由<strong> ${taskLog.createBy.name } </strong>重新指派任务。<a class="btn btn-xs plus">+</a>
									<ul class="describe">
										<li>修改了<strong><em> 指派给 </em></strong>，旧值为:"${taskLog.assignedTo }",新值为:"${taskLog.lastAssignedTo }"</li>
										<li>修改了<strong><em> 指派时间 </em></strong>，旧值为:"<fmt:formatDate value="${taskLog.assignedDate }" pattern="yyyy-MM-dd HH:mm:ss"/>",新值为:"<fmt:formatDate value="${taskLog.lastAssignedDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"</li>
										<c:if test="${taskLog.surplus != null }">
											<li>修改了<strong><em>总消耗</em></strong>，旧值为:"${consumedSum-taskLog.consumed }",新值为:"${consumedSum }"</li>
											<li>修改了<strong><em>预计剩余</em></strong>，旧值为:"${surplus }",新值为:"${taskLog.surplus }"</li>
										</c:if>
									</ul>
									</li>
								</c:when>
								<c:otherwise>
									<li><fmt:formatDate value="${taskLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 由<strong> ${taskLog.createBy.name } </strong>记录工时，消耗 ${taskLog.consumed } 小时。<a class="btn btn-xs plus">+</a>
										<ul class="describe">
											<li>修改了<strong><em>总消耗</em></strong>，旧值为:"${consumedSum-taskLog.consumed }",新值为:"${consumedSum }"</li>
											<li>修改了<strong><em>预计剩余</em></strong>，旧值为:"${surplus }",新值为:"${taskLog.surplus }"</li>
										</ul>
									</li>
								</c:otherwise>
							</c:choose>
							<c:if test="${taskLog.content != null }">
								<p>${taskLog.content }</p>
							</c:if>
							<c:set var="surplus" value="${taskLog.surplus }"></c:set>
						</c:forEach>
					</ol>
				</div>
				</div>
			</div>
		</div>
		<div class="ibox-content-workInfo col-sm-4 col-lg-4 col-md-4">
			<span style="padding-left:10px;">基本信息</span>
			<div class="baseInfo" style="height:400px">
					<table class="table table-hover">
						<tr>
							<td class="text-right">所属迭代：</td>
							<td class="text-left">
								<span hidden="true" id="iterator">${taskInfo.iteration }</span>
								<form:select path="iteration" class="form-control required" onchange="change(this)">
									<c:forEach items="${fns:getIteraterList()}" var="iterater"  varStatus="status">
										<option value="${iterater.id}" teamMan="${iterater.teamMan }">${iterater.name}</option>
									</c:forEach>
								</form:select>
							</td>
						</tr>
						<tr>
							<td class="text-right">所属模块：</td>
							<td class="text-left">
								<form:input path="module" htmlEscape="false" maxlength="64" class="form-control " value="/" disabled="true"/>
							</td>
						</tr>
						<tr>
							<td class="text-right">相关需求：</td>
							<td class="text-left">
								<form:input path="requirement" htmlEscape="false" maxlength="64" class="form-control " value="/" disabled="true"/>
							</td>
						</tr>
						<tr>
							<td class="text-right">指派给：</td>
							<td class="text-left">
							<span hidden="true" id="aVal">${taskInfo.assignedTo }</span>
								<form:select id="assignedTo" path="assignedTo" class="form-control">
									
								</form:select>
							</td>
						</tr>
						<tr>
							<td class="text-right">任务类型：</td>
							<td class="text-left">
								<form:select path="type" class="form-control">
									<form:options items="${fns:getDictList('task_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</td>
						</tr>
						<tr>
							<td class="text-right">任务状态：</td>
							<td class="text-left">
								<form:select path="status" class="form-control">
									<form:options items="${fns:getDictList('task_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</td>
						</tr>
						<tr>
							<td class="text-right">优先级：</td>
							<td class="text-left">
								<form:select path="pri" class="form-control">
									<form:options items="${fns:getDictList('task_pri')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</td>
						</tr>
					</table>
			</div>
			<span style="padding-left:10px;">工时信息</span>
			<div class="worktime" style="height:350px">
					<table class="table table-hover">
						<tr>
							<td class="text-right ">预计开始：</td>
							<td class="text-left">
								<input id="estStarted" name="estStarted" type="text" maxlength="20" class="laydate-icon form-control layer-date"
									value="<fmt:formatDate value="${taskInfo.estStarted}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							</td>
						</tr>
						<tr>
						<td class="text-right">实际开始：</td>
						<td class="text-left">
							<input id="realStarted" name="realStarted" type="text" maxlength="20" class="laydate-icon form-control layer-date"
									value="<fmt:formatDate value="${taskInfo.realStarted}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
						</tr>
						<tr>
							<td class="text-right">截止日期：</td>
							<td class="text-left">
								<input id="deadline" name="deadline" type="text" maxlength="20" class="laydate-icon form-control layer-date"
										value="<fmt:formatDate value="${taskInfo.deadline}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							</td>
						</tr>
						<tr>
							<td class="text-right">最初预计：</td>
							<td class="text-left">
								<form:input path="estimate" htmlEscape="false" maxlength="64" class="form-control number" placeholder="小时"/>
							</td>
						</tr>
						<tr>
							<td class="text-right">总耗时：</td>
							<td class="text-left">
								<fmt:formatNumber value="${taskInfo.consumed}" pattern="#,###"/>
								<a href="#" onclick="openDialog('新增日志', '${ctx}/task/taskLog/logs?id=${taskInfo.id }','890px', '686px')" class="btn"><span class="glyphicon glyphicon-time"></span></a>
							</td>
						</tr>
						<tr>
							<td class="text-right">预计剩余：</td>
							<td class="text-left">
								<form:input path="surplus" htmlEscape="false" class="form-control  number" placeholder="小时"/>
							</td>
						</tr>					
					</table>
			</div>
			<span style="padding-left:10px;">任务的一生</span>
			<div class="life" style="height:450px">
					<table class="table table-hover">
						<tr>
							<td class="text-right">由谁创建：</td>
							<td class="text-left">
								${taskInfo.createBy.name }
							</td>
						</tr>
						<tr>
							<td class="text-right">由谁完成：</td>
							<td class="text-left">
								<span hidden="true" id="fVal">${taskInfo.finishedBy }</span>
								<form:select id="finishedBy" path="finishedBy" class="form-control">
									
								</form:select>
							</td>
						</tr>
						<tr>
							<td class="text-right">完成时间：</td>
							<td class="text-left">
								<input id="finishedDate" name="finishedDate" type="text" maxlength="20" class="laydate-icon form-control layer-date"
										value="<fmt:formatDate value="${taskInfo.finishedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							</td>
						</tr>
						<tr><td class="text-right">由谁取消：</td>
							<td class="text-left">
								<span hidden="true" id="cVal">${taskInfo.canceledBy }</span>
									<form:select id="canceledBy" path="canceledBy" class="form-control">
										
									</form:select>
							</td>
						</tr>
						<tr>
							<td class="text-right">取消时间：</td>
							<td class="text-left">
								<input id="canceledDate" name="canceledDate" type="text" maxlength="20" class="laydate-icon form-control layer-date"
										value="<fmt:formatDate value="${taskInfo.canceledDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							</td>
						</tr>
						<tr>
							<td class="text-right">由谁关闭：</td>
							<td class="text-left">
								<span hidden="true" id="closedVal">${taskInfo.closedBy }</span>
									<form:select id="closedBy" path="closedBy" class="form-control">
										
									</form:select>
							</td>
						</tr>
						<tr>
							<td class="text-right">关闭原因：</td>
							<td class="text-left">
								<form:input path="closedReason" htmlEscape="false" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td class="text-right">关闭时间：</td>
							<td class="text-left">
								<input id="closedDate" name="closedDate" type="text" maxlength="20" class="laydate-icon form-control layer-date"
										value="<fmt:formatDate value="${taskInfo.closedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	</form:form>
</body>
</html>