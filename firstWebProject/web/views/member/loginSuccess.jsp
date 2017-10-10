<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="member.model.vo.Member, java.util.*" %>
<%
	Member member = (Member)session.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginSuccess</title>
</head>
<body>
<h2>로그인 성공 : <%= member.getMemberName() %>님 환영합니다.</h2>
<a href="../../logout">로그아웃</a>
</body>
</html>