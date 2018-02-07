
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%-- <%@ include file="/webpage/include/head.jsp"%> --%>
<html lang="en">
<head>
<meta name="decorator" content="default"/>
<title>修改产品</title>
<script src="../../../static/jquery/jquery-1.9.1.min.js"></script>
<script src="../../../static/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../static/bootstrap/3.3.4/css_default/bootstrap.min.css">
<script>
$(document).ready(function () {
	
	var e =  $("#estimate").text();
	var c = $("#consumed").text();
	var s = $("#surplus").text();
	
	$("#es").text(e);
	$("#co").text(c);
	$("#su").text(s);

	$("#center").hide();
	
	$("button.btn-xs").click(function(){
		if($(this).parent().parent().next().children().children().css("display") == "none"){
			$(this).parent().parent().next().children().children().slideToggle(300);
			$(this).html("-");
			$(this).parent().parent().next().children().children().css("background-color","#F2F2F2");
		}else{
			$(this).parent().parent().next().children().children().slideToggle(300);
			$(this).html("+");
		}
	})
});

	
</script>
<style>
* {
	margin: 0;
	padding: 0;
}

.title {
	border: 1px solid #F2F2F2 !important;
	padding-left: 10px;
	font-size: 13px;
	font-family: "Arial";
	height: 36px;
	line-height: 36px;
	margin-bottom: 10px;
	margin-top: 10px;
	background: #F2F2F2;
}

.title span {
	display: inline-block;
	width: 5px;
	height: 10px;
	background: #59C203;
	border-color: #59C203;
	margin-right: 5px;
}

.filed {
	text-align: right;
	width: 150px;
}



.line {
	display: block;
	padding-bottom: 5px;
	border-bottom: 1px solid #e0e2e4;
	width: 300px;
}

.line-two {
	width: 71%;
}

.table tr {
	height: 40px;
}

table {
	margin: 0 auto;
}

.btn-xs {
	border-color: #F2F2F2;
	border: none;
}


textarea {
	width: 75%;
	height: 100px;
	padding:2px 4px;
	border-color: #e0e2e4;
	background-color: #F2F2F2;
}

#itera {
	display: none;
}
table tr td.itera-table{
	padding: 10px 0;
}
</style>

</head>

