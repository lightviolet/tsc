<%@ page import="java.sql.Connection" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="net.member.db.*"%>
<%
	//아이디 중복 체크
	request.setCharacterEncoding("UTF-8");
	System.out.println(request.getParameter("id"));

	MemberDAO dao = new MemberDAO();
		
	boolean isDup = dao.duplicateIdCheck(request.getParameter("id"));
%>
<%=isDup%>