<%@page import="com.dbja.dao.AnswerDAO"%>
<%@page import="com.dbja.vo.AnswerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String acontent=request.getParameter("acontent");
	int qno=Integer.parseInt(request.getParameter("qno"));
	AnswerVO a=new AnswerVO();
	a.setAcontent(acontent);
	a.setQno(qno);
	AnswerDAO dao=AnswerDAO.getInstance();
	int re=dao.insertAnswer(a);
	System.out.println(re);
%>