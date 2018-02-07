<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<!-- <script src="${ctxStatic}/layui/lay/dest/layui.all.js"></script>   -->

	<style type="text/css">
		.comments {
		 width:100%;/*自动适应父布局宽度*/
		 overflow:auto;
		 word-break:break-all;
		 /*在ie中解决断行问题(防止自动变为在一行显示，主要解决ie兼容问题，ie8中当设宽度为100%时，文本域类容超过一行时，当我们双击文本内容就会自动变为一行显示，所以只能用ie的专有断行属性“word-break或word-wrap”控制其断行)*/
		}
	</style>
	<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css">
	<script src="${ctxStatic}/layui/layui.js"></script>

	<script type="text/javascript">
		var validateForm;
		var layedit;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }

		  return false;
		}
		$(document).ready(function() {
			innitTxtarea();
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					$("#logs").find("textarea").each(function(){
						   var index=$(this).attr("index");
						    console.log("index:"+index);
						   var content=layedit.getContent(index);//建立编辑器
						   // var content=layedit.getText(index);//建立编辑器
						   console.log("内容："+content);
						   $(this).val(content);
					});
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
	            elem: '#followDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
			
		});

   	  function innitTxtarea(){
   	  	  layui.use('layedit', function(){
			    layedit = layui.layedit;
			    $("#logs").find("textarea").each(function(){
				   console.log($(this).attr("id"));
				   var id=$(this).attr("id");
				   var index=layedit.build(id); //建立编辑器
				   $(this).attr("index",index);
				});
		});
   	  }

   	  function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
			innitTxtarea();
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
 
	</script>
	<style>
		.star{
			color:red;
		}
		.filed {
			text-align: right;
			width:100px;
		}
		
	</style>
</head>
<body class="pop-window">
	<form:form id="inputForm" modelAttribute="log" action="${ctx}/project/project/saveLog" method="post">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<!-- <div class="ibox-content" style="border: none;overflow: hidden;" id="container">  -->
	<table class="table">
		
	   	 <tbody id="tboody_head">
	   	 	<tr>
	   	 		
	   	 			<input type="hidden" name="project" value="${project.id }"></input>
	   	 		
	   	 	</tr>
			<tr>
				<td class="filed">项目名称：</td>
				<td>
					<span style="display: block;padding-bottom: 5px;border-bottom: 1px solid #e0e2e4;width:85%;">${project.name}</span>
				</td>
				
			</tr>
			<tr>
				<td class="filed"><span class="star">*</span>跟进时间：</td>
				<td>
					<input id="followDate" name="followDate" type="text" maxlength="100" class="laydate-icon form-control layer-date required"
								value="<fmt:formatDate value="${log.followDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				</td>
			</tr>
			<tr>
				<td class="filed"><span class="star">*</span>阶段描述：</td>
				<td>
					<form:textarea path="summary" htmlEscape="false" rows="15" maxlength="" class="form-control required" cssStyle="width:85%;"/>
				</td>
			</tr>
			<!-- <tr>
				<td>记录人：</td>
				<td>
					<form:input path="createBy.name" htmlEscape="false"    class="form-control "/>
				</td>
				
			</tr>  -->
			<!-- <c:forEach items="${logs}" var="log"  varStatus="status">
				<tr>
					<td>纪要 ${status.count}： 
					<input type="hidden" name="logs[${status.count-1}].id" value="${log.id}"></input>
					<input type="hidden" name="logs[${status.count-1}].project" value="${project.id}"></input>
					</td>
					<td colspan="3">
					     <textarea name="logs[${status.count-1}].summary" id="log_${log.id}"  class="comments"  rows="10" cols="10"  style="display: none" >${log.summary}</textarea>
					</td>
				</tr>
			</c:forEach>
			 <c:if test="${empty logs}">
				<tr>
					<td>纪要：
					 	<input type="hidden" name="logs[0].id" value=""></input>
						<input type="hidden" name="logs[0].project" value="${project.id}"></input> 
					</td>
					<td colspan="3">
					     <textarea name="logs[0].summary"     class="comments"  rows="10" cols="10" id="remarks" style="display: none"></textarea>
					</td>
				</tr> 
			</c:if>  -->
		   </tbody> 
		</table>
        <!-- <ul class="nav nav-tabs">
        			<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">项目动态</a>
            </li>
        </ul>
        <div class="tab-content">
        			<div id="tab-1" class="tab-pane active">
        				<a class="btn btn-white btn-sm" onclick="addRow('#logs', bProjectLogRowIdx, bProjectLogTpl);bProjectLogRowIdx = bProjectLogRowIdx + 1;" title="新增"><i class="fa fa-plus"></i> 新增</a>
        				<table id="contentTable" class="table table-striped table-bordered table-condensed"> -->
        
        					<!-- <colgroup>
        						<col  style="width:0%">
        						<col style="width:25%">
        						<col style="width:70%">
        						<col style="width:5%">
        					</colgroup> -->
        				<!--	<thead>
        						<tr>
        							<th class="hide"></th>
        							<th>主题</th>
        							<th>项目纪要</th>
        							<th >&nbsp;</th>
        						</tr>
        					</thead>
        					<tbody id="logs">
        					</tbody>
        				</table>  -->
        				<script type="text/template" id="bProjectLogTpl">
        				      <tr id="logs{{idx}}">
        						<td class="hide">
        							<input id="logs{{idx}}_id" name="logs[{{idx}}].id" type="hidden" value="{{row.id}}"/>
        							<input id="logs{{idx}}_delFlag" name="logs[{{idx}}].delFlag" type="hidden" value="0"/>
        						</td>
        						<td>
        							<input id="logs{{idx}}__theme"  name="logs[{{idx}}].theme" class="comments"   class="form-control " value="{{row.theme}}"/>
        						</td>
        						<td >
        							<textarea id="logs{{idx}}_summary"  name="logs[{{idx}}].summary" class="comments"    rows="4" class="form-control ">{{row.summary}}</textarea>
        						</td>
        						<td class="text-center" width="10">
        							{{#delBtn}}<span class="close" onclick="delRow(this, '#logs{{idx}}')" title="删除">&times;</span>{{/delBtn}}
        						</td>
        					</tr>
        				</script>
        				<script type="text/javascript">
        					var bProjectLogRowIdx = 0, bProjectLogTpl = $("#bProjectLogTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        					$(document).ready(function() {
        						var data = ${fns:toJson(logs)};
        						for (var i=0; i<data.length; i++){
        							addRow('#logs', bProjectLogRowIdx, bProjectLogTpl, data[i]);
        							bProjectLogRowIdx = bProjectLogRowIdx + 1;
        						}
        					});
        				</script>
        		</div>
        	 </div>  
	</form:form>
</body>
</html>