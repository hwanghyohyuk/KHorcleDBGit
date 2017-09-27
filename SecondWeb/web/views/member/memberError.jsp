<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String errorMessage = (String)request.getAttribute("message");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>
</head>
<body>

<h1> 에러 메시지 <%=errorMessage %></h1>

</body>
</html>