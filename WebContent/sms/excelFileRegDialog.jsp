<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>텍스트파일등록</title>
<script type="text/javascript">
//파일등록페이지로 이동
function sub(){
	document.fm.submit();
}
//다이어로그닫기
function clo(){
	window.close();
}
</script>
<style>
table,tr,td { border: 3px solid #e4e4e4;}
</style>
</head>
<body>
<form name="fm" action="<%=application.getContextPath()%>/sms/excelFileReg.jsp" method="post" enctype="multipart/form-data">
   <table> 
    <tr><input type="file" name="fileName"><br><br>
    </tr>
 	<tr>
 	<th colspan="2">파일 등록 양식</th>
 	</tr>
 	<tr>
 	<td colspan="2"><br>엑셀파일등록<br>사용법)A컬럼에만 작성하세요, A1, A2....</td>
 	</tr>
 	<tr>
    <td align="center"><input type="button" style="font-size:13pt"value="전송" onclick="sub()"></td>
 	<td align="center"><input type="button" style="font-size:13pt"value="닫기" onclick="clo()"></td>
 	</tr>
 	</table>
</form>
</body>
</html>