package com.sis.controller;

import com.sis.util.HttpClientUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RequestMapping("/area")
@Api(value = "机构区域相关接口",tags={"机构区域相关接口"} )
@RestController
public class AreaController {

    /**
     * 机构区域
     * @return
     */
    @ApiOperation(value = "机构区域列表",notes = "机构区域列表",response = String.class)
    @RequestMapping(value = "/list.do",method = RequestMethod.GET)
    public String getAreaList()
    {
        String url = "/api/areaList.do";
        Map<String,String> param = new HashMap<>();
        param.put("siteId","531B601029F97174012A0D3D396600B2");
        String result = HttpClientUtil.sendHttpGet(url,param);
        return result;
    }

}
