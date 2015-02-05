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
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="<%=application.getContextPath() %>/css/template.css" rel="stylesheet">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script src="<%=application.getContextPath() %>/jquery/jquery-1.10.1.min.js"></script>
<script src="<%=application.getContextPath() %>/bootstrap/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
        window.alert = function(){};
        var defaultCSS = document.getElementById('bootstrap-css');
        function changeCSS(css){
            if(css) $('head > link').filter(':first').replaceWith('<link rel="stylesheet" href="'+ css +'" type="text/css" />'); 
            else $('head > link').filter(':first').replaceWith(defaultCSS); 
        }
        $( document ).ready(function() {
          var iframe_height = parseInt($('html').height()); 
          window.parent.postMessage( iframe_height, 'http://bootsnipp.com');
        });
    </script>
<body>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<%
if((MemberBean)session.getAttribute("Member")==null || !loginManager.isLogin(session.getId())){
	%><jsp:forward page="../index.jsp"></jsp:forward><%
}
%>
<div class="nav-side-menu">
    <div class="brand">T S C</div>
    	<div class="text-center" style="font-size: 15px">
    		<br><br>
    		<strong><%=bean.getName()%>님 환영합니다.</strong>
    		<br><br>
    		<strong>현재 접속자 수 : <%=loginManager.getUserCount() %>명</strong>
    		<br><br>
    		<div>
    			<input class="btn btn-info" type="button" value="정보변경" onclick="location.href='<%=application.getContextPath()%>/MemberAlterView.mem'">
    			<input class="btn btn-info" type="button" value="로그아웃" onclick="location.href='<%=application.getContextPath()%>/MemberLogoutAction.mem'">
    		</div>
    		<br><br>
    	</div>
    	<i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>
       	<div class="menu-list">
            <ul id="menu-content" class="menu-content collapse out">
               <li class="active">
                  <a href="<%=application.getContextPath()%>/TscMainView.tsc">
                  	<i class="fa fa-dashboard fa-lg"></i> 메인페이지
                  </a>
               </li>
               <li  data-toggle="collapse" data-target="#products" class="collapsed">
                  <a href="#"><i class="fa fa-gift fa-lg"></i> 발송하기 <span class="arrow"></span></a>
               </li>
               <ul class="sub-menu collapse" id="products">
                   <li><a href="<%=application.getContextPath()%>/SmsSendView.sms">S M S 발송</a></li>
                   <li><a href="<%=application.getContextPath()%>/PushSendView.push">PUSH 발송</a></li>
               </ul>
                
               <li data-toggle="collapse" data-target="#service" class="collapsed">
                  <a href="#"><i class="fa fa-globe fa-lg"></i> 발송레포트<span class="arrow"></span></a>
               </li>  
               <ul class="sub-menu collapse" id="service">
                  <li><a href="<%=application.getContextPath()%>/SmsReportView.sms">S M S 레포트</a></li>
                  <li><a href="<%=application.getContextPath()%>/PushReportView.push">PUSH 레포트</a></li>
               </ul>
           </ul>
     </div>
</div>
<!-- 페이지 본문 내용 -->
<div id="page-wrapper">
    <div class="row">
    	<div class="col-xs-0 col-sm-5 col-md-3"></div>
        <div class="col-xs-12 col-sm-7 col-md-7">
            <h1 class="page-header">방문해주신 여러분 환영합니다.</h1>
        </div>
    </div>
  	<div id="row">
        <div class="col-xs-0 col-sm-5 col-md-3"></div>
        <div class="col-xs-12 col-sm-7 col-md-7">
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
