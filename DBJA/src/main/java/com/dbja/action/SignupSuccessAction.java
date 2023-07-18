package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.MemberDAO;

public class SignupSuccessAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String view ="";
		
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String birth = request.getParameter("birth");
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		String pwdCheck = request.getParameter("pwdCheck");
		System.out.println("id : "+id);
		System.out.println("name : "+name);
		System.out.println("birth : "+birth);
		System.out.println("email : "+email);
		System.out.println("pwd : "+pwd);
		System.out.println("pwdCheck : "+pwdCheck);
		MemberDAO dao = MemberDAO.getInstance();
		
		if(dao.isBirthValid(birth)) {
			boolean b = dao.isBirthValid(birth);
			System.out.println("booleanBirth :"+b);
			
			//생일 유효성 검사 통과 성공
			//비밀번호 확인 후 가입 진행
			if(pwd.equals(pwdCheck)) {
				//비밀번호랑 비밀번호 확인이랑 동일.
				//dao.insertMember 진행
				//유효성검사 적합하면 signupSuccess.jsp 로 보내
				//유효성검사 부적합하면 signup.jsp로 보내
				int re = dao.insertMember(id,pwd,name,birth,email);
				System.out.println("re : "+re);
				
				if(re==1) {
					//업데이트 성공-유효성 검사 적합
					view="signupSuccess.jsp";
				}else {
					//업데이트 실패-유효성 검사 부적합
					view = "signup.jsp";
					request.setAttribute("msg", "비밀번호는 문자,숫자,특수문자 포함 10~20자 입니다.");
				}
			}else {
				//비밀번호랑 비밀번호 확인이랑 다름.
				//업데이트 진행 안하고
				//다시 signup.jsp 로 보내
				view = "signup.jsp";
				request.setAttribute("msg", "비밀번호와 비밀번호 확인이 다릅니다.");
			}
		}else {
			//생일 유효성 검사 통과 실패
			//생년월일 양식 불일치 메세지
			//signup.jsp 로 보내
			request.setAttribute("msg", "생년월일이 올바르지 않습니다.");
			view="signup.jsp";
		}
		
		
		return view;
	}
}
