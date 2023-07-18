<%@page import="com.dbja.dao.ExpenseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int tno=Integer.parseInt(request.getParameter("tno"));
	int ano=Integer.parseInt(request.getParameter("ano"));
	String id=request.getParameter("id");
	ExpenseDAO dao=ExpenseDAO.getInstance();
	int re=dao.deleteExpense(tno, id,ano);
	out.print(re);
%>