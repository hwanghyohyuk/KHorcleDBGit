package member.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import member.model.vo.Member;

public class MemberDao {

	public Member selectMember(Connection conn, String memberid, String memberpw){
		System.out.println(memberid+","+memberpw);
		String query = "select * from member where member_id = ? and member_pw = ?";
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberid);
			pstmt.setString(2, memberpw);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				member = new Member();
				member.setMemberid(memberid);
				member.setMemberpw(memberpw);
				member.setMemberName(rset.getString("member_name"));
				member.setGender(rset.getString("gender"));
				member.setAge(rset.getInt("age"));
				member.setEmail(rset.getString("email"));
				member.setPhone(rset.getString("phone"));
				member.setAddress(rset.getString("address"));
				member.setHobby(rset.getString("hobby"));
				member.setEnrollDate(rset.getDate("enroll_date"));
				
				System.out.println(member);
			}else{
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return member;
	} 
}
