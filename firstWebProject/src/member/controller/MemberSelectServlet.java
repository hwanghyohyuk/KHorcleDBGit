package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberSelectServlet
 */
@WebServlet("/minfo")
public class MemberSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원 정보 조회 처리용 컨트롤러
		response.setContentType("text/html; charset=utf-8");
		
		Member member = new MemberService().selectMember(request.getParameter("userid"));
		
		RequestDispatcher view = null;
		if(member != null){
			view = request.getRequestDispatcher("views/member/myInfo.jsp");
			request.setAttribute("member", member);
			view.forward(request, response);
		}else{
			//getRequestDispatcher("상대경로만 사용할 수 있음")
			//절대경로 사용하면 에러남
			view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", "회원 정보 조회 실패!");
			view.forward(request, response);
		}
	}

}

















