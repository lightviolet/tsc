<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CSV파일등록</title>
<script type="text/javascript">
//파일등록페이지로 이동
function sub(){
	var fileext = document.getElemnetById('file').value;
	fileext = fileext.slice(fileext.indexOf(".")+1).toLowerCase();
	if(fileext == "txt"){
		document.fm.submit();
	}else if(fileext == "csv"){
		document.fm.action = "<%=application.getContextPath()%>/sms/csvFileReg.jsp";
		document.fm.submit();
	}else if(fileext == "xls" || fileext == "xlsx"){
		document.fm.action = "<%=application.getContextPath()%>/sms/excelFileReg.jsp";
		document.fm.submit();
	}else{
		alert("파일형식을 확인하세요");
	}
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
<form name="fm" action="<%=application.getContextPath()%>/sms/csvFileReg.jsp" method="post" enctype="multipart/form-data">
   <table> 
    <tr><input type="file" id="file" name="fileName"><br><br>
    </tr>
 	<tr>
 	<th colspan="2">파일 등록 양식</th>
 	</tr>
 	<tr>
 	<td colspan="2">CSV는 셀마다 ,구분자로 구분됩니다.</br>CSV파일등록</br>예)01055233629,01044523534,01052345556</td>
 	</tr>
 	<tr>
    <td align="center"><input type="button" style="font-size:13pt"value="전송" onclick="sub()"></td>
 	<td align="center"><input type="button" style="font-size:13pt"value="닫기" onclick="clo()"></td>
 	</tr>
 	</table>
</form>
</body>
</html>