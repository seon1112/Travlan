package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.dao.PostDAO;
import com.dbja.dao.TravelListDAO;
import com.dbja.vo.DetailPostVO;
import com.oreilly.servlet.MultipartRequest;

public class InsertPostOKAction implements DbjaAction {
	/* 로그인필요 */
	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = "teddie1";
		String path = request.getRealPath("assets");
		System.out.println("path:"+path);
		
		MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*5, "utf-8");
		PostDAO pdao = PostDAO.getInstance();
		TravelListDAO tdao = TravelListDAO.getInstance();
		String tname = multi.getParameter("tname");

		int tno = tdao.findTnoByTname(tname);
		if(multi.getParameter("hashtags") != null && multi.getParameter("pcontent") != null) {
			String hashtags = multi.getParameter("hashtags");
			String pcontent = multi.getParameter("pcontent");
			String p_pic = multi.getFilesystemName("p_pic");
			int postno = pdao.getPostno();
			System.out.println(p_pic);
			pdao.insertPost(hashtags, pcontent, tno, id, p_pic);
			
			request.setAttribute("postno", postno);
			DetailPostVO p = pdao.findByPno(postno);
			request.setAttribute("p", p);
			return "detailPost.jsp";

		}
		else {
			return "insertPost.jsp";
		}
		
	}

}
