<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>迭代管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/silviomoreto-bootstrap/bootstrap-select.min.css">
	<script type="text/javascript">



			var product=${fns:toJson(iterater.product)};
			var id=${fns:toJson(iterater.id)};

			var iid =${fns:getIteraterNum()};
			
			$("#product").val(product);

		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
		  	//对团队成员进行非空校验	
		  	 var te = $(".pull-left").text();
		  	 console.log(te);
		  	 if(te=="请选择"){
		  	 	var la  =  $("<label id='teamMan-error' class='error' for='teamMan'>这是必填字段</label>")
		  	 	 $("#test").append(la );
		  	 	return	
		  	 }

			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			

			//加载迭代编号
			if(id){
				$(".iid").val("S"+id);	
			}else{
				if(iid=="0"){
					$(".iid").val("S1");
					
				}else{
					$(".iid").val("S"+(iid+1));
				} 
			}

			$('.selectpicker').selectpicker({
                'selectedText': 'cat'
            });
			
			//回显团队成员
			var users=${fns:toJson(iterater.teamMan)};
			if(users){
				console.log(users);
				var oldnumber = users.split(",");
				console.log(oldnumber);

			    //$('.teamMans selectpicker').text(teamMan);
			     //$(".pull-left").text(teamMan);
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

			laydate({
	            elem: '#s_times', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
            	choose: function(datas){ //选择日期完毕的回调
           	        //end.min = datas; //开始日选好后，重置结束日的最小日期
           	        //end.start = datas //将结束日的初始值设定为开始日 
           	        //alert(datas);
           	        //$("#s_times").attr("start",datas);
           	        var ends = $("#e_times").val();
           	        var start = new Date(datas).getTime();
           	        var end = new Date(ends).getTime();

           	        var day  = (end-start)/(1000*60*60);
           	    	$("#useTiem").val(day);
           	   	}
			
	        });
			laydate({
	            elem: '#e_times', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	           
	            event: 'focus', //响应事件。如果没有传入event，则按照默认的click
           	    choose: function(datas){ //选择日期完毕的回调
           	    	
           	    	//var st = $("#s_times").attr("start");
           	    	var sts = $("#s_times").val();
           	    
           	    	//if(st){
           	    		
	           	    //	var start = new Date(st).getTime();
           	    	//}else{
           	    		var start = new Date(sts).getTime();
           	    	//}
           	    	var end = new Date(datas).getTime();
           	    	//alert(typeof(start));
           	    	var day  = (end-start)/(1000*60*60);
           	    	$("#useTiem").val(day);
           	   	}
	        });

		});
			//关联时间
		 function dateFunction(obj){
			
			var endTime = new Date();
			endTime.setDate(endTime.getDate()+parseInt(obj)-1);
			
			//alert(endTime.getDate()+parseInt(obj));
			
		 	$("#s_times").val(new Date().Format("yyyy-MM-dd"));
		 	$("#e_times").val(endTime.Format("yyyy-MM-dd"));
		 	$("#useTiem").val(obj*24);//关联可用时间
		}

		 //时间格式化
		 Date.prototype.Format = function (fmt) {  
			    var o = {  
			        "M+": this.getMonth() + 1, //月份   
			        "d+": this.getDate(), //日   
			        "H+": this.getHours(), //小时   
			        "m+": this.getMinutes(), //分   
			        "s+": this.getSeconds(), //秒   
			        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
			        "S": this.getMilliseconds() //毫秒   
			    };  
			    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
			    for (var k in o)  
			    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
			    return fmt;  
			}  

	</script>
	<style type="text/css">
		.star{
			color:red;
		}
	</style>
</head>
 <body class="pop-window">
		<form:form id="inputForm" modelAttribute="iterater" action="${ctx}/iterater/iterater/save" method="post"  >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="ibox-content" style="border: none;overflow: hidden; background-color: #F8F8F8;" id="container">
		<table class="table">
		   <tbody>
				<tr>
					<td><label class="pull-right"><span class="star">*</span>迭代名称:</label></td>
					<td>
						<form:input path="name" htmlEscape="false" maxlength="64" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td><label class="pull-right"><span class="star">*</span>迭代编号:</label></td>
					<td>
						<form:input id="iid" path="" htmlEscape="false" maxlength="64" class="form-control required iid" readonly="true"/>
					</td>
				</tr>
				<tr>	
					<td><label class="pull-right"><span class="star">*</span>起始日期:</label></td>
					<td>
						<div>
						<%-- <form:input id="s_times" start="" path="beginTime" class="laydate-icon  layer-date" placeholder="开始日期" /><span>至</span>
						<form:input id="e_times" path="endTime" htmlEscape="false" end="" class="laydate-icon layer-date " placeholder="结束日期" />
 --%>
						
						
						<input id="s_times" name="beginTime" type="text" maxlength="20" style="width:150px;"  class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${iterater.beginTime}" pattern="yyyy-MM-dd"/>"/><span>至</span>				 
						<input id="e_times" name="endTime" type="text" maxlength="20" style="width:150px;" class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${iterater.endTime}" pattern="yyyy-MM-dd"/>"/>	



						</div>
					</td>
				</tr>
				 <tr>
					<td></td>
					<td>
						<form:radiobutton  path="remarks" value="7" onclick="dateFunction(this.value)" label="一个星期"/>			
						<form:radiobutton  path="remarks" value="14" onclick="dateFunction(this.value)" label="两个星期"/>		
						<form:radiobutton  path="remarks" value="30" onclick="dateFunction(this.value)" label="一个月"/>		
						<form:radiobutton  path="remarks" value="60" onclick="dateFunction(this.value)" label="两个月"/></br>		
						<form:radiobutton  path="remarks" value="90" onclick="dateFunction(this.value)" label="三个月"/>		
						<form:radiobutton  path="remarks" value="180" onclick="dateFunction(this.value)" label="半年"/>		
						<form:radiobutton  path="remarks" value="365" onclick="dateFunction(this.value)" label="一年"/> 	
					</td>
				</tr> 
				<tr>	
					<td><label class="pull-right"><span class="star">*</span>可用时间:</label></td>
					<td>
						<div class="input-group">	
							<form:input id="useTiem" path="times" htmlEscape="false" maxlength="64" class="form-control required" readonly="true"/>
							<span class="input-group-addon">小时</span>
						</div>
					</td>
				</tr>
				<tr>
					<td><label class="pull-right"><span class="star">*</span>迭代类型:</label></td>
					<td>
						<form:select path="type" class="form-control required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('iter_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>	
					<td><label class="pull-right"><span class="star">*</span>关联产品:</label></td>
					<td>
						<form:input id="product" path="product" htmlEscape="false" maxlength="64" class="form-control a required" readonly="true"/>
					</td>
				</tr>
				<tr>
					<td align="right"><span class="star">*</span>迭代描述:</td>
					<td>
						<form:textarea path="describe" htmlEscape="false" rows="4" maxlength="1024" class="form-control required"/>
					</td>
				</tr>
				<tr>	
					<td align="right"> <span class="star">*</span> 团队成员：</td>
					<td id="test">	
						<div id="teamMan">					
							<form:select path="teamMan"  class="selectpicker form-control "  multiple="true" 
																	data-live-search="true" >
									<form:options items="${fns:fundUsers()}" itemLabel="name" itemValue="name" htmlEscape="false"/>
							</form:select>
						</div>
								
					</td>
				</tr>
		 	</tbody>
		</table>
		</div>
	</form:form>
</body> 

</html>