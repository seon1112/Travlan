package com.dbja.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.PostDAO;
import com.dbja.vo.CommentsVO;
import com.dbja.vo.DetailPostVO;
import com.dbja.vo.PostVO;

public class DetailPostAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = "teddie1;";
		PostDAO pdao = PostDAO.getInstance();
		
		int postno = Integer.parseInt(request.getParameter("postno"));
		DetailPostVO p = pdao.findByPno(postno);
		ArrayList<CommentsVO> list = pdao.findCommentsByPostNo(postno);
		request.setAttribute("p", p);
		request.setAttribute("list", list);
		return "detailPost.jsp";
	}

}
