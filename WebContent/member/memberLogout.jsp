<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.member.db.*" %>
<%
	String id = request.getParameter("id");
	LoginManager loginManager = LoginManager.getInstance();
	loginManager.removeSession(id);
	session.invalidate();
%>
<script>
alert("로그아웃되었습니다");
alert("재로그인해주세요");
location.href="<%=application.getContextPath()%>/MemberLoginView.mem";
</script>