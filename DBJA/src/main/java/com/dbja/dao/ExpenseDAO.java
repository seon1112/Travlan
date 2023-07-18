package com.dbja.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.ExpenseVO;
import com.dbja.vo.TravelListVO;

public class ExpenseDAO {

	public static ExpenseDAO dao;
	private ExpenseDAO() {
		
	}
	public static ExpenseDAO getInstance() {
		if(dao==null) {
			dao=new ExpenseDAO();
		}
		return dao;
	}
	
	//카테고리별 사용금액 
	public static ArrayList<ExpenseVO>category(String id,int tno){
		ArrayList<ExpenseVO>list=new ArrayList<>();
		String sql="select category,sum(real) from account where tno=? and id=? and category is not null group by category";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			pstmt.setString(2, id);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				ExpenseVO v= new ExpenseVO(rs.getString(1),rs.getInt(2));
				list.add(v);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("차트 예외발생:"+e.getMessage());
		}
		return list;
	}
	
	//가계부 수정
	public static int updateExpense(ExpenseVO v) {
		int re=0;
		String sql="update account set adate=?, expect=?, category=?,payment=?,memo=?,real=? where id=? and tno=? and ano=?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, v.getAdate());
			pstmt.setInt(2, v.getExpect());
			pstmt.setString(3, v.getCategory());
			pstmt.setString(4, v.getPayment());
			pstmt.setString(5, v.getMemo());
			pstmt.setInt(6, v.getReal());
			pstmt.setString(7, v.getId());
			pstmt.setInt(8, v.getTno());
			pstmt.setInt(9, v.getAno());
			re=pstmt.executeUpdate();
			if(re==1) {
				System.out.println("수정완료");
			}
		} catch (Exception e) {
			System.out.println("수정예외발생:"+e.getMessage());
		}
		return re;
	}
	//여행이름과 일정 출력 
	public static TravelListVO tnameAndTdate(int tno){
		TravelListVO t=new TravelListVO();
		String sql="select tname,tstart,tend from travellist where tno=?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				t.setTname(rs.getString(1));
				t.setTstart(rs.getString(2));
				t.setTend(rs.getString(3));
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생:"+e.getMessage());
		}
		return t;
	}
	
	//예산출력
	public static int budget(int tno) {
		int buget=0;
		String sql="select budget from travellist where tno=?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				buget=rs.getInt(1);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생:"+e.getMessage());
		}
		
		
		return buget;
	}
	
	//가계부 ano +1 가져오기
	public static int nextAno(String id,int tno) {
		int ano=0;
		String sql="select max(ano)+1 from account where tno=? and id=?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			pstmt.setString(2, id);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				ano=rs.getInt(1);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("날짜출력 예외:"+e.getMessage());
		}
		return ano;
	}
	//가계부 지출 추가
	public static int insertExpense(ExpenseVO v) {
		int re=0;
		int ano=nextAno(v.getId(), v.getTno());
		String sql="insert into account values("+ano+",?,0,?,?,?,?,?,?,?)"; //가계부에서 추가시 sno가 없음으로 0 넣음 
		//일정 추가시 무조건 0만들어줘야한 fk로 설정되어있음
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, v.getId()); 
			pstmt.setInt(2, v.getTno());
			pstmt.setString(3, v.getAdate());
			pstmt.setString(4, v.getCategory());
			pstmt.setInt(5, v.getExpect());
			pstmt.setInt(6, v.getReal());
			pstmt.setString(7, v.getPayment());
			pstmt.setString(8, v.getMemo());
			re=pstmt.executeUpdate();
			if(re==1) {
				System.out.println("지출이 추가 되었습니다");
			}
		} catch (Exception e) {
			System.out.println("지출추가 예외발생:"+e.getMessage());
		}
		return re;
	}
	
	//여행 일정 날짜들 출력
	public static ArrayList<String> findDay(String id,int tno){
		ArrayList<String>list=new ArrayList<>();
		String sql="select distinct adate from account where tno=? and id=? order by adate";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			pstmt.setString(2, id);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("날짜출력 예외:"+e.getMessage());
		}
		return list;
	}
	//가계부 지출 항목 삭제
	public static int deleteExpense(int tno,String id,int ano) {
		int re=0;
		String sql="delete account where tno="+tno+" and id='"+id+"' and ano="+ano+"";
		try {
			Connection conn=ConnectionProvider.getConnection();
			Statement stmt=conn.createStatement();
			re=stmt.executeUpdate(sql);
			if(re==1) {
				System.out.println("지출삭제");
			}
		} catch (Exception e) {
			System.out.println("지출삭제 예외:"+e.getMessage());
		}
		return re;
	}
	//토탈 사용금액 가져오기
		public static int totalExpense(String id,int tno,String adate, String colum, String keyword) {
			int total=0;
			String sql="select sum(real) from account where tno=? and id=?";
			if(adate!=null) {
				sql += " and adate='" + adate + "'";
			}
			if(keyword!=null) {
				sql+=" and "+colum+" like '%"+keyword+"%'";
			}
			try {
				Connection conn=ConnectionProvider.getConnection();
				PreparedStatement pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, tno);
				pstmt.setString(2, id);
				ResultSet rs=pstmt.executeQuery();
				if(rs.next()) {
					total=rs.getInt(1);
				}
				ConnectionProvider.close(conn, pstmt, rs);
			} catch (Exception e) {
				System.out.println("전체사용금액 예외발생:"+e.getMessage());
			}
			
			return total;
		}
	//가계부 지출 항목을 모두 불러온다
	public static ArrayList<ExpenseVO> findAll(String id,int tno, String adate, String colum, String keyword){
		ArrayList<ExpenseVO>list=new ArrayList<>();
		String sql="select * from account where tno=? and id=?";
		if(adate!=null) {
			sql += " and adate='" + adate + "'";
		}
		if(keyword!=null) {
			sql+=" and "+colum+" like '%"+keyword+"%'";
		}
		sql+=" order by adate";
		try {
			Connection conn=ConnectionProvider.getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, tno);
			pstmt.setString(2, id);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				ExpenseVO e=new ExpenseVO();
				e.setTno(tno);
				e.setAno(rs.getInt(1));
				e.setSno(rs.getInt(3));
				e.setAdate(rs.getString(5));
				e.setCategory(rs.getString(6));
				e.setExpect(rs.getInt(7));
				e.setReal(rs.getInt(8));
				e.setPayment(rs.getString(9));
				e.setMemo(rs.getString(10));
				list.add(e);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("expensec dao예외발생:"+e.getMessage());
		}
		return list;
	}
}
