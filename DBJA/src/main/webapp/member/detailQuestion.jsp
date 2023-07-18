<%@page import="com.google.gson.Gson"%>
<%@page import="com.dbja.vo.QuestionVO"%>
<%@page import="com.dbja.dao.QuestionDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int qno=Integer.parseInt(request.getParameter("qno"));
	QuestionDAO dao=QuestionDAO.getInstance();
	QuestionVO q=new QuestionVO();
	q=dao.findByQno(qno);
	Gson gson = new Gson();
	String str = gson.toJson(q);
	out.print(str);
%>
