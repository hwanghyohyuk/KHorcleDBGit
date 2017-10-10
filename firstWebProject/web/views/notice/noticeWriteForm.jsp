<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeWriteForm</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
<hr>
<br>
<h2 align="center">공지글쓰기 페이지</h2>
<br>
<section align="center">
	<form action="/first/ninsert" method="post" enctype="multipart/form-data">
	<table align="center" width="600">
	<tr><th width="150" bgcolor="gray">제목</th>
		<td align="left"><input type="text" name="title"></td>
	</tr>
	<tr><th width="150" bgcolor="gray">작성자</th>
		<td align="left"><input type="text" name="writer" value="<%= member.getMemberId() %>" readonly></td>
	</tr>
	<tr><th width="150" bgcolor="gray">첨부파일</th>
	    <td align="left"><input type="file" name="file"></td>
	</tr>
	<tr><th width="150" bgcolor="gray">내용</th>
		<td align="left"><textarea rows="5" cols="50" name="content"></textarea></td>
	</tr>
	<tr><th width="150" bgcolor="gray" colspan="2">
		<input type="submit" value="등록하기"> &nbsp;
		<input type="reset" value="취소하기">
	</th></tr>
	</table>
	</form>
	<br>
	<a href="/first/nlist">목록으로 이동</a>
</section>

<br>
<hr>
<%@ include file="../../footer.html" %>
</body>
</html>