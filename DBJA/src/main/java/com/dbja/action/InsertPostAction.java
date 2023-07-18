package com.dbja.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.PostDAO;
import com.dbja.dao.TravelListDAO;
import com.dbja.vo.DetailPostVO;
import com.dbja.vo.TravelListVO;

public class InsertPostAction implements DbjaAction {
	/* 로그인필요 */
	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = "teddie1";

		TravelListDAO tdao = TravelListDAO.getInstance();
		ArrayList<TravelListVO> list = tdao.findById(id);
		request.setAttribute("list", list);
		return "insertPost.jsp";
	
	}

}
