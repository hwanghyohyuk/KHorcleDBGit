package notice.contoller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
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

import notice.model.service.NoticeService;
import notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeInsertServlet
 */
@WebServlet("/ninsert")
public class NoticeInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 공지글 등록 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		/*String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");		
		
		Notice notice = new Notice();
		notice.setNoticeTitle(title);
		notice.setNoticeWriter(writer);
		notice.setNoticeContent(content);
		
		if(new NoticeService().insertNotice(notice) > 0){
			response.sendRedirect("/first/nlist");
		}else{
			RequestDispatcher errorPage = request.getRequestDispatcher("views/notice/noticeError.jsp");
			request.setAttribute("message", "새 공지글 등록 실패!");
			errorPage.forward(request, response);
		}
		*/
		
		//enctype 이 multipart 방식으로 전송되었는지 확인
		RequestDispatcher view = null;
		Notice notice = null;
		
		if(!ServletFileUpload.isMultipartContent(request)){
			view = request.getRequestDispatcher("views/notice/noticeError.jsp");
			request.setAttribute("message", "form 의 enctype 속성 누락됨!");
			view.forward(request, response);
		}
		
		//업로드할 파일의 용량 제한 : 10Mbyte 로 제한한다면
		int maxSize = 1024 * 1024 * 10;
		
		//업로드된 파일의 저장 위치 지정
		//해당 컨테이너에서 구동중인 웹 애플리케이션의 루트 폴더의 경로 알아냄
		String root = request.getSession().getServletContext().getRealPath("/");
		//업로드될 파일의 폴더명과 루트 폴더 연결처리
		String savePath = root + "uploadfiles";
		//  web/uploadfiles 로 만들어짐
		
		//request 를 MultipartRequest 객체로 변환함
		MultipartRequest mrequest = new MultipartRequest(request, 
				savePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
		
		String title = mrequest.getParameter("title");
		String writer = mrequest.getParameter("writer");
		String content = mrequest.getParameter("content");
		String originalFileName = mrequest.getFilesystemName("file");
		
		//업로드되어 있는 파일을 '년월일시분초.확장자' 형식으로 파일명 바꾸기 처리
		if(originalFileName != null){
			//변경할 파일명 만들기
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String renameFileName = sdf.format(new java.sql.Date(
					System.currentTimeMillis())) + "." + 
					originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
			
			//파일명 바꾸려면 File 객체의 renameTo() 사용함
			File originalFile = new File(savePath + "\\" + originalFileName);
			File renameFile = new File(savePath + "\\" + renameFileName);
			
			if(!originalFile.renameTo(renameFile)){
				//이름바꾸기 실패시
				//원 파일의 내용을 읽어서, 복사본 파일에 옮겨 기록하고
				int read = -1;
				byte[] buf = new byte[1024];
				
				FileInputStream fin = new FileInputStream(originalFile);
				FileOutputStream fout = new FileOutputStream(renameFile);
				
				while((read = fin.read(buf, 0, buf.length)) != -1){
					fout.write(buf, 0, read);
				}
				
				fin.close();
				fout.close();
				
				//폴더에서 원 파일을 삭제함
				originalFile.delete();
			}
			
			//업로드된 파일이 있을 경우
			notice = new Notice(0, title, writer, content, null,
					originalFileName, renameFileName, 0);
		}else{
			//업로드된(첨부) 파일이 없을 경우
			notice = new Notice(0, title, writer, content, null,
					null, null, 0);
		}
		
		//서비스로 전달하고 결과받아서 뷰 선택해서 내보내기
		if(new NoticeService().insertNotice(notice) > 0){
			response.sendRedirect("/first/nlist");
		}else{
			view = request.getRequestDispatcher("views/notice/noticeError.jsp");
			request.setAttribute("message", "공지글 등록 실패!");
			view.forward(request, response);
		}		
		
		//System.out.println(notice);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}










