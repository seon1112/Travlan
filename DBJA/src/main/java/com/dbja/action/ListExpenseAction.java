package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.ExpenseDAO;

public class ListExpenseAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		
		ExpenseDAO dao=ExpenseDAO.getInstance();
		String id=request.getParameter("id");
		int tno = Integer.parseInt(request.getParameter("tno"));
		session.setAttribute("id", id);
		session.setAttribute("tno", tno);
		String adate=null;
		if(request.getParameter("adate")!=null) {
			adate=request.getParameter("adate");
		}
		String colum=null;
		String keyword=null;
		
		if(request.getParameter("selectColum")!=null) {
			colum=request.getParameter("selectColum");
			System.out.println(colum);
		}
		if(request.getParameter("keyword")!=null) {
			keyword=request.getParameter("keyword");
			System.out.println(keyword);
		}
		//여행 이름, 일정 출력
		request.setAttribute("tnameAndtdate", dao.tnameAndTdate(tno));
		
		//전체 목록 출력
		request.setAttribute("list", dao.findAll(id	, tno,adate,colum,keyword));
		
		//전체 사용금액 출력
		int total=dao.totalExpense(id, tno,adate,colum,keyword);
		request.setAttribute("totalExpense", total);
		//예산 출력
		int budget=dao.budget(tno);
		request.setAttribute("buget", budget);
		//예산 대비 남은 금액
		int remain=budget-total;
		request.setAttribute("remain", remain);
		//예산 대비 전체 사용금액 퍼센트
		double percent=(Math.round((double)total/budget * 10.0) / 10.0)*100;
		request.setAttribute("percent", percent);
		
		request.setAttribute("id", id);
		request.setAttribute("tno", tno);
		
		return "bookPage.jsp";
	}

}
