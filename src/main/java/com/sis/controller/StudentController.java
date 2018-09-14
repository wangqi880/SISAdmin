package com.sis.controller;

import com.sis.util.HttpClientUtil;
import io.swagger.annotations.Api;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import springfox.documentation.annotations.ApiIgnore;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/student")
public class StudentController {

    /**
     * 学生信息
     * @return
     */
    @ApiIgnore
    @RequestMapping("/info")
    @ResponseBody
    public String getStudentInfo()
    {
        String url = "/api/studentinfo.do";
        Map<String,String> param = new HashMap<>();
        param.put("userName","杨一");
        param.put("userMobile","13057922980");
        param.put("siteId","531B601029153CBE0129165AF7C00040");
        param.put("appKey","f58f9540c36111e7abc4cec278b6b50a");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }

    /**
     * 学生报名班级列表
     * @return
     */
    @ApiIgnore
    @RequestMapping("/clazzList")
    @ResponseBody
    public String getStudentClazzList()
    {
        String url = "/api/studentClazzList.do";
        Map<String,String> param = new HashMap<>();
        param.put("studentId","96677B8A0976B510E040007F010062C0");
//        param.put("status","");
        param.put("siteId","531B601029153CBE0129165AF7C00040");
//        param.put("pageNo","1");
//        param.put("keyWords","");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }

    /**
     * 学生报名班级详情
     * @return
     */
    @ApiIgnore
    @RequestMapping("/clazzView")
    @ResponseBody
    public String getStudentClazzView()
    {
        String url = "/api/studentClazzView.do";
        Map<String,String> param = new HashMap<>();
        param.put("studentId","96677B8A0976B510E040007F010062C0");
        param.put("siteId","531B601029153CBE0129165AF7C00040");
        param.put("reserveNo","");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }
}
