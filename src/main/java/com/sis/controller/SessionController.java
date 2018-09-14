package com.sis.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Enumeration;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/index")
@Api(value = "session相关接口",tags={"session相关接口"} )
public class SessionController {

    /**
     * 清session
     * @return
     */
    @ApiOperation(value = "清session",notes = "清session")
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
