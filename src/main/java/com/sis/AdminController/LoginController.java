package com.sis.AdminController;

import com.sis.common.BaseResponse;
import com.sis.common.CodeConstraint;
import com.sis.model.AdminUser;
import com.sis.service.AdminUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    AdminUserService adminUserService;

    @RequestMapping("/login/login")
    public ModelAndView login(){
        ModelAndView modelAndView =new ModelAndView();
        modelAndView.setViewName("login/login");
        return modelAndView;
    }

    @RequestMapping(value = "/login/doLogin",method = RequestMethod.POST)
    @ResponseBody
    public Object doLogin(String username, String password, HttpSession session){
        BaseResponse resp  = new BaseResponse();
        resp.setCode(CodeConstraint.SUCCESS);
        resp.setInfo("success");
        AdminUser adminUser = adminUserService.queryByLogin(username,password);
        if(null!=adminUser){
            session.setAttribute("loginUser",adminUser);
        }else{
            resp.setCode(CodeConstraint.LOGINERROR);
            resp.setInfo("账户或者密码错误");
        }
        return resp;
    }

    @RequestMapping("/login/logout")
    public ModelAndView logout(HttpSession session){
        session.removeAttribute("loginUser");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("redirect:/login/login");
        return modelAndView;
    }
}
