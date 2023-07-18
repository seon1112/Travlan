<%@page import="com.dbja.db.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<%
  // 중복 체크할 아이디
  String id = request.getParameter("id");

  // 중복 체크 결과
  int responseText = -1;

  try {
    String sql = "select count(*) from member where id = ?";
    Connection conn = ConnectionProvider.getConnection();
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);
    ResultSet rs = pstmt.executeQuery();
    if (rs.next()) {
      int count = rs.getInt(1);
      if (count > 0) {
        responseText = 1;
      } else {
        responseText = 0;
      }
    }
  } catch (SQLException e) {
    // 오류 처리
    e.printStackTrace();
    responseText = -1;
  } 

  // 응답 반환
  response.setContentType("text/plain");
  response.setCharacterEncoding("UTF-8");
  response.getWriter().write(String.valueOf(responseText));
%>
