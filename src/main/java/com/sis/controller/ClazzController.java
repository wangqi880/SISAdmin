package com.sis.controller;

import com.alibaba.fastjson.JSONObject;
import com.sis.column.ClazzSearch;
import com.sis.common.Constants;
import com.sis.model.ClassDetail;
import com.sis.util.AnalysisUtil;
import com.sis.util.HttpClientUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/clazz")
public class ClazzController {

    private final static Logger log = LoggerFactory.getLogger(ClazzController.class);
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

    /**
     * 根据班级代码查询班级信息
     * @param classNo
     * @return
     */
    @RequestMapping("/classSearch.do")
    @ResponseBody
    public JSONObject getClazzSearch(String classNo,HttpSession session)
    {
        JSONObject result = new JSONObject();
        Map<String,String> param = new HashMap<>();
        param.put("siteId",Constants.SITE_ID);
        param.put("classNo",classNo);
        String str = HttpClientUtil.sendHttpGet(Constants.ClazzSearchUrl,param);
        ClazzSearch search = AnalysisUtil.analyClazzSearch(str);
        if(null == search)
        {
            result.put("code",0);
            result.put("msg","fail");
            return result;
        }
        ClassDetail classinfo = AnalysisUtil.searchToDetail(search);
        session.setAttribute("class",classinfo);
        log.info("当前班级信息："+classinfo.toString());
        result.put("code",1);
        result.put("msg","class_Info");
        return result;
    }

    /**
     * 班级信息页面跳转
     * @return
     */
    @RequestMapping("/classInfo.do")
    public String classInfoView()
    {
        return "class_info";
    }
}
