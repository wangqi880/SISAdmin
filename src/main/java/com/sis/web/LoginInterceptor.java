package com.sis.web;

import com.sis.model.AdminUser;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();
		if(session==null){
			String s = request.getContextPath();
			response.sendRedirect(request.getContextPath()+"/login");
		}
		AdminUser user = (AdminUser)session.getAttribute("loginUser");
		if(user==null) {
			String s = request.getContextPath();
			response.sendRedirect(request.getContextPath()+"/login/login");
			return false;
		} else {
			/*boolean isAdmin = (Boolean)session.getAttribute("isAdmin");
			if(!isAdmin) {
				//不是超级管理人员，就需要判断是否有权限访问某些功能

			}*/
		}
		return super.preHandle(request, response, handler);
	}
}
