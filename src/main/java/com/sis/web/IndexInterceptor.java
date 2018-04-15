package com.sis.web;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//现在未启用
public class IndexInterceptor extends HandlerInterceptorAdapter {
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
		String hiddenShowIndexIs="1";
		if("1".equals(hiddenShowIndexIs)) {
			/*response.sendRedirect(request.getContextPath() + "/wh.jsp");*/
			request.getRequestDispatcher("wh.jsp").forward(request,response);
			response.sendRedirect("wh.jsp");
		}
		return super.preHandle(request, response, handler);
	}
}
