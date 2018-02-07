<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>合作伙伴管理</title>
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
	            elem: '#signingTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            format: 'YYYY-MM-DD hh:mm:ss',
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click

	        });
		});
	</script>
</head>
<body class="pop-window">
	<form:form id="inputForm" modelAttribute="partner" action="${ctx}/partner/partner/save" method="post">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="ibox-content" style="border: none;overflow: hidden;" id="container">
	
	<table class="table table-condensed table-inform">
			
		<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col style="width:35%">
		</colgroup>
		<c:choose>
       		<c:when test="${partner.op==1}">
       			
       			<tbody>			
						<tr>
							<td> 合作伙伴名称：</td>
							<td>
								${partner.name}
							</td>
							<td>签约时间：</td>
							<td>
								<fmt:formatDate value="${partner.signingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
						<tr>
							<td>公司简介：</td>
							<td>
								<c:choose>
			                     <c:when test="${fn:length(partner.company)>7}"> 
			                         ${fn:substring(partner.company, 0, 4)}... 
			                        <a onclick="showDetail(this,'备注描述')" style="color: #ccc" >详情 </a>
			                        <input type="hidden" value=" ${partner.company}" />
			                     </c:when>
			                     <c:otherwise>   
			                           ${partner.company}
			                     </c:otherwise>
			                     </c:choose>
							</td>
							<td>合作项目：</td>
							<td>
								<c:choose>
			                     <c:when test="${fn:length(partner.project)>7}"> 
			                         ${fn:substring(partner.project, 0, 4)}... 
			                        <a onclick="showDetail(this,'备注描述')" style="color: #ccc" >详情 </a>
			                        <input type="hidden" value=" ${partner.project}" />
			                     </c:when>
			                     <c:otherwise>   
			                           ${partner.project}
			                     </c:otherwise>
			                     </c:choose>
							</td>
						</tr>
						<tr>
							<td>联系人：</td>
							<td> ${partner.contacts}
							</td>
							<td>联系人电话：</td>
							<td>${partner.phone}
							</td>
						</tr>

					</tr>
					<tr>
						<td>创建人：</td>
						<td>${partner.createBy.name}</td>
						<td>创建时间：</td>
						<td><fmt:formatDate value="${partner.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /> </td>
					</tr>
					<tr>
						<td>更新人：</td>
						<td>${partner.updateBy.name}</td>
						<td>更新时间：</td>
						<td><fmt:formatDate value="${partner.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
					</tr>
		 		</tbody>
       		</c:when>
       		 <c:otherwise>
		    	<tbody>
						<tr>
							<td><span class="star">*</span>合作伙伴名称：</td>
							<td>
								<form:input path="name" htmlEscape="false" maxlength="64" class="form-control required"/>
							</td>
							</tr><tr>
							<td>签约时间：</td>
							<td>
								<input id="signingTime" name="signingTime" type="text" maxlength="20" class="laydate-icon form-control layer-date "
									value="<fmt:formatDate value="${partner.signingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							</td>
						</tr>
						<tr>
							<td><span class="star">*</span>公司简介：</td>
							<td>
								<form:textarea path="company" htmlEscape="false" rows="4" class="form-control required"/>
							</td>
							</tr><tr>
							<td><span class="star">*</span>合作项目：</td>
							<td>
								<form:textarea path="project" htmlEscape="false" rows="4"  class="form-control required"/>
							</td>
						</tr>
						<tr>
							<td>联系人：</td>
							<td>
								<form:input path="contacts" htmlEscape="false" maxlength="64" class="form-control "/>
							</td>
							</tr><tr>
							<td>联系人电话：</td>
							<td>
								<form:input path="phone" htmlEscape="false" maxlength="11" class="form-control "/>
							</td>
						</tr>
		 		</tbody>
	 	</c:otherwise>
      </c:choose>
	</table>
	</div>
	</form:form>
</body>
</html>