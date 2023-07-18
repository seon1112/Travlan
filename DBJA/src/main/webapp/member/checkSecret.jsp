<%@page import="com.dbja.dao.QuestionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String password=request.getParameter("pwd");
	int qno=Integer.parseInt(request.getParameter("qno"));
	QuestionDAO dao=QuestionDAO.getInstance();
	boolean flag=dao.checkPassword(qno, password);
	System.out.println(flag);
	out.print(flag);
			
%>