<%@page import="com.dbja.dao.AnswerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int qno=Integer.parseInt(request.getParameter("qno"));
	AnswerDAO dao=AnswerDAO.getInstance();
	String data=dao.findByQno(qno);
	if(data.equals("")){
		data="답변이 아직 준비되지 않았습니다.";
	}else{
		data="답변 : "+data;
	}
	out.print(data);
	
%>