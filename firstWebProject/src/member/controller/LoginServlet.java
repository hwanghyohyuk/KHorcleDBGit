package member.controller;

import java.io.IOException;
import java.util.ArrayList;

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
 * Servlet implementation class LoginServlet
 */
//@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 요청 처리용 컨트롤러
		//1. 전송값에 한글이 있을 경우, 한글에 대한 인코딩 처리함
		request.setCharacterEncoding("utf-8");
		//2. 응답 처리시 컨텐츠 타입 지정
		response.setContentType("text/html; charset=utf-8");
		
		//3. 전송온 값 꺼내서 변수에 담기
		String userId = request.getParameter("userid");
		String userPwd = request.getParameter("userpwd");
		
		//4. 비즈니스 로직 처리용 클래스 객체 생성
		MemberService mservice = new MemberService();	
		//로그인 처리용 메소드 실행하고, 결과 받음
		Member member = mservice.loginCheck(userId, userPwd);
		
		//5. 받은 결과를 가지고, 성공/실패 페이지 선택해서 클라이언트로 내보냄
		RequestDispatcher view = null;
		if(member != null){ //로그인 성공시
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			//System.out.println("session id : " + session.getId());
			
			//response.sendRedirect("views/member/loginSuccess.jsp");
			if(userId.equals("admin")){
				//회원 전체 정보 조회 처리용 메소드 실행함
				ArrayList<Member> mlist = mservice.selectAll();
				view = request.getRequestDispatcher("views/member/memberListView.jsp");
				request.setAttribute("list", mlist);
				view.forward(request, response);
			}else
				response.sendRedirect("index.jsp");
		}else{
			//response.sendRedirect("views/member/loginFail.html");
			view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", "로그인 실패! 아이디 또는 암호 확인하세요.");
			view.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}









