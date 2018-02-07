<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>产品管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

		// $.post('${ctx}/product/product/listIterater',function(data){	 });
		var id=${fns:toJson(product.id)};
		/* var name = ${fns:toJson(product.name)};
		console.log(name); */
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			$("#pid").val("P"+id);	
			
			
			
			
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
			
		});
		 
	</script>
	<style type="text/css">
		.star{
			color:red;
		}
		.navthree{
			margin-bottom: -1px;
		}
		.additera{
			padding: 0;
			padding-top: 6px;
		}
	</style>
</head>
<body  class="pop-window">

		<div class="container">
			<ul class="nav nav-tabs navthree">
				<li class="active"><a href="#product" data-toggle="tab">产品信息</a></li>
				<li ><a href=" #iterater" data-toggle="tab">迭代信息</a></li>
				<li ><a href="#edition" data-toggle="tab">发布情况</a></li>
			</ul>
			
			<div class="tab-content">
				<div class="tab-pane active" id="product">
								
					<form:form id="inputForm" modelAttribute="product" action="${ctx}/product/product/save" method="post" >
					<form:hidden path="id"/>
					<sys:message content="${message}"/>	
					<table class="table">
					   <tbody>
							<tr>
								<td ><label class="pull-right"><span class="star">*</span>产品名称:</label></td>
								<td >
									<form:input path="name"  htmlEscape="false" maxlength="64" class="form-control "/>
								</td>
								<td ><label class="pull-right"><span class="star">*</span>产品代号:</label></td>
								<td >
									<form:input id="pid" path="" style="width:300px;" htmlEscape="false" maxlength="64" class="form-control " readonly="true"/>
								</td>
							</tr>
						
							<tr>	
								<td ><label class="pull-right"><span class="star">*</span>产品负责人:</label></td>
								<td >
									<form:input path="proManager" htmlEscape="false" maxlength="64" class="form-control "/>
								</td>
							
								<td ><label class="pull-right"><span class="star">*</span>测试负责人:</label></td>
								<td>
									<form:input path="testManager" style="width:300px;" htmlEscape="false" maxlength="64" class="form-control "/>
								</td>
							</tr>
							<tr>
								<td ><label class="pull-right"><span class="star">*</span>发布负责人:</label></td>
								<td >
									<form:input path="issueManager"  htmlEscape="false" maxlength="64" class="form-control "/>
								</td>
								<td ><label class="pull-right"><span class="star">*</span>创建人:</label></td>
								<td >
									<form:input path="createBy.name" style="width:300px;" htmlEscape="false" maxlength="64" class="form-control "/>
								</td>
							</tr>
							<tr>
								<td ><label class="pull-right"><span class="star">*</span>产品状态:</label></td>
								<td >
									<form:select path="status" class="form-control ">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('pro_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</td>
								
								<td ><label class="pull-right"><span class="star">*</span>产品类型:</label></td>
								<td >
									<form:select path="type" style="width:300px;" class="form-control ">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('pro_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</td>
							</tr>
							<tr>
								<td ><label class="pull-right"><span class="star">*</span>产品描述:</label></td>
								<td >
									<form:textarea path="describe" htmlEscape="false" rows="4" maxlength="64" class="form-control "/>
								</td>
							</tr>
							<tr>	
								<td ><label class="pull-right"><span class="star">*</span>访问控制:</label></td>
								<td >
									<!-- <form:radiobuttons path="interview" style="width:200px;" items="${fns:getDictList('interview')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/> -->
									<form:radiobutton path="interview" value="默认设置（  有产品视图权限，即可访问）" 
											label="默认设置（  有产品视图权限，即可访问）"/>	</br>				
									<form:radiobutton path="interview" value="私有产品（ 有产品相关人员和迭代人员访问）" 
											label="私有产品（ 有产品相关人员和迭代人员访问）"/>	
								</td>
							</tr>
					 	</tbody>
					</table>
				</form:form>
				</div>
				<!-- 迭代信息 -->	
				<div class="tab-pane " id="iterater">
					
				 <div class="ibox-content additera">
				 <div class="row">
				<div class="col-sm-12">
					<div class="pull-left">
						<shiro:hasPermission name="edition:edition:add">
						<!-- 迭代信息增加操作 -->
							<table:addRow url="" width="540px;" height="600px;" title="版本"></table:addRow><!-- 增加按钮 -->
						</shiro:hasPermission>
					</div>
					
				</div>
				</div>					
					<!-- 表格 -->
					<table id="contentTable1" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
						<thead>
							<tr>
								
								<th  class="sort-column id">迭代编号</th>
								<th  class="sort-column name">迭代名称</th>
								<th  class="sort-column beginTime">开始日期</th>
								<th  class="sort-column endTime">结束日期</th>
								<th  class="sort-column times">可用工作日</th>
								<th  class="sort-column type">迭代类型</th>
								
								<th  class="sort-column describe">迭代描述</th>
								<th  class="sort-column teamMan">团队成员</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<%-- <c:set var="name" >${fns:toJson(product.name)}</c:set> --%>
						<c:set var="name" >${product.name}</c:set>
						<c:forEach items="${fns:getIteraterListByName(name)}" var="iterater">
							<tr>
								
								<td >
									
									S${iterater.id}
								</td>
								<td >
									${iterater.name}
								</td>
								<td >
									<fmt:formatDate value="${iterater.beginTime}" pattern="yyyy-MM-dd"/>
								</td>
								<td >
									<fmt:formatDate value="${iterater.endTime}" pattern="yyyy-MM-dd"/>
								</td>
								<td >
									<fmt:formatNumber value="${iterater.times/24 }" pattern="#0" />
								</td>
								<td >
									${iterater.type}
								</td>
								
								<td >
									${iterater.describe}
								</td>
								<td >
									${iterater.teamMan}
								</td>
								<td>
									
									<shiro:hasPermission name="iterater:iterater:edit">
				    					<a href="#" onclick="openDialog('修改迭代', '${ctx}/iterater/iterater/form?id=${iterater.id}','800px', '500px')"> 修改</a>
				    				</shiro:hasPermission>
				    				
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					
				</div>
				</div>
				<!-- 版本信息 -->	
				<div class="tab-pane " id="edition">
				<div class="ibox-content additera">
				<div class="row">
				<div class="col-sm-12">
					<div class="pull-left">
						<shiro:hasPermission name="edition:edition:add">
							<table:addRow url="${ctx}/edition/edition/form" width="540px;" height="600px;" title="版本"></table:addRow><!-- 增加按钮 -->
						</shiro:hasPermission>
					</div>
					
				</div>
				</div>
					<!-- 表格 -->
				<table id="contentTable2" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
					<thead>
						<tr>
							
							<th  class="sort-column id">编号</th>
							<th  class="sort-column createMan">构建者</th>
							<th  class="sort-column date">打包日期</th>
							<th  class="sort-column editionNum">发布版本号</th>
							<th  class="sort-column iteration">关联的迭代</th>
							<th  class="sort-column codeAddress">源代码地址</th>
							<th  class="sort-column loadAddress">发布版本下载地址</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:set var="id" >${product.id}</c:set>
					 <c:forEach items="${fns:getEditionListById(id)}" var="edition">
						<tr>
							
							<td >
								${edition.id}
							</td>
							<td >
								${edition.createMan}
							</td>
							<td >
								<fmt:formatDate value="${edition.date}" pattern="yyyy-MM-dd"/>
							</td>
							<td >
								${edition.editionNum}
							</td>
							<td >
								${edition.iteration}
							</td>
							<td >
								${edition.codeAddress}
							</td>
							<td >
								${edition.loadAddress}
							</td>
							
							<td>
								<shiro:hasPermission name="edition:edition:edit">
			    					<a href="#" onclick="openDialog('修改版本', '${ctx}/edition/edition/form?id=${edition.id}','540px', '600px')"> 修改</a>
			    				</shiro:hasPermission>
							</td>
						</tr>
					</c:forEach> 
					</tbody>
				</table>
				</div>
				
			</div>

	</div>

</body>
</html>