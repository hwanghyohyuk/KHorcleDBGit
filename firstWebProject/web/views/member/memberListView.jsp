<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, member.model.vo.Member" %>
<%
	ArrayList<Member> list = (ArrayList<Member>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberListView</title>
</head>
<body>
<h2 align="center">관리자 전용 페이지입니다.</h2>
<br><br>
<table border="1" cellspacing="0" align="center">
<th>아이디</th><th>암호</th><th>이름</th><th>성별</th><th>나이</th>
<th>이메일</th><th>전화번호</th><th>주소</th><th>취미</th><th>가입날짜</th>
<% for(Member m : list){ %>
<tr height="30">
<td><%= m.getMemberId() %></td>
<td><%= m.getMemberPwd() %></td>
<td><%= m.getMemberName() %></td>
<td><%= m.getGender() %></td>
<td><%= m.getAge() %></td>
<td><%= m.getEmail() %></td>
<td><%= m.getPhone() %></td>
<td><%= m.getAddress() %></td>
<td><%= m.getHobby() %></td>
<td><%= m.getEnrollDate() %></td>
</tr>
<% } %>
</table>
<br><br>
<div align="center">
<a href="/first/index.jsp">시작페이지로</a>
</div>
</body>
</html>












