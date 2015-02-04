<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.member.db.*" %>
<%@ page import="java.util.Random" %>
<%
	MemberBean bean = new MemberBean();
	bean = (MemberBean)session.getAttribute("Member");

	LoginManager loginManager = LoginManager.getInstance();
	
	double failCount = 0;//(Integer)request.getAttribute("failCount");
	double successCount = 0; //(Integer)request.getAttribute("successCount");
	double totalCount = failCount + successCount;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SMS 발송센터(SSC:SMS Send Center)</title>

<!-- Bootstrap Core CSS -->
<link href="<%=application.getContextPath() %>/bootstrap/bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- MetisMenu CSS -->
<link href="<%=application.getContextPath() %>/bootstrap/bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">
<!-- Morris Charts CSS -->
<link href="<%=application.getContextPath() %>/bootstrap/bower_components/morrisjs/morris.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="<%=application.getContextPath() %>/bootstrap/dist/css/sb-admin-2.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="<%=application.getContextPath() %>/bootstrap/bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
<%
if((MemberBean)session.getAttribute("Member")==null || !loginManager.isLogin(session.getId())){
	%><jsp:forward page="../index.jsp"></jsp:forward><%
}
%>
    <div id="wrapper">
        <!-- 네비게이션 -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        	<!-- 상단 네비게이션 -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<%=application.getContextPath() %>/SmsMainView.sms"">SMS 발송센터</a>
            </div>
			<!-- 상단 드롭다운 네비게이션 -->
            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="<%=application.getContextPath()%>/MemberAlterView.mem"><i class="fa fa-user fa-fw"></i>정보수정</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="<%=application.getContextPath()%>/MemberLogoutAction.mem"><i class="fa fa-sign-out fa-fw"></i>로그아웃</a>
                        </li>
                    </ul>
                </li>
            </ul>
			<!-- 왼쪽 네비게이션 -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                	<div class="text-center" style="font-size: 15px">
                		<br>
                		<strong><%=bean.getName()%>님 환영합니다.</strong>
                		<br>
                		<br>
                		<strong>현재 접속자 수 : <%=loginManager.getUserCount() %>명</strong>
                		<br>
                		<br>
                		<div>
                			<input class="btn btn-info" type="button" value="정보변경" onclick="location.href='<%=application.getContextPath()%>/MemberAlterView.mem'">
                			<input class="btn btn-info" type="button" value="로그아웃" onclick="location.href='<%=application.getContextPath()%>/MemberLogoutAction.mem'">
                		</div>
                		<br>
                	</div>
                    <ul class="nav" id="side-menu">
                        <li style="background: #eee;">
                            <a href="<%=application.getContextPath() %>/TscMainView.tsc"><i class="fa fa-dashboard fa-fw"></i>메인페이지</a>
                        </li>
                        <li>
                            <a href="<%=application.getContextPath() %>/SmsSendView.sms"><i class="fa fa-table fa-fw"></i>발송하기</a>
                        </li>
                        <li>
                            <a href="<%=application.getContextPath() %>/SmsReportView.sms"><i class="fa fa-bar-chart-o fa-fw"></i>발송레포트</a>
                        </li>   
                    </ul>
                </div>
            </div>
        </nav>
		<!-- 페이지 본문 내용 -->
        <div id="page-wrapper">
        	<div class="row">
                <div class="col-lg-6">
                    <h1 class="page-header">방문해주신 여러분 환영합니다.</h1>
                </div>
            </div>
        	<%-- <div id="row">
        		<div class="col-lg-7">
                	<div id="myCarousel" class="carousel slide"data-interval="3000">
               			<!-- <ol class="carousel-indicators">
                 			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                 			<li data-target="#myCarousel" data-slide-to="1"></li>
                 			<li data-target="#myCarousel" data-slide-to="2"></li>
               			</ol> -->
               			<div class="carousel-inner">
                 			<div class="item active">
                   				<img src="<%=application.getContextPath() %>/img/sms_main1.png" alt="">
                   				<br><br><br><br><br><br><br><br>
                   				<div class="carousel-caption">
                     				<h4 style="color:black;"><strong>기업고객을 위한 대량메시지 서비스</strong></h4>
                     				<p style="color:black;"><strong>쉽고 빠른 대량전송! 비즈니스를 도와줄 메세징 솔루션! 개인고객을 넘어서 기업고객에게도 맞는 맞춤메세지 서비스가 되겠습니다.</strong></p>
                   				</div>
                 			</div>
                 			<div class="item">
                   				<img src="<%=application.getContextPath() %>/img/sms_main2.jpg" alt="">
                   				<br><br><br><br><br><br><br><br>
                   				<div class="carousel-caption">
                     				<h4 style="color:black;"><strong>사용자들에게 간편함과 편의성을 제공</strong></h4>
                     				<p style="color:black;"><strong>노트북, PC, Tablet, Mobile 모든 스마트기기에서 입력후 발송가능.</strong></p>
                   				</div>
                 			</div>
                 			<div class="item">
                   				<img src="<%=application.getContextPath() %>/img/sms_main3.png" alt="">
                   				<br><br><br><br><br><br><br><br>
                   				<div class="carousel-caption">
                     				<h4 style="color:black;"><strong>제휴업체</strong></h4>
                     				<p style="color:black;"><strong>포스트맨은 저희의 가족입니다.</strong></p>
                   				</div>
                 			</div>
               			</div>
               			<a class="left carousel-control en-font-family" href="#myCarousel" data-slide="prev">&lsaquo;</a>
               			<a class="right carousel-control en-font-family" href="#myCarousel" data-slide="next">&rsaquo;</a>
             		</div>
           		</div>
       		</div> --%>
       		<div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">	
                        <div class="panel-heading">
              				<span style="padding-right:100px"><%=bean.getName() %>님의 통계</span>
           				</div>
                        <div class="panel-body" style="margin: 0 auto; text-align: center;">
                            <div id="smsTotalChart" style="padding-left:25px; pading-right:25px;float:left;width:250px;"></div>
                            <div id="smsPercentChart" style="padding-left:25px; pading-right:25px;float:left;width:250px;"></div>
                        </div>
                    </div>
                </div>
            </div>
       	</div>
    </div>

