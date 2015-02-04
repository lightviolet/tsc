<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.sms.db.*" %>
<%@ page import="net.member.db.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	ArrayList<SmsSendInfoBean> sendList = new ArrayList<SmsSendInfoBean>();
	sendList = (ArrayList<SmsSendInfoBean>)request.getAttribute("sendList");
	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
	
	MemberBean bean = new MemberBean();
	bean = (MemberBean)session.getAttribute("Member");
	
	LoginManager loginManager = LoginManager.getInstance();
	
	int pageno = (Integer)request.getAttribute("pageNo");
	if(pageno<1){//현재 페이지
		pageno = 1;
	}
	int total_record = (Integer)session.getAttribute("totalSendCount");		   //총 레코드 수
	int page_per_record_cnt = 5;  //페이지 당 레코드 수
	int group_per_page_cnt =3;     //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5]
//					  									  [6],[7],[8],[9],[10]											
	int record_end_no = pageno*page_per_record_cnt;				
	int record_start_no = record_end_no-(page_per_record_cnt-1);
	if(record_end_no>total_record){
		record_end_no = total_record;
	}
										  									   
	int total_page = total_record / page_per_record_cnt + (total_record % page_per_record_cnt>0 ? 1 : 0);
	if(pageno>total_page){
		pageno = total_page;
	}
// 	현재 페이지(정수) / 한페이지 당 보여줄 페지 번호 수(정수) + (그룹 번호는 현제 페이지(정수) % 한페이지 당 보여줄 페지 번호 수(정수)>0 ? 1 : 0)
	int group_no = pageno/group_per_page_cnt+( pageno%group_per_page_cnt>0 ? 1:0);
//		현재 그룹번호 = 현재페이지 / 페이지당 보여줄 번호수 (현재 페이지 % 페이지당 보여줄 번호 수 >0 ? 1:0)	
//	ex) 	14		=	13(몫)		=	 (66 / 5)		1	(1(나머지) =66 % 5)			  
	
	int page_eno = group_no*group_per_page_cnt;		
//		현재 그룹 끝 번호 = 현재 그룹번호 * 페이지당 보여줄 번호 
//	ex) 	70		=	14	*	5
	int page_sno = page_eno-(group_per_page_cnt-1);	
// 		현재 그룹 시작 번호 = 현재 그룹 끝 번호 - (페이지당 보여줄 번호 수 -1)
//	ex) 	66	=	70 - 	4 (5 -1)
	if(page_eno>total_page){
//	   현재 그룹 끝 번호가 전체페이지 수 보다 클 경우		
		page_eno=total_page;
//	   현재 그룹 끝 번호와 = 전체페이지 수를 같게
	}
	
	int prev_pageno = page_sno-group_per_page_cnt;  // <<  *[이전]* [21],[22],[23]... [30] [다음]  >>
//		이전 페이지 번호	= 현재 그룹 시작 번호 - 페이지당 보여줄 번호수	
//	ex)		46		=	51 - 5				
	int next_pageno = page_sno+group_per_page_cnt;	// <<  [이전] [21],[22],[23]... [30] *[다음]*  >>
