package board.model.service;

import static common.JDBCTemplate.*;
import java.sql.*;
import java.util.*;
import board.model.vo.Board;
import board.model.dao.BoardDao;

public class BoardService {
	public BoardService(){}
	
	//전체 게시글 갯수 조회용
	public int getListCount(){
		Connection con = getConnection();
		int listCount = new BoardDao().getListCount(con);
		close(con);
		return listCount;
	}
	
	//페이지별 목록 조회용
	public ArrayList<Board> selectList(int currentPage, int limit){
		Connection con = getConnection();
		ArrayList<Board> list = new BoardDao().selectList(con, currentPage, limit);
		close(con);
		return list;
	}

	//원글 등록 처리용
	public int insertBoard(Board b) {
		Connection con = getConnection();
		int result = new BoardDao().insertBoard(con, b);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
}















