<%@page import="com.dbja.dao.ScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int tno=Integer.parseInt(request.getParameter("tno"));
	int sno=Integer.parseInt(request.getParameter("sno"));
	
	ScheduleDAO dao=ScheduleDAO.getInstance();
	int re=dao.deleteAccountBySchedule(tno, sno);
	int re2=dao.deleteSchedule(tno, sno);
	
	out.print(re);		
			
%>