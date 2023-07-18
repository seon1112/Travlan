package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.MemberDAO;

public class ForgotPasswordOKAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String view = "resetPassword.jsp";
		
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		System.out.println("id : "+id);
		System.out.println("pwd : "+name);
		System.out.println("email : "+email);
		MemberDAO dao = MemberDAO.getInstance();
		String dbPwd = dao.findPwd(id, name, email);
		
		if(dbPwd==null) {
			view = "forgotPassword.jsp";
			request.setAttribute("msg", "일치하는 정보가 없습니다.");
		}else {
		}
		return view;
	}
}
