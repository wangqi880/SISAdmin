package com.sis.controller;

import com.sis.util.HttpClientUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/code")
public class CodeController {

    /**
     * 发送短信验证码
     * @return
     */
    @RequestMapping("/send")
    @ResponseBody
    public String sendCode()
    {
        String url = "/api/smsCode.do";
        Map<String,String> param = new HashMap<>();
        param.put("studentId","96677B8A0976B510E040007F010062C0");
        param.put("siteId","531B601029153CBE0129165AF7C00040");
        param.put("smsCode","");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }
}
