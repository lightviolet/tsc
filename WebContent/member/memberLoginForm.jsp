<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="net.common.constants.*"%>
<%@ page import="net.member.db.*"%>
<%
	//쿠키있으면 값받고 없으면 안받기
	String cookieId=null;
	Cookie[] cookies = request.getCookies();
	for(int i = 0 ; i<cookies.length; i++){ 
		if(cookies[i].getName().equals("cookieId")){
		cookieId=cookies[i].getValue();
		}
	}
	//로그인행위에 대한 정보
	int msg;
	if(request.getAttribute("msg")==null){
		msg=0;
	}else{
		msg=(Integer)request.getAttribute("msg");
	}
	String msgString = null;

	LoginManager loginManager = LoginManager.getInstance();

	if (loginManager.isLogin(session.getId())) //세션 아이디가 로그인 중이면
	{
		System.out.println("로그인중입니다.");
%><jsp:forward page="../TscMainView.tsc"></jsp:forward>
<%
	}
	if (msg != 0) {
		switch (msg) {
			case MemberLoginCheck.ID_NOT_FOUND :
				msgString = "아이디를 찾을 수 없음";
				break;
			case MemberLoginCheck.PASSWORD_MISMATCH :
				msgString = "비밀번호가 일치하지 않음";
				break;
			case MemberLoginCheck.ALREADY_LOGIN:
				msgString = "3";
				break;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap Core CSS -->
<link href="<%=application.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<title>TSC 로그인창</title>
<script src="<%=application.getContextPath()%>/js/functions.js"></script>
<!-- jQuery -->
<script src="<%=application.getContextPath()%>/jquery/jquery-1.10.1.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="<%=application.getContextPath()%>/bootstrap/css/bootstrap.min.js"></script>
<script>
	$(document).ready(function(){
		$('#btnLogin').click(formCheck);//폼체크 후 Submit
		$('#btnJoin').click(function(){//회원가입폼으로
			location.href = "<%=application.getContextPath()%>/MemberJoinView.mem";
		});
		$("#password").keydown(function (key) {
            if (key.keyCode == 13) {
                formCheck();
            }
        });
		
<%if (msgString != null) {//로그인상태확인 alert
	if(msgString.equals("3")){%>
		if(confirm("로그아웃시키겟습니까?")){
			location.href="<%=application.getContextPath()%>/member/memberLogout.jsp?id=<%=(String)request.getAttribute("useID")%>";
		}
	<%}else{%>
		alert('<%=msgString%>');
	<%}%>
<%}%>
	});
</script>
</head>
<body class="text-center">
<!-- 로그인폼 -->
<form class="form-horizontal" action="<%=application.getContextPath()%>/MemberLoginAction.mem"role="form" id="loginForm" name="loginForm" method="post">
	<div class="container" style="padding-top: 50px">
	    <label for="inputid" class="col-lg-4 control-label"></label>
	    <div class="col-lg-3" >
	      	<h1 align="center">T S C</h1>
	    </div>
	</div>
	<div class="container">
	    <label for="inputid" class="col-lg-4 control-label" ></label>
	    <div class="container col-lg-3">
	      	<input type="text" class="form-control" id="id" name="id" placeholder="아이디" value="<%if (cookieId == null) {%><%=""%><%} else {%><%=cookieId%><%}%>" tabindex="1">
	      	<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" tabindex="2">
	    </div>
	</div>
	<div class="container">
	    <div class="container col-lg-offset-4 col-lg-3">
		    <div style="text-align: left;">
		    	<input type="checkbox" name="save_id" value="save"
				<%if (cookieId != null) {%> checked="checked" <%}%> style="height:20px;width:20px;" /><label>아이디 저장</label>
			</div>
	    </div>
	</div>
    <div class="container">
	    <div class="container col-lg-offset-4 col-lg-3">
		    <div>
		      	<input type="button" class="btn btn-info btn-lg btn-block" id="btnLogin" value="로그인">
		      	<input type="button" class="btn btn-danger btn-lg btn-block" id="btnJoin" value="회원가입">
		    </div>
	    </div>
	</div>
</form>
</body>
</html>