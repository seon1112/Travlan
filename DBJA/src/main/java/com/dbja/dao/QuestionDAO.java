package com.dbja.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.QuestionVO;

public class QuestionDAO {
	public static int totalRecord; 	//전체 레코드수 
	public static int pageSIZE = 5;//한화면에 보여줄 레코드수
	public static int totalPage;	//전체 페이지수
	
	public static QuestionDAO dao;
	private QuestionDAO() {
		
	}
	public static QuestionDAO getInstance() {
		if(dao==null) {
			dao=new QuestionDAO();
		}
		return dao;
	}
	
	//답변이 없는 질문리스트 조회
	public static ArrayList<QuestionVO> findNoAnswer() {
		ArrayList<QuestionVO>list=new ArrayList<>();
		String sql="select * from question where qno not in(select qno from answer )";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()) {
				QuestionVO q=new QuestionVO();
				q.setQno(rs.getInt(1));
				q.setId(rs.getString(2));
				q.setQtitle(rs.getString(3));
				q.setQcontent(rs.getString(4));
				q.setQpassword(rs.getString(5));
				q.setSecret(rs.getInt(6));
				
				list.add(q);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("답변없는 질문 예외:"+e.getMessage());
		}
		return list;	
	}
	//비밀번호 확인하기
	public static boolean checkPassword(int qno,String password) {
		boolean str=false;
		String realPassword="";
		String sql="select qpassword from question where qno="+qno+"";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()) {
				realPassword=rs.getString(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("질문번호조회예외:"+e.getMessage());
		}
		if(realPassword.equals(password)) {
			str=true;
		}
		
		System.out.println("비밀번호체크:"+str);
		return str;
	}
	
	//전체 레코드 수
	public static int getTotalRecord(String keyword, String columnQna) {
		int n=0;
		String sql="select count(*) from question";
		if(keyword!=null) {
			sql+=" where "+columnQna+" like '%"+keyword+"%'";
		}
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()) {
				n=rs.getInt(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("질문번호조회예외:"+e.getMessage());
		}
		return n;
	}
	//질문번호+1 조회
	public static int nextQno() {
		int next=0;
		String sql="select max(qno)+1 from question";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()) {
				next=rs.getInt(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("질문번호조회예외:"+e.getMessage());
		}
		return next;
	}
	public static int deleteQuestion(int qno) {
		int re=0;
		String sql="delete question where qno="+qno+"";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			re=stmt.executeUpdate(sql);
			if(re==1) {
				System.out.println("질문이 삭제되었습니다");
			}
			ConnectionProvider.close(conn, stmt);
		} catch (Exception e) {
			System.out.println("질문삭제예외:"+e.getMessage());
		}
		return re;
	}
	//질문 수정
	public static int updateQuestion(QuestionVO v) {
		int re=0;
		String sql="update question set qtitle=?,qcontent=?,qpassword=?,secret=? where qno=?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(5, v.getQno());
			pstmt.setString(1, v.getQtitle());
			pstmt.setString(2, v.getQcontent());
			pstmt.setString(3, v.getQpassword());
			pstmt.setInt(4, v.getSecret());
			re=pstmt.executeUpdate();
			if(re==1) {
				System.out.println("질문이 수정 되었습니다.");
			}else {
				System.out.println("질문이 수정되지 않았습니다.");
			}
		} catch (Exception e) {
			System.out.println("질문수정 예외:"+e.getMessage());
		}
		return re;
	}
	//질문 삽입
	public static int insertQuestion(QuestionVO v) {
		int re=0;
		int qno=nextQno();
		String sql="insert into question values(?,?,?,?,?,?)";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, qno);
			pstmt.setString(2, v.getId());
			pstmt.setString(3, v.getQtitle());
			pstmt.setString(4, v.getQcontent());
			pstmt.setString(5, v.getQpassword());
			pstmt.setInt(6, v.getSecret());
			System.out.println("id:"+v.getId());
			re=pstmt.executeUpdate();
			if(re==1) {
				System.out.println("질문이 추가 되었습니다.");
			}else {
				System.out.println("질문 추가 실패");
			}
		} catch (Exception e) {
			System.out.println("질문추가예외:"+e.getMessage());
		}
		return re;
	}
	//질문조회
	public static QuestionVO findByQno(int qno) {
		QuestionVO q=new QuestionVO();
		String sql="select * from question where qno="+qno+"";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()) {
				q.setQno(rs.getInt(1));
				q.setId(rs.getString(2));
				q.setQtitle(rs.getString(3));
				q.setQcontent(rs.getString(4));
				q.setQpassword(rs.getString(5));
				q.setSecret(rs.getInt(6));
				
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("질문확인예외:"+e.getMessage());
		}
		return q;
	}
	//질문 리스트 조회
	public static ArrayList<QuestionVO> findAll(int pageNUM, String keyword, String columnQna){
		totalRecord=getTotalRecord(keyword,columnQna);
		
		totalPage=(int)Math.ceil((double)totalRecord/pageSIZE);
		int start= (pageNUM-1)*pageSIZE+1; 
		int end=start+pageSIZE-1;			//현재 페이지에 보여줄 마지막레코드
		if(end > totalRecord) {
			end = totalRecord;
		}
		
		ArrayList<QuestionVO>list=new ArrayList<>();
		String sql="select qno,qtitle,qcontent,qpassword,secret,id "
				+ "from (select rownum n, qno,qtitle,qcontent,qpassword,secret,id "
				+ "from (select * from question ";
				
			if(keyword!=null) {
				sql+="where "+columnQna+" like '%"+keyword+"%' ";
			}
				sql+= "order by qno desc)) a where a.n between ? and ?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				QuestionVO q=new QuestionVO();
				q.setQno(rs.getInt(1));
				q.setQtitle(rs.getString(2));
				q.setQcontent(rs.getString(3));
				q.setQpassword(rs.getString(4));
				q.setSecret(rs.getInt(5));
				q.setId(rs.getString(6));
				list.add(q);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("질문 조회 예외:"+e.getMessage());
		}
		return list;
	}
}
