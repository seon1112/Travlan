package com.dbja.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.ScheduleVO;
import com.dbja.vo.TravelListVO;

		public class ScheduleDAO {
		
		private static ScheduleDAO dao;
		private ScheduleDAO() {		
		}
		
		public static ScheduleDAO getInstance() {
			if(dao == null) {
				dao = new ScheduleDAO();
			}
			return dao;
		}
		//스케줄 수성
		public int updateSchedule(ScheduleVO s) {
			int re=0;
			String sql="update schedule set sdate=?, sname=?,stime=?,saddr=? where sno=? and tno=?";
			try {
				Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,s.getSdate());
				pstmt.setString(2, s.getSname());
				pstmt.setString(3, s.getStime());
				pstmt.setString(4, s.getSaddr());
				pstmt.setInt(5, s.getSno());
				pstmt.setInt(6, s.getTno());
				re=pstmt.executeUpdate();
				if(re>=1) {
					System.out.println("일정이 수정되었습니다.");
				}
			} catch (Exception e) {
				System.out.println("일정수정예외:"+e.getMessage());
			}
			return re;
		}
		//가계부도 같이 수정
		public int updateAccountBySchedule(ScheduleVO s) {
			int re=0;
			String sql="update account set category=?,expect=?, adate=? where sno=? and tno=?";
			try {
				Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, s.getCategory());
				pstmt.setInt(2, s.getExpect());
				pstmt.setString(3, s.getSdate());
				pstmt.setInt(4, s.getSno());
				pstmt.setInt(5, s.getTno());
				re=pstmt.executeUpdate();
				if(re>=1) {
					System.out.println("가계부가 수정되었습니다.");
				}
			} catch (Exception e) {
				System.out.println("여행가계부수정예외:"+e.getMessage());
			}
			return re;
		}
		//스케줄 삭제
		public int deleteSchedule(int tno, int sno) {
			int re=0;
			String sql="delete schedule where tno="+tno+" and sno="+sno+"";
			try {
				Connection conn = ConnectionProvider.getConnection();
				Statement stmt=conn.createStatement();
				re=stmt.executeUpdate(sql);
				if(re>=1) {
					System.out.println("일정이 삭제되었습니다");
				}
			} catch (Exception e) {
				System.out.println("일정삭제예외:"+e.getMessage());
			}
			return re;
		}
		//가계부도 스케줄과 같이 삭제
		public int deleteAccountBySchedule(int tno, int sno) {
			int re=0;
			String sql="delete account where tno="+tno+" and sno="+sno+"";
			try {
				Connection conn = ConnectionProvider.getConnection();
				Statement stmt=conn.createStatement();
				re=stmt.executeUpdate(sql);
				if(re>=1) {
					System.out.println("가계부가 삭제되었습니다");
				}
			} catch (Exception e) {
				System.out.println("가계부삭제예외:"+e.getMessage());
			}
			return re;
		}
		//sno+1구학
		public int nextSno(int tno) {
			int next=0;
			String sql="select max(sno)+1 from schedule where tno="+tno+"";
			try {
				Connection conn=ConnectionProvider.getConnection();
				Statement stmt=conn.createStatement();
				ResultSet rs=stmt.executeQuery(sql);
				if(rs.next()) {
					next=rs.getInt(1);
				}
				ConnectionProvider.close(conn, stmt, rs);
			} catch (Exception e) {
				System.out.println("sno+1예외:"+e.getMessage());
			}
			return next;
			
		}
		//스케줄 등록
		public int insertSchedule(ScheduleVO s) {
			int re=0;
			int sno=nextSno(s.getTno());
			System.out.println("sno:"+sno);
			String sql="insert into schedule values("+sno+",?,?,?,?,?)";
			try {
				Connection conn=ConnectionProvider.getConnection();
				PreparedStatement pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, s.getTno());
				pstmt.setString(2, s.getSdate());
				pstmt.setString(3, s.getSname());
				pstmt.setString(4, s.getStime());
				pstmt.setString(5, s.getSaddr());
				re=pstmt.executeUpdate();
				if(re>=1) {
					System.out.println("스케줄이 등록되었습니다.");
					FriendListDAO f=FriendListDAO.getInstance();
					ArrayList<String> list=f.friendList(s.getTno());
					insertAccountBySchedule(s,sno,list);
				}
			} catch (Exception e) {
				System.out.println("스케줄 등록예외:"+e.getMessage());
			}
			return re;
		}
		
		//가계부에도 같이 등록
		public int insertAccountBySchedule(ScheduleVO s,int sno,ArrayList<String> list) {
			int re=0;
			try {
				String sql="insert into account (ano,id,sno,tno,adate,category,expect,real) values (?,?,?,?,?,?,?,0)";
				for(String id:list) {
					ExpenseDAO e=ExpenseDAO.getInstance();
					int ano=e.nextAno(id, s.getTno());
					Connection conn=ConnectionProvider.getConnection();
					PreparedStatement pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, ano);
					pstmt.setString(2, id);
					pstmt.setInt(3, sno);
					pstmt.setInt(4, s.getTno());
					pstmt.setString(5, s.getSdate());
					pstmt.setString(6, s.getCategory());
					pstmt.setInt(7, s.getExpect());
					re=pstmt.executeUpdate();
					}
					if(re>=1) {
						System.out.println("가계부에 추가되었습니다.");
					}
				
			}catch (Exception e) {
				System.out.println("가계부추가예외:"+e.getMessage());
			}
			return re;
		}
		//여행일정
		public TravelListVO findByTno(int tno){
			TravelListVO t=new TravelListVO();
			String sql = "select * from travelList where tno=?";
			try {
				Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, tno);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					t.setTno(rs.getInt(1));
					t.setTname(rs.getString(2));
					t.setBudget(rs.getInt(3));
					t.setTstart(rs.getString(4));
					t.setTend(rs.getString(5));
					t.setTpic(rs.getString(6));
				}
				ConnectionProvider.close(conn, pstmt, rs);
			} catch (Exception e) {
				System.out.println("여행예외발생 : "+e.getMessage());
			}
			return t;
		}
		//여행일정 상세목록
		public ArrayList<ScheduleVO> findAll(int tno){
			ArrayList<ScheduleVO> list = new ArrayList<ScheduleVO>();
			String sql = "select distinct schedule.sno,sdate,sname,stime,saddr,category,expect,schedule.tno from schedule,account where account.sno=schedule.sno and schedule.tno=? order by sdate";
			try {
				Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, tno);
				ResultSet rs = pstmt.executeQuery();
				while(rs.next()) {
					ScheduleVO s = new ScheduleVO();
					s.setSno(rs.getInt(1));
					s.setSdate(rs.getString(2));
					s.setSname(rs.getString(3));
					s.setStime(rs.getString(4));
					s.setSaddr(rs.getString(5));
					s.setCategory(rs.getString(6));
					s.setExpect(rs.getInt(7));
					s.setTno(rs.getInt(8));
					list.add(s);
				}
				ConnectionProvider.close(conn, pstmt, rs);
			} catch (Exception e) {
				System.out.println("여행상세예외발생 : "+e.getMessage());
			}
			return list;
		}
}
