package com.dbja.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.TravelListVO;

public class TravelListDAO {
	private static TravelListDAO dao;
	private TravelListDAO() {		
	}
	
	public static TravelListDAO getInstance() {
		if(dao == null) {
			dao = new TravelListDAO();
		}
		return dao;
	}
	
	public ArrayList<TravelListVO> findAllById(String id){
		ArrayList<TravelListVO> list = new ArrayList<TravelListVO>();
		String sql = "select * from travelList t, friendList f where f.tno = t.tno and id='"+id+"'";
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				TravelListVO t = new TravelListVO();
				t.setTno(rs.getInt(1));
				t.setTname(rs.getString(2));
				t.setBudget(rs.getInt(3));
				t.setTstart(rs.getString(4));
				t.setTend(rs.getString(5));
				t.setTpic(rs.getString(6));
				list.add(t);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return list;
	}
	
	public int findTnoByTname(String tname) {
		int tno = -1;
		String sql = "select tno from travelList where tname='"+tname+"'";
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) {
				tno=rs.getInt(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return tno;
	}
	
	//여행일정 등록
		public int insertTravelList(TravelListVO t) {
			int re = -1;
			try {
				Connection conn = ConnectionProvider.getConnection();
				String sql = "insert into travelList values(getTno(), ?, ?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, t.getTname());
					pstmt.setInt(2, t.getBudget());
					pstmt.setString(3, t.getTstart());
					pstmt.setString(4, t.getTend());
					re=pstmt.executeUpdate();
				ConnectionProvider.close(conn, pstmt);
			} catch (Exception e) {
				System.out.println("예외발생 : "+e.getMessage());
			}
			return re;
		}
		
		//tno 자동증가
		public int getTno() {
		      int tno= -1;
		      String sql = "select nvl(max(tno), 0)+1 from travelList";
		      try {
		         Connection conn = ConnectionProvider.getConnection();
		         Statement stmt = conn.createStatement();
		         ResultSet rs = stmt.executeQuery(sql);
		         if (rs.next()) {
		            tno=rs.getInt(1);
		         }
		         ConnectionProvider.close(conn, stmt, rs);
		      } catch (Exception e) {
		         System.out.println("예외발생 : " + e.getMessage());
		      }
		      return tno;
		   }
		
		//여행일정 목록 불러오기
				public ArrayList<TravelListVO>findById(String id){
					ArrayList<TravelListVO> list = new ArrayList<TravelListVO>();
					String sql = "select tname from travelList,friendlist where travelList.tno=friendlist.tno and id=?";
					try {
						Connection conn = ConnectionProvider.getConnection();
						PreparedStatement pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, id);
						ResultSet rs = pstmt.executeQuery();
						while(rs.next()) {
							TravelListVO t = new TravelListVO();
							t.setTname(rs.getString(1));
							list.add(t);
						}
						ConnectionProvider.close(conn, pstmt, rs);
					} catch (Exception e) {
						System.out.println("예외발생 : "+e.getMessage());
					}
					return list;
				}
	
	//여행일정 수정
	public static int updateTravelList(TravelListVO t) {
		int re=0;
		String sql="update travelList set tname=?,budget=?,tstart=?,tend=? where tno=?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, t.getTname());
			pstmt.setInt(2, t.getBudget());
			pstmt.setString(3, t.getTstart());
			pstmt.setString(4, t.getTend());
			pstmt.setInt(5, t.getTno());
			
			re=pstmt.executeUpdate();
			if(re==1) {
				System.out.println("여행수정완료");
			}
		} catch (Exception e) {
			System.out.println("여행수정예외:"+e.getMessage());
		}
		return re;
	}
}
