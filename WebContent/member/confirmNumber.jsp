<%@ page import="java.sql.Connection" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//인증번호와 입력한번호 비교
	request.setCharacterEncoding("UTF-8");
	boolean isCheck = false;
	System.out.println(session.getAttribute("confirmNumber"));
	System.out.println(request.getParameter("confirmNumber"));
	if(session.getAttribute("confirmNumber").equals(request.getParameter("confirmNumber"))){
		isCheck=true;
	}
%>
<%=isCheck%>