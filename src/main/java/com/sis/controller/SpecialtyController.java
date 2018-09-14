package com.sis.controller;

import com.sis.util.HttpClientUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/specialty")
@Api(value = "专业相关接口",tags={"专业相关接口"} )
public class SpecialtyController {

    /**
     * 专业分类
     * @return
     */
    @ApiOperation(value = "专业分类",notes = "专业分类")
    @RequestMapping(value = "/list",method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String getSpecialtyList()
    {
        String url = "/api/specialtyList.do";
        Map<String,String> param = new HashMap<>();
        param.put("siteId","531B601029153CBE0129165AF7C00040");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }
}
