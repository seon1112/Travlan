package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.MyPageDAO;
import com.dbja.vo.TravelListVO;


public class ListMemberInfoAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		
		MyPageDAO m=MyPageDAO.getInstance();
		request.setAttribute("info", m.findInfo(id));
		request.setAttribute("travelList", m.findTravelList(id));
		request.setAttribute("heart", m.findHeart(id));
		return "listMemberInfo.jsp";
	}

}
