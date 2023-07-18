package com.dbja.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.InformationDAO;
import com.dbja.vo.InformationVO;

public class MainAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		InformationDAO dao = InformationDAO.getInstance();
		ArrayList<InformationVO> list = dao.InformationTop5();
		
		InformationVO top1 = list.get(0);
		InformationVO top2 = list.get(1);
		InformationVO top3 = list.get(2);
		InformationVO top4 = list.get(3);
		InformationVO top5 = list.get(4);
		System.out.println("--------------------"+top1.getLatitude()); 
		request.setAttribute("top1", top1);
		request.setAttribute("top2", top2);
		request.setAttribute("top3", top3);
		request.setAttribute("top4", top4);
		request.setAttribute("top5", top5);
		
		return "main.jsp";
	}

}
