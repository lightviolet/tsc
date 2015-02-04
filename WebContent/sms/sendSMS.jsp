<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.member.db.*" %>
<%
	MemberBean bean = new MemberBean();
	bean = (MemberBean)session.getAttribute("Member");
	
	LoginManager loginManager = LoginManager.getInstance();
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
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//번호추가
	$('#numberAdd').click(function(){
		var to_number = $('#to_number').val();		
		var reg_phoneNumber=/^[0-9]*$/;
		if(to_number.search(reg_phoneNumber) == -1 || to_number.length < 10 || to_number.length > 11){
			alert("핸드폰번호형식을 확인해보세요");
			return;
		}
		for(var i=0; i<$('#numberList option').size(); i++){
			if($("#numberList option:eq("+i+")").val() == to_number){
				alert("핸드폰번호가 중복되었습니다.");
				return;
			}
		}
		$('#numberList').append("<option value="+to_number+">"+to_number+"</option>");
		$('#to_number').val("");
	});
	//영역선택후 지우기
	$('#selectDel').click(function(){
		var numberList = document.getElementById("numberList");
		// 선택부분만 
		var isSelected = [];
		for (var i = 0; i < numberList.options.length; ++i)
		{
			isSelected[i] = numberList.options[i].selected;
		}
		// 뒷부분부터 선택부분 지우기
		i = numberList.options.length;
		while (i--)
		{
		    if (isSelected[i])
		    {
		    	numberList.remove(i);
		    }
		}
	});
	//번호리셋
	$('#numberReset').click(function(){
		$('#numberList option').remove();
	});
	//텍스트파일등록
	$('#txtFileReg').click(function(){
		var popUrl = "<%=application.getContextPath()%>/SmsTxtFileRegView.sms";   //팝업창에 출력될 페이지 URL
		var popOption = "width=290, height=220, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(option)
		   window.open(popUrl,"",popOption);
		
	});
	//csv파일등록
	$('#csvFileReg').click(function(){
		var popUrl = "<%=application.getContextPath()%>/SmsCsvFileRegView.sms";   //팝업창에 출력될 페이지 URL
		var popOption = "width=290, height=220, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(option)
		   window.open(popUrl,"",popOption);
		
	});
	//엑셀파일등록
	$('#excelFileReg').click(function(){
		var popUrl = "<%=application.getContextPath()%>/SmsExcelFileRegView.sms";   //팝업창에 출력될 페이지 URL
		var popOption = "width=290, height=220, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(option)
		   window.open(popUrl,"",popOption);
		
	});
	//메시지리셋
	$('#msgReset').click(function(){
		$('#message').val("");
		$('#viewByte').text("0 / 90byte");
	});
	//메시지발송
	$('#smsSend').click(function(){
		if($('#message').val() == ""){
			alert("메세지를 작성해주세요");
			$('#message').focus();
			return;
		}
		var reg_phoneNumber=/^[0-9]*$/;
		var from_number = document.getElementById("from_number").value;
		if($('#from_number').val()== "" || from_number.search(reg_phoneNumber) == -1){
			alert("보내는 사람의 번호가 잘못되었습니다");
			$('#from_number').focus();
			return;
		}
		if($('#numberList option').size()==0){
			alert("받는 사람의 정보가 없습니다.");
			return;
		}
		for(var i=0; i<$('#numberList option').size(); i++){
			if($('#list').val() == ""){
				$('#list').val($('#numberList option:eq('+i+')').val());	
			}else{
				$('#list').val($('#list').val()+"/"+$('#numberList option:eq('+i+')').val());
			}
		}
		$('#smsSend').attr("disabled", true);
		fm.submit();
	});
});
var clearChk=true;
var limitByte = 90;
//메시지 바이트계산
function cal_byte(msg){
	var message = $('#message').val();
	if (message == null ) return 0;
	
	var totalByte = 0;

    for(var i =0; i < message.length; i++) {
        var currentByte = message.charCodeAt(i);
        if(currentByte > 128){
            	totalByte += 2;
        }
        else {
			totalByte++;
		}
        if(totalByte>limitByte){
        	alert( limitByte+"바이트까지 전송가능합니다.");
            $('#message').val(message.substring(0,i));
            return ;
        }
	}

	$('#viewByte').text(totalByte+" / 90byte");
}
//대화상자에서 사용할 펑션
function addOption(text, value){
	var obj = document.getElementById("numberList"); 
	for(var i=0; i<$('#numberList option').size(); i++){
		if($("#numberList option:eq("+i+")").val() == value){
			alert("핸드폰번호가 중복되었습니다.");
			return;
		}
	}
	obj[obj.length] = new Option(text, value); 
}
</script>
</head>
<body>
<%
if((MemberBean)session.getAttribute("Member")==null || !loginManager.isLogin(session.getId())){
	%><jsp:forward page="../index.jsp"></jsp:forward><%
}
%>
<form name="fm" action="<%=application.getContextPath() %>/SmsSendAction.sms" method="post">
<input type="hidden" id="list" name="list" value="">
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
                        <li style="background: #eee;">
                            <a href="<%=application.getContextPath() %>/SmsSendView.sms"><i class="fa fa-table fa-fw"></i>발송하기</a>
                        </li>
                        <li>
                            <a href="<%=application.getContextPath() %>/SmsReportView.sms"><i class="fa fa-bar-chart-o fa-fw"></i>발송레포트</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
		<!-- 페이지 내용부분 -->
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">SMS 발송</h1>
                </div>
            </div>
            <!-- 받는사람의 번호 등록부분 -->
            <div class="row">
            	<div class="col-lg-3" style="width:300px">
                    <div class="panel panel-default" >
                        <div class="panel-heading">
                        	<em>받는 사람 : <input type="text" id="to_number"name="to_number" value="" size="12" placeholder="-을 빼고 입력"/></em>
                        	<input type="button" id="numberAdd" value="추가">
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <div>
                            <select name="numberList" id="numberList"  style="width: 100%; height: 100%" size="13" multiple="multiple">
                            
                            </select>
                        </div>
                        <div style="text-align: center">
                        	<input type="button" id="selectDel" value="선택번호삭제">
                            <input type="button" id="numberReset" value="번호목록리셋">
                        </div>
                        </div>
                        <div class="panel-footer">
  	                      	<input type="button" id="txtFileReg" value="txt등록"style="width:32%;">
  	                      	<input type="button" id="csvFileReg" value="csv등록"style="width:32%;">
  	                      	<input type="button" id="excelFileReg" value="excel등록"style="width:32%;">
                        </div>
                    </div>
                </div>
                <!-- 보내는사람의 번호와 메세지등록 부분 -->
                <div class="col-lg-3" style="width:300px;">
                    <div class="panel panel-default">
                    	<div class="panel-heading">
							<em>보내는 사람 : <input type="text" id="from_number" name="from_number" value="<%=bean.getPhonenumber() %>" size="12"/></em>
						</div>
						<div class="panel-body">
							<textarea name="message" id="message" style="width: 100%;" rows="15" onchange="cal_byte(this);" onkeyup="cal_byte(this);"></textarea>
							<br><span id="viewByte">0 / 90byte</span>
						</div>
						<div class="panel-footer">
							<input type="button" id="msgReset" value="메 세 지 리 셋" style="width:49%;">
							<input type="button" id="smsSend" value="메세지전송하기" style="width:49%;">
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
    <script src="<%=application.getContextPath() %>/bootstrap/js/morris-data.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="<%=application.getContextPath() %>/bootstrap/dist/js/sb-admin-2.js"></script>
</form>
</body>
</html>
