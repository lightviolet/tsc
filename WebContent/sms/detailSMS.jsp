<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.sms.db.*" %>
<%@ page import="net.member.db.*" %>
<%@ page import="java.util.*" %>
<%
	MemberBean bean = new MemberBean();
	bean = (MemberBean)session.getAttribute("Member");

	LoginManager loginManager = LoginManager.getInstance();
	
	ArrayList<SmsReportInfoBean> reportInfoList = new ArrayList<SmsReportInfoBean>();
	reportInfoList = (ArrayList<SmsReportInfoBean>)request.getAttribute("reportInfoList");
	//Error코드 등록된 맵불러오기
	HashMap<String,String> errorCodeMap = new HashMap<String,String>();
	SmsErrorCodeMap map =new SmsErrorCodeMap();
	map.setErrorCodeMap();
	errorCodeMap = map.getErrorCodeMap();
	
	double reportFail = (Integer)session.getAttribute("totalFailCount");
	double reportSuccess = (Integer)session.getAttribute("totalSuccessCount");
	double reportTotal =reportFail+reportSuccess;
	//현재 페이지
	int pageno = (Integer)request.getAttribute("pageNo");
	if(pageno<1){
		pageno = 1;
	}
	int total_record = (Integer)session.getAttribute("totalTotalCount");//총 레코드 수
	int page_per_record_cnt = 4;  //페이지 당 레코드 수
	int group_per_page_cnt =5;    //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5]
  					  			  //               [6],[7],[8],[9],[10]											
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>T S C(Total Send Center)</title>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="<%=application.getContextPath() %>/css/template.css" rel="stylesheet">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script src="<%=application.getContextPath() %>/jquery/jquery-1.10.1.min.js"></script>
<script src="<%=application.getContextPath() %>/bootstrap/js/bootstrap.min.js"></script>
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
if((MemberBean)session.getAttribute("Member")==null){
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
               <li>
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
                
               <li data-toggle="collapse" data-target="#service" class="collapsed active">
                  <a href="#"><i class="fa fa-globe fa-lg"></i> 발송레포트<span class="arrow"></span></a>
               </li>  
               <ul class="sub-menu collapse" id="service">
                  <li class="active"><a href="<%=application.getContextPath()%>/SmsReportView.sms">S M S 레포트</a></li>
                  <li><a href="<%=application.getContextPath()%>/PushReportView.push">PUSH 레포트</a></li>
               </ul>
           </ul>
     </div>
</div>
		<!-- 페이지 내용부분 -->
        <div id="page-wrapper">
            <div>
                <div class="col-xs-1 col-sm-5 col-md-3"></div>
        		<div class="col-xs-11 col-sm-7 col-md-7">
                    <h1 class="page-header">SMS Report</h1>
                </div>
            </div>
            <!-- 발송 대비 성공률 차트 -->
            <div>
                <div class="col-xs-1 col-sm-5 col-md-3"></div>
        		<div class="col-xs-11 col-sm-7 col-md-7">
                    <div class="panel panel-default">	
                        <div class="panel-heading">
              				<span style="padding-right:100px">발송 대비 성공률</span>
              				<input class="btn btn-primary" type="button" value="뒤로가기" onclick="javascript:history.back()">
           				</div>
                        <div class="panel-body" style="margin: 0 auto; text-align: center;">
                            <div id="smsTotalChart" style="padding-left:25px; pading-right:25px;float:left;width:250px;"></div>
                            <div id="smsPercentChart" style="padding-left:25px; pading-right:25px;float:left;width:250px;"></div>
                        </div>
                    </div>
                </div>
            </div>
			<!-- 해당 발송 정보 리스트 -->
            <div>
                <div class="col-xs-1 col-sm-5 col-md-3"></div>
        		<div class="col-xs-11 col-sm-7 col-md-7">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                                                                       해당 발송 정보(성공여부가 계속 발송진행중으로 뜬다면 고객센터 : 010-5523-3629로 연락바랍니다.)
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center;width:20%;">받는번호</th>
                                            <th style="text-align: center;width:30%;">보낸시간</th>
                                            <th style="text-align: center;width:30%;">받은시간</th>
                                            <th style="text-align: center;width:20%;">성공여부</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%if(reportInfoList.size()!=0){
                                    	for(int i=0; i<reportInfoList.size(); i++){ %>
                                        <tr>
                                            <td style="text-align: center;"><%=reportInfoList.get(i).getToNumber() %></td>
                                            <td style="text-align: center;"><%if(reportInfoList.get(i).getSentDate()!=null){%><%=reportInfoList.get(i).getSentDate() %><%} %></td>
                                            <td style="text-align: center;"><%if(reportInfoList.get(i).getReceiveDate()!=null){%><%=reportInfoList.get(i).getReceiveDate() %><%} %></td>
                                           <% if(reportInfoList.get(i).getResultCode() == null){
                                        	   %><td style="text-align: center;">발송진행중</td><%
                                        	   continue;
                                        }else{
                                        	%><td style="text-align: center;"><%=errorCodeMap.get(reportInfoList.get(i).getResultCode()) %></td>
                                        </tr>
                                   		<%}
                                	}}
                                    %>
                                    </tbody>
                                </table>
                                <!-- 페이지처리부분 -->
                            	<div class="text-center">
                    				<div class="pagination">
   										<%-- <li><a href="<%=application.getContextPath() %>/SmsDetailAction.sms?pageno=1">맨앞</a></li> --%>
 									    <li><a href="<%=application.getContextPath() %>/SmsDetailAction.sms?pageno=<%=prev_pageno%>">이전</a></li>
  										 <%for(int i =page_sno;i<=page_eno;i++){%>
										<li><a href="<%=application.getContextPath() %>/SmsDetailAction.sms?pageno=<%=i %>">
											<%if(pageno == i){ %>
												[<%=i %>]
											<%}else{ %>
												<%=i %>
											<%} %>
										</a></li>
										<%} %>
   										<li><a href="<%=application.getContextPath() %>/SmsDetailAction.sms?pageno=<%=next_pageno%>" >다음</a></li>
  										<%-- <li><a href="<%=application.getContextPath() %>/SmsDetailAction.sms?pageno=<%=total_page %>">맨뒤</a></li> --%>
									</div>
								</div>
                            </div>
                        </div>
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
	    {label: "Success(건수)", value: <%=reportSuccess%>},
	    {label: "Failure(건수)", value: <%=reportFail%>},],
		colors: [
         '#0BA462',
         '#39B580',
       ],
});
Morris.Donut({
	    element: 'smsPercentChart',
		  data: [
		    {label: "Success(%)", value:<%=Math.round(reportSuccess * 100/reportTotal)%>},
		    {label: "Failure(%)", value:<%=Math.round(reportFail* 100/reportTotal)%>},],
		    colors: [
		             '#0BA462',
		             '#39B580',
		           ],
		  formatter: function (x) { return x + "%"}
});
</script>
