package com.dbja.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.AnswerVO;

public class AnswerDAO {
	public static AnswerDAO dao;
	private AnswerDAO () {
		
	}
	public static AnswerDAO  getInstance() {
		if(dao==null) {
			dao=new AnswerDAO ();
		}
		return dao;
	}
	//답변삭제하기
	public static int deleteAnswer(int qno) {
		int re=0;
		String sql="delete answer where qno="+qno+"";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			re=stmt.executeUpdate(sql);
			if(re==1) {
				System.out.println("답변삭제완료");
			}
		} catch (Exception e) {
			System.out.println("답변삭제예외:"+e.getMessage());
		}
		return re;
	}
	//답변작성하기
	public static int insertAnswer(AnswerVO a) {
		int re=0;
		String sql="insert into answer values(?,?,?)";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, a.getQno());
			pstmt.setInt(2, a.getQno());
			pstmt.setString(3, a.getAcontent());
			
			re=pstmt.executeUpdate();
			if(re==1) {
				System.out.println("답변추가 성공");
			}
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("답변추가예외:"+e.getMessage());
		}
		return re;
	}
	
	//답변가져오기
	public static String findByQno(int qno) {
		String answer="";
		String sql="select acontent from answer where qno="+qno+"";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()) {
				answer=rs.getString(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("답변 예외:"+e.getMessage());
		}
		return answer;
	}
}
