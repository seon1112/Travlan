<%@page import="com.dbja.dao.FriendListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int tno=Integer.parseInt(request.getParameter("tno"));
	String id=request.getParameter("id");
	FriendListDAO dao=FriendListDAO.getInstance();
	int re=dao.inviteFriend(id, tno);
	out.print(re);
			
%>