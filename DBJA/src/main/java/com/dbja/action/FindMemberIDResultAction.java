package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.MemberDAO;

public class FindMemberIDResultAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String view = "findMemberIDResult.jsp";
		
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		System.out.println("pwd : "+name);
		System.out.println("email : "+email);
		MemberDAO dao = MemberDAO.getInstance();
		String dbID = dao.findMemberID(name, email);
		
		if(dbID==null) {
			view = "findMemberID.jsp";
			request.setAttribute("msg", "일치하는 정보가 없습니다.");
		}else {
			request.setAttribute("id", dbID);
		}
		return view;
	}
}
