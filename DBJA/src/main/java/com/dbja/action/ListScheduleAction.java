package com.dbja.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.FriendListDAO;
import com.dbja.dao.PostDAO;
import com.dbja.dao.ScheduleDAO;
import com.dbja.vo.PostVO;
import com.dbja.vo.ScheduleVO;
import com.dbja.vo.TravelListVO;

public class ListScheduleAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		String id=request.getParameter("id");
		int tno = Integer.parseInt(request.getParameter("tno"));
		session.setAttribute("id", id);
		session.setAttribute("tno", tno);
		
		ScheduleDAO s=ScheduleDAO.getInstance();
		request.setAttribute("travel", s.findByTno(tno));
		request.setAttribute("schedule", s.findAll(tno));
		
		FriendListDAO f=FriendListDAO.getInstance();
		request.setAttribute("friend", f.friendList(tno));
		request.setAttribute("id", id);
		request.setAttribute("tno", tno);
		return "listSchedule.jsp";
	}

}
