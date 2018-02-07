<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>会议纪要</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.min.css">
	<script type="text/javascript">
	
				
			$(function(){

				$('.selectpicker').selectpicker({
		                'selectedText': 'cat'
		            });
           



				//ajax表单校验
				$(":input[vild='on']").each(function() {
							$(this).attr("maxlength",25);
							var errorhtml=$("<label id='theme-error' class='error' for='theme'>长度必须大于5</label>");
							$(this).bind('input propertychange', function() {
								console.log($(this).val());
								console.log($(this).parent().children().find("label.error")<0);
								if($(this).val().length<=5 && $(this).parent().children().find("label.error")<0)
								{
									$(this).parent().append(errorhtml);							 
								}
								if($(this).val().length>5)
								{
									errorhtml.remove();							 
								}
							}); 
						});
				
				//回显主送人信息
				 var mainEmail=${fns:toJson(meeting.mainEmail)};
				if(mainEmail){
					console.log(mainEmail);
					var oldnumber = mainEmail.split(",");
					console.log(oldnumber);
	
				    $('.mainEmail').selectpicker('val', oldnumber);//默认选中
				    
				    $('.mainEmail').selectpicker('refresh');
				} 

				//回显抄送人信息
				 var addEmail=${fns:toJson(meeting.addEmail)};
				if(addEmail){
					console.log(addEmail);
					var oldnumbers = addEmail.split(",");
					console.log(oldnumbers);
	
				    $('.addEmail').selectpicker('val', oldnumbers);
				    $('.addEmail').selectpicker('refresh');
				} 
				///////////////////////////////////////////////////
					
           
						validateForm = $("#inputForm").validate({
							submitHandler: function(form){
								loading('正在提交，请稍等...');
								form.submit();
							},});
						
						laydate({
				            elem: '#beginTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
				            format: 'YYYY-MM-DD hh:mm:ss',
				            event: 'focus' //响应事件。如果没有传入event，则按照默认的click

				        });
					 // 保存 
					$("#save").click(function(){

						//对主送人进行非空校验	 str.indexOf("abc")!=-1
					  	 var tes = $(".pull-left").text().substring(3,0);
					  	 console.log(tes);
					  	 if(tes=="请选择"){
					  	 	var la  =  $("<label id='mainEmail-error' class='error' for='mainEmail'>这是必填字段</label>")
					  	 	 $(".mainEmail").append(la );
					  	 	return	
					  	 }	
	
						$("#inputForm").submit();
					});
					
					 // 取消
					$("#cancel").click(function(){
							$.ajax({
							    type:"POST",
							    url:"${ctx}/meeting/meeting/toFirst", 
							    async:true,//同步：意思是当有返回值以后才会进行后面的js程序。
							    success:function(msg){
							       top.document.location.href = "${ctx}";
							    }
							});
					});
					 // 清空
					 $("#clear").click(function(){

						 $(".pull-left").text("请选择");
						
					});
					
					 //确定发送 
					var f = true;
					$("#send").click(function(){
						
						//对主送人进行非空校验	 
						
						
					  	 var te = $(".pull-left").text().substring(3,0);

					  	 console.log(te);
					  	 if(te=="请选择"){				  		
				  	 	 	if (!f) {
							return;
							};	
					  	 	var la  =  $("<label id='mainEmail-error' class='error' for='mainEmail'>这是必填字段</label>")
					  	 	$(".mainEmail").append(la);
					  	 	f = false;
					  	 	console.log(f);
					  	 	return
					  	 }	
					  	


						var flag=true;
						
						$(".required").each(function() {
							
							var label =  $("#mainEmail-error");
							
							if(label){
								label.remove();
								
							}
							
							$(this).attr("maxlength",255);
							$(this).bind('input propertychange', function() {
								console.log($(this).val());
							}); 
							$(this).parent().children().remove(".error");
							if($(this).val().length==0)
							{
								var errorhtml=$("<label id='theme-error' class='error' for='theme'>必填字段</label>");			
								 $(this).parent().append(errorhtml);
								flag=false;	
															 
							}
						});
						if (!flag) {
							return;
						};
						var data=$("#inputForm").serializeArray();
						console.info(data);

						

						$.ajax({
						    type:"POST",
						    data:data,
						    url:"${ctx}/meeting/meeting/sendEmail", 
						    async:true,//同步：意思是当有返回值以后才会进行后面的js程序。
						    success:function(data){
						    	 top.document.location.href = "${ctx}";
						    }
						});
			});	
			
		});


	

	</script>
	
	<style type="text/css">
	 .meeting-btn{
			padding-top: 30px;
			padding-bottom: 10px;
			
		}
		 .meeting-btn input {
			width: 140px;
			height: 40px;
			border-radius: 5px;
			line-height: 40px;
			font-size: 14px;
			text-align: center;
			background-color: #fff;
			border: 1px solid #888;
			margin-left: 10px;
		}
		
		
		.star{
			color: red;
		}
		.td_intro{
			color:#BBB;
		}
	
		
	</style>
