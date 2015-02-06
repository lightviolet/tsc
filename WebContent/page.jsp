<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript">
$(function() {
 // 푸시팝업 + 앱내메시지
 $("#both").click(function() {
  $("#pushPopupView").show();
  $("#inAppView").show();
  $('#pushTab a:first').tab('show');
 });
 // 푸시팝업
 $("#pushPopup").click(function() {
  $("#pushPopupView").show();
  $("#inAppView").hide();
  $('#pushTab a:first').tab('show');
 });
 // 앱내메시지
 $("#inApp").click(function() {
  $("#pushPopupView").hide();
  $("#inAppView").show();
  $('#pushTab a:last').tab('show');
 });
});

</script>
</head>
<body>
<div class="page-header">
 <h1>Push 발송 페이지</h1>
</div>

<div class="col-lg-5" style="float:left; padding-bottom: 20px;">
 <input type="text" class="form-control" id="msgTitle" placeholder="메시지 제목">
</div>

<!-- 받는사람의 번호 등록부분 -->
<div class="row" style="width:800px;">
 <div class="col-lg-4" style="width:400px">
  <div class="panel panel-default" >
   <div class="panel-heading">
    받는 사람 : <input type="text" id="to_number"name="to_number" value="" size="12" placeholder="-을 빼고 입력"/>
       <input type="button" id="numberAdd" value="추가">
   </div>
   <!-- /.panel-heading -->
   <div class="panel-body">
   <div>
       <select name="numberList" id="numberList" style="width: 100%; height: 100%" size="13" multiple="multiple"></select>
   </div>
   <div style="text-align: center">
    <input type="button" id="selectDel" value="선택번호삭제">
    <input type="button" id="numberReset" value="번호목록리셋">
   </div>
   </div>
   <div class="panel-footer" align="center">
       <input type="button" id="txtFileReg" value="파일업로드"style="width:40%;">
   </div>
  </div>
 </div>
</div>

<!-- 푸시메세지 타입 선택 -->
<div class="bs-example bs-example-tabs" style="width:1000px; height:300px;">
 <ul id="pushTypeTab" class="nav nav-pills">
  <li class="active" id="both"><a href="#both" data-toggle="tab">푸시팝업 & 앱내메시지</a></li>
  <li id="pushPopup"><a href="#pushPopup" data-toggle="tab">푸시팝업</a></li>
  <li id="inApp"><a href="#inApp" data-toggle="tab">앱내메시지</a></li>
 </ul>
  <div id="pushTypeTabContent" class="tab-content" style="padding-top: 10px">
  <div class="tab-pane in active" id="both">
   <ul id="pushTab" class="nav nav-tabs">
    <li class="active" id="pushPopupView"><a href="#pushPopupContent" data-toggle="tab">푸시팝업</a></li>
    <li id="inAppView"><a href="#inAppContent" data-toggle="tab">앱내메시지</a></li>
   </ul>
   <div id="myTabContent" class="tab-content">
    <!-- 푸시팝업 -->
    <div class="tab-pane in active" id="pushPopupContent">
     <div class="col-lg-6" style="float:left; padding-top: 20px;">
      <form>
       <table style="width:100%">
        <tr>
         <td><input type="text" class="form-control" id="pushPopupTitle" placeholder="푸시팝업 제목"><br/></td>
        </tr>
        <tr>
         <td><textarea class="form-control" id="pushPopupContext" placeholder="푸시팝업 내용" rows="5"></textarea><br/></td>
        </tr>
       </table>
      </form>
     </div>
     <div class="col-lg-6" style="float:left;  background: yellow;">
      ㅇㅣ미지 ㄱㄱ
     </div>
      </div>
        
       <!-- 앱내메시지 -->
    <div class="tab-pane" id="inAppContent">
             <div class="tab-pane in active" id="pushPopupContent">
              <div>
             <div class="col-lg-6" style="float:left; padding-top: 20px;">
        <form>
         <table style="width:100%">
          <tr>
           <td><textarea class="form-control" id="pushPopupContext" placeholder="앱내메시지 내용" rows="7"></textarea><br/></td>
          </tr>
         </table>
        </form>
       </div> 
       <div class="col-lg-6" style="float:left;  background: yellow;">
        ㅇㅣ미지 ㄱㄱ
       </div>
      </div>
     </div>
    </div>        
        </div>
  </div> 
 </div>
</div>

<!-- 저장/실행 버튼 -->
<div style="padding-bottom: 20px; width:1000px;">
 <button type="button" class="btn btn-default">저장</button>
 <button type="button" class="btn btn-default">실행</button>
</div>



</body>
</html>
