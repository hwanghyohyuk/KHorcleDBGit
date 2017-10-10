<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="notice.model.vo.Notice" %>
<%
	Notice notice = (Notice)request.getAttribute("notice");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeDetailView</title>
</head>
<body>
	<%@ include file="../../header.jsp" %>
	<session>
		<h2 align="center"><%= notice.getNoticeNo() %>번 공지글 상세보기</h2><br>
<table border="1" cellspacing="0" width="600" align="center">
	<tr><th>제목</th><td><%= notice.getNoticeTitle() %></td></tr>
	<tr><th>작성자</th><td><%= notice.getNoticeWriter() %></td></tr>
	<tr><th>작성날짜</th><td><%= notice.getNoticeDate() %></td></tr>
	<tr><th>첨부파일</th>
		<td>
		<% if(notice.getOriginalFileName() != null){ %>
			<a href="/first/fdown?oname=<%= notice.getOriginalFileName() %>&rname=<%= notice.getRenameFileName() %>"><%= notice.getOriginalFileName() %></a>
		<% }else{ %>
			첨부파일 없음
		<% } %>
		</td>
	</tr>
	<tr><th>조회수</th><td><%= notice.getReadCount() %></td></tr>
	<tr><th>내용</th><td><%= notice.getNoticeContent() %></td></tr>
	<% if(notice.getNoticeWriter().equals(member.getMemberId())){ %>
	<tr><th colspan="2">
		<a href="/first/nupview?no=<%= notice.getNoticeNo() %>">수정페이지로 이동</a> &nbsp;
		<a href="/first/ndel?no=<%= notice.getNoticeNo() %>">삭제하기</a>
	</th></tr>
	<% } %>
</table>
<br>
<div align="center">
	<a href="/first/nlist">목록보기로 이동</a>
</div>
<br><br>
<hr>
<%@ include file="../../footer.html" %>
</body>
</html>















