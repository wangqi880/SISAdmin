package com.sis.web;

import com.sis.common.GlobalContext;
import com.sis.service.ConfigService;
import com.sis.util.ConfigUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.context.support.XmlWebApplicationContext;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class IndexFilter implements Filter {


    ConfigService configService= (ConfigService) GlobalContext.getBean("configService");
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpServletRequest request =(HttpServletRequest)servletRequest;
        String hiddenShowIndexIs="0";
       /* if(null==configService){
            ServletContext sc = request.getSession().getServletContext();
            XmlWebApplicationContext cxt = (XmlWebApplicationContext) WebApplicationContextUtils.getWebApplicationContext(sc);
            if(cxt != null && cxt.getBean("configService") != null && null==configService)
                configService= (ConfigService) cxt.getBean("configService");
        }*/
           String value= configService.getConfigvalue(ConfigUtil.FIX_IS_SHOW);
           if(StringUtils.isNotEmpty(value)){
               hiddenShowIndexIs=value;
           }
        if("1".equals(hiddenShowIndexIs)) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/wh.jsp");
            dispatcher.forward(request, response);
            return;
        }else{
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
}
