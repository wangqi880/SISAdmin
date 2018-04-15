package com.sis.controller;

import com.sis.util.HttpClientUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/clazz")
public class ClazzController {

    /**
     * 培训课程列表
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public String getClazzList()
    {
        String url = "/api/clazzList.do";
        Map<String,String> param = new HashMap<>();
        param.put("siteId","531B601029153CBE0129165AF7C00040");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }

    /**
     *课程详情
     * @return
     */
    @RequestMapping("/view")
    @ResponseBody
    public String getClazzView()
    {
        String url = "/api/clazzView.do";
        Map<String,String> param = new HashMap<>();
        param.put("siteId","531B601029153CBE0129165AF7C00040");
        param.put("id","");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }

}
