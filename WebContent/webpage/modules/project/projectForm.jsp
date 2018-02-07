<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.min.css">
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
			$('.selectpicker').selectpicker({
                'selectedText': 'cat'
            });
            var requirements=${fns:toJson(project.requirements)};
            if(requirements){
				$("select[name=requirements]").val(requirements);
            }
			var users=${fns:toJson(project.majorManager)};
			if(users){
				console.log(users);
				var oldnumber = users.split(",");
				console.log(oldnumber);

			    $('.selectpicker').selectpicker('val', oldnumber);//默认选中
			    $('.selectpicker').selectpicker('refresh');
			}
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
				var op = ${fns:toJson(project.op)};
				if (op!=1) {//标示是新增，修改页面
					laydate({
			            elem: '#coreDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#orderDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#signingTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
				}

			//修改项目信息时需求字段和顾客字段的填充
			var requirements = document.getElementById("requirements").value;
			$.post('${ctx}/project/project/requirements',{id:requirements},function(data){
				$("#saleManager").val(data.saleManager);
				$("#preSaleManager").val(data.preSaleManager);
				//$("#contacts").val(data.contacts);
				$("#department").val(data.department);
				$("#product").val(data.product);
				$.post('${ctx}/project/project/customer',{id:data.customer},function(data) {
					$("#industry").val(data.industry);
					$("#projectBelong").val(data.projectBelong);
					$("#contacts").val(data.contacts);
				});
			});	
					
		});


	  function changeCustomer(obj){
			var option=$(obj).find("option:selected");
			var item = option.text();
			console.log(option[0]);
			/*$(".phone").val($(option[0]).attr("phone"));*/
			$("#saleManager").val($(option[0]).attr("saleManager"));
			$("#preSaleManager").val($(option[0]).attr("preSaleManager"));
			//$("#contacts").val($(option[0]).attr("contacts"));
			$("#department").val($(option[0]).attr("department"));
			$("#product").val($(option[0]).attr("product"));
			//当项目名称未输入，先选择所属需求，此时项目名称输入框显示所属需求的内容；当项目名称有输入，然后选择所属需求，此时项目名称保持原输入内容
			if($('.name').val() == ''){
				$(".name").val(item);
			}
			var customer = $(option[0]).attr("customer");
			$.post('${ctx}/project/project/customer',{id:customer},function(data) {
				$("#industry").val(data.industry);
				$("#projectBelong").val(data.projectBelong);
				$("#contacts").val(data.contacts);
			});
		}

	</script>
	
	<style>
		.star {
			color: red;
		}
		.filed {
			text-align: right;
			width:150px;
		}
		.title {
			background: #F2F2F2;
			line-height: 40px;
			padding-left: 30px;
		}
		.line {
			display: block;
			padding-bottom: 5px;
			border-bottom: 1px solid #e0e2e4;
			width:300px;
		}
		.line-two {
			width:71%;
		}
	</style>
