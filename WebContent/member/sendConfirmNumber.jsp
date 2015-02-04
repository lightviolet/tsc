<%@ page import="java.sql.Connection" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="net.member.db.*" %>
<%@ page import="java.util.Random" %>
<%
	//인증번호를 생성하고 SMS로 발송
	request.setCharacterEncoding("UTF-8");
	String numbers = "";
	boolean check = false;
	numbers+=(int)(Math.random()*90000+10000);
	System.out.println(numbers);
	String phoneNumber = request.getParameter("phoneNumber");
	MemberDAO dao = new MemberDAO();
	check = dao.sendConfirmNumber(phoneNumber, numbers);
	session.setAttribute("confirmNumber", numbers);
%>
<%=check%>