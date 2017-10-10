package board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.service.BoardService;
import board.model.vo.Board;

/**
 * Servlet implementation class BoardInsertServlet
 */
@WebServlet("/binsert")
public class BoardInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 원글 등록 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//업로드할 파일의 용량 제한 : 10Mbyte 로 제한한다면
		int maxSize = 1024 * 1024 * 10;
		
		//enctype="multipart/form-data" 로 전송되었는지 확인
		RequestDispatcher view = null;
		if(!ServletFileUpload.isMultipartContent(request)){
			view = request.getRequestDispatcher("views/board/boardError.jsp");
			request.setAttribute("message", "form enctype 속성 사용 안 함!");
			view.forward(request, response);
		}
		
		//해당 컨테이너에서 구동중인 웹 애플리케이션의 루트 경로 알아냄
		String root = request.getSession().getServletContext().getRealPath("/");
		//업로드되는 파일이 저장될 폴더명과 루트 경로 연결 처리
		String savePath = root + "buploadfiles";
		//web/buploadfiles 로 지정됨
		
		//request 를 MultipartRequest 객체로 변환함
		//자동 지정된 경로에 파일 저장됨
		MultipartRequest mrequest = new MultipartRequest(request, savePath,
				maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String title = mrequest.getParameter("btitle");
		String writer = mrequest.getParameter("bwriter");
		String content = mrequest.getParameter("bcontent");
		
		String originalFileName = mrequest.getFilesystemName("upfile");
		Board b = null;
		if(originalFileName != null){
			//업로드된 파일이 있을 경우, 파일명을 "년월일시분초.확장자"로 변경함
			SimpleDateFormat sdf = 
					new SimpleDateFormat("yyyyMMddHHmmss");
			String renameFileName = sdf.format(
					new java.sql.Date(System.currentTimeMillis())) + "."
					+ originalFileName.substring(
							originalFileName.lastIndexOf(".") + 1);
			
			//업로드되어 있는 원래 파일의 이름을 새 이름으로 바꾸기
			File originalFile = new File(savePath + "\\" + originalFileName);
			File renameFile = new File(savePath + "\\" + renameFileName);
			
			//파일이름 바꾸기 실행 >> 실패시 직접 바꾸기함
			//새 파일 만들고, 원래 파일의 내용 읽어서 복사 기록하고
			//원 파일 삭제함
			if(!originalFile.renameTo(renameFile)){
				int read = -1;
				byte[] buf = new byte[1024];
				
				FileInputStream fin = new FileInputStream(originalFile);
				FileOutputStream fout = new FileOutputStream(renameFile);
				
				while((read = fin.read(buf, 0, buf.length)) != -1)
					fout.write(buf, 0, read);
				
				fin.close();
				fout.close();
				originalFile.delete();
			}
			b = new Board(title, writer, content, originalFileName, renameFileName);
		}else  //첨부 파일이 없을 때
			b = new Board(title, writer, content, null, null);
		
		//처리결과에 따라 뷰 지정함
		if(new BoardService().insertBoard(b) > 0){
			response.sendRedirect("/first/blist?page=1");
		}else{
			view = request.getRequestDispatcher("views/board/boardError.jsp");
			request.setAttribute("message", "Board 서비스 : 원글 등록 실패!");
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







