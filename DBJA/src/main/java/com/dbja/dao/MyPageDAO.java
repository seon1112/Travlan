package com.dbja.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.HeartListVO;
import com.dbja.vo.MemberVO;
import com.dbja.vo.TravelListVO;

public class MyPageDAO {
	
	private static MyPageDAO dao;
	private MyPageDAO() {		
	}
	
	public static MyPageDAO getInstance() {
		if(dao == null) {
			dao = new MyPageDAO();
		}
		return dao;
	}
	//회원정보 가져오기
	public MemberVO findInfo(String id) {
		MemberVO m=new MemberVO();
		String sql="select * from member where id='"+id+"'";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()) {
				m.setId(id);
				m.setPwd(rs.getString(2));
				m.setName(rs.getString(3));
				m.setBirth(rs.getDate(4));
				m.setEmail(rs.getString(5));
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("회원정보죄회예외:"+e.getMessage());
		}
		return m;
	}
	
	//가까운 일정 확인
	public ArrayList<TravelListVO> findTravelList(String id){
		ArrayList<TravelListVO> list = new ArrayList<TravelListVO>();
		String sql = "select tname,tstart,tend from travelList,friendlist where travelList.tno=friendlist.tno and id=? and tstart > sysdate order by tstart";
		try {
			Connection conn = ConnectionProvider.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, id);
			 ResultSet rs = pstmt.executeQuery();
			 while(rs.next()) {
				 TravelListVO t = new TravelListVO();
				 t.setTname(rs.getString(1));
				 t.setTstart(rs.getString(2));
				 t.setTend(rs.getString(3));
				 list.add(t);
			 }
			 ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return list;
	}
	
	//좋아요 리스트
	public ArrayList<String> findHeart(String id){
		ArrayList<String> list = new ArrayList<>();
		String sql ="select iname from information i,heartList h where h.ino=i.ino and id=?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
			if(list.size()==0) {
				list.add("좋아요 여행지가 없습니다");
			}
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return list;
	}
	
	//회원 탈퇴
	public int deleteMemberInfo(MemberVO m) {
		int re = -1;
		String sql = "delete from member where id = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getId());
			re = pstmt.executeUpdate();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return re;
	}
	
	//회원 정보 수정
	public int updateMemberInfo(MemberVO m) {
		int re = -1;
		String sql = "update member set password = ?, name = ?, birth = ?, email = ? where id = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getPwd());
			pstmt.setString(2, m.getName());
			pstmt.setDate(3, m.getBirth());
			pstmt.setString(4, m.getEmail());
			pstmt.setString(5, m.getId());
			re = pstmt.executeUpdate();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return re;
	}
}
