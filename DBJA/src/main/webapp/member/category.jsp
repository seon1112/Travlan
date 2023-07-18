
<%@page import="com.google.gson.Gson"%>
<%@page import="com.dbja.vo.ExpenseVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.dbja.dao.ExpenseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	int tno=Integer.parseInt(request.getParameter("tno"));
	
	ExpenseDAO dao=ExpenseDAO.getInstance();
	ArrayList<ExpenseVO>list=new ArrayList<>();
	list=dao.category(id, tno);
	Gson gson=new Gson();
	String str=gson.toJson(list);
	out.print(str);


%>
