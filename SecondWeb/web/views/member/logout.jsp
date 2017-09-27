<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 처리</title>
</head>
<body>
	<%
		session.invalidate(); // 모든세션정보 삭제
		response.sendRedirect("http://localhost:8888/main/"); // 로그인 화면으로 다시 돌아간다.
	%>
</body>
</html>
