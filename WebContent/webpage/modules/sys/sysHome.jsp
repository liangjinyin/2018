<%@ page contentType="text/html;charset=UTF-8" %>
  <%@ include file="/webpage/include/taglib.jsp"%>
    <html>
    <head>
      <title>首页</title>
      <meta name="decorator" content="default" />
      <script src="${ctxStatic}/echarts/echarts.min.js" type="text/javascript"></script>
     
    </head>
    <body class="gray-bg">
       <div class="wrapper wrapper-content">
          <div class="ibox">
              <div class="panel-body">
                <div id="chartDay" style="max-height: 500px;">
                    <div class="ibox-title">
                    <span class="ibox-title-photo"></span>
                      <h5>销售看板</h5>
                    </div>
                    <table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
                        <thead>
                          <tr>
                            <th >销售负责人</th>
                            <th >销售指标(元)</th>
                            <th >签单数</th>
                            <th >销售总额(万)</th>
                            <th >完成率</th>           
                           </tr>
                        </thead>
                         <tbody>
                            <c:forEach items="${data.saleManData}" var="sale">
                                <tr>
                                  <td   class="text-center"  >
                                      ${sale.sname}
                                  </td>
                                   <td   class="text-center"  >
                                   <%-- <c:if test="${sale.target==0}">
                                   	<fmt:formatNumber value="${sale.target}" pattern="0"/>
                                  </c:if> --%>
                                   <fmt:formatNumber value="${sale.target}" pattern="#,###.00"/>
                                   	
                                      <%-- ${sale.target} --%>
                                  </td>
                                   <td   class="text-center"  >
                                   	<c:choose>
									   <c:when test="${not empty sale.snum}">  
									         ${sale.snum}  
									   </c:when>
									   <c:otherwise> 
									 			0
									   </c:otherwise>
									</c:choose>	
                                   
                                      
                                  </td>
                                   <td   class="text-center"  >
                                   <c:if test="${sale.amount==0}">
                                   	<fmt:formatNumber value="${sale.amount}" pattern="0"/>
                                  </c:if>
                                   	<fmt:formatNumber value="${sale.amount}" pattern="#,###.00"/>
                                  
                                      <%-- ${sale.amount} --%>
                                  </td>
                                   <td   class="text-center"  >
                                      ${sale.rate}
                                  </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!--  <div id="pieChart" style="height: 300px;"></div> -->
              </div>
                
             
               <script>
                           var  data=${fns:toJson(data)};
                           console.log(data);
                           var products=data.products;//['直达','营销广告','搜索引擎','邮件营销','联盟广告','视频广告','百度','谷歌','必应','其他'];
                           var otherData=data.otherData;/*[
                                              {value:0, name:'直达'},
                                              {value:0, name:'邮件营销'},
                                              {value:0, name:'联盟广告'},
                                              {value:0, name:'视频广告'},
                                              {value:0, name:'百度'},
                                              {value:0, name:'谷歌'},
                                              {value:0, name:'必应'},
                                              {value:50, name:'其他'}
                                      ];*/
                            var coreData =data.coreData;/*[
                                              {value:335, name:'直达', selected:true},
                                              {value:679, name:'营销广告'},
                                              {value:1548, name:'搜索引擎'}
                                          ];*/
                            var pieChart = echarts.init(document.getElementById('pieChart'));
                                option = {
                                  tooltip: {
                                      trigger: 'item',
                                      formatter: "{a} <br/>{b}: {c} ({d}%)"
                                  },
                                  legend: {
                                      orient: 'vertical',
                                      x: 'left',
                                      data:products
                                  },
                                  series: [
                                          {
                                          name:'销售额（元）',
                                          type:'pie',
                                          selectedMode: 'single',
                                          radius: [0, '35%'],
                                          label: {
                                              normal: {
                                                  position: 'inner'
                                              }
                                          },
                                          labelLine: {
                                              normal: {
                                                  show: false
                                              }
                                          },
                                          data:coreData
                                      },
                                      {
                                          name:'销售额（元）',
                                          type:'pie',
                                          radius: ['45%', '65%'],

                                          data:otherData
                                      }
                                  ]
                              };
                          pieChart.setOption(option);
               </script>
          </div>
       </div>
    </body>
  </html>
