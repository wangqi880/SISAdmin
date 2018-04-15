package com.sis.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Enumeration;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/index")
public class SessionController {

    /**
     * 清session
     * @return
     */
    @RequestMapping("/clearSession")
    @ResponseBody
    public String clearSession(HttpSession session)
    {
    	 Enumeration em = session.getAttributeNames();
    	 while(em.hasMoreElements()){
    		  session.removeAttribute(em.nextElement().toString());
    	 }
        return "SUCCESS";
    }
}
