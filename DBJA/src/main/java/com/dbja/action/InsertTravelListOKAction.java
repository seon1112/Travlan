package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.TravelListDAO;
import com.dbja.vo.TravelListVO;

public class InsertTravelListOKAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TravelListVO t = new TravelListVO();
		TravelListDAO dao = TravelListDAO.getInstance();	
		int re = dao.insertTravelList(t);
		if(re == 1) {
			request.setAttribute("msg", "여행 일정 등록 성공!");
		}else {
			request.setAttribute("msg", "여행 일정 등록 실패!");
		}
		
		return "travelList.jsp";
	}

}
