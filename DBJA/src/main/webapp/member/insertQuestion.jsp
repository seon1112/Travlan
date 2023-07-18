<%@page import="com.dbja.dao.QuestionDAO"%>
<%@page import="com.dbja.vo.QuestionVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String qtitle=request.getParameter("qtitle");
	String qcontent=request.getParameter("qcontent");
	String qpassword=request.getParameter("qpassword");
	String check=request.getParameter("secret");
	int secret=0;
	if(check.equals("true")||check==null){
		secret=1;
	}
	QuestionVO q=new QuestionVO();
	q.setId(id);
	q.setQcontent(qcontent);
	q.setQpassword(qpassword);
	q.setQtitle(qtitle);
	q.setSecret(secret);
	QuestionDAO dao=QuestionDAO.getInstance();
	int re=dao.insertQuestion(q);
	System.out.println(re);
	out.print(re);
	
%>