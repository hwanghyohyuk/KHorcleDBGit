package notice.model.dao;

import java.util.*;
import java.sql.*;

import notice.model.vo.Notice;
import static common.JDBCTemplate.*;

public class NoticeDao {
	public NoticeDao(){}
	
	public ArrayList<Notice> selectList(Connection con){
		ArrayList<Notice> list = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice order by notice_no desc";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset != null){
				list = new ArrayList<Notice>();
				
				while(rset.next()){
					Notice n = new Notice();
					
					n.setNoticeNo(rset.getInt("notice_no"));
					n.setNoticeTitle(rset.getString("notice_title"));
					n.setNoticeWriter(rset.getString("notice_writer"));
					n.setNoticeContent(rset.getString("notice_content"));
					n.setNoticeDate(rset.getDate("notice_date"));
					n.setOriginalFileName(rset.getString("original_filename"));
					n.setRenameFileName(rset.getString("rename_filename"));
					n.setReadCount(rset.getInt("read_count"));
					
					list.add(n);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}
		
		return list;
	}

	public HashMap<Integer, Notice> selectMap(Connection con) {
		HashMap<Integer, Notice> map = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice order by notice_no desc";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset != null){
				map = new HashMap<Integer, Notice>();
				
				while(rset.next()){
					Notice n = new Notice();
					
					n.setNoticeNo(rset.getInt("notice_no"));
					n.setNoticeTitle(rset.getString("notice_title"));
					n.setNoticeWriter(rset.getString("notice_writer"));
					n.setNoticeContent(rset.getString("notice_content"));
					n.setNoticeDate(rset.getDate("notice_date"));
					n.setOriginalFileName(rset.getString("original_filename"));
					n.setRenameFileName(rset.getString("rename_filename"));
					n.setReadCount(rset.getInt("read_count"));
					
					map.put(n.getNoticeNo(), n);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}
		
		return map;
	}

	public Notice selectOne(Connection con, int no) {
		Notice notice = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice where notice_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				notice = new Notice();
				
				notice.setNoticeNo(rset.getInt("notice_no"));
				notice.setNoticeTitle(rset.getString("notice_title"));
				notice.setNoticeWriter(rset.getString("notice_writer"));
				notice.setNoticeContent(rset.getString("notice_content"));
				notice.setNoticeDate(rset.getDate("notice_date"));
				notice.setOriginalFileName(rset.getString("original_filename"));
				notice.setRenameFileName(rset.getString("rename_filename"));
				notice.setReadCount(rset.getInt("read_count"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return notice;
	}

	public int updateReadCount(Connection con, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update notice set read_count = read_count + 1 "
				+ "where notice_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int insertNotice(Connection con, Notice notice) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into notice values "
				+ "((select max(notice_no) + 1 from notice), "
				+ "?, ?, ?, default, ?, ?, default)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeWriter());
			pstmt.setString(3, notice.getNoticeContent());
			pstmt.setString(4, notice.getOriginalFileName());
			pstmt.setString(5, notice.getRenameFileName());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}		
		
		return result;
	}

	public int deleteNotice(Connection con, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from notice where notice_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}
	

	public int updateNotice(Connection con, Notice notice) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update notice set notice_title = ?, "
				+ "notice_content = ?, original_filename = ?, "
				+ "rename_filename = ? where notice_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeContent());
			pstmt.setString(3, notice.getOriginalFileName());
			pstmt.setString(4, notice.getRenameFileName());
			pstmt.setInt(5, notice.getNoticeNo());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Notice> selectTitleSearch(Connection con, String keyword) {
		ArrayList<Notice> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice "
				+ "where notice_title like ? order by notice_no desc";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" + keyword + "%");
			
			rset = pstmt.executeQuery();
			
			if(rset != null){
				list = new ArrayList<Notice>();
				
				while(rset.next()){
					Notice n = new Notice();
					
					n.setNoticeNo(rset.getInt("notice_no"));
					n.setNoticeTitle(rset.getString("notice_title"));
					n.setNoticeWriter(rset.getString("notice_writer"));
					n.setNoticeContent(rset.getString("notice_content"));
					n.setNoticeDate(rset.getDate("notice_date"));
					n.setOriginalFileName(rset.getString("original_filename"));
					n.setRenameFileName(rset.getString("rename_filename"));
					n.setReadCount(rset.getInt("read_count"));
					
					list.add(n);
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
	
	
}















