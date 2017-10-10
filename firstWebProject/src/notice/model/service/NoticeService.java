package notice.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import notice.model.dao.NoticeDao;
import notice.model.vo.Notice;
import static common.JDBCTemplate.*;

public class NoticeService {
	public NoticeService(){}
	
	public ArrayList<Notice> selectList(){
		Connection con = getConnection();
		ArrayList<Notice> list = new NoticeDao().selectList(con);
		close(con);
		return list;
	}

	public HashMap<Integer, Notice> selectMap() {
		Connection con = getConnection();
		HashMap<Integer, Notice> map = new NoticeDao().selectMap(con);
		close(con);
		return map;
	}

	public Notice selectNotice(int no) {
		Connection con = getConnection();
		Notice notice = new NoticeDao().selectOne(con, no);
		close(con);
		return notice;
	}

	public void addReadCount(int no) {
		Connection con = getConnection();
		int result = new NoticeDao().updateReadCount(con, no);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);		
	}

	public int insertNotice(Notice notice) {
		Connection con = getConnection();
		int result = new NoticeDao().insertNotice(con, notice);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int deleteNotice(int no) {
		Connection con = getConnection();
		int result = new NoticeDao().deleteNotice(con, no);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int updateNotice(Notice notice) {
		Connection con = getConnection();
		int result = new NoticeDao().updateNotice(con, notice);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public ArrayList<Notice> selectSearch(String keyword) {
		Connection con = getConnection();
		ArrayList<Notice> list = new NoticeDao().selectTitleSearch(con, keyword);
		close(con);
		return list;
	}
	
	
}










