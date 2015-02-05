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
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Responsive Navigation Menu - Bootsnipp.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <style type="text/css">
    .nav-side-menu {
  overflow: auto;
  font-family: verdana;
  font-size: 12px;
  font-weight: 200;
  background-color: #2e353d;
  position: fixed;
  top: 0px;
  width: 300px;
  height: 100%;
  color: #e1ffff;
}
.nav-side-menu .brand {
  background-color: #23282e;
  line-height: 50px;
  display: block;
  text-align: center;
  font-size: 14px;
}
.nav-side-menu .toggle-btn {
  display: none;
}
.nav-side-menu ul,
.nav-side-menu li {
  list-style: none;
  padding: 0px;
  margin: 0px;
  line-height: 35px;
  cursor: pointer;
  /*    
    .collapsed{
       .arrow:before{
                 font-family: FontAwesome;
                 content: "\f053";
                 display: inline-block;
                 padding-left:10px;
                 padding-right: 10px;
                 vertical-align: middle;
                 float:right;
            }
     }
*/
}
.nav-side-menu ul :not(collapsed) .arrow:before,
.nav-side-menu li :not(collapsed) .arrow:before {
  font-family: FontAwesome;
  content: "\f078";
  display: inline-block;
  padding-left: 10px;
  padding-right: 10px;
  vertical-align: middle;
  float: right;
}
.nav-side-menu ul .active,
.nav-side-menu li .active {
  border-left: 3px solid #d19b3d;
  background-color: #4f5b69;
}
.nav-side-menu ul .sub-menu li.active,
.nav-side-menu li .sub-menu li.active {
  color: #d19b3d;
}
.nav-side-menu ul .sub-menu li.active a,
.nav-side-menu li .sub-menu li.active a {
  color: #d19b3d;
}
.nav-side-menu ul .sub-menu li,
.nav-side-menu li .sub-menu li {
  background-color: #181c20;
  border: none;
  line-height: 28px;
  border-bottom: 1px solid #23282e;
  margin-left: 0px;
}
.nav-side-menu ul .sub-menu li:hover,
.nav-side-menu li .sub-menu li:hover {
  background-color: #020203;
}
.nav-side-menu ul .sub-menu li:before,
.nav-side-menu li .sub-menu li:before {
  font-family: FontAwesome;
  content: "\f105";
  display: inline-block;
  padding-left: 10px;
  padding-right: 10px;
  vertical-align: middle;
}
.nav-side-menu li {
  padding-left: 0px;
  border-left: 3px solid #2e353d;
  border-bottom: 1px solid #23282e;
}
.nav-side-menu li a {
  text-decoration: none;
  color: #e1ffff;
}
.nav-side-menu li a i {
  padding-left: 10px;
  width: 20px;
  padding-right: 20px;
}
.nav-side-menu li:hover {
  border-left: 3px solid #d19b3d;
  background-color: #4f5b69;
  -webkit-transition: all 1s ease;
  -moz-transition: all 1s ease;
  -o-transition: all 1s ease;
  -ms-transition: all 1s ease;
  transition: all 1s ease;
}
@media (max-width: 767px) {
  .nav-side-menu {
    position: relative;
    width: 100%;
    margin-bottom: 10px;
  }
  .nav-side-menu .toggle-btn {
    display: block;
    cursor: pointer;
    position: absolute;
    right: 10px;
    top: 10px;
    z-index: 10 !important;
    padding: 3px;
    background-color: #ffffff;
    color: #000;
    width: 40px;
    text-align: center;
  }
  .brand {
    text-align: left !important;
    font-size: 22px;
    padding-left: 20px;
    line-height: 50px !important;
  }
}
@media (min-width: 767px) {
  .nav-side-menu .menu-list .menu-content {
    display: block;
  }
}
body {
  margin: 0px;
  padding: 0px;
}

    </style>
    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
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
</head>
<body>
<%
if((MemberBean)session.getAttribute("Member")==null || !loginManager.isLogin(session.getId())){
	%><jsp:forward page="../index.jsp"></jsp:forward><%
}
%>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<div class="nav-side-menu">
    <div class="brand">Brand Logo</div>
    <i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>
  
        <div class="menu-list">
  
            <ul id="menu-content" class="menu-content collapse out">
                <li>
                  <a href="#">
                  <i class="fa fa-dashboard fa-lg"></i> 메인페이지
                  </a>
                </li>
                <li  data-toggle="collapse" data-target="#products" class="collapsed active">
                  <a href="#"><i class="fa fa-gift fa-lg"></i> 발송하기 <span class="arrow"></span></a>
                </li>
                <ul class="sub-menu collapse" id="products">
                    <li class="active"><a href="#">S M S 발송</a></li>
                    <li><a href="#">PUSH 발송</a></li>
                </ul>
                
                <li data-toggle="collapse" data-target="#service" class="collapsed">
                  <a href="#"><i class="fa fa-globe fa-lg"></i> 발송레포트<span class="arrow"></span></a>
                </li>  
                <ul class="sub-menu collapse" id="service">
                  <li>S M S 레포트</li>
                  <li>PUSH 레포트</li>
                </ul>
            </ul>
     </div>
</div>
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
</body>
</html>
