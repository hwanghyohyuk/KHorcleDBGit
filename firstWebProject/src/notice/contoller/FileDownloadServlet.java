package notice.contoller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileDownloadServlet
 */
@WebServlet("/fdown")
public class FileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//파일 다운로드 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		
		//프로젝트 내에 저장된 파일의 폴더 경로정보 알아냄
		String savePath = request.getSession().getServletContext()
				.getRealPath("/uploadfiles");
		
		String originalFileName = request.getParameter("oname");
		String renameFileName = request.getParameter("rname");
		
		File downFile = new File(savePath + "/" + renameFileName);
		
		//클라이언트로 내보낼 출력 스트림 생성
		ServletOutputStream downOut = response.getOutputStream();
		
		response.setContentType("text/plane; charset=utf-8");
		//한글 파일명 인코딩 처리함 : 받아주는 시스템의 인코딩으로 변환함
		response.addHeader("Content-Disposition", "attachment; filename=\""
				+ new String(originalFileName.getBytes("utf-8"), "ISO-8859-1") + "\"");
		response.setContentLength((int)downFile.length());
		
		//저장된 폴더에서 파일을 읽어서, 클라이언트한테 내보내기 : 파일 다운
		BufferedInputStream bin = new BufferedInputStream(
				new FileInputStream(downFile));
		int read = -1;
		while((read = bin.read()) != -1){
			downOut.write(read);
			downOut.flush();
		}
		
		downOut.close();
		bin.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}




