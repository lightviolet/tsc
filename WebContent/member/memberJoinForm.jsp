<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.member.db.*" %>
<%
LoginManager loginManager = LoginManager.getInstance();
if (loginManager.isLogin(session.getId())) //세션 아이디가 로그인 중이면
{
	System.out.println("로그인중입니다.");
	%><jsp:forward page="../TSC/main.jsp"></jsp:forward><%
}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap Core CSS -->
<link href="<%=application.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<title>TSC 회원가입</title>
<script src="<%=application.getContextPath()%>/js/functions.js"></script>
<!-- jQuery -->
<script src="<%=application.getContextPath()%>/jquery/jquery-1.10.1.min.js"></script>
<script src="<%=application.getContextPath()%>/jquery/jquery.validate.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="<%=application.getContextPath()%>/bootstrap/css/bootstrap.min.js"></script>
<style type="text/css">
input.error, textarea.error{
  border:1px dashed red;
}
label.error{
  display:block;
  color:red;
}
</style>
<script type="text/javascript">

$(document).ready(function(){
	//아이디 중복체크
	<%-- $('#btnDupId').click(function(){
		var reg_id = /^[A-Za-z0-9+]*$/;

		if(($('#id').val()).search(reg_id) == -1 || $('#id').val()==""){
			alert("아이디형식을 확인해주세요");
			return;
		}
		$.ajax({
			type: "POST",
			url: "<%=application.getContextPath()%>/member/dupIdCheck.jsp",
			dataType: "json",
			data: {"id": $('#id').val()},
			success: function (check) {
				if(check){
					alert('중복되었습니다.');
				}else{
					alert('사용가능한 아이디입니다.');
				}
			},
			failure: function () {
				alert('Fail');
			}
		})
	}); --%>
	//SMS인증번호 발송
	$('#btnSendNumber').click(function(){
		
		var reg_phoneNumber=/^[0-9]*$/;
		if(($('#phoneNumber').val()).search(reg_phoneNumber) == -1 || ($('#phoneNumber').val()).length < 10){
			alert("핸드폰번호형식을 확인해보세요");
			return;
		}
		alert("ㅎㅇ");
		$.ajax({
			type: "POST",
			url: "<%=application.getContextPath()%>/member/sendConfirmNumber.jsp",
			dataType: 'json',
			data: {"phoneNumber": $('#phoneNumber').val()},
			success: function (check){
				alert("인증번호발송");
			},
			failure: function () {
				alert('Fail');
			}
		});
	});
	//입력번호와 인증번호 확인
	$('#btnConfirmNumber').click(function(){
		$.ajax({
			type: "POST",
			url: "<%=application.getContextPath()%>/member/confirmNumber.jsp",
			dataType: "json",
			data: {"confirmNumber": $('#confirmNumber').val()},
			success:  function (check) {
				if(check){
					alert('인증번호가 일치합니다.');
					$('#btnJoin').removeAttr('disabled');
				}else{
					alert('인증번호가 일치하지않습니다.');
					$('#btnJoin').attr("disabled","disabled");
				}
			},
			failure: function () {
				alert('Fail');
			}
		});
	});
	//폼체크/유효성체크 후 회원가입
	$('#btnJoin').click(function(){
			
			var f = document.forms[0];
			var length = f.length;

			for (var i = 0; i < length; i++)
			{
				if (f[i].value == null || f[i].value == "")
				{
					alert(f[i].title + " 를(을) 입력해 주세요");
					f[i].focus();
					return false;
				}
			}
			var dup;
			var reg_id = /^[A-Za-z0-9+]*$/;
			var reg_email=/^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/;
			var reg_phoneNumber=/^[0-9]*$/;
			$.ajax({
				type: "POST",
				url: "<%=application.getContextPath()%>/member/dupIdCheck.jsp",
				dataType: "json",
				data: {"id": $('#id').val()},
				success: function (check) {
					if(check){
						dup=check;
					}
				},
				failure: function () {
					alert('Fail');
				}
			})
			if(dup){
				alert("아이디가 중복되었습니다");
				return false;
			}
			// 인자 email_address를 정규식 format 으로 검색
			if($('#id').val().search(reg_id) == -1){
				alert("아이디형식을 확인해주세요.");
				document.getElementById("id").focus();
				return false;
			}
			if($('#password').val().length<6){
				alert("패스워드길이가 6자 미만입니다.");
				document.getElementById("password").focus();
				return false;
			}
			if($('#password').val() != $('#password_re').val()){
				alert("패스워드가 같지 않습니다.");
				document.getElementById("password").focus();
				return false;
			}
			if ($('#email').val().search(reg_email) == -1){
			   alert("이메일형식을 확인해주세요.");
			   document.getElementById("email").focus();
			   return false;
			}
			if($('#phoneNumber').val().search(reg_phoneNumber) == -1 || $('#phoneNumber').val().length < 10){
				alert("핸드폰번호형식을 확인해보세요");
				document.getElementById("phoneNumber").focus();
				return false;
			}
			fm.submit();
	});
	//회원가입취소
	$('#btnCancel').click(function(){
		location.href = "<%=application.getContextPath()%>/MemberLoginView.mem";
	});
});
$(function() {
	$("#fm").validate({
		rules : {
			id : {
				alnum : true,
				required : true,
				maxlength : 10,
			},
			password : {
				required : true,
				minlength : 6,
				maxlength : 12
			},
			password_re : {
				required : true,
				minlength : 6,
				maxlength : 12,
				equalTo : "#password"
			},
			name : "required",
			email : {
				required : true,
				email : true
			},
			phoneNumber : {
				required : true,
				num : true,
				minlength : 10,
				maxlength : 11
			},
			confirmNumber : {
				required : true
			}
		},
		//error 메세지 정의
		messages : {
			id : {
				alnum : "영문자/숫자만 가능합니다.",
				required : "아이디를 입력하세요.",
				maxlength : "아이디는 10자리까지 가능합니다."
			},
			password : {
				required : "암호를 입력하세요.",
				minlength : "암호는 최소 6자리입니다.",
				maxlength : "암호는 10자리까지 가능합니다."
			},
			password_re : {
				required : "암호를 한 번 더 입력하세요.",
				minlength : "암호는 최소 6자리입니다.",
				maxlength : "암호는 10자리까지 가능합니다.",
				equalTo : "암호가 일치하지 않습니다."
			},
			name : "이름을 입력하세요.",
			email : "형식에 맞는 이메일을 입력하세요.",
			phoneNumber : {
				required : "핸드폰 번호를 입력하세요.(-제외 10~11자)",
				num : "숫자만 입력하세요"
			},
			confirmNumber : "인증번호를 입력하세요"
		}
	});
});
</script>
</head>
<body>
<!-- 회원가입 폼 -->
<form id="fm"  name="joinForm" class="form-horizontal" action="<%=application.getContextPath()%>/MemberJoinAction.mem"role="form"method="post">
	<div class="container" style="padding-top: 50px">
	    <label for="inputid" class="col-lg-4 control-label"></label>
	    <div class="col-lg-3" >
	      	<h1 align="center">회원가입</h1>
	    </div>
	</div>
	<div class="container">
	    <label for="inputid" class="col-lg-4 control-label" ></label>
	    <div class="col-lg-3">
	      	<input type="text" class="form-control" id="id" name="id" placeholder="아이디" tabindex="1">
	    </div>
	</div>
	<div class="container">
	    <label for="inputid" class="col-lg-4 control-label" ></label>
	    <div class="container col-lg-3">
	      	<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" tabindex="2">
	    </div>
	</div>
	<div class="container">
	    <label for="inputid" class="col-lg-4 control-label" ></label>
	    <div class="container col-lg-3">
	      	<input type="password" class="form-control" id="password_re" name="password_re" placeholder="비밀번호재입력" tabindex="23">
	    </div>
	</div>
	<div class="container">
	    <label for="inputid" class="col-lg-4 control-label" ></label>
	    <div class="container col-lg-3">
	      	<input type="text" class="form-control" id="name" name="name" placeholder="이름" tabindex="4">
	    </div>
	</div>
	<div class="container">
	    <label for="inputid" class="col-lg-4 control-label" ></label>
	    <div class="container col-lg-3">
	      	<input type="email" class="form-control" id="email" name="email" placeholder="이메일" tabindex="5">
	    </div>
	</div>
	<div class="container">
	    <label for="inputid" class="col-lg-4 control-label"></label>
		<div class="col-lg-2"> 
	   		<input type="number" class="form-control" id="phoneNumber" name="phoneNumber" size="11" placeholder="핸드폰번호" tabindex="6">
		</div>
		<div class="col-lg-1" >
			<input type="button" class="btn btn-default btn-block" id="btnSendNumber" value="인증">
		</div>
	</div>
	<div class="container">
		<label for="inputid" class="col-lg-4 control-label"></label>
		<div class="col-lg-2"> 
	      	<input type="number" class="form-control" id="confirmNumber" name="confirmNumber" placeholder="인증번호" tabindex="7">
	    </div>
		<div class="col-lg-1" >
	       <input type="button" class="btn btn-default btn-block" id="btnConfirmNumber"value="확인">
	    </div>
	</div>
    <div class="container">
	    <div class="container col-lg-offset-4 col-lg-3">
		    <div>
		      	<input type="button" class="btn btn-info btn-lg btn-block" id="btnJoin" value="가입완료" disabled>
		      	<input type="button" class="btn btn-danger btn-lg btn-block" id="btnCancel" value="가입취소">
		    </div>
	    </div>
	</div>
</form>
</body>
</html>