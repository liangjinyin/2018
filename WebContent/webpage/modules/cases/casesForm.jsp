<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>案场管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.min.css">
	<script type="text/javascript" >
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {

			var a = ${fns:toJson(cases.charge)};
			 $("#charge").val(a);
			
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

			$('.selectpicker').selectpicker({
                'selectedText': 'cat'
            });
			
			//回显团队成员
			var users=${fns:toJson(cases.team)};
			if(users){
				console.log(users);
				var oldnumber = users.split(",");
				console.log(oldnumber);

			    //$('.teamMans selectpicker').text(teamMan);
			     //$(".pull-left").text(teamMan);
			    $('.selectpicker').selectpicker('val', oldnumber);//默认选中
			    $('.selectpicker').selectpicker('refresh');
			} 
			//时间
			laydate({
	            elem: '#b_times', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'click', //响应事件。如果没有传入event，则按照默认的click
            	choose: function(datas){ //选择日期完毕的回调
           	       
           	   	}
			
	        });
			laydate({
	            elem: '#e_times', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	           
	            event: 'click', //响应事件。如果没有传入event，则按照默认的click
           	    choose: function(datas){ //选择日期完毕的回调
           	    
           	   	}
	        });			

		});
	</script>
	<style type="text/css">
		.star{
			color:red;
		}

		.bian{
			margin: 20px;
			border: 1px solid #DDDFE2; 
		}
	</style>


</head>
<body>
<div class="bian">		
		<form:form id="inputForm" modelAttribute="cases" action="${ctx}/cases/cases/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table" >
		   <tbody>
				
				<tr >	
					<td align="right"><span class="star">*</span>案场名称：</td>
					<td >
						<form:input path="name" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td align="right"><span class="star">*</span>案场位置：</td>
					<td >
						<form:input path="address" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
				<tr>	
					<td align="right"><span class="star">*</span>所属集团：</td>
					<td >
						<form:input path="company" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
				<tr>	
					<td align="right"><span class="star">*</span>案场负责人：</td>
					<td >
						<form:select  path="charge" class="form-control required" multiple="" >
								<option id="" value=" "></option>										
								<c:forEach items="${fns:fundUsers()}" var="team"  varStatus="status">
									<option value="${team.name}" >${team.name}</option>
								</c:forEach>
						</form:select>
					</td>
				</tr>
				
				<tr>	
					<td align="right"><span class="star">*</span>负责人电话：</td>
					<td >
						<form:input path="phone" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
				<tr>	
					<td align="right"><span class="star">*</span>开盘时间：</td>
					<td >
						<input id="b_times" name="beginTime" type="text" maxlength="20" style="width:200px;"  class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${cases.beginTime}" pattern="yyyy-MM-dd"/>"/>
					</td>
				</tr>
				<tr>	
					<td align="right"><span class="star">*</span>结束时间：</td>
					<td >
						<input id="e_times" name="endTime" type="text" maxlength="20" style="width:200px;"  class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${cases.endTime}" pattern="yyyy-MM-dd"/>"/>
					</td>
				</tr>

				<tr>	
					<td align="right"> <span class="star">*</span> 团队成员：</td>
					<td >	
							<form:select path="team" class="form-control selectpicker" multiple="true" data-live-search="true">
								<form:options items="${fns:fundUsers()}" itemLabel="name" itemValue="name" htmlEscape="false"/>
							</form:select>		
					</td>
				</tr>
				<tr>
					<td align="right">备注信息：</td>
					<td >
						<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
					</td>
				</tr>
		

			

		 	</tbody>
		</table>

	</form:form>
	</div>
</body>
</html>