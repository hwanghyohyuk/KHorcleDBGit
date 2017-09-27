package member.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8"); 

		String memberId = request.getParameter("memberid");
		String memberPw = request.getParameter("memberpw");
		MemberService mService = new MemberService();
		Member member = mService.loginCheck(memberId, memberPw);
		RequestDispatcher view = null;
		
		if(member !=null){
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			System.out.println("Session ID : "+session.getId());			
			response.sendRedirect("index.jsp");
		}else{
			view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", "로그인 실패 : 아이디 또는 암호를 확인하시오.");
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
