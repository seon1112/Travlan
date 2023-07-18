package com.dbja.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbja.dao.InformationDAO;
import com.dbja.dao.MemberDAO;
import com.dbja.vo.InformationVO;

public class LoginOKAction implements DbjaAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String view = "main.jsp";
		
		//아이디 비번 받아온거 멤버확인
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		MemberDAO dao = MemberDAO.getInstance();
		int re = dao.isMember(id, pwd);
		
		//인기여행지 top5 불러와서 상태유지
		InformationDAO daoInfo = InformationDAO.getInstance();
		ArrayList<InformationVO> list = daoInfo.InformationTop5();
		InformationVO top1 = list.get(0);
		InformationVO top2 = list.get(1);
		InformationVO top3 = list.get(2);
		InformationVO top4 = list.get(3);
		InformationVO top5 = list.get(4);
		request.setAttribute("top1", top1);
		request.setAttribute("top2", top2);
		request.setAttribute("top3", top3);
		request.setAttribute("top4", top4);
		request.setAttribute("top5", top5);
		
		//세션 생성
		HttpSession session = request.getSession();
		if(re!=1) {
			//1이 아니면 로그인 실패니까 일단 login.jsp 로 보내는거 확정
			view = "login.jsp";
			if(re==0) {
				//0이면 암호 틀림
				request.setAttribute("msg", "암호가 올바르지 않습니다.");
			}else {
				//1,0 다 아니면 ID 가 존재하지않음.
				request.setAttribute("msg", "존재하지 않는 ID입니다.");
			}
		}else {
			session.setAttribute("id", id);
			session.setAttribute("pwd", pwd);
		}
		return view;
	}
}