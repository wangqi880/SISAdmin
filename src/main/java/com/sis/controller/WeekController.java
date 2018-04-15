package com.sis.controller;

import com.sis.util.HttpClientUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/week")
public class WeekController {

    /**
     * 时间段
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public String getWeekList()
    {
        String url = "/api/weekList.do";
        Map<String,String> param = new HashMap<>();
        param.put("siteId","531B601029153CBE0129165AF7C00040");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }
}
