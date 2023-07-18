package com.dbja.controller;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbja.action.DbjaAction;

/**
 * Servlet implementation class SistController
 */
@WebServlet("*.do")
public class DbjaController extends HttpServlet {
	
	HashMap<String, DbjaAction> map;
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DbjaController() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    
    
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		map = new HashMap<String, DbjaAction>();
		String path = config.getServletContext().getRealPath("WEB-INF");
		try {
			FileReader fr = new FileReader(path +"/dbja.properties");
			Properties prop = new Properties();
			prop.load(fr);
			Iterator key_list= prop.keySet().iterator();
			while(key_list.hasNext()) {
				String key = (String)key_list.next();
				String clsName = prop.getProperty(key);
				System.out.println("key:"+key);
				System.out.println("clsName:"+clsName);
				System.out.println("----------------------");
				DbjaAction action = (DbjaAction)Class.forName(clsName).newInstance();
				map.put(key, action);
			}
			System.out.println(map);
			fr.close();
		}catch (Exception e) {
			System.out.println("예외발생:"+e.getMessage());
		}
	}

	private void pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// TODO Auto-generated method stub
		String uri = request.getRequestURI();
		System.out.println("uri:"+uri);
//		/day0616/listBoard.do
//		/day0616/member/login.do
		
		int first = uri.indexOf("/")+1;
		String cmd =  uri.substring(uri.indexOf("/", first)+1);
		System.out.println("cmd:"+cmd);
		//String cmd = uri.substring(uri.lastIndexOf("/")+1);
		
		DbjaAction action = map.get(cmd);
		String view  = action.pro(request, response);
		System.out.println("view : "+view);
		//뷰페이지가 listGoods.jsp일때에 
		//세션을 완전히 파기합니다.
		//세션을 완전히 파기하면
		//모든 상태유지가 제거되기 때문
		//로그아웃할때만 사용하기를 권장합니다.
		
			request.setAttribute("viewPage", view);
			RequestDispatcher dispatcher = request.getRequestDispatcher("template.jsp");
			dispatcher.forward(request, response);
	}


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		pro(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		pro(request, response);
	}


	
}
