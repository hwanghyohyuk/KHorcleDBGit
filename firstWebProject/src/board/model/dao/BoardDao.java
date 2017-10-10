package board.model.dao;

import static common.JDBCTemplate.*;
import board.model.vo.Board;
import java.sql.*;
import java.util.*;

public class BoardDao {
	public BoardDao(){}

	public int getListCount(Connection con) {
		// 총 게시글 갯수 조회용
		int result = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from board";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next())
				result = rset.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}
		
		return result;
	}

	public ArrayList<Board> selectList(Connection con, 
			int currentPage, int limit) {
		// 한 페이지에 출력할 게시글 목록 조회용
		ArrayList<Board> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//currentPage 에 해당되는 목록만 조회
		String query ="select * from ("
				+ "select rownum rnum, board_num, board_title, "
				+ "board_writer, board_content, board_original_filename, "
				+ "board_rename_filename, board_date, board_level, "
				+ "board_ref, board_reply_ref, board_reply_seq, "
				+ "board_readcount from (select * from board "
				+ "order by board_ref desc, board_reply_ref desc, "
				+ "board_level asc, board_reply_seq asc)) "
				+ "where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			if(rset != null){
				list = new ArrayList<Board>();
				
				while(rset.next()){
					Board b = new Board();
					
					b.setBoardNum(rset.getInt("board_num"));
					b.setBoardTitle(rset.getString("board_title"));
					b.setBoardWriter(rset.getString("board_writer"));
					b.setBoardContent(rset.getString("board_content"));
					b.setBoardDate(rset.getDate("board_date"));
					b.setBoardReadCount(rset.getInt("board_readcount"));
					b.setBoardOriginalFileName(rset.getString("board_original_filename"));
					b.setBoardRenameFileName(rset.getString("board_rename_filename"));
					b.setBoardLevel(rset.getInt("board_level"));
					b.setBoardRef(rset.getInt("board_ref"));
					b.setBoardReplyRef(rset.getInt("board_reply_ref"));
					b.setBoardReplySeq(rset.getInt("board_reply_seq"));
					
					list.add(b);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int insertBoard(Connection con, Board b) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into board values ("
				+ "(select max(board_num) + 1 from board), "
				+ "?, ?, ?, ?, ?, sysdate, default, 0, "
				+ "(select max(board_num) + 1 from board), NULL, "
				+ "default)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, b.getBoardTitle());
			pstmt.setString(2, b.getBoardWriter());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setString(4, b.getBoardOriginalFileName());
			pstmt.setString(5, b.getBoardRenameFileName());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}
	
	
}















