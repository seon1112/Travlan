<%@page import="com.dbja.dao.TravelListDAO"%>
<%@page import="com.dbja.vo.TravelListVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int tno=Integer.parseInt(request.getParameter("tno"));
	String tname=request.getParameter("tname");
	String tstart=request.getParameter("tstart");
	String tend=request.getParameter("tend");
	int budget=Integer.parseInt(request.getParameter("budget"));
	TravelListVO t= new TravelListVO();
	t.setTno(tno);
	t.setTname(tname);
	t.setTstart(tstart);
	t.setTend(tend);
	t.setBudget(budget);
	TravelListDAO dao=TravelListDAO.getInstance();
	int re=dao.updateTravelList(t);
	out.print(re);
%>