</head>
<body class="pop-window">
	<form:form id="inputForm" modelAttribute="meeting" action="${ctx}/meeting/meeting/save" method="post" class="form-horizontal" >
	<sys:message content="${message}"/>
	<div class="ibox-content" style="border: none;overflow: hidden; background-color: #F8F8F8;" id="container">
	<table class="table">
		<!-- <colgroup>
			<col style="width:15%">
			<col style="width:35%">
		 <col style="width:35%">
					<col style="width:35%"> 
		</colgroup> -->
			<caption class="text-center"><h2>会议纪要</h2></caption>
	   	 <tbody>
	   	 			
					<tr>
						
						<td align="right"><span class="star">*</span> 会议主题：</td>
						<td>
							<form:input path="theme" htmlEscape="false" maxlength="64" class="form-control required" size="80" id="theme"  vild="on"/>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span> 召集人：</td>
						<td>
							<form:input path="caller" htmlEscape="false" maxlength="64" class="form-control required" size="80" id="caller" vild="on"/>
						</td>
					</tr>
					
					<tr>
						<td align="right"><span class="star">*</span> 会议时间：</td>
						<td>
							<input id="beginTime" name="beginTime" type="text" maxlength="20" class="laydate-icon form-control layer-date required" 
									value="<fmt:formatDate value="${meeting.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span> 会议地点：</td>
						<td>
							<form:input path="address" htmlEscape="false" maxlength="64" class="form-control required" size="80" id="address"/>
						</td>
					</tr>
					<tr>
						<td align="right"><span class="star">*</span> 记录人：</td>
						<td>
							<form:input path="recorder" htmlEscape="false" maxlength="64" class="form-control required" size="80" id="recorder"/>
						</td>
						</tr>
					<tr>
						<td align="right"><span class="star">*</span> 会议耗时：</td>
						<td>
							<form:input path="meetingTime" htmlEscape="false" maxlength="64" class="form-control required" size="80" id="meetingTime"/>
						</td>
						
					</tr>
					<tr>
						<td align="right"><span class="star">*</span> 会议出席人员：</td></br>
						<td>
							<form:textarea path="attender" htmlEscape="false" rows="4" maxlength="64" class="form-control required" cols="80" id="attender"/>
						</td>
						
						</tr>
					<tr>
						<td align="right">会议缺席人员：</td>
						<td>
							<form:textarea path="absentee" htmlEscape="false" maxlength="64" rows="4" class="form-control " cols="80"/>
						</td>
					</tr>
					<!-- <tr>
						<td></td>
						<td></td>
					</tr> -->
					<tr >
						<td align="right"><span class="star">*</span> 会议目标：</td>
						<td>(<span class="td_intro">简要说明会议的目标，包括达到期望的效果</span>)</td>
						</tr><tr>
						<td></td>
						<td>
							<form:textarea path="purpose" htmlEscape="false" rows="4" maxlength="255" class="form-control required" cols="80" id="purpose"/>
						</td>
						</tr>
					<tr>
						<td align="right"><span class="star">*</span> 会议内容：</td>
						<td>
							<form:textarea path="content" htmlEscape="false" rows="4" maxlength="255" class="form-control required" cols="80" id="content"/>
						</td>
					</tr>
					<!-- <tr>
					</tr> -->
					<tr>
						
						<td align="right"><span class="star">*</span> 主送人：</td>
						<td>
							<form:select  path="mainEmail" size="80" class="mainEmail selectpicker form-control " multiple="true" data-live-search="true">
									<form:options items="${fns:fundUsers()}" itemLabel="name" itemValue="name" htmlEscape="false" id="mainEmail"/>
							</form:select>
						</td>
						</tr>
					<tr>
						<td align="right">抄送人：</td>
						<td>
							
							<form:select  path="addEmail" size="80" class="addEmail selectpicker form-control " multiple="true" data-live-search="true">
								<form:options items="${fns:fundUsers()}" itemLabel="name" itemValue="name" htmlEscape="false"/>
							</form:select>
						</td>
					</tr>
					<tr>
	 	</tbody>
	</table>
		
		<div class="meeting-btn" align="center">
					<input type="reset" name="" id="clear" value="清空"/>
					<input type="button" name="" id="cancel" value="取消"/>
					<input type="button" name="" id="save" value="保存"/>
					<input type="button" name="" id="send" value="确定发送"/>
		</div>
	</div>
	</form:form>
</body>
</html>