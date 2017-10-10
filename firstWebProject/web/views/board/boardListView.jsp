<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- page 지시자 태그는 한 페이지에 한 개만 사용이 원칙임
     예외로 import 속성에 대해서만 따로 작성할 수 있음. --%>
<%@ page import="board.model.vo.Board, java.util.ArrayList, java.sql.Date" %>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardListView</title>
<script type="text/javascript">
	function showWriteBoard(){
		location.href = "views/board/boardWriteForm.jsp";
	}
</script>
</head>
<body>
<%@ include file="../../header.jsp" %>
<hr style="clear:both">
<h2 align="center">게시글 목록</h2>
<h3 align="center">총 게시글 갯수 : <%= listCount %></h3>
<br>
<% if(member != null){ %>
	<div align="center">
	<button onclick="showWriteBoard();">글쓰기</button>
	</div>
<% } %>
<br>
<table align="center" border="1" cellspacing="0" width="700">
<tr bgcolor="gray"><th>번호</th><th>제목</th><th>작성자</th><th>날짜</th><th>조회수</th>
   <th>첨부파일</th></tr>
<%
	for(Board b : list){
%>
<tr>
	<td align="center"><%= b.getBoardNum() %></td>
	<td>
	<%-- 답글일 때는 들여쓰기하면서 앞에 ▶ 표시함 --%>
		<% if(b.getBoardLevel() == 1){  //원글의 댓글일 때 %>
		&nbsp; &nbsp; ▶
		<% }else if(b.getBoardLevel() == 2){  //댓글의 댓글일 때 %>
		&nbsp; &nbsp; &nbsp; &nbsp; ▶▶
		<% } %>
	<%-- 로그인한 경우 상세보기 가능하게 처리함 --%>
		<% if(member != null){ %>
			<a href="/first/bdetail?bnum=<%= b.getBoardNum() %>&page=<%= currentPage %>">
			<%= b.getBoardTitle() %>
			</a>
		<% }else{ %>
			<%= b.getBoardTitle() %>
		<% } %>
	</td>
	<td align="center"><%= b.getBoardWriter() %></td>
	<td align="center"><%= b.getBoardDate() %></td>
	<td align="center"><%= b.getBoardReadCount() %></td>
	<td align="center">
		<% if(b.getBoardOriginalFileName() != null){ %>
			◎
		<% }else{ %>
			&nbsp;
		<% } %>
	</td>
</tr>
<%  } %>
</table>
<br>
<%-- 페이지 번호 처리 --%>
<div align="center">
<%-- 이전 페이지 있을 경우에 대한 처리 --%>
<% if(currentPage <= 1){ %>
	[이전] &nbsp;
<% }else{ %>
	<a href="/first/blist?page=<%= currentPage - 1 %>">[이전]</a>
<% } %>
<%-- 현재 페이지 숫자 보여주기 --%>
<% for(int p = startPage; p <= endPage; p++){ 
		if(p == currentPage){
%>
	<b><font size="4" color="red">[<%= p %>]</font></b>
<%     }else{ %>
	<a href="/first/blist?page=<%= p %>"><%= p %></a>
<% }} %>
<%-- 현재 페이지 다음 페이지에 대한 처리 --%>
<% if(currentPage >= maxPage){ %>
	[다음]
<% }else{ %>
	<a href="/first/blist?page=<%= currentPage + 1 %>">[다음]</a>
<% } %>
</div>


<br><br><br>
<%@ include file="../../footer.html" %>
</body>
</html>









