
<%@page import="com.google.gson.Gson"%>
<%@page import="com.dbja.dao.ExpenseDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
    int tno=Integer.parseInt(request.getParameter("tno"));
	String id=request.getParameter("id");
	ExpenseDAO dao=ExpenseDAO.getInstance();
	ArrayList<String>list=dao.findDay(id, tno);
	Gson gson = new Gson();
	String str = gson.toJson(list);
	out.print(str);
   
%>