package com.dbja.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.HeartListDAO;
import com.dbja.dao.InformationDAO;
import com.dbja.dao.ReviewDAO;
import com.dbja.vo.InformationVO;
import com.dbja.vo.ReviewVO;

public class InsertReviewAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		int ino = Integer.parseInt(request.getParameter("ino"));
		String id = "teddie1";
		int grade = -1;
		String rcontent = null;
		HeartListDAO hdao = HeartListDAO.getInstance();
		InformationDAO dao = InformationDAO.getInstance();
		InformationVO i = dao.findByIno(ino);
		ReviewDAO rdao = ReviewDAO.getInstance();
		boolean re = hdao.checkHeartList(id, i.getIno());
		

		if(request.getParameter("grade") != null) {
			grade = Integer.parseInt(request.getParameter("grade"));
			if(rdao.checkReview(id, ino) == null) {
				if(request.getParameter("rcontent") != null) {
					rcontent = (String) request.getParameter("rcontent");
					rdao.insertReview(id, ino, rcontent, grade);
					i = dao.findByIno(ino);
				}
			}
			else {
				if(request.getParameter("rcontent") != null) {
					rcontent = (String) request.getParameter("rcontent");
					rdao.updateReview(id, ino, rcontent, grade);
					i = dao.findByIno(ino);
					
				}
			}
		}
		ArrayList<ReviewVO> list2 = rdao.findByIno(ino);

		request.setAttribute("heart", re);
		request.setAttribute("i", i);
		request.setAttribute("re", re);
		request.setAttribute("ino", ino);
		request.setAttribute("list2", list2);
		return "detailInformation.jsp";
	}

}
