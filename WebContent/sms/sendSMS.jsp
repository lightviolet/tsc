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
	//파일등록
	$('#FileReg').click(function(){
		var popUrl = "<%=application.getContextPath()%>/SmsFileRegView.sms";   //팝업창에 출력될 페이지 URL
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
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<%
if((MemberBean)session.getAttribute("Member")==null || !loginManager.isLogin(session.getId())){
	%><jsp:forward page="../index.jsp"></jsp:forward><%
}
%>
<form name="fm" action="<%=application.getContextPath() %>/SmsSendAction.sms" method="post">
<input type="hidden" id="list" name="list" value="">
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
               <li  data-toggle="collapse" data-target="#products" class="collapsed active">
                  <a href="#"><i class="fa fa-gift fa-lg"></i> 발송하기 <span class="arrow"></span></a>
               </li>
               <ul class="sub-menu collapse" id="products">
                   <li class="active"><a href="<%=application.getContextPath()%>/SmsSendView.sms">S M S 발송</a></li>
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
		<!-- 페이지 내용부분 -->
        <div id="page-wrapper">
            <div class="row">
                <div class="col-xs-1 col-sm-5 col-md-3"></div>
        		<div class="col-xs-11 col-sm-7 col-md-7">
                    <h1 class="page-header">SMS 발송</h1>
                </div>
            </div>
            <!-- 받는사람의 번호 등록부분 -->
            <div class="row">
            	<div class="col-xs-1 col-sm-5 col-md-3"></div>
            	<div class="col-xs-11 col-sm-7 col-md-4" style="width:300px">
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
  	                      	<input type="button" id="FileReg" value="파일등록">
                        </div>
                    </div>
                </div>
                <!-- 보내는사람의 번호와 메세지등록 부분 -->
                <div class="col-xs-0 col-sm-5 col-md-0"></div>
                <div class="col-xs-5 col-sm-7 col-md-4" style="width:300px;">
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
</form>
</body>
</html>
