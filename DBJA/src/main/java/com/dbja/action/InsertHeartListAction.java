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

public class InsertHeartListAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = "teddie1";
		HttpSession session = request.getSession();
		
		HeartListDAO hdao = HeartListDAO.getInstance();
		InformationDAO dao = InformationDAO.getInstance();
		InformationVO i = dao.findByIno(Integer.parseInt(request.getParameter("ino")));
		int ino = i.getIno();
		boolean re = hdao.checkHeartList(id, i.getIno());
		if(re) { // heart가 true일 때
			int re3 = hdao.deleteHeartList(id, ino);
			if(re3 != -1) {
				re = hdao.checkHeartList(id, ino);
			}
			else {
				
			}
		}
		else { // heart가 false일 때
			int re2 = hdao.insertHeartList(id, ino);
			if(re2 != -1) { // 추가 성공
				re = hdao.checkHeartList(id, ino);
			}
			else { // 추가 실패
			}
		}
		
		ReviewDAO rdao = ReviewDAO.getInstance();
		ArrayList<ReviewVO> list2 = rdao.findByIno(ino);
		
		request.setAttribute("i", i);
		request.setAttribute("list2", list2);
		session.setAttribute("re", re);
		return "detailInformation.jsp";
	}

}
