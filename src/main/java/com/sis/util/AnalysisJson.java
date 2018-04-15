package com.sis.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.sis.column.StudentClazzListColumn;
import java.util.List;

/**
 * Created by xp-zhao on 2017/11/16.
 */
public class AnalysisJson
{
	public static void main(String[] args)
	{
//		String url = "/api/studentClazzList.do";
//		Map<String,String> param = new HashMap<>();
//		param.put("siteId","531B601029F97174012A0D3D396600B2");
//		param.put("studentId","1047D73FA58578BBE0530100007F11D0");
//		String str = HttpClientUtil.sendHttpGet(url,param);
//		analysisMuliJson(str);
		Test();
	}

	public static void analysisMuliJson(String jsonStr)
	{
		Gson    gson = new Gson();
		JSONObject object = JSON.parseObject(jsonStr);
		List<StudentClazzListColumn> result;
		JSONArray array = object.getJSONArray("content");
		result = JSON.parseArray(array.toJSONString(),StudentClazzListColumn.class);
		System.out.println(result.size());
	}

	public static String Test()
	{
		String str = "{\"message\":\"发送成功!\",\"result\":true}";
		String codeInfo = "{\"message\":\"发送成功!\",\"result\":true}";
		JSONObject object = JSON.parseObject(codeInfo);
		boolean result = (boolean) object.get("result");
		if(result)
		{
			return "SUCCESS";
		}
		return "FAIL";
	}
}
