package com.dbja.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface DbjaAction {
	public String pro(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException ;
	
}
