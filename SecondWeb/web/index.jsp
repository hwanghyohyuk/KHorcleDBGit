<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="member.model.vo.Member" %>
<%
	Member member = (Member) session.getAttribute("member");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Second Web</title>
<link rel="stylesheet" href="http://localhost:8888/main/css/bootstrap.css">
</head>
<body>
	<jsp:include page="/views/include/header.jsp" flush="true"></jsp:include>
	<div class="container">
		<div class="jumbotron col-md-7">
			<h1>Hello, world!</h1>
			<p>...</p>
			<p>
				<a class="btn btn-primary btn-lg" href="#" role="button">Learn
					more</a>
			</p>
		</div>
		<%if(member!=null){ %>
		<%}else{ %>
		<div class="col-md-5">
			<form method="post" action="login">
				<div style="height: 30px"></div>
				<div class="form-group">
					<label for="exampleInputEmail1">아이디</label> <input type="text"
						class="form-control" name="memberid" placeholder="아이디를 입력하세요">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">비밀번호</label> <input
						type="password" class="form-control" name="memberpw"
						placeholder="암호">
				</div>
				<div class="form-group">
					<div style="height: 30px"></div>
					<button type="submit" class="form-control btn btn-primary"
						style="height: 60px">로그인</button>
				</div>
			</form>
		</div>
		<%} %>
	</div>
	<jsp:include page="/views/include/footer.jsp" flush="true"></jsp:include>

	<script type="text/javascript" src="http://localhost:8888/main/js/jquery-3.2.1.js"></script>
	<script type="text/javascript" src="http://localhost:8888/main/js/bootstrap.js"></script>
</body>
</html>