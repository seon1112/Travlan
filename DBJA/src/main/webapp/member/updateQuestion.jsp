<%@page import="com.dbja.dao.AnswerDAO"%>
<%@page import="com.dbja.dao.QuestionDAO"%>
<%@page import="com.dbja.vo.QuestionVO"%>
<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String qtitle=request.getParameter("qtitle");
	String qcontent=request.getParameter("qcontent");
	String qpassword=request.getParameter("qpassword");
	String check=request.getParameter("secret");
	int qno=Integer.parseInt(request.getParameter("qno"));
	int secret=0;
	if(check.equals("true")||check==null){
		secret=1;
	}
	//질문이 변경
	QuestionVO q=new QuestionVO();
	q.setQno(qno);
	q.setQcontent(qcontent);
	q.setQpassword(qpassword);
	q.setQtitle(qtitle);
	q.setSecret(secret);
	QuestionDAO dao=QuestionDAO.getInstance();
	int re=dao.updateQuestion(q);
	
	//답변삭제
	AnswerDAO a=AnswerDAO.getInstance();
	int re2=a.deleteAnswer(qno);
	
	
	out.print(re);
%>