</head>
<body class="pop-window">
	<form:form id="inputForm" modelAttribute="project" action="${ctx}/project/project/save" method="post">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="ibox-content" style="border: none;overflow: hidden;" id="container">
	<table class="table" align="center">
	
		<c:choose>
		
       		<c:when test="${project.op==1}">
       			<div class="title">基本信息</div>
       					<colgroup>
						 	<col style="width:20%">
							<col style="width:30%">
							<col style="width:20%">
							<col style="width:30%">
       					</colgroup>
				<tbody>
						<tr>
							<td class="filed">项目名称：</td>
							<td colspan="3">
								<span class="line">${project.name}</span>
							</td>
						</tr>
						<tr>
							<td class="filed">需求名称：</td>
							<td>
								<span class="line">${requirements.name}</span>
							</td>
							<td class="filed">需求联系人：</td>
							<td>
								<span class="line">${customer.contacts}</span>
							</td>
						</tr>
						<tr>
							<td class="filed">所属行业：</td>
							<td>
								<span class="line">${customer.industry}</span>
							</td>
							<td class="filed">需求部门：</td>
							<td>
								<span class="line">${requirements.department}</span>								
							</td>
						</tr>
						<tr>
							<td class="filed">产品/服务：</td>
							<td>
								<span class="line">${requirements.product}</span>								
							</td>
							<td class="filed">项目所属区域：</td>
							<td>
								<span class="line">${customer.projectBelong}</span>
							</td>
						</tr>
						<tr>
							<td class="filed">销售负责人：</td>
							<td>
								<span class="line">${requirements.saleManager}</span>
							</td>
							<td class="filed"> 售前负责人：</td>
							<td>
								<span class="line">${requirements.preSaleManager}</span>
							</td>
						</tr>
						<tr>
							<td class="filed">决策流程：</td>
							<td colspan="3">
								<form:textarea path="decisionProcess"  htmlEscape="false" rows="4" maxlength="1024" class="form-control" cssStyle="width:71%"/>	
							</td>
						</tr>
						<tr>
							<td class="filed">决策人(电话)：</td>
							<td>
								<span class="line">${project.decisionManager}</span>								 
							</td>
							<td class="filed">关键人(电话)：</td>
							<td>
								<span class="line">${project.coreManager}</span>
							</td>
						</tr>
						<tr>
							<td class="filed">竞争对手及动态：</td>
							<td colspan="3">
								<form:textarea path="competitor" htmlEscape="false" rows="4" maxlength="1024" class="form-control" cssStyle="width:71%"/>
							</td>
						</tr>
						<tr>
							<td class="filed">是否有内线：</td>
							<td>			
								<c:choose>
								 	<c:when test="${project.relationship == '是'}">
								 		<form:radiobutton path="relationship" value="是" checked="true"/>是
										<form:radiobutton path="relationship" value="否"/>否
								 	</c:when>
								 	<c:otherwise> 
										<form:radiobutton path="relationship" value="是" />是
										<form:radiobutton path="relationship" value="否" checked="true"/>否
								 	</c:otherwise>
								</c:choose>
							</td>						
							<td class="filed">客户预算金额：</td>
							<td>
								<span class="line">
									<c:if test="${project.budget != ''}">
										${project.budget}万
									</c:if>
								</span>								 
							</td>	
						</tr>
						<tr>
							<td class="filed">我方对外报价金额：</td>
							<td>
								<span class="line">
									<c:if test="${project.quotation != ''}">
										${project.quotation}万
									</c:if>
								</span>
							</td>
							<td class="filed">我方成本金额：</td>
							<td>
								<span class="line">
									<c:if test="${project.cost != ''}">
										${project.cost}万
									</c:if>
								</span>
							</td>
						</tr>
						<tr>
							<td class="filed">预计下单几率：</td>
							<td>
								<span class="line">
									<c:if test="${project.orderRate != null}">
										${project.orderRate}%
									</c:if>
								</span>
							</td>
							<td class="filed">预计下单时间：</td>
							<td>
								<span class="line"><fmt:formatDate value="${project.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
							</td>
						</tr>
						<tr>
							<td class="filed">项目所处阶段：</td>
							<td>
								<span class="line">${project.stage}</span>								 
							</td>
							<td class="filed">是否投标：</td>
							<td>
								<c:choose>
								 	<c:when test="${project.bid == '是'}">
								 		<form:radiobutton path="bid" value="是" checked="true"/>是
										<form:radiobutton path="bid" value="否"/>否
										<form:radiobutton path="bid" value="未知"/>未知
								 	</c:when>
								 	<c:when test="${project.bid == '否'}">
								 		<form:radiobutton path="bid" value="是" />是
										<form:radiobutton path="bid" value="否" checked="true"/>否
										<form:radiobutton path="bid" value="未知"/>未知
								 	</c:when>
								 	<c:otherwise> 
										<form:radiobutton path="bid" value="是" />是
										<form:radiobutton path="bid" value="否"/>否
										<form:radiobutton path="bid" value="未知" checked="true"/>未知
								 	</c:otherwise>
								</c:choose>
							</td>							
						</tr>
						<tr>
							<td class="filed">项目关键时间点：</td>
							<td>
								<span class="line"><fmt:formatDate value="${project.coreDate}" pattern="yyyy-MM-dd"/></span>
							</td>
							<td class="filed">是否提前投入：</td>
							<td>
								<c:choose>
								 	<c:when test="${project.advanceService == '是'}">
								 		<form:radiobutton path="advanceService" value="是" checked="true"/>是
										<form:radiobutton path="advanceService" value="否"/>否
										<form:radiobutton path="advanceService" value="未知"/>未知
								 	</c:when>
								 	<c:when test="${project.advanceService == '否'}">
								 		<form:radiobutton path="advanceService" value="是" />是
										<form:radiobutton path="advanceService" value="否" checked="true"/>否
										<form:radiobutton path="advanceService" value="未知"/>未知
								 	</c:when>
								 	<c:otherwise> 
										<form:radiobutton path="advanceService" value="是" />是
										<form:radiobutton path="advanceService" value="否"/>否
										<form:radiobutton path="advanceService" value="未知" checked="true"/>未知
								 	</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="filed">项目风险：</td>
							<td colspan="3">
								<form:textarea path="projectRisk" htmlEscape="false" rows="4" maxlength="1024" class="form-control" cssStyle="width:71%"/>
							</td>							 
						</tr>
						<tr>
							<td class="filed">应对策略：</td>
							<td colspan="3">
								<form:textarea path="copingStrategies" htmlEscape="false" rows="4" maxlength="1024" class="form-control" cssStyle="width:71%"/>
							</td>							 
						</tr>
						<tr>
							<td class="filed">签约时间：</td>
							<td>
								<span class="line"><fmt:formatDate value="${project.signingTime}" pattern="yyyy-MM-dd"/></span>
							</td>
							<td class="filed">合同金额：</td>
							<td>
								<span class="line">
									<c:if test="${project.contractAmount != ''}">
										${project.contractAmount}万
									</c:if>
								</span>
							</td>
						</tr>
						<tr>	
							<td class="filed">项目干系人：</td>
							<td colspan="3">
								<span class="line line-two">${project.majorManager}</span>								 
							</td>
						</tr>
						<tr>
							<td class="filed">项目经理：</td>
							<td>
								<span class="line">${project.projectManager }</span>
							</td>
							<%-- <td class="filed">状态：</td>
							<td>
								<span class="line">${project.state}</span>
							</td> --%>
						</tr>					
						<tr>							
							<td class="filed">备注：</td>
							<td colspan="3">
								<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="1024" class="form-control" cssStyle="width:71%"/>
							</td>	
					    </tr>
						<tr>
							<td class="filed">创建日期：</td>
							<td>
								<span class="line"><fmt:formatDate value="${project.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
							</td>
							<td class="filed">创建人：</td>
							<td>
								<span class="line">${project.createBy.name}</span>
							</td>							
						</tr>
						<tr>
						<td class="filed">修改日期：</td>
							<td>
								<span class="line"><fmt:formatDate value="${project.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
							</td>
							<td class="filed">修改人：</td>
							<td>
								<span class="line">${project.updateBy.name}</span>
							</td>	
						</tr>
		
			</tbody>
		</c:when>
		 <c:otherwise>
		 
	   	 <tbody>
					<tr>
						<td class="filed"><span class="star">*</span>项目名称：</td>
						<td>
							<form:input path="name" htmlEscape="false" maxlength="64" class="form-control required name"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>对应需求：</td>
						<td>
							<form:select id="requirements" path="requirements" class="form-control required" onchange='changeCustomer(this)'>
								<option value="" saleManager="" preSaleManager="" department="" customer="" product="">请选择</option>
								<!-- <form:option value="" label=""/> -->
								<!-- <form:options items="${fns:getCustomerList()}"    itemLabel="name" itemValue="id" htmlEscape="false"/> -->
								<c:forEach items="${fns:getRequireList()}" var="require"  varStatus="status">
									<option value="${require.id}" saleManager="${require.saleManager }" 
									preSaleManager="${require.preSaleManager }" department="${require.department }" customer="${require.customer }"
									product="${require.product}">${require.name}</option>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<td class="filed">需求联系人：</td>
						<td>
							<form:input id="contacts" path="" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="filed">所属行业：</td>
						<td>
							<form:input id="industry" path="" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="filed">需求部门：</td>
						<td>
							<form:input id="department" path="department" htmlEscape="false" maxlength="64" class="form-control " readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="filed">产品/服务：</td>
						<td>
							<form:input id="product" path="type" htmlEscape="false" maxlength="64" class="form-control " readonly="true"/>
							<%-- <form:select id="product" path="type" class="form-control "  >
								<form:options items="${fns:getDictList('requirement')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select> --%>
						</td>
					</tr>
					<tr>
						<td class="filed">项目所属区域：</td>
						<td>
							<form:input id="projectBelong" path="area" htmlEscape="false" maxlength="64" class="form-control " readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="filed">销售负责人：</td>
						<td>
							<!-- <form:select path="saleManager" class="form-control required" >
								<option value=" " contacts=""  phone="">请选择</option> -->
								<!-- <form:option value="" label=""/> -->
								<!-- <form:options items="${fns:getCustomerList()}"    itemLabel="name" itemValue="id" htmlEscape="false"/> -->
								<!--  <c:forEach items="${fns:fundSalesMans()}" var="sale"  varStatus="status">
									<option value="${sale.name}"   phone="${sale.phone}">${sale.name}</option>
								</c:forEach>
							</form:select>  -->
							<form:input id="saleManager" path="saleManager" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="filed">售前负责人：</td>
						<td>
							<form:input id="preSaleManager" path="preSaleManager" htmlEscape="false" maxlength="64" class="form-control " readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>决策流程：</td>
						<td>
							<form:textarea path="decisionProcess" htmlEscape="false" rows="4" maxlength="1024"  class="form-control required decisionProcess"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>决策人(电话)：</td>
						<td>
							<form:input path="decisionManager" htmlEscape="false" maxlength="11" class="form-control required decisionManager"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>关键人(电话)：</td>
						<td>
							<form:input path="coreManager" htmlEscape="false" maxlength="11" class="form-control required coreManager"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>竞争对手及动态：</td>
						<td>
							<form:textarea path="competitor" htmlEscape="false" rows="4" maxlength="1024" class="form-control required competitor"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>是否有内线：</td>
						<td>	
							<!--<form:select path="relationship" class="form-control ">
								<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="label" htmlEscape="false"/>
							</form:select>-->
							<form:radiobutton path="relationship" value="是" checked="true"/>是
							<form:radiobutton path="relationship" value="否"/>否
						</td>
					</tr>
					<tr>
						<td class="filed">客户预算金额：</td>
						<td>
							<div class="input-group">
								<form:input path="budget" htmlEscape="false" maxlength="64" class="form-control number budget" />
								<span class="input-group-addon">万</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="filed">我方对外报价金额：</td>
						<td>
							<div class="input-group">
								<form:input path="quotation" htmlEscape="false" maxlength="64" class="form-control number quotation"/>
								<span class="input-group-addon">万</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="filed">我方成本金额：</td>
						<td>
							<div class="input-group">
								<form:input path="cost" htmlEscape="false" maxlength="64" class="form-control number cost"/>
								<span class="input-group-addon">万</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="filed">预计下单几率：</td>
						<td id="rate">
							<div class="input-group">
								<form:input path="orderRate" htmlEscape="false" maxlength="11" class="form-control digits orderRate"/>
								<span class="input-group-addon">%</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="filed">预计下单时间：</td>
						<td>
							<input id="orderDate" name="orderDate" type="text" maxlength="20" class="laydate-icon form-control layer-date"
								value="<fmt:formatDate value="${project.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>项目所处阶段：</td>
						<td>
							<form:select path="stage" class="form-control required stage">
								<form:options items="${fns:getDictList('project_status')}" itemLabel="label" itemValue="label" htmlEscape="false"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>是否投标：</td>
						<td>
							<!--<form:select path="bid" class="form-control ">
								<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="label" htmlEscape="false"/>
							</form:select>-->	
							<form:radiobutton path="bid" value="是" checked="true"/>是
							<form:radiobutton path="bid" value="否"/>否
							<form:radiobutton path="bid" value="未知"/>未知
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>项目关键时间点：</td>
						<td>
							<input id="coreDate" name="coreDate" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
								value="<fmt:formatDate value="${project.coreDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>是否提前投入：</td>
						<td>
							<form:radiobutton path="advanceService" value="是" checked="true"/>是
							<form:radiobutton path="advanceService" value="否"/>否
							<form:radiobutton path="advanceService" value="未知"/>未知
							<!--<form:select path="advanceService" class="form-control required">
								<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="label" htmlEscape="false"/>
							</form:select>-->
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>项目风险：</td>
						<td>
							<form:textarea path="projectRisk" htmlEscape="false" rows="4" maxlength="1024" class="form-control required projectRisk"/>
						</td>
					</tr>
					<tr>
						<td class="filed"><span class="star">*</span>应对策略：</td>
						<td>
							<form:textarea path="copingStrategies" htmlEscape="false" rows="4" maxlength="1024" class="form-control required copingStrategies"/>
						</td>
					</tr>
					<tr>
						<td class="filed">签约时间：</td>
						<td>
							<input id="signingTime" name="signingTime" type="text" maxlength="20" class="laydate-icon form-control layer-date"
								value="<fmt:formatDate value="${project.signingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
						</td>
					</tr>
					<tr>
						<td class="filed">合同金额：</td>
						<td>
							
							<div class="input-group">
									<form:input path="contractAmount" htmlEscape="false" class="form-control number contractAmount"/>
									<span class="input-group-addon">万</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="filed">项目经理</td>
						<td>
							<form:select path="projectManager" class="form-control">
								<option value="">请选择</option>
								<form:options items="${fns:fundUsers()}" itemLabel="name" itemValue="name" htmlEscape="false"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<td class="filed">项目干系人：</td>
						<td>
							<form:select path="majorManager" class="form-control selectpicker" multiple="true" data-live-search="true">
								<form:options items="${fns:fundUsers()}" itemLabel="name" itemValue="name" htmlEscape="false"/>
							</form:select>
						</td>
					</tr>
					<%-- <tr>
						<td class="filed"><span class="star">*</span>状态：</td>
						<td>
							<form:select path="state" class="form-control required">
								<form:options items="${fns:getDictList('state')}" itemLabel="label" itemValue="label" htmlEscape="false"/>
								<!--<option value="意向客户">意向客户</option>
								<option value="初步沟通">初步沟通</option>
								<option value="深度沟通">深度沟通</option>
								<option value="签订合同">签订合同</option>-->
							</form:select>
						</td>
					</tr> --%>
					<tr>
						<td class="filed">备注：</td>
						<td>
							<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="1024" class="form-control "/>
						</td>
					<td></td>
					<td></td>
				</tr>
	 	</tbody>
	   </c:otherwise>
      </c:choose>
	</table>
	</div>
	</form:form>

	<c:if test="${project.op==1 && not empty logs}">
		 <div class="title">项目跟踪情况</div>
		 <table class="table table-hover table-condensed" >
				<thead>
					<tr>
						<th style="width:10%">操作者</th>
						<th style="width:10%">时间</th>
						<th style="width:5%">操作</th>
						<th style="width:10%">联系时间</th>
						<th style="width:65%">阶段描述</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${logs}" var="log">
					<tr>
						<c:choose>
							<c:when test="${log.updateDate.getTime() - log.createDate.getTime() == 0 }">
								<td  class="text-center">
							 		${log.createBy.name}
								</td>
							    <td  class="text-center" >
							    	<fmt:formatDate value="${log.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td  class="text-center" >
									 新增
								</td>
							</c:when>
							<c:otherwise>
								<td  class="text-center">
							 		${log.updateBy.name}
								</td>
							    <td  class="text-center" >
							    	<fmt:formatDate value="${log.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td  class="text-center" >
									 更新
								</td>
							</c:otherwise>
						</c:choose>
							
							<td   class="text-center"  >
								<fmt:formatDate value="${log.followDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td class="text-center" >
								${log.summary }
							</td>
					</tr>
				</c:forEach>
				</tbody>
		</table>
	</c:if>


</body>
</html>