package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.PostDAO;
import com.dbja.vo.PostVO;

public class ListPostAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");			//문자 인코딩
		HttpSession session = request.getSession();

		PostDAO dao = PostDAO.getInstance();			//다오 생성
		String id="teddie1";
		String keyword = null;

		
		if(session.getAttribute("keyword") != null) {
			keyword = (String)session.getAttribute("keyword");
		}
		
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		
		request.setAttribute("list", dao.findAll(keyword));	
		session.setAttribute("keyword", keyword);

		return "listPost.jsp";
	}

}
