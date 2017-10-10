<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.Member" %>
<%
	//Member member = (Member)session.getAttribute("member");
	Member member = (Member)request.getAttribute("member");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myInfo</title>
<style>
	th { background: lightgray; }
</style>
<script type="text/javascript">
	function mdel(){
		location.href = "/first/mdelete?userid=<%= member.getMemberId() %>";
		return false;
	}
</script>
</head>
<body>
<h2 align="center"><%= member.getMemberName() %> 님 정보보기</h2>
<br><br>
<form action="../../mupdate" method="post">
<table align="center" width="600" height="350">
<tr><th width="150">아이디</th>
	<td width="450"><input name="userid" value="<%= member.getMemberId() %>" readonly></td>
</tr>
<tr><th>이 름</th>
	<td><input type="text" name="username" value="<%= member.getMemberName() %>"></td>
</tr>
<tr><th>암 호</th>
	<td><input type="password" name="userpwd" value="<%= member.getMemberPwd() %>"></td>
</tr>
<tr><th>암호확인</th><td><input type="password" name="userpwd2"></td></tr>
<tr><th>성 별</th>
	<% if(member.getGender().equals("M")){ %>
	<td><input type="radio" name="gender" value="M" checked> 남
		<input type="radio" name="gender" value="F"> 여
	</td>
	<% }else{ %>
	<td>
		<input type="radio" name="gender" value="M"> 남
		<input type="radio" name="gender" value="F" checked> 여
	</td>
	<%  } %>
</tr>
<tr><th>나 이</th>
	<td><input type="number" name="age" min="1" max="100" value="<%= member.getAge() %>"></td>
</tr>
<tr><th>전화번호</th>
	<td><input type="tel" name="phone" value="<%= member.getPhone() %>"></td>
</tr>
<tr><th>이메일</th>
	<td><input type="email" name="email" value="<%= member.getEmail() %>"></td>
</tr>
<tr><th>주 소</th>
	<td><input type="text" name="address" value="<%= member.getAddress() %>"></td>
</tr>
<tr><th>취 미</th>
	<td>
	<% 
		String[] hobby = member.getHobby().split(",");
		boolean[] checked = new boolean[9];
		for(int i = 0; i < hobby.length; i++){
			if(hobby[i].equals("독서"))	
				checked[0] = true;
			if(hobby[i].equals("운동"))	
				checked[1] = true;
			if(hobby[i].equals("등산"))	
				checked[2] = true;
			if(hobby[i].equals("그림"))	
				checked[3] = true;
			if(hobby[i].equals("요리"))	
				checked[4] = true;
			if(hobby[i].equals("음악"))	
				checked[5] = true;
			if(hobby[i].equals("게임"))	
				checked[6] = true;
			if(hobby[i].equals("댄스"))	
				checked[7] = true;
			if(hobby[i].equals("기타"))	
				checked[8] = true;
		}
	%>
	<table>
	<tr>
	<%	if(checked[0] == true){ %>
		<td><input type="checkbox" name="hobby" value="독서" checked> 독서</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="독서"> 독서</td>	
	<%  } %>
	<%	if(checked[1] == true){ %>
		<td><input type="checkbox" name="hobby" value="운동" checked> 운동</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="운동"> 운동</td>
	<%  } %>
	<%	if(checked[2] == true){ %>
		<td><input type="checkbox" name="hobby" value="등산" checked> 등산</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="등산"> 등산</td>
	<%  } %>
	</tr>
	<tr>
	<%	if(checked[3] == true){ %>
		<td><input type="checkbox" name="hobby" value="그림" checked> 그림</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="그림" > 그림</td>
	<%  } %>
	<%	if(checked[4] == true){ %>
		<td><input type="checkbox" name="hobby" value="요리" checked> 요리</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="요리" > 요리</td>
	<%  } %>
	<%	if(checked[5] == true){ %>
		<td><input type="checkbox" name="hobby" value="음악" checked> 음악</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="음악" > 음악</td>
	<%  } %>
	</tr>
	<tr>
	<%	if(checked[6] == true){ %>
		<td><input type="checkbox" name="hobby" value="게임" checked> 게임</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="게임" > 게임</td>
	<%  } %>
	<%	if(checked[7] == true){ %>	
		<td><input type="checkbox" name="hobby" value="댄스" checked> 댄스</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="댄스" > 댄스</td>
	<%  } %>
	<%	if(checked[8] == true){ %>
		<td><input type="checkbox" name="hobby" value="기타" checked> 기타</td>
	<%  }else{  %>
		<td><input type="checkbox" name="hobby" value="기타" > 기타</td>
	<%  } %>
	</tr>
	
	</table>	
	</td>
</tr>
<tr><th colspan="2">
	<input type="submit" value="수정하기"> &nbsp;
	<input type="reset" value="취소"> &nbsp;
	<button onclick="return mdel();">탈퇴하기</button>
</th></tr>
</table>
</form>
<br><br>
<div align="center">
	<a href="/first/index.jsp">시작페이지로 이동</a>
</div>



</body>
</html>





