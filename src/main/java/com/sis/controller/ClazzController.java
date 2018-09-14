
package com.sis.controller;

import com.alibaba.fastjson.JSONObject;
import com.sis.column.ClazzSearch;
import com.sis.common.Constants;
import com.sis.model.ClassDetail;
import com.sis.util.AnalysisUtil;
import com.sis.util.HttpClientUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value = "课程相关接口",tags={"课程相关接口"} )
@ Controller
@ RequestMapping ("/clazz")
public class ClazzController
{
	private final static Logger log = LoggerFactory.getLogger(ClazzController.class);

	/**
	 * 培训课程列表
	 * @return
	 */
	@ApiOperation(value = "培训课程列表",notes = "培训课程列表",response = Map.class)
	@ RequestMapping (value = "/list",method = {RequestMethod.GET,RequestMethod.POST})
	@ ResponseBody
	public String getClazzList()
	{
		String url = "/api/clazzList.do";
		Map<String , String> param = new HashMap<>();
		param.put("siteId", "531B601029153CBE0129165AF7C00040");
		String result = HttpClientUtil.sendHttpGet(url, param);
		return result;
	}

	/**
	 * 课程详情
	 * @return
	 */
	@ApiIgnore
	@ RequestMapping ("/view")
	@ ResponseBody
	public String getClazzView()
	{
		String url = "/api/clazzView.do";
		Map<String , String> param = new HashMap<>();
		param.put("siteId", "531B601029153CBE0129165AF7C00040");
		param.put("id", "");
		String result = HttpClientUtil.sendHttpGet(url, param);
		return result;
	}

    /**
     * 根据班级代码查询班级信息
     * @param classNo
     * @return
     */
	@ApiOperation(value = "根据班级代码查询班级信息",notes = "根据班级代码查询班级信息",response = Map.class)
	@ApiImplicitParams({
			@ApiImplicitParam(name = "classNo",value = "班级code",dataType = "String")
	})
	@RequestMapping(value = "/classSearch.do",method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public JSONObject getClazzSearch(String classNo,HttpSession session)
    {
        JSONObject result = new JSONObject();
        Map<String,String> param = new HashMap<>();
        param.put("siteId",Constants.SITE_ID);
        param.put("classNo",classNo);
        String str = HttpClientUtil.sendHttpGet(Constants.ClazzSearchUrl,param);
        List<ClazzSearch> searchs = AnalysisUtil.analyClazzSearch(str);
        if(CollectionUtils.isEmpty(searchs))
        {
            result.put("code",0);
            result.put("msg","fail");
            return result;
        }
        List<ClassDetail> classinfo = AnalysisUtil.searchToDetail(searchs);
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
	@ApiIgnore
	@ RequestMapping ("/classInfo.do")
	public String classInfoView()
	{
		return "class_detail_test";
	}
}
