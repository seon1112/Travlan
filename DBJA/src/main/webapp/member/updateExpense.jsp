<%@page import="com.dbja.vo.ExpenseVO"%>
<%@page import="com.dbja.dao.ExpenseDAO"%>
<%@page import="com.dbja.vo.TravelListVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
>
<%
	int defaultValue=0; // 기본값 설정
	int real=0;
	int expect=0;
	if(!request.getParameter("expect").equals("")){
		 expect=Integer.parseInt(request.getParameter("expect"));
	}else{
		 expect = defaultValue; // 기본값 설정
	}
	request.setCharacterEncoding("utf-8");
	String adate=request.getParameter("adate");
	int tno=Integer.parseInt(request.getParameter("tno"));
	int ano=Integer.parseInt(request.getParameter("ano"));
	String id=request.getParameter("id");
	
	String category=request.getParameter("categroy");
	String payment=request.getParameter("payment");
	String memo=request.getParameter("memo");
	if(!request.getParameter("real").equals("")){
		real=Integer.parseInt(request.getParameter("real"));
	}else{
		 real = defaultValue; // 기본값 설정
	}
	 
	int sno=Integer.parseInt(request.getParameter("sno"));
	
	
	ExpenseDAO dao=ExpenseDAO.getInstance();
	ExpenseVO v=new ExpenseVO();
	v.setAdate(adate);
	v.setAno(ano);
	v.setCategory(category);
	v.setExpect(expect);
	v.setId(id);
	v.setMemo(memo);
	v.setPayment(payment);
	v.setReal(real);
	v.setTno(tno);
	v.setSno(sno);
	
	int re=dao.updateExpense(v);
	out.print(re);
%>
