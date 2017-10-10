<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="notice.model.vo.Notice" %>
<%
	Notice notice = (Notice)request.getAttribute("notice");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeUpdateView</title>
</head>
<body>
<%@ include file="../../header.jsp" %>
<hr>
<br>
<h2 align="center"><%= notice.getNoticeNo() %>번 공지글 수정 페이지</h2>
<br>
<section align="center">
	<form action="/first/nupdate" method="post" enctype="multipart/form-data">
	<input type="hidden" name="no" value="<%= notice.getNoticeNo() %>">
	<table align="center" width="600">
	<tr><th width="150" bgcolor="gray">제목</th>
		<td align="left"><input type="text" name="title" value="<%= notice.getNoticeTitle() %>"></td>
	</tr>
	<tr><th width="150" bgcolor="gray">작성자</th>
		<td align="left"><input type="text" name="writer" value="<%= notice.getNoticeWriter() %>" readonly></td>
	</tr>
	<tr><th width="150" bgcolor="gray">첨부파일</th>
	    <td align="left">
	    <% if(notice.getOriginalFileName() != null){ %>
	    <input type="file" name="file" value="<%= notice.getOriginalFileName() %>">
	    <% }else{ %>
	    <input type="file" name="file">
	    <% } %>
	    </td>
	</tr>
	<tr><th width="150" bgcolor="gray">내용</th>
		<td align="left">
			<textarea rows="5" cols="50" name="content">
				<%= notice.getNoticeContent() %>
			</textarea>
		</td>
	</tr>
	<tr><th width="150" bgcolor="gray" colspan="2">
		<input type="submit" value="수정하기"> &nbsp;
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