<%@ page contentType="text/html;charset=UTF-8" %>
  <%@ include file="/webpage/include/taglib.jsp"%>
    <html>
    <head>
      <title>首页</title>
      <meta name="decorator" content="default" />
      <script src="${ctxStatic}/echarts/echarts.min.js" type="text/javascript"></script>
     <style type="text/css">
    .lan{
      color:#000;
      background-color:#3ff;
      -webkit-border-radius: 5px;
      height: 145px;
    }
    .main-box {
    text-align: center;
    padding: 20px;
    -webkit-border-radius: 5px;
    margin-bottom: 40px;	
    }
    .mb-pink {
    background-color: yellow;
	}
	.mb-dull {
    background-color: #0194E9;
	}
	.mb-red {
    background-color: red;
	}
  </style>
    </head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="ibox">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-4">
						<div class="main-box mb-dull">
							<a href="#"> <i class="fa fa-plug fa-5x"></i> <span>充能</span>
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="main-box mb-red">
							<a href="#"> <i class="fa fa-bolt fa-5x"></i> <span>奋斗</span>
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="main-box mb-pink">
							<a href="#"> <i class="fa fa-dollar fa-5x"></i> <span>回报</span>
							</a>
						</div>
					</div>

				</div>
				<!-- /. ROW  -->

				<div class="row">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-12">

								<div id="reviews" class="carousel slide" data-ride="carousel">

									<div class="carousel-inner lan" style="">
										<div class="item active">

											<div class="col-md-10 col-md-offset-1">

												<h4>
													<i ></i>第一名 <i ></i>
												</h4>
												<div class="user-img pull-right"
													style="border-radius: 50%; overflow: hidden;">
													<img src="${ctxStatic}/images/r_1.png"
														style="height: 50px; width: 50px" alt=""
														class="img-u image-responsive">
												</div>
												<h5 class="pull-right">
													<strong class="c-black">林心如</strong>
												</h5>
											</div>
										</div>
										<div class="item">
											<div class="col-md-10 col-md-offset-1">

												<h4>
													<i ></i>第二名 <i ></i>
												</h4>
												<div class="user-img pull-right"
													style="border-radius: 50%; overflow: hidden;">
													<img src="${ctxStatic}/images/r_2.png"
														style="height: 50px; width: 50px" alt=""
														class="img-u image-responsive">
												</div>
												<h5 class="pull-right">
													<strong class="c-black">刘亦菲</strong>
												</h5>
											</div>

										</div>
										<div class="item">
											<div class="col-md-10 col-md-offset-1">

												<h4>
													<i ></i>第三名 <i ></i>
												</h4>
												<div class="user-img pull-right"style="border-radius:50%; overflow:hidden;">
													<img src="${ctxStatic}/images/r_3.png"
														style="height: 50px; width: 50px" alt=""
														class="img-u image-responsive">
												</div>
												<h5 class="pull-right">
													<strong class="c-black">范冰冰</strong>
												</h5>
											</div>
										</div>
									</div>
									<!--INDICATORS-->
									<ol class="carousel-indicators">
										<li data-target="#reviews" data-slide-to="0" class="active"></li>
										<li data-target="#reviews" data-slide-to="1" class=""></li>
										<li data-target="#reviews" data-slide-to="2" class=""></li>
									</ol>
									<!--PREVIUS-NEXT BUTTONS-->

								</div>

							</div>

						</div>
						<!-- /. ROW  -->
						<hr>

						<div class="panel panel-default">

							<div id="carousel-example" class="carousel slide"
								data-ride="carousel" style="border: 5px solid #000;">

								<div class="carousel-inner">
									<div class="item">

										<img src="${ctxStatic}/images/f_1.png"
											style="height: 440px; width: 700px" alt="image">

									</div>
									<div class="item active left">
										<img src="${ctxStatic}/images/f_2.png"
											style="height: 440px; width: 700px" alt="image">

									</div>
									<div class="item next left">
										<img src="${ctxStatic}/images/f_3.png"
											style="height: 440px; width: 700px" alt="image">

									</div>
								</div>
								<!--INDICATORS-->
								<ol class="carousel-indicators">
									<li data-target="#carousel-example" data-slide-to="0" class=""></li>
									<li data-target="#carousel-example" data-slide-to="1" class=""></li>
									<li data-target="#carousel-example" data-slide-to="2"
										class="active"></li>
								</ol>
								<!--PREVIUS-NEXT BUTTONS-->
								<a class="left carousel-control" href="#carousel-example"
									data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left"></span>
								</a> <a class="right carousel-control" href="#carousel-example"
									data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right"></span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
