package com.dbja.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import com.dbja.dao.MemberDAO;
import com.dbja.db.ConnectionProvider;

public class MemberDAO {
	private static MemberDAO dao;
	private MemberDAO() {
	}
	
	public static MemberDAO getInstance() {
		if(dao == null) {
			dao = new MemberDAO();
		}
		return dao;
	}
	
	// 생년월일 유효성 검사 메서드
    public boolean isBirthValid(String birth) {
        if (birth.length() != 8) {
            // 생년월일이 8자리가 아닌 경우 유효하지 않음
            return false;
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        dateFormat.setLenient(false);

        try {
            // 형식에 맞는지 검사하고 ParseException 발생 여부로 결과 반환
            Date parsedDate = dateFormat.parse(birth);
            return true;
        } catch (ParseException e) {
            return false;
        }
    }
	
	//회원가입을 위한 메서드
	public int insertMember(String id,String pwd,String name,String birth,String email) {
		int re = -1;
		boolean b = isPwdValid(pwd);
		System.out.println("booleanPwdValid: "+b);
		
		if(isPwdValid(pwd)) {
			//비번 유효성 검사 통과하면 insert 실행
			try {
				String sql ="insert into member values(?,?,?,?,?)";
				Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pwd);
				pstmt.setString(3, name);
				pstmt.setString(4, birth);
				pstmt.setString(5, email);
				re = pstmt.executeUpdate();
				ConnectionProvider.close(conn, pstmt);
			} catch (Exception e) {
				System.out.println("예외발생 : "+e.getMessage());
			}
		}
		return re;
	}
	
	//비밀번호 유효성 검사
	public boolean isPwdValid(String pwd) {
	    // 길이 확인
	    if (pwd.length() < 10 || pwd.length() > 20) {
	        return false;
	    }

	    // 영문, 숫자, 특수문자 포함 여부 확인
	    boolean hasLetter = false;
	    boolean hasDigit = false;
	    boolean hasSpecialChar = false;

	    for (char c : pwd.toCharArray()) {
	        if (Character.isLetter(c)) {
	            hasLetter = true;
	        } else if (Character.isDigit(c)) {
	            hasDigit = true;
	        } else {
	            // 특수문자 확인
	            if ("!@#$%^&*()\\-_=+\\\\|\\[{\\]};:'\",<.>/?".indexOf(c) != -1) {
	                hasSpecialChar = true;
	            }
	        }
	    }

	    // 문자, 숫자, 특수문자가 모두 포함되었는지 확인
	    return hasLetter && hasDigit && hasSpecialChar;
	}
	
	//아이디,비밀번호 입력받아서 비밀번호 재설정하는 메서드
	public int updatePwd(String id, String newPwd) {
		int re = -1;
		boolean b = isPwdValid(newPwd);
		System.out.println("boolean : "+b);
		
		try {
			if(isPwdValid(newPwd)) {
				//유효성검사 적합
				//비밀번호 업데이트 진행
				try {
					String sql = "update member set pwd=? where id=?";
					Connection conn = ConnectionProvider.getConnection();
					PreparedStatement pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, newPwd);
					pstmt.setString(2, id);
					re = pstmt.executeUpdate();
					ConnectionProvider.close(conn, pstmt);
				} catch (Exception e) {
					System.out.println("예외발생 : "+e.getMessage());
				}
			}
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return re;
	}
	
	//아이디 찾기-이름,이메일 받아서 아이디 찾기
	public String findMemberID(String name, String email) {
		String id = null;
		String sql = "select id from member where name=? and email=?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return id;
	}
	
	//비밀번호 찾기-아이디,이름,이메일 받아서 비밀번호 찾기
	public String findPwd(String id,String name,String email) {
		String pwd = null;
		String sql = "select pwd from member where id=? and name=? and email=?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				pwd = rs.getString(1);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 :"+e.getMessage());
		}
		return pwd;
	}
	
	
	//로그인을 위해 입력받은 아이디로 pwd 검색하여 입력받은 pwd 와 동일한지 판별 하기 위해 pwd 찾기
	public int isMember(String id,String pwd) {
		int re = -1;
		String sql = "select pwd from member where id=?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			//rs.next() 가 있으면 일치하는 ID 있음
			//rs.next() 가 없으면 일치하는 ID 없음
			if(rs.next()) {
				//일치하는 ID 있으니까 pwd 비교해보기
				String dbPwd = rs.getString(1);
				if(pwd.equals(dbPwd)) {
					//비밀번호 같으면 re = 1
					re=1;
				}else {
					//비밀번호 틀리면 re = 0
					re=0;
				}
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : "+e.getMessage());
		}
		return re;
	}
}