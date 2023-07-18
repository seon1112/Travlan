package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.MemberDAO;

public class ResetPasswordAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String view ="";
		
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String newPwd = request.getParameter("newPwd");
		String newPwdCheck = request.getParameter("newPwdCheck");
		System.out.println("id : "+id);
		System.out.println("newPwd : "+newPwd);
		System.out.println("newPwdCheck : "+newPwdCheck);
		
		if(newPwd.equals(newPwdCheck)) {
			//비밀번호랑 비밀번호 확인이랑 동일.
			//dao.updatePwd 진행
			//유효성검사 적합하면 resetPasswordSuccess.jsp 로 보내
			//유효성검사 부적합하면 resetPassword.jsp로 보내
			MemberDAO dao = MemberDAO.getInstance();
			int re = dao.updatePwd(id, newPwd);
			System.out.println("re : "+re);
			
			if(re==1) {
				//업데이트 성공-유효성 검사 적합
				view="resetPasswordSuccess.jsp";
			}else {
				//업데이트 실패-유효성 검사 부적합
				view = "resetPassword.jsp";
				request.setAttribute("msg", "비밀번호는 문자,숫자,특수문자 포함 10~20자 입니다.");
			}
		}else {
			//비밀번호랑 비밀번호 확인이랑 다름.
			//업데이트 진행 안하고
			//다시 resetPassword.jsp 로 보내
			view = "resetPassword.jsp";
			request.setAttribute("msg", "비밀번호와 비밀번호 확인이 다릅니다.");
		}

		return view;
	}
}
