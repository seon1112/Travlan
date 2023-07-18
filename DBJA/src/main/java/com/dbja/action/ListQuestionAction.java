package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.QuestionDAO;

public class ListQuestionAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		String id=request.getParameter("id");
		session.setAttribute("id", id);
		int pageNUM=1;
		String columnQna=null;
		String keyword=null;
		if(request.getParameter("pageNUM")!=null) {
			pageNUM=Integer.parseInt(request.getParameter("pageNUM"));
		}
		if(request.getParameter("keyword")!=null) {
			keyword=request.getParameter("keyword");
		}
		if(request.getParameter("selectColumnQna")!=null) {
			columnQna=request.getParameter("selectColumnQna");
		}
		QuestionDAO dao=QuestionDAO.getInstance();
		
		request.setAttribute("list", dao.findAll(pageNUM,keyword,columnQna));
		request.setAttribute("noAnswer", dao.findNoAnswer());
		request.setAttribute("totalPage", dao.totalPage);
		return "qnaPage.jsp";
	}

}