<!-- jQuery -->
<script src="<%=application.getContextPath() %>/bootstrap/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="<%=application.getContextPath() %>/bootstrap/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="<%=application.getContextPath() %>/bootstrap/bower_components/metisMenu/dist/metisMenu.min.js"></script>
<!-- Morris Charts JavaScript -->
<script src="<%=application.getContextPath() %>/bootstrap/bower_components/raphael/raphael-min.js"></script>
<script src="<%=application.getContextPath() %>/bootstrap/bower_components/morrisjs/morris.min.js"></script>
<script src="<%=application.getContextPath() %>/bootstrap/js/morris-data.js"></script>
<!-- Custom Theme JavaScript -->
<script src="<%=application.getContextPath() %>/bootstrap/dist/js/sb-admin-2.js"></script>
<script src="<%=application.getContextPath() %>/bootstrap/bower_componets/bootstrap/js/carousel.js"></script>
</body>
</html>
<script type="text/javascript">
Morris.Donut({
	  element: 'smsTotalChart',
	  data: [
	    {label: "Success", value: <%=(int)successCount%>},
	    {label: "Failure", value: <%=(int)failCount%>},],
		colors: [
       '#0BA462',
       '#39B580',
     ],
     formatter: function (x) { return x + "건"}
});

<%
double success = successCount/totalCount*100;
double fail = failCount/totalCount*100;
System.out.println(totalCount+"/"+success+"/"+fail);
%>
Morris.Donut({
    element: 'smsPercentChart',
	  data: [
	    {label: "Success", value:<%if(totalCount!=0){%><%=Math.round(success)%><%}%>},
	    {label: "Failure", value:<%if(totalCount!=0){%><%=Math.round(fail)%><%}%>},],
	    colors: [
	             '#0BA462',
	             '#39B580',
	           ],
	  formatter: function (x) { return x + "%"}
});
</script>
