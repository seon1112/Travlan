package com.dbja.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.dbja.db.ConnectionProvider;

public class FriendListDAO {
	private static FriendListDAO dao;
	private FriendListDAO() {		
	}
	
	public static FriendListDAO getInstance() {
		if(dao == null) {
			dao = new FriendListDAO();
		}
		return dao;
	}
	//친구 초대하기
	public static int inviteFriend(String id,int tno) {
		int re=0;
		String sql="insert into friendList values("+tno+", '"+id+"')";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			re=stmt.executeUpdate(sql);
			if(re==1) {
				System.out.println("친구 초대 완료");
			}
		} catch (Exception e) {
			System.out.println("친구초대예외:"+e.getMessage());
		}
		return re;
	}
	
	//친구리스트 가져오기
	public static ArrayList<String> friendList(int tno){
		ArrayList<String>list=new ArrayList<>();
		String sql="select id from friendList where tno="+tno+"";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()) {
				list.add(rs.getString(1));
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("친구예외:"+e.getMessage());
		}
		return list;
	}
}
