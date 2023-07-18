package com.dbja.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.dbja.db.ConnectionProvider;
import com.dbja.vo.CommentsVO;
import com.dbja.vo.DetailPostVO;
import com.dbja.vo.PostVO;
import com.dbja.vo.ReviewVO;

public class PostDAO {
	
	public static int totalRecord; 			//전체 레코드수 
	public static int pageSIZE = 10;		//한화면에 보여줄 레코드수
	public static int totalPage;				//전체 페이지수
	
	private static PostDAO dao;
	private PostDAO() {		
	}
	
	public static PostDAO getInstance() {
		if(dao == null) {
			dao = new PostDAO();
		}
		return dao;
	}
	
//	//전체레코드 수를 반환하는 메소드
//		public int getTotalRecord(String keyword) {
//			int n =  0;
//			String sql = "select count(*) from post ";
//			if(keyword != null) {
//// 모르겠,,	sql += "where "+searchColumn+" like '%"+keyword+"%'";
//			}
//			try {
//				Connection conn = ConnectionProvider.getConnection();
//				Statement stmt = conn.createStatement();
//				ResultSet rs = stmt.executeQuery(sql);
//				if(rs.next()) {
//					n = rs.getInt(1);
//				}
//				ConnectionProvider.close(conn, stmt, rs);
//			}catch (Exception e) {
//				System.out.println("예외발생:"+e.getMessage());
//			}
//			return n;
//		}
	
	/*
	 * public ArrayList<TravelListVO> findById(int tno){ ArrayList<TravelListVO>
	 * list = new ArrayList<TravelListVO>(); String sql =
	 * "select tname from travelList where id=?"; try { Connection conn =
	 * ConnectionProvider.getConnection(); PreparedStatement pstmt =
	 * conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery();
	 * while(rs.next()) { TravelListVO t = new TravelListVO();
	 * t.setTno(rs.getInt(1)); t.setTname(rs.getNString(2));
	 * t.setBudget(rs.getInt(3)); t.setTstart(rs.getString(4));
	 * t.setTend(rs.getString(5)); t.setTpic(rs.getString(6)); list.add(t); } }
	 * catch (Exception e) { System.out.println("예외발생 : " + e.getMessage()); }
	 * return list; }
	 */

	//게시판 삭제를 위한 코멘트 삭제
	public int deleteComments(int postno) {
		int re = -1;
		String sql = "delete comments where postno="+postno+"";
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			re = stmt.executeUpdate(sql);
			ConnectionProvider.close(conn, stmt);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return re;
	}
	
