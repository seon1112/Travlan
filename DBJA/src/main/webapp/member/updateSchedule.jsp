<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@page import="com.dbja.dao.ScheduleDAO"%>
<%@page import="com.dbja.vo.ScheduleVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int defaultValue=0; // 기본값 설정
	int expect=0;
	int tno=Integer.parseInt(request.getParameter("tno"));
	int sno=Integer.parseInt(request.getParameter("sno"));
	String sdate=request.getParameter("sdate");
	String saddr=request.getParameter("saddr");
	String stime=request.getParameter("stime");
	String sname=request.getParameter("sname");
	String category=request.getParameter("category");
	if(!request.getParameter("expect").equals("")){
		 expect=Integer.parseInt(request.getParameter("expect"));
	}else{
		 expect = defaultValue; // 기본값 설정
	}
	
	ScheduleVO s=new ScheduleVO();
	s.setTno(tno);
	s.setSname(sname);
	s.setSno(sno);
	s.setSaddr(saddr);
	s.setSdate(sdate);
	s.setStime(stime);
	s.setSname(sname);
	s.setCategory(category);
	s.setExpect(expect);
	ScheduleDAO dao=ScheduleDAO.getInstance();
	int re=dao.updateAccountBySchedule(s);
	int re2=dao.updateSchedule(s);
	out.print(re);
	
	
%>
