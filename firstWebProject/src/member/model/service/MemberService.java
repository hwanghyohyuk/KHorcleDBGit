package member.model.service;

import member.model.dao.MemberDao;
import member.model.vo.Member;
import static common.JDBCTemplate.*;
import java.sql.*;
import java.util.ArrayList;

public class MemberService {
	public MemberService(){}
	
	//로그인 처리용 메소드
	public Member loginCheck(String userId, String userPwd){
		Connection con = getConnection();
		Member member = new MemberDao().selectMember(con, userId, userPwd);
		close(con);
		return member;
	}
	
	//회원 정보 조회 처리용 메소드
	public Member selectMember(String userId){
		Connection con = getConnection();
		Member member = new MemberDao().selectMember(con, userId);
		close(con);
		return member;
	}

	//회원 정보 수정 처리용 메소드
	public int updateMember(Member member) {
		Connection con = getConnection();
		int result = new MemberDao().updateMember(con, member);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		
		close(con);
		
		return result;
	}

	public int insertMember(Member member) {
		Connection con = getConnection();
		int result = new MemberDao().insertMember(con, member);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int deleteMember(String userId) {
		Connection con = getConnection();
		int result = new MemberDao().deleteMember(con, userId);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public ArrayList<Member> selectAll() {
		Connection con = getConnection();
		ArrayList<Member> mlist = new MemberDao().selectList(con);
		close(con);
		return mlist;
	}
	
}


















