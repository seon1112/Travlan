<%@page import="com.dbja.dao.ExpenseDAO"%>
<%@page import="com.dbja.vo.ExpenseVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int defaultValue=0; // 기본값 설정
	int real=0;
	int expect=0;
	request.setCharacterEncoding("utf-8");
	String tdate=request.getParameter("tdate");
	System.out.println("expect:"+request.getParameter("expect"));
	if(!request.getParameter("expect").equals("")){
		 expect=Integer.parseInt(request.getParameter("expect"));
	}else{
		 expect = defaultValue; // 기본값 설정
	}
	String category=request.getParameter("selectCategory");
	String payment=request.getParameter("selectPayment");
	String memo=request.getParameter("memo");
	if(!request.getParameter("real").equals("")){
		real=Integer.parseInt(request.getParameter("real"));
	}else{
		 real = defaultValue; // 기본값 설정
	}

	int tno=Integer.parseInt(request.getParameter("tno"));
	String id=request.getParameter("id");
	
	session.setAttribute("id", id);
	session.setAttribute("tno", tno);
	

	ExpenseVO e=new ExpenseVO();
	e.setAdate(tdate);
	e.setExpect(expect);
	e.setCategory(category);
	e.setPayment(payment);
	e.setMemo(memo);
	e.setReal(real);
	e.setTno(tno);
	e.setId(id);
	
	ExpenseDAO dao=ExpenseDAO.getInstance();
	int re=dao.insertExpense(e);
	out.print(re);
%>