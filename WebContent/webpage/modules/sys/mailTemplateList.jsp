<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>邮件模板管理</title>
	<meta name="decorator" content="default"/>
	
	<style>
		.mailMain{
			/*padding: 15px;*/
			border: 1px solid #CCC;
		}
		
		.active{
			color: #C6819A;
		}
		.floatRight{
			float: right;
			margin-right: 30px;
		}
		.radioActive{
			width: 20px;
		}
		.confirm{
			padding: 5px 15px;
			background: #00C3F4;
			border: none;
			border-radius: 5px; 
			color: #FFF;
			margin-top: 15px;
		}
		.twoTitle{
			color: #1B7552;
			font-weight: bold;
		}
		.textIndex{
			text-indent: 2em;
		}
		
		.contain{
			padding: 0 15px;
			margin-top: 30px;
		}
		.position{
			text-align: right;
			padding-right: 20px;
		}
		.headerLog{
			vertical-align: middle;
		    background-color: #40C0EF;
		    padding: 5px 10px 8px 10px;
		}
		.headerLog2{
			background-color: #5A636F;
		}
	</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>邮件模板列表 </h5>		
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	

	<div class="row">
	<div class="col-sm-12">
		
		
	</div>
	</div>
		<div class="panel panel-info">
			<div class="panel-body">
				<c:forEach items="${page.list}" var="mailTemplate">
					<p>${mailTemplate.mtContent}</p>
					
					<input type="radio" id="mtId" hidden="true" value="${mailTemplate.mtId}">
				</c:forEach>
	

			<!-- <label>
				<input type="radio" class="radioActive" name="checks" value="0" checked="checked">模板一
			</label>
			<div class=" mailMain">
				<div class="headerLog">
					<img src="http://image4.cnpp.cn/upload/images/20140913/09183631645_138x60.gif_138_60.jpg">
				</div>
				<div class="contain">
					<h5>尊敬的${receiveName},您好！</h5><br>
					<div class="textIndex">${jobName}任务执行失败！</div>
					<div id="main">
						<div class="textIndex">
						任务失败原因：${execDesc}</div>
						<br>
						<div class="textIndex">（此信为系统邮件，请不要直接回复！）</div>
						<div class="position">xdata</div>
						<div class="position">${sendDate}</div>
						<div></div>
					</div>
				</div>
			</div>
			<label>
				<input type="radio" class="radioActive" name="checks" value="1" checked="checked">模板二
			</label>
			<div class=" mailMain">
				<div class="headerLog headerLog2">
					<img src="${ctxStatic}/common/img/logo.png">
				</div>
				<div class="contain">
					<h5>亲爱的${receiveName}，您好！</h5><br>
					<div class="textIndex active">${jobName}任务执行失败！</div>
					<div id="main">
						<div class="textIndex active">
						任务失败原因：${execDesc}</div>
						<br>
						<div class="textIndex">（此信为系统邮件，请不要直接回复！）</div>
						<div class="position">xdata</div>
						<div class="position">${sendDate}</div>
						<div></div>
					</div>
				</div>
			</div> -->


			<button class="floatRight confirm" id="confirm">确认</button>
			</div>
		</div>
		

	
	<br/>
	<br/>
	</div>
	</div>
</div>
<script type="text/javascript">
		$(document).ready(function() {
		
		});
		function submit(){
			var confirm = $("#confirm");
			var mtId = $("#mtId").val();
			var radio =  $('input[name="checks"]:checked').val()
			confirm.on('click', function(){
				$.ajax({
					type: 'post',
					data: {
						mtId: mtId,
						mtType: 1,
					},
					url: '${ctx}/sys/mailtemplate/pitchon',
					success: function(msg){
						// console.log(msg)
						top.layer.alert(msg);
					}
				})
			})
		}
		submit();
</script>
</body>
</html>