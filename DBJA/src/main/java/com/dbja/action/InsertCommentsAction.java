package com.dbja.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.PostDAO;
import com.dbja.vo.CommentsVO;
import com.dbja.vo.DetailPostVO;

public class InsertCommentsAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = "teddie1";
		HttpSession session = request.getSession();
		
		PostDAO pdao = PostDAO.getInstance();
		int postno = Integer.parseInt(request.getParameter("postno"));
		String c_comment = null;
		
		CommentsVO c = pdao.checkComments(postno, id);
		if(c == null) { // comment가 없으면 등록
			if(request.getParameter("c_comment") != null) {
	
				c_comment = request.getParameter("c_comment");
				int re = pdao.insertComments(postno, c_comment, id);
			}
		}
		else { // comment가 있으면 수정
			if(request.getParameter("c_comment") != null) {
				c_comment = request.getParameter("c_comment");
				int re = pdao.updateComments(postno, c_comment, id);
			}
		}
		

		DetailPostVO p = pdao.findByPno(postno);
		ArrayList<CommentsVO> list = pdao.findCommentsByPostNo(postno);
		request.setAttribute("p", p);
		request.setAttribute("postno", postno);
		request.setAttribute("list", list);
		
		return "detailPost.jsp";
	}

}
