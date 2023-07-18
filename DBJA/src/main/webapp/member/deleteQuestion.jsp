<%@page import="com.dbja.dao.QuestionDAO"%>
<%@page import="com.dbja.dao.AnswerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int qno=Integer.parseInt(request.getParameter("qno"));
	//질문 삭제
	QuestionDAO q=QuestionDAO.getInstance();
	int re=q.deleteQuestion(qno);
	
	//답변 삭제
	AnswerDAO a=AnswerDAO.getInstance();
	int re2=a.deleteAnswer(qno);
	
	out.print(re);
%>