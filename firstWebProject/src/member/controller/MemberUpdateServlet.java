package member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/mupdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원 정보 수정용 컨트롤러
		//1. 전송값에 한글이 있을 경우, 문자 인코딩 처리함
		request.setCharacterEncoding("utf-8");
		//2. 내보낼 뷰의 컨텐츠타입 지정
		response.setContentType("text/html; charset=utf-8");
		
		//3. 전송값 꺼내서 변수에 저장하기
		String userId = request.getParameter("userid");
		String userPwd = request.getParameter("userpwd");
		String userName = request.getParameter("username");
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		String[] hobbies = request.getParameterValues("hobby");
		StringBuilder hb = new StringBuilder();
		for(int i = 0; i < hobbies.length; i++){
			if(i < hobbies.length - 1)
				hb.append(hobbies[i] + ",");
			else
				hb.append(hobbies[i]);
		}
		
		String hobby = hb.toString();
		
		Member member = new Member(userId, userPwd, userName, 
				gender, age, email, phone, address, hobby, null);
		
		//System.out.println(member);
		
		/* 전송값 추출해서 객체에 저장하는 또 다른 방법
		 * Member member = new Member();
		member.setAddress(request.getParameter("address"));
		member.setAge(Integer.parseInt(request.getParameter("age")));*/
		
		//4. 모델서비스로 전달하고, 결과받기
		int result = new MemberService().updateMember(member);
		
		//5. 받은 결과에 따라 뷰를 선택해서 내보냄
		RequestDispatcher rd = null;
		if(result > 0){
			//수정된 회원정보 읽어와서, 세션객체에 저장된 회원 정보 변경 처리함
			Member smember = new MemberService().selectMember(userId);
			HttpSession session = request.getSession(false);
			session.removeAttribute("member");
			session.setAttribute("member", smember);
			
			response.sendRedirect("/first/index.jsp");
		}else{
			rd = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", "회원 정보 수정 실패!");
			rd.forward(request, response);
			
			//response.sendRedirect("views/member/memberError.jsp");
		}
	}

}
