	// 게시판 삭제
	public int deletePost(int postno, String id) {
		deleteComments(postno);
		int re = -1;
		String sql = "delete post where postno = ? and id = '"+id+"'";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postno);
			re=pstmt.executeUpdate();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}

	// 게시판 수정
	public int updatePost(PostVO p) {
		int re = -1;
		String sql = "update post set p_pic=?, hashtag1=?, hashtag2=?, hashtag3=?, pcontent=? where postno=?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p.getP_pic());
			pstmt.setString(2, p.getHashtag1());
			pstmt.setString(3, p.getHashtag2());
			pstmt.setString(4, p.getHashtag3());
			pstmt.setString(5, p.getPcontent());
			pstmt.setInt(6, p.getPostno());
			re = pstmt.executeUpdate();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}

	public int getPostno() {
		int postno = -1;
		String sql = "select max(postno)+1 from post"; 
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				postno=rs.getInt(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return postno;
	}
	
	// 게시판 글쓰기
	public int insertPost(String hashtags, String pcontent, int tno, String id, String p_pic) {
		int re = -1;
		try {
			String sql = "insert into post (postno, hashtag1, hashtag2, hashtag3, pcontent, tno, id, p_pic) values(?,?,?,?,?,?,?, ?)";
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			String hashtag1 = hashtags.substring(hashtags.lastIndexOf("#"), hashtags.length());
			hashtags = hashtags.substring(0, hashtags.lastIndexOf("#"));
			String hashtag2 = hashtags.substring(hashtags.lastIndexOf("#"), hashtags.length());
			hashtags = hashtags.substring(0, hashtags.lastIndexOf("#"));
			String hashtag3 = hashtags.substring(hashtags.lastIndexOf("#"), hashtags.length());
			pstmt.setInt(1, getPostno());
			pstmt.setString(2, hashtag1);
			pstmt.setString(3, hashtag2);
			pstmt.setString(4, hashtag3);
			pstmt.setString(5, pcontent);
			pstmt.setInt(6, tno);
			pstmt.setString(7,  id);
			pstmt.setString(8,  p_pic);
			re = pstmt.executeUpdate();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}
	
	
	
	//게시판 불러오기
	public ArrayList<PostVO> findAll(String keyword){
		ArrayList<PostVO> list = new ArrayList<PostVO>();
		String sql = "select postno, pcontent,hashtag1,hashtag2,hashtag3,p_pic from post ";

		if (keyword != null) {
			sql += "where hashtag1 like '%" + keyword + "%' or hashtag2 like '%" + keyword + "%' or hashtag3 like '%" + keyword + "%' or pcontent like '%" + keyword + "%'";
		};
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				PostVO p = new PostVO();
				p.setPostno(rs.getInt(1));
				String pcontent = rs.getString(2);
				if(pcontent.length() > 64) {
					pcontent = pcontent.substring(0, 64)+" ...";
				}
				p.setPcontent(pcontent);
				p.setHashtag1(rs.getString(3));
				p.setHashtag2(rs.getString(4));
				p.setHashtag3(rs.getString(5));
				p.setP_pic(rs.getString(6));
				list.add(p);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return list;
	}
	
	public DetailPostVO findByPno(int postno) {
		DetailPostVO p = new DetailPostVO();
		String sql = "select postno, budget, tstart, tend, pcontent, hashtag1, hashtag2, hashtag3, p_pic, tname "
				+ "from post p, travelList t, member m "
				+ "where p.tno=t.tno and p.id=m.id and postno="+postno;

		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				p.setPostno(rs.getInt(1));
				p.setBudget(rs.getInt(2));
				p.setTstart(rs.getString(3));
				p.setTend(rs.getString(4));
				p.setPcontent(rs.getString(5));
				p.setHashtag1(rs.getString(6));
				p.setHashtag2(rs.getString(7));
				p.setHashtag3(rs.getString(8));
				p.setP_pic(rs.getString(9));
				p.setTname(rs.getString(10));
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생3 : " + e.getMessage());
		}
		return p;
	}
	
	public ArrayList<CommentsVO> findCommentsByPostNo(int postno) {
		ArrayList<CommentsVO> list = new ArrayList<CommentsVO>();
		String sql = "select * from comments where postno="+postno;
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				CommentsVO c = new CommentsVO();
				c.setCno(rs.getInt(1));
				c.setPostno(rs.getInt(2));
				c.setC_content(rs.getString(3));
				c.setId(rs.getString(4));
				list.add(c);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생3 : " + e.getMessage());
		}
		return list;
	}
	
	public int getCno(int postno) {
		int cno = -1;
		String sql = "select nvl(max(cno), 0)+1 from comments where postno="+postno;
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				cno = rs.getInt(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생3 : " + e.getMessage());
		}
		return cno;
	}
	
	
	
	public int insertComments(int postno, String c_content, String id) {
		int re = -1;
		String sql = "insert into comments values ("+getCno(postno)+", "+postno+", '"+c_content+"', '"+id+"')";
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			re = stmt.executeUpdate(sql);
			ConnectionProvider.close(conn, stmt);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}
	
	public CommentsVO checkComments(int postno, String id) {
		CommentsVO c = null;
		String sql = "select * from comments where id='"+id+"' and postno="+postno;
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				c = new CommentsVO();
				c.setCno(rs.getInt(1));
				c.setPostno(postno);
				c.setC_content(rs.getString(3));
				c.setId(id);
			}
			ConnectionProvider.close(conn, stmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생3 : " + e.getMessage());
		}
		return c;
	}

	public int updateComments(int postno, String c_content, String id) {
		int re = -1;
		String sql = "update comments set c_content='"+c_content+"' where postno="+postno+"and id='"+id+"'";
		try {
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			re = stmt.executeUpdate(sql);
			ConnectionProvider.close(conn, stmt);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}

	// 게시판 => 모든 게시물 불러오기
//	public ArrayList<PostVO> findAll(String keyword) {
//		ArrayList<PostVO> list = new ArrayList<PostVO>();
//		String sql = "select pcontent,hashtag1,hashtag2,hashtag3,p_pic,id from "
//				+ "from (select rownum n,pcontent,hashtag1,hashtag2,hashtag3,p_pic,id " + "from (select * from post ";
//
//		if (keyword != null) {
//			sql += "where hashtag1 like '%" + keyword + "%' or hashtag2 like '%" + keyword + "%' or hashtag3 like '%" + keyword + "%' or pcontent like '%" + keyword + "%'";
//		}
//
//		sql += "order by postno)) a " + "where a.n between ? and ?";
//
//		try {
//			Connection conn = ConnectionProvider.getConnection();
//			Statement stmt = conn.createStatement();
//			ResultSet rs = stmt.executeQuery(sql);
//			while (rs.next()) {
//				PostVO p = new PostVO();
//				p.setPcontent(rs.getString(1));
//				p.setHashtag1(rs.getString(2));
//				p.setHashtag2(rs.getString(3));
//				p.setHashtag3(rs.getString(4));
//				p.setP_pic(rs.getString(5));
//				p.setTno(rs.getInt(6));
//				p.setId(rs.getString(7));
//				list.add(p);
//			}
//			ConnectionProvider.close(conn, stmt, rs);
//		} catch (Exception e) {
//			System.out.println("예외발생 : " + e.getMessage());
//		}
//
//		return list;
//	}
//	
//public ArrayList<PostVO> findAll(int pageNUM, String keyword){
//		
//		totalRecord = getTotalRecord(keyword);
//
//		System.out.println("totalRecord:"+totalRecord);
//		
//		totalPage = (int)Math.ceil((totalRecord / (double)pageSIZE));
//		
//		int start = (pageNUM-1)*pageSIZE+1; 	//현재 페이지에 보여줄 시작레코드
//		int end=start+pageSIZE-1;					//현재 페이지에 보여줄 마지막레코드
//		
//		if(end > totalRecord) {
//			end = totalRecord;
//		}
//		
//		ArrayList<PostVO> list = new ArrayList<PostVO>();
//		
//		String sql = "select pcontent,hashtag1,hashtag2,hashtag3,p_pic,id from "
//				+ "from (select rownum n,pcontent,hashtag1,hashtag2,hashtag3,p_pic,id " + "from (select * from post ";
//				
//		if (keyword != null) {
//			sql += "where hashtag1 like '%" + keyword + "%' or hashtag2 like '%" + keyword + "%' or hashtag3 like '%" + keyword + "%' or pcontent like '%" + keyword + "%'";
//		}
//
//		sql += "order by postno)) a " + "where a.n between ? and ?";
//		
//		
//		try {
//			Connection conn = ConnectionProvider.getConnection();
//			PreparedStatement pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, start);
//			pstmt.setInt(2, end);
//			ResultSet rs = pstmt.executeQuery();
//			while(rs.next()) {
//				PostVO p = new PostVO();
//				p.setPcontent(rs.getString(1));
//				p.setHashtag1(rs.getString(2));
//				p.setHashtag2(rs.getString(3));
//				p.setHashtag3(rs.getString(4));
//				p.setP_pic(rs.getString(5));
//				p.setTno(rs.getInt(6));
//				p.setId(rs.getString(7));
//				list.add(p);
//			}
//			ConnectionProvider.close(conn, pstmt, rs);
//					
//		}catch (Exception e) {
//			System.out.println("예외발생:"+e.getMessage());
//		}
//		return list;
//	}
	
}
