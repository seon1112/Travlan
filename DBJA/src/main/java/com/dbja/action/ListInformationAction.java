package com.dbja.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.HeartListDAO;
import com.dbja.dao.InformationDAO;
import com.dbja.vo.InformationVO;

public class ListInformationAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String id = "teddie1";
		InformationDAO dao = InformationDAO.getInstance();
		HeartListDAO hdao = HeartListDAO.getInstance();

		String sort = null;
		String keyword = null;
		int pageNUM = 1;
		int firstPage = 1;
		int lastPage = 9;
		
		if(request.getParameter("pageNUM") != null) {
			pageNUM = Integer.parseInt(request.getParameter("pageNUM"));
		}
		
		if(request.getParameter("firstPage") != null) {
			firstPage = Integer.parseInt(request.getParameter("firstPage"));
			System.out.println(firstPage);
		}
		
		if(request.getParameter("lastPage") != null) {
			lastPage = Integer.parseInt(request.getParameter("lastPage"));
		}
		
		if(session.getAttribute("sort") != null) {
			sort = (String)session.getAttribute("sort");
		}
		
		if(session.getAttribute("keyword") != null) {
			keyword = (String)session.getAttribute("keyword");
		}
		if(request.getParameter("sort") != null) {
			sort = request.getParameter("sort");
		}
		
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		
		
		ArrayList<InformationVO> list = dao.findAll(pageNUM, sort, keyword);
		int totalPage =  dao.totalPage; // 10
		
		String goPage = request.getParameter("goPage");
		if(goPage != null) {
			if(goPage.equals("다음")) {
					if(pageNUM <= totalPage) {
						firstPage = (firstPage/10+1)*10;
						pageNUM = firstPage;
						list = dao.findAll(pageNUM, sort, keyword);
					}
					else {
						pageNUM = totalPage;
						list = dao.findAll(pageNUM, sort, keyword);
					}
			}
			else if (goPage.equals("이전")){ // 이전 클릭 시
				System.out.println("firstPage: "+firstPage);
				System.out.println("lastPage: " +lastPage);
				System.out.println("PAGEnum: " +pageNUM);
				if(firstPage == 10) {
					firstPage = 1;
				}
				else if(firstPage == 1) {
				}
				else {
					firstPage = (firstPage/10-1) * 10;
				}
			}
			
			else { // 마지막 클릭 시
				if(totalPage < 10) {
					firstPage = totalPage/10*10+1;
				}
				else {
					firstPage = totalPage/10*10;
				}
				pageNUM = totalPage;
				list = dao.findAll(pageNUM, sort, keyword);
			}
			lastPage = firstPage/10*10+9;
		}
		
		if(pageNUM >= 10 && (firstPage==1 || lastPage==9)) {
			firstPage = pageNUM;
			lastPage = firstPage+9;
		}
		
		/* 평점계산 */
		request.setAttribute("list", list);
		session.setAttribute("keyword", keyword);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("firstPage", firstPage);
		request.setAttribute("lastPage", lastPage); // 9
		return "listInformation.jsp";
	}

}
