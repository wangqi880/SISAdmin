
package com.sis.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.sis.column.ClazzApplyColumn;
import com.sis.column.ClazzSearch;
import com.sis.column.ClazzView;
import com.sis.column.GradeColumn;
import com.sis.column.SpecialtyColumn;
import com.sis.column.StudentClazzListColumn;
import com.sis.column.StudentClazzViewColumn;
import com.sis.column.StudentInfoColumn;
import com.sis.column.TrimColumn;
import com.sis.column.areaList.AreaColumn;
import com.sis.common.Constants;
import com.sis.model.ClassDetail;

/**
 * Created by xp-zhao on 2017/11/14.
 */
public class AnalysisUtil
{
	private static final Logger logger = Logger.getLogger(AnalysisUtil.class);

	public static void main(String[] args)
	{
		String url = Constants.StudentInfoUrl;
		Map<String , String> param = new HashMap<>();
		param.put("siteId", Constants.SITE_ID);
		param.put("userMobile", "13777464111");
		param.put("appKey", Constants.StudentInfoAppKey);
		String studentListInfo = HttpClientUtil.sendHttpPost(url, param);
		List<StudentInfoColumn> infos = analyStudentInfo(studentListInfo);
		System.out.println(infos.size());
	}

	public static List<AreaColumn> analyArea(String str)
	{
		Pattern p = Pattern.compile("(?<=\\{)(.+?)(?=\\})");
		Matcher m = p.matcher(str);
		List<AreaColumn> areaColumns = new ArrayList<>();
		while(m.find())
		{
			AreaColumn areaColumn = JSON.parseObject("{" + m.group() + "}", AreaColumn.class);
			areaColumns.add(areaColumn);
		}
		return areaColumns;
	}

	public static Map<String , Object> analyClazzList(String str)
	{
		Map<String , Object> resultMap = new HashMap<>();
		List<ClazzView> clazzViewList = null;
		JSONObject object = JSON.parseObject(str);
		String number = object.get("number").toString();
		String totalPages = object.get("totalPages").toString();
		resultMap.put("number", number);
		resultMap.put("totalPages", totalPages);
		if(StringUtils.isNotBlank(object.get("content").toString()))
		{
			JSONArray array = object.getJSONArray("content");
			clazzViewList = JSON.parseArray(array.toJSONString(), ClazzView.class);
		}
		resultMap.put("clazzViewList", clazzViewList);
		return resultMap;
	}

	public static ClazzView analyClazzView(String str)
	{
		ClazzView clazzView = JSON.parseObject(str, ClazzView.class);
		return clazzView;
	}

	public static List<ClazzSearch> analyClazzSearch(String str)
	{
//		ClazzSearch clazzSearch = JSON.parseObject(str,ClazzSearch.class);
		List<ClazzSearch> clazzSearchs = JSON.parseArray(str,ClazzSearch.class);
		return clazzSearchs;
	}

	public static List<GradeColumn> analyGrade(String str)
	{
		Pattern p = Pattern.compile("(?<=\\{)(.+?)(?=\\})");
		Matcher m = p.matcher(str);
		List<GradeColumn> gradeColumns = new ArrayList<>();
		while(m.find())
		{
			GradeColumn gradeColumn = JSON.parseObject("{" + m.group() + "}", GradeColumn.class);
			gradeColumns.add(gradeColumn);
		}
		return gradeColumns;
	}

	public static List<SpecialtyColumn> analySpecialty(String str)
	{
		Pattern p = Pattern.compile("(?<=\\{)(.+?)(?=\\})");
		Matcher m = p.matcher(str);
		List<SpecialtyColumn> specialtyColumns = new ArrayList<>();
		while(m.find())
		{
			SpecialtyColumn areaColumn = JSON.parseObject("{" + m.group() + "}", SpecialtyColumn.class);
			specialtyColumns.add(areaColumn);
		}
		return specialtyColumns;
	}

	public static List<StudentInfoColumn> analyStudentInfo(String str)
	{
		Pattern p = Pattern.compile("(?<=\\{)(.+?)(?=\\})");
		Matcher m = p.matcher(str);
		List<StudentInfoColumn> studentInfos = new ArrayList<>();
		while(m.find())
		{
			StudentInfoColumn studentInfo = JSON
				.parseObject("{" + m.group() + "}", StudentInfoColumn.class);
			studentInfos.add(studentInfo);
		}
		return studentInfos;
	}

