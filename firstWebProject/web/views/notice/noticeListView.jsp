<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="java.util.*, notice.model.vo.Notice" %>
<%	
	/* HashMap<Integer, Notice> map = 
			(HashMap<Integer, Notice>)request.getAttribute("map");
	Set<Map.Entry<Integer, Notice>> entrySet = map.entrySet();
	Iterator<Map.Entry<Integer, Notice>> entryIter = entrySet.iterator(); */
	
	ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeListView</title>
<script type="text/javascript">
	function insertPage(){
		location.href="views/notice/noticeWriteForm.jsp";
	}
</script>
</head>
<body>
<%@ include file="../../header.jsp" %>
<h2 align="center">공지사항</h2>
<br><br>
<div align="center">
	<button onclick="insertPage();">글쓰기</button>
</div>
<br><br>
<div align="center">
	<form action="/first/nsearch" method="post">
	<input type="search" autocomplete name="keyword" length="50"> &nbsp;
	<input type="submit" value="제목검색">
	</form>
</div>
<br><br>
<table align="center" width="600" border="1" cellspacing="0">
<th>번호</th><th>제목</th><th>작성자</th><th>날짜</th><th>첨부파일</th>
<th>조회수</th>
<% /* while(entryIter.hasNext()){
		Map.Entry<Integer, Notice> entry = entryIter.next();
		Integer key = entry.getKey();
		Notice notice = entry.getValue(); */
		
	for(Notice notice : list){
%>
	<tr height="30">
	<td align="center"><%= notice.getNoticeNo() %></td>
	<td>
	<% if(member != null){ %>
		<a href="/first/ndetail?no=<%= notice.getNoticeNo() %>">
			<%= notice.getNoticeTitle() %>
		</a>
	<% }else{ %>
		<%= notice.getNoticeTitle() %>
	<% } %>
	</td>
	<td align="center"><%= notice.getNoticeWriter() %></td>
	<td align="center"><%= notice.getNoticeDate() %></td>
	<td align="center">
	<% if(notice.getOriginalFileName() != null){ %>
		◎
	<% }else{ %>
		&nbsp:
	<% } %>
	</td>
	<td align="center"><%= notice.getReadCount() %></td>
	</tr>
<% } %>
</table>
<br><br>
<div align="center">
	<a href="/first/index.jsp">시작페이지로 이동</a>
</div>
<br>
<hr>
<%@ include file="../../footer.html" %>
</body>
</html>

















