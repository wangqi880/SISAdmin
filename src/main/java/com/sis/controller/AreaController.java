package com.sis.controller;

import com.sis.util.HttpClientUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/area")
public class AreaController {

    /**
     * 机构区域
     * @return
     */
    @RequestMapping("/list.do")
    public String getAreaList()
    {
        String url = "/api/areaList.do";
        Map<String,String> param = new HashMap<>();
        param.put("siteId","531B601029F97174012A0D3D396600B2");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }

}
