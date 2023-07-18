package com.dbja.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.InformationVO;
import com.dbja.vo.ReviewVO;

public class ReviewDAO {
	private static ReviewDAO dao;
	private ReviewDAO() {}
	
	// getInstance 생성하여 메모리 절약
	public static ReviewDAO getInstance() {
		if(dao == null) {
			dao = new ReviewDAO();
		}
		return dao;
	}
	
	// ino를 받아 review들을 불러오는 메소드
	public ArrayList<ReviewVO> findByIno(int ino) {
				
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		String sql = "select id, rcontent, grade from review where ino="+ino;
		try {
			Connection conn = com.dbja.db.ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String id = rs.getString(1);
				String rcontent = rs.getString(2);
				int grade = rs.getInt(3);
				ReviewVO r = new ReviewVO(ino, id, rcontent, grade);
				list.add(r);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외: "+e.getMessage());
		}
		return list;
	}
	
	// 작성된 review를 테이블에 추가하는 메소드
	public int insertReview(String id, int ino, String rcontent, int grade) {
		int re = -1;
		String sql = "insert into Review values ("+ino+", '"+id+"', '"+rcontent+
				"', "+grade+")";
		try {
			Connection conn = com.dbja.db.ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			re = stmt.executeUpdate(sql);
			ConnectionProvider.close(conn, stmt);
		} catch (Exception e) {
			System.out.println("예외: "+e.getMessage());
		}
		return re;
	}
	
	// review가 작성됐는지 체크하는 메소드
	public ReviewVO checkReview(String id, int ino) {
		ReviewVO r = null;
		try {
			String sql = "SELECT * FROM review where ino="+ino+" and id='"+id+"'";
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				r = new ReviewVO();
				r.setIno(ino);
				r.setId(id);
				r.setRcontent(rs.getString(3));
				r.setGrade(rs.getInt(4));
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외7:"+e.getMessage());
		}		
		return r;
	}
	
	// 작성된 review가 있다면 update하는 메소드
	public int updateReview(String id, int ino, String rcontent, int grade) {
		int re = -1;
		String sql = "update review set rcontent='"+rcontent+"', grade="+grade+" "
				+ "where id='"+id+"' and ino="+ino;
		try {
			Connection conn = com.dbja.db.ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			re = stmt.executeUpdate(sql);
			ConnectionProvider.close(conn, stmt);
		} catch (Exception e) {
			System.out.println("예외: "+e.getMessage());
		}
		return re;
	}
}