	public static List<TrimColumn> analyTrim(String str)
	{
		Pattern p = Pattern.compile("(?<=\\{)(.+?)(?=\\})");
		Matcher m = p.matcher(str);
		List<TrimColumn> trimColumns = new ArrayList<>();
		while(m.find())
		{
			TrimColumn trimColumn = JSON.parseObject("{" + m.group() + "}", TrimColumn.class);
			trimColumns.add(trimColumn);
		}
		return trimColumns;
	}

	public static List<StudentClazzListColumn> analyStudentClazzList(String str)
	{
		List<StudentClazzListColumn> clazzListColumns;
		JSONObject object = JSON.parseObject(str);
		JSONArray array = object.getJSONArray("content");
		clazzListColumns = JSON.parseArray(array.toJSONString(), StudentClazzListColumn.class);
		return clazzListColumns;
	}

	public static StudentClazzViewColumn analyStudentClazzView(String str)
	{
		StudentClazzViewColumn studentClazzView = JSON.parseObject(str, StudentClazzViewColumn.class);
		return studentClazzView;
	}

	//	public static List<StudentClazzTotal> analyStudentClazzTotal(String str)
	//	{
	//		List<StudentClazzTotal> clazzTotals = new ArrayList<>();
	//		JSONObject object = JSONObject.parseObject(str);
	//		List<StudentClazzListColumn> result;
	//		JSONArray array = object.getJSONArray("content");
	//		result = JSON.parseArray(array.toJSONString(),StudentClazzListColumn.class);
	//		return clazzTotals;
	//	}
	public static ClassDetail ViewToDetail(ClazzView clazzView)
	{
		ClassDetail classDetail = new ClassDetail();
		classDetail.setAge(clazzView.getApplyLimit());
		classDetail.setMajor(clazzView.getSpelName());
		classDetail.setClassCode(clazzView.getClassNo());
		classDetail.setClassName(clazzView.getName());
		classDetail.setDesc(clazzView.getDescript());
		classDetail.setArea(clazzView.getArea());
		classDetail.setStatus(clazzView.getFrontStatusName());
		classDetail.setScheduleInfo(clazzView.getTimeable());
		classDetail.setTerm(clazzView.getYear());
		classDetail.setDate(clazzView.getClassDate());
		classDetail.setCost(clazzView.getClassFee());
		classDetail.setTimes(clazzView.getTimes());
		classDetail.setAbility(clazzView.getAbilitys());
		classDetail.setAttitudinal(clazzView.getAttitudes());
		classDetail.setSemester(clazzView.getTerm());
		classDetail.setLevel(clazzView.getDegree());
		return classDetail;
	}

	public static List<ClassDetail> searchToDetail(List<ClazzSearch> searchs)
	{
		List<ClassDetail> details = new ArrayList<>();
		for(ClazzSearch search : searchs)
		{
			ClassDetail classDetail = new ClassDetail();
			classDetail.setId(search.getId());
			classDetail.setAge(search.getApplyLimit());
			classDetail.setMajor(search.getSpelName());
			classDetail.setClassCode(search.getClassNo());
			classDetail.setClassName(search.getName());
			classDetail.setDesc(search.getDescript());
			classDetail.setArea(search.getArea());
			classDetail.setStatus(search.getFrontStatusName());
			classDetail.setScheduleInfo(search.getTimeable());
			classDetail.setTerm(search.getTerm());
			classDetail.setDate(search.getClassDate());
			classDetail.setCost(String.valueOf(search.getTotalFees()));
			classDetail.setTimes(String.valueOf(search.getTimes()));
			classDetail.setAbility(search.getAbilitys());
			classDetail.setAttitudinal(search.getAttitudes());
			classDetail.setSemester(search.getTerm());
			classDetail.setLevel(search.getDegree());
			details.add(classDetail);
		}

		return details;
	}

	public static ClazzApplyColumn anaylyClazzApply(String str)
	{
		ClazzApplyColumn clazzApplyColumn = null;
		try
		{
			clazzApplyColumn = JSON.parseObject(str, ClazzApplyColumn.class);
		}
		catch (Exception e)
		{
			logger.error("解析失败", e);
		}
		return clazzApplyColumn;
	}

	// 获取 4 位验证码
	public static String getCode()
	{
		String str = "123456789";
		StringBuilder sb = new StringBuilder(4);
		for(int i = 0 ; i < 4 ; i++)
		{
			char ch = str.charAt(new Random().nextInt(str.length()));
			sb.append(ch);
		}
		return sb.toString();
	}
}
