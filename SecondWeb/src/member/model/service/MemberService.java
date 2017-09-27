package member.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;

import member.model.dao.MemberDao;
import member.model.vo.Member;

public class MemberService {

	public Member loginCheck(String memberid, String memberpw) {
		Connection conn = getConnection();
		Member member = new MemberDao().selectMember(conn, memberid, memberpw);
		close(conn);
		return member;
	}

}
