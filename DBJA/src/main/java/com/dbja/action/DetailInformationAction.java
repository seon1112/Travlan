package com.dbja.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.HeartListDAO;
import com.dbja.dao.InformationDAO;
import com.dbja.dao.ReviewDAO;
import com.dbja.vo.InformationVO;
import com.dbja.vo.ReviewVO;

public class DetailInformationAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();

		String id = "teddie1";
		HeartListDAO hdao = HeartListDAO.getInstance();
		InformationDAO dao = InformationDAO.getInstance();
		dao.updateClick(Integer.parseInt(request.getParameter("ino")));

		InformationVO i = dao.findByIno(Integer.parseInt(request.getParameter("ino")));
		int ino = i.getIno();
		boolean re = hdao.checkHeartList(id, i.getIno());
		if(request.getParameter("heart") != null) { // heart 클릭 전
			if(request.getParameter("heart").equals("true")) {
				int re3 = hdao.deleteHeartList(id, ino);
				if(re3 != -1) {
					re = hdao.checkHeartList(id, ino);
				}
				request.setAttribute("heart", "false");
			}
			else {
				if(!hdao.checkHeartList(id, ino)) {
					int re2 = hdao.insertHeartList(id, ino);
					if(re2 != -1) { // 추가 성공
						re = hdao.checkHeartList(id, ino);
					}
					else { // 추가 실패
						
					}
					request.setAttribute("heart", "true");
				}
			}
			
		}
		
		ReviewDAO rdao = ReviewDAO.getInstance();
		ArrayList<ReviewVO> list2 = rdao.findByIno(ino);
		
		request.setAttribute("heart", re);
		request.setAttribute("i", i);
		request.setAttribute("list2", list2);
		request.setAttribute("re", re);
		return "detailInformation.jsp";

	}
	
	

}

