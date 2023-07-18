package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.PostDAO;

public class DeletePostAction implements DbjaAction {
	/* 로그인필요 */
	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");			//문자 인코딩
		HttpSession session = request.getSession();

		PostDAO dao = PostDAO.getInstance();			//다오 생성
		String id="teddie1";
		String keyword = null;

		int re = dao.deletePost(Integer.parseInt(request.getParameter("postno")), id);
		
		request.setAttribute("list", dao.findAll(keyword));	
		session.setAttribute("keyword", keyword);
		return "listPost.jsp";
	}

}
