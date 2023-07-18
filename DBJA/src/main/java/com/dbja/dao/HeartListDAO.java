package com.dbja.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.InformationVO;

public class HeartListDAO {
	private static HeartListDAO dao;
	private HeartListDAO() {}
	
	// getInstance 생성하여 메모리 절약
	public static HeartListDAO getInstance() {
		if(dao == null) {
			dao = new HeartListDAO();
		}
		return dao;
	}
	
	
	// 좋아요 버튼 누르는 경우 insert
	public int insertHeartList(String id, int ino) {
		int re = -1;
		String sql = "insert into HeartList values ('"+id+"', "+ino+")";
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
	
	// 좋아요 누른 정보를 한 번 더 누를 때 delete
	public int deleteHeartList(String id, int ino) {
		int re = -1;
		String sql = "delete from HeartList where id='"+id+"' and ino="+ino;
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
	
	// heartList에 해당 information이 있는지 확인
	public boolean checkHeartList(String id, int ino) {
		boolean re = false;
		try {
			String sql = "SELECT count(*) FROM HeartList where id = '"+id+"' and ino="+ino;
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) {
				if(rs.getInt(1) != 0) {
					re=true;
				}
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외7:"+e.getMessage());
		}		
		return re;
	}
}