<body>
	<div class="ibox-contents" style="border: none; overflow: hidden;">
		<div class="ibox-content-info">
			<div class="title">
				<span></span>基本信息
			</div>
			<table class="table">
				<!-- <colgroup>
				<col style="width:15%;">
			<col style="width:30%;">
			<col style="width:15%;">
			<col style="width:30%;">
			<col style="width:10%;">
			</colgroup> -->
				<tr>
					<td class="filed">产品名称：</td>
					<td><span class="line">${product.name}</span></td>
					<td class="filed">产品代号：</td>
					<td><span class="line">P${product.id}</span></td>
				</tr>
				<tr>
					<td class="filed">产品负责人：</td>
					<td><span class="line">${product.proManager}</span></td>
					<td class="filed">测试负责人：</td>
					<td><span class="line">${product.testManager}</span></td>
				</tr>
				<tr>
					<td class="filed">发布负责人：</td>
					<td><span class="line">${product.testManager}</span></td>
					<td class="filed">产品类型：</td>
					<td><span class="line">${product.type}</span></td>
				</tr>
				<tr>
					<td class="filed">状态：</td>
					<td><span class="line">${product.status}</span></td>
					<td class="filed">访问控制：</td>
					<td><span class="line">${product.interview}</span></td>
				</tr>
				<tr>
					<td class="filed" class="width-15 ">产品描述：</td>
					<td colspan="3" class="width-70">
						<textarea  class="form-control" style="width:72%;">${product.describe}</textarea>
					</td>
				</tr>
				<tr>
					<td class="filed">创建人：</td>
					<td><span class="line">${product.createBy.name}</span></td>
					<td class="filed">创建日期：</td>
					<td><span class="line"><fmt:formatDate value="${product.createDate}" pattern="yyyy-MM-dd hh:MM:ss"/></span></td>
				</tr>
				<tr>
					<td class="filed">修改人：</td>
					<td><span class="line">${product.updateBy.name}</span></td>
					<td class="filed">修改日期：</td>
					<td><span class="line"><fmt:formatDate value="${product.updateDate}" pattern="yyyy-MM-dd hh:MM:ss"/></span></td>
				</tr>
			</table>

			<div class="title">
				<span></span>迭代信息
				
			</div>
			
			<table class="table">
				<c:set var="iterater">${product.iterater}</c:set>
				
				
				
				<c:if test="${not empty iterater}">
					<c:set var="estimate" value="0"></c:set>
					<c:set var="consumed" value="0"></c:set>
					<c:set var="surplus" value="0"></c:set>
					<%--  <c:forEach items="${fns:getTaskInfoList()}" var="iterater">
						<c:set var="estimate" value = "${estimate+iterater.estimate}"></c:set>
						<c:set var="consumed" value = "${consumed+iterater.consumed}"></c:set>
						<c:set var="surplus" value = "${surplus+iterater.surplus}"></c:set>
					</c:forEach>  --%>
					
				</c:if>
				<c:set var="name">${product.name}</c:set>
				
				<c:forEach items="${fns:getIteraterListByName(name)}" var="iterater" varStatus="last">
					
					 <c:if test="${last.last}">
        						<center>总工时统计 ：总共预计<span id="es"></span>工时，已经消耗<span id="co"></span>工时，预计剩余<span id="su"></span>工时</center>					
        			</c:if>	 
        								
        				

					
					

				<!-- <tr><td colspan="4"></td></tr> -->
				<tr>
					<td class="filed">迭代名称：</td>
					<td><span class="line">${iterater.name }</span></td>
					<td class="filed">迭代编号：</td>
					<td><span class="line id" iid ="${iterater.id }" >S${iterater.id }</span></td>
					<td class="text-left"><button class="btn-xs ">+</button></td>
				</tr>
				<tr>
					<td colspan="5" class="itera-table">
						<table class="table" id="itera" aligtablen="left">
							<tr>
								<td class="filed">起始日期：</td>
								
								<td><span class="line" >
										<fmt:formatDate value="${iterater.beginTime }" pattern="yyyy-MM-dd"/>~
										<fmt:formatDate value="${iterater.endTime }" pattern="yyyy-MM-dd"/></span></td>
								<td class="filed">可用工作日：</td>
								<td><span class="line"><fmt:formatNumber value="${iterater.times/24 }" pattern="#0" /> </span></td>
								<td><button class="btn-xs " style="visibility: hidden;">+</button></td>
							</tr>
							<tr>
								<td class="filed">团队成员：</td>
								<td><span class="line">${iterater.teamMan }</span></td>
								<td class="filed">迭代类型：</td>
								<td><span class="line">${iterater.type}</span></td>

							</tr>
							<tr>
								<td class="filed">迭代描述：</td>
								<td colspan="3"><textarea>${iterater.describe}</textarea></td>

							</tr>
							<tr>
								<td class="filed">创建人：</td>
								<td><span class="line">${iterater.createBy.name }</span></td>
								<td class="filed">创建日期：</td>
								<td><span class="line"><fmt:formatDate value="${iterater.createDate}" pattern="yyyy-MM-dd hh:MM:ss"/></span></td>

							</tr>
							<tr>
								<td class="filed">修改人：</td>
								<td><span class="line">${product.updateBy.name}</span></td>
								<td class="filed">修改日期：</td>
								<td><span class="line"><fmt:formatDate value="${iterater.updateDate}" pattern="yyyy-MM-dd hh:MM:ss"/></span></td>
							</tr>

							<tr>
								<c:set var="id">${iterater.id}</c:set>
								<c:set var="estimates" value="0"></c:set>
								<c:set var="consumeds" value="0"></c:set>
								<c:set var="surpluss" value="0"></c:set>
								<c:set var="surp" value="0"></c:set> 
								<c:forEach items="${fns:getTimeByIid(id)}" var="iteraters">
									<c:set var="estimates" value = "${estimates+iteraters.estimate}"></c:set>
									<c:set var="consumeds" value = "${consumeds+iteraters.consumed}"></c:set>
									<c:set var="surpluss" value = "${surpluss+iteraters.surplus}"></c:set>
									<c:set var="surp" value = "${surp+iteraters.surplus}"></c:set>
								</c:forEach>
								
								<td colspan="4">
									<center>工时统计 ：总共预计<span>${estimates}</span>工时，已经消耗<span>${consumeds}</span>工时，预计剩余<span>${surpluss}</span>工时</center>
								</td> 
							</tr>
								<c:set var="estimate" value = "${estimate+estimates}"></c:set>
								<c:set var="consumed" value = "${consumed+consumeds}"></c:set>
								<c:set var="surplus" value = "${surplus+surpluss}"></c:set>
							<tr>
								<td>
									<div id="center" style="display:none">
										<c:if test="${last.last}">
			        						<center style="display:none">总工时统计 ：总共预计<span id="estimate">${estimate}</span>工时，已经消耗<span id="consumed">${consumed}</span>工时，预计剩余<span id="surplus">${surplus}</span>工时</center>					
			        					</c:if>	
									</div>
								</td>
							</tr>
								
						</table>
					</td>
				</tr>
				</c:forEach>
			
			</table>
		</div>
	</div>
</body>

</html>