//		다음 페이지 번호 = 현재 그룹 시작 번호 + 페이지당 보여줄 번호수
//	ex)		56		=	51 - 5
	if(prev_pageno<1){
//		이전 페이지 번호가 1보다 작을 경우		
		prev_pageno=1;
//		이전 페이지를 1로
	}
	if(next_pageno>total_page){
//		다음 페이지보다 전체페이지 수보가 클경우		
		next_pageno=total_page/group_per_page_cnt*group_per_page_cnt+1;
//		next_pageno=total_page
//		다음 페이지 = 전체페이지수 / 페이지당 보여줄 번호수 * 페이지당 보여줄 번호수 + 1 
//	ex)			   = 	76 / 5 * 5 + 1	???????? 		
	}
	if(total_record==0){
		page_eno = 1;
		page_sno = 1;
	}
	
	// [1][2][3].[10]
	// [11][12]
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
<!-- Custom CSS -->
<link href="<%=application.getContextPath() %>/bootstrap/dist/css/sb-admin-2.css" rel="stylesheet">
<!-- Morris Charts CSS -->
<link href="<%=application.getContextPath() %>/bootstrap/bower_components/morrisjs/morris.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="<%=application.getContextPath() %>/bootstrap/bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
if((MemberBean)session.getAttribute("Member")==null  || !loginManager.isLogin(session.getId())){
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
                <a class="navbar-brand" href="<%=application.getContextPath() %>/SmsMainView.sms">SMS 발송센터</a>
            </div>
			<!-- 상단 드랍다운 네비게이션 -->
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
                        <li>
                            <a href="<%=application.getContextPath() %>/TscMainView.tsc"><i class="fa fa-dashboard fa-fw"></i>메인페이지</a>
                        </li>
                        <li>
                            <a href="<%=application.getContextPath() %>/SmsSendView.sms"><i class="fa fa-table fa-fw"></i>발송하기</a>
                        </li>
                        <li style="background: #eee;">
                            <a href="<%=application.getContextPath() %>/SmsReportView.sms"><i class="fa fa-bar-chart-o fa-fw"></i>발송레포트</a>
                        </li> 
                    </ul>
                </div>
            </div>
        </nav>
		<!-- 페이지 내용 부분 -->
        <div id="page-wrapper">
        	<!-- 페이지 제목 -->
            <div class="row">
                <div class="col-lg-9">
                    <h1 class="page-header">SMS Report</h1>
                </div>
            </div>
            <!-- 발송별 정보 부분 -->
            <div class="row">
                <div class="col-lg-9">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	발송별 정보 (발송에 관한 업데이트는 최대 5분정도 소요될 수 있습니다.)
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                            	<!-- 보낸정보의 리스트 -->
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center;width:13%">보낸시간</th>
                                            <th style="text-align: center;width:13%">발송번호</th>
                                            <th style="text-align: center;width:34%">메세지내용</th>
                                            <th style="text-align: center;width:13%">총건수</th>
                                            <th style="text-align: center;width:15%">성공/실패</th>
                                            <th style="text-align: center;width:12%">상세정보</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%if(sendList.size()!=0){for(int i=0; i<sendList.size(); i++){ %>
                                        <tr style="text-align: center">
                                            <td><%=sdf.format(sendList.get(i).getSendDate()) %></td>
                                            <td><%=sendList.get(i).getFromNumber() %></td>
                                            <td style='word-break:break-all'><%=sendList.get(i).getMessage() %></td>
                                            <td><%=sendList.get(i).getSendTotal() %></td>
                                            <%if(sendList.get(i).getSendTotal()==(sendList.get(i).getSendSuccess()+sendList.get(i).getSendFailure())){%>
                                            <td><%=sendList.get(i).getSendSuccess() %>/<%=sendList.get(i).getSendFailure() %></td><%}else{ %>
                                            <td id=<%=sendList.get(i).getEtc() %>>정보갱신중</td><%} %>
                                            <td><input class="btn btn-success" type="button" value="보기" onclick="location.href='<%=application.getContextPath()%>/SmsDetailView.sms?etc=<%=sendList.get(i).getEtc()%>'"></td>
                                        </tr>
                                        <%}}%>
                                    </tbody>
                                </table>
                                <!-- 페이징 처리 부분 -->
                                <div class="text-center">
                   					<div class="pagination">
   										<%-- <li><a href="<%=application.getContextPath() %>/SmsReportAction.sms?pageno=1">앞</a></li> --%>
   										<li><a href="<%=application.getContextPath() %>/SmsReportAction.sms?pageno=<%=prev_pageno%>">이전</a></li>
   										<%for(int i =page_sno;i<=page_eno;i++){%>
										<li><a href="<%=application.getContextPath() %>/SmsReportAction.sms?pageno=<%=i %>">
											<%if(pageno == i){ %>
												[<%=i %>]
											<%}else{ %>
												<%=i %>
											<%} %></a></li>
										<%} %>
   										<li><a href="<%=application.getContextPath() %>/SmsReportAction.sms?pageno=<%=next_pageno%>" >다음</a></li>
   										<%-- <li><a href="<%=application.getContextPath() %>/SmsReportAction.sms?pageno=<%=total_page %>">뒤</a></li> --%>
									</div>
								</div>
                            </div>         
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
</body>
</html>
