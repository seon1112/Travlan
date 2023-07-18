package com.dbja.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.dbja.vo.InformationVO;
import com.dbja.db.ConnectionProvider;

public class InformationDAO {
	private static InformationDAO dao;
	private InformationDAO() {}

	// getInstance 생성하여 메모리 절약
	public static InformationDAO getInstance() {
		if(dao == null) {
			dao = new InformationDAO();
		}
		return dao;
	}
	
	public static int pageSIZE=9;
	public static int totalPage;
	public static int totalRecord;
	
	//인기여행지 top5
	public ArrayList<InformationVO> InformationTop5(){
		ArrayList<InformationVO> list = new ArrayList<InformationVO>();
		String sql = "select iname, icontent, ipic,latitude,longitude from (select iname, icontent, ipic,latitude,longitude from information order by click desc) where rownum <= 5";
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				InformationVO v = new InformationVO();
				v.setIname(rs.getString(1));
				v.setIcontent(rs.getString(2));
				v.setIpic(rs.getString(3));
				v.setLatitude(rs.getString(4));
				v.setLongitude(rs.getString(5));
				list.add(v);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return list;
	}
	
	
	// 페이징처리를 위한 전체 record 구하기
	public int getTotalRecord(String keyword) {
		int cnt=0;
		try {
			String sql = "SELECT count(*) FROM information ";
			
			if(keyword != null) {
				sql += "where iname like '%"+keyword+"%' or addr like '%"+keyword+"%' or"
						+ " icontent like '%"+keyword+"%' ";
			}
			
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				cnt = rs.getInt(1);		
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외7:"+e.getMessage());
		}		
		return cnt;
	}
	
	// 현재 페이지에 띄울 list 반환함. sort 방법과 keyword 설정이 필수는 아님.
	public ArrayList<InformationVO> findAll(int pageNUM, String sort, String keyword) {
		
		//전체 페이지수를 계산하여 출력
		totalRecord = getTotalRecord(keyword);
		totalPage = totalRecord/pageSIZE;
		
		if(totalRecord % pageSIZE != 0) {
			totalPage++;
		}

		int start = (pageNUM-1)*pageSIZE+1; //현재 페이지에 보여줄 시작 레코드
		int end = pageNUM*10; //현재 페이지에 보여줄 마지막 레코드
		
		/*
		 * 전체레코드 52, 현재페이지가 1페이지라면 시작레코드 1, 마지막 9 현대페이지기ㅏ 2페이지라면 시작레코드 10, 마지막 레코드 19
		 */
		
		if(end > totalRecord) {
			end = totalRecord;
		}	

		
		ArrayList<InformationVO> list = new ArrayList<InformationVO>();
		String sql = "select ino, iname, addr, icontent, click, ipic, longitude, latitude  from "
				+ "(select rownum as r, ino, iname, addr, icontent, click, ipic, longitude, latitude from "
				+ "(select * from information ";
		
		if(keyword != null) {
			sql += "where iname like '%"+keyword+"%' or addr like '%"+keyword+"%' or"
					+ " icontent like '%"+keyword+"%' ";
		}
		if(sort != null) {
			if(!sort.equals("correct"))
				sql += "order by "+sort;
			else {
				sql += "order by ino";
			}
		}
		
		sql += ")) where r BETWEEN "+start+" AND "+end;
		
		try {
			Connection conn = com.dbja.db.ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int ino = rs.getInt(1);
				String iname = rs.getString(2);
				if(iname.length() >= 7) {
					iname = iname.substring(0, 6)+"...";
				}
				String addr = rs.getString(3);
				
				/* addr이 길어지면 18자 미만으로 정리함 */
				while(addr.length() >= 18) {
					addr = addr.substring(0, addr.lastIndexOf(" "));
				}
				if(addr.endsWith("-") || addr.endsWith(",") || addr.endsWith("(")) {
					addr = addr.substring(0, addr.length()-1);
				}
				
				String icontent = rs.getString(4);
				if(icontent.length() >= 70) {
					icontent = icontent.substring(0, 70)+"...";
				}
				int click = rs.getInt(5);
				String ipic = rs.getString(6);
				String longitude = rs.getString(7);
				String latitude = rs.getString(8);

				InformationVO i = new InformationVO(ino, iname, addr, icontent, click, 
						ipic, longitude, latitude, calcAvgGrade(ino), firstReview(ino));
				list.add(i);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외: "+e.getMessage());
		}
		return list;
	}
	
	// ino를 받아 information 전부를 가져오는 메소드
	public InformationVO findByIno(int ino) {
		InformationVO i = null;
		String sql = "select * from information where ino="+ino;
		try {
			Connection conn = com.dbja.db.ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				ino = rs.getInt(1);
				String iname = rs.getString(2);
				String addr = rs.getString(3);
				String icontent = rs.getString(4);
				int click = rs.getInt(5);
				String ipic = rs.getString(6);
				String longitude = rs.getString(7);
				String latitude = rs.getString(8);
				i = new InformationVO(ino, iname, addr, icontent, click, 
						ipic, longitude, latitude, calcAvgGrade(ino), firstReview(ino));
				}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외: "+e.getMessage());
		}
		return i;
	}
	
	// 평균 별점을 구하는 메소드
	public double calcAvgGrade(int ino) {
		double grade = 0;
		String sql = "select sum(grade) as s, count(*) as c from review "
				+ "where ino="+ino+" group by ino";
		try {
			Connection conn = com.dbja.db.ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				double total = rs.getInt(1);
				double cnt = rs.getInt(2);
				grade = Math.round((total/cnt)*10)/10.0; // 소수 첫째자리까지 반환
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외: "+e.getMessage());
		}		
		return grade;
	}
	
	// 첫 번째 리뷰를 대표로 띄우기 위한 메소드
	public String firstReview(int ino) {
		String review = "";
		String sql = "select rcontent from "
				+ "(select rownum as r, rcontent from (select * from review where ino="+ino+"))"
				+ "where r=1";
		try {
			Connection conn = com.dbja.db.ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				review = rs.getString(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외: "+e.getMessage());
		}		
		return review;
	}
	
	// 조회수 update를 위한 메소드
	public int updateClick(int ino) {
		int re = -1;
		String sql = "update information set click=click+1 where ino="+ino;
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
