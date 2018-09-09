package com.sis.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.sis.column.*;
import com.sis.common.BaseLogInfo;
import com.sis.common.Constants;
import com.sis.common.ParentId;
import com.sis.common.ReplaceArea;
import com.sis.model.AttendInfo;
import com.sis.model.ClassDetail;
import com.sis.model.ScheduleTd;
import com.sis.model.StudentInfo;
import com.sis.service.ConfigService;
import com.sis.service.PrintService;
import com.sis.util.*;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.beans.Encoder;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by 13046 on 2017/11/2.
 */
@Controller
@RequestMapping("/info")
public class AttendController
{
	private final static Logger log = LoggerFactory.getLogger(AttendController.class);
	@Autowired
	ConfigService configService;

	@Autowired
	PrintService printService;
	/**
	 * 展示专业小类
	 * @param area
	 * @param major
	 * @param session
	 * @return
	 */
	@RequestMapping("/majorDetail.do")
	@ResponseBody
	public Map<String,List<String>>  showMajorDetail (String area, String major,HttpSession session) {
			area = ReplaceArea.getArea(area);
		String url = Constants.SpecialtyList;
		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		String str = HttpClientUtil.sendHttpGet(url,param);
		List<SpecialtyColumn> specialtyColumns = AnalysisUtil.analySpecialty(str);
		Map<String,List<String>> map = getMajorDetail(area,major,specialtyColumns);
		AttendInfo info = (AttendInfo) session.getAttribute("attendInfo");
		if(info == null){
			info = new AttendInfo();
		}
		if(StringUtils.isNotBlank(area) && !area.equals("null")){
			info.setArea(area);
		}
		info.setMajor(major);
		session.setAttribute("attendInfo", info);
		log.info("报名信息："+info.toString());
		SessionUtil.printSession(session);
		return map;
	}

	/**
	 * 展示区域下、专业下的所有班级
	 * @param major
	 * @param session
	 * @return
	 */
	@RequestMapping(value="showClass",produces="application/json;charset=utf-8")
	@ResponseBody
	public String showClass(String major,HttpSession session){
		List<ClassDetail> list = new ArrayList<>();
		if(StringUtils.isBlank(major) || major.equals("undefined")||  major.equals("null")){
			List<ClassDetail> details = (List<ClassDetail>) session.getAttribute("class");
			Gson gson1 = new Gson();
			String str = gson1.toJson(details);
			session.setAttribute("classList",details);
			return str;
		}
		AttendInfo info = (AttendInfo) session.getAttribute("attendInfo");
		info.setMajorDetailId(major);
		String spelId = major;
		session.setAttribute("attendInfo", info);
		String url = Constants.ClazzListUrl;
		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		param.put("spelId",spelId);
		String clazzViewInfo = HttpClientUtil.sendHttpGet(url,param);
		Map<String,Object> resultMap = AnalysisUtil.analyClazzList(clazzViewInfo);
		List<ClazzView> clazzViews = (List<ClazzView>) resultMap.get("clazzViewList");
		String totalPages = (String) resultMap.get("totalPages");
		String number = (String) resultMap.get("number");
		int pageNum = 1;
		while(Integer.valueOf(number) <= Integer.valueOf(totalPages))
		{
			pageNum++;
			param.put("pageNo",pageNum+"");
			clazzViewInfo = HttpClientUtil.sendHttpGet(url,param);
			resultMap = AnalysisUtil.analyClazzList(clazzViewInfo);
			List<ClazzView> clazzViews1 = (List<ClazzView>) resultMap.get("clazzViewList");
			totalPages = (String) resultMap.get("totalPages");
			number = (String) resultMap.get("number");
			clazzViews.addAll(clazzViews1);
		}
		log.info("报名信息："+info.toString());

		String area = info.getArea();
		int countall = 0;
		int countr = 0;
		int counte = 0;
		for(ClazzView clazzView : clazzViews)
		{
			if(!area.equals(clazzView.getArea()) || !"报名进行中".equals(clazzView.getFrontStatusName()))
			{
				counte++;
				continue;
			}else{
				countr++;
			}
			log.info("区域："+area+"||专业："+major+"||"+clazzView.toString());
			ClassDetail classDetail = new ClassDetail();
			classDetail.setAge(clazzView.getApplyLimit());
			classDetail.setMajor(clazzView.getSpelName());
			classDetail.setClassCode(clazzView.getClassNo());
			classDetail.setClassName(clazzView.getName());
			classDetail.setDesc(clazzView.getDescript());
			classDetail.setArea(clazzView.getArea());
			classDetail.setStatus(clazzView.getFrontStatusName());
			classDetail.setScheduleInfo(clazzView.getTimeable());
			classDetail.setTerm(clazzView.getTerm());
			classDetail.setDate(clazzView.getClassDate());
			classDetail.setCost(clazzView.getTotalFees());
			classDetail.setTimes(clazzView.getTimes());
			classDetail.setAbility(clazzView.getAbilitys());
			classDetail.setAttitudinal(clazzView.getAttitudes());
			classDetail.setSemester(clazzView.getTerm());
			classDetail.setLevel(clazzView.getDegree());
			classDetail.setId(clazzView.getId());
			classDetail.setYear(clazzView.getYear());
			try {
				String btime = DateUtil.getDateToStringFormat(clazzView.getBeginTime(), "yyyy-MM-dd");
				classDetail.setBeginTime(btime);
			}catch (Exception e){
				classDetail.setBeginTime(clazzView.getBeginTime());
			}
			list.add(classDetail);
		}
		System.out.println("counte:"+counte);
		System.out.println("countr:"+countr);
		countall = counte+countr;
		log.info("count:"+countall);
		if(CollectionUtils.isEmpty(list)){
			return null;
		}
		info.setMajorDetail(list.get(0).getClassName());
		session.setAttribute("classList",list);
		Gson gson = new Gson();
		String str = gson.toJson(list);
		log.info("返回："+str);
		SessionUtil.printSession(session);
		return str;

	}

	/**
	 * 展示班级详细信息
	 * @return
	 */
	@RequestMapping("/classDetail.do")
	private String getClassDetail(String classCode,HttpSession session){
		List<ClassDetail> list = (List<ClassDetail>)session.getAttribute("classList");
		if(CollectionUtils.isEmpty(list)){
			return "class_Info";
		}
		for(ClassDetail classinfo:list){
			if(classinfo.getClassCode().equals(classCode)){
				session.setAttribute("class",classinfo);
				log.info("当前班级信息："+classinfo.toString());
				break;
			}
		}
//		String url = Constants.ClazzViewUrl;
//		Map<String,String> param = new HashMap<>();
//		param.put("siteId",Constants.SITE_ID);
//		param.put("id",classCode);
//		String clazzViewInfo = HttpClientUtil.sendHttpGet(url,param);
//		ClazzView clazzView = AnalysisUtil.analyClazzView(clazzViewInfo);
//		ClassDetail classinfo = AnalysisUtil.ViewToDetail(clazzView);
//		session.setAttribute("class",classinfo);
		SessionUtil.printSession(session);
		return "class_Info";
	}
	/**
	 * 展示学员课表
	 * @return
	 */
	/*@RequestMapping(value = "/showSchedule.do",produces = "application/json;charset=utf-8")
	@ResponseBody
	private Map<String, Object> showSchedule(String studentId,HttpSession session){
		//TODO 根据学员ID查询学员本学期课表（已缴费的课程）
		//TODO 已缴费的课程的timeTable字段封装成List
		//TODO 这个人、这个学期、已缴费的
		List<ScheduleTd> timeTable = new ArrayList<>();

		String url = Constants.StudentClazzListUrl;
		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		param.put("studentId",studentId);
		String studentClazzViewInfo = HttpClientUtil.sendHttpGet(url,param);
		List<StudentClazzListColumn> studentClazzList;
		Map<String,Object> map = new HashMap<>();
		try
		{
			studentClazzList = AnalysisUtil.analyStudentClazzList(studentClazzViewInfo);
		}
		catch (Exception e)
		{
			log.error("解析失败",e);
			map.put("status","ERROR");
			SessionUtil.printSession(session);
			return map;
		}
		for(StudentClazzListColumn column : studentClazzList)
		{
			ScheduleTd scheduleTd = new ScheduleTd();
			scheduleTd.setInfo(column.getSpelName());
			scheduleTd.setSchedule(column.getTimeable());
			if("3".equals(column.getApplyStatus()) || "已缴费".equals(column.getApplyStatus()))
			{
				timeTable.add(scheduleTd);
			}

		}
		Map<String, Object> table = new HashMap<>();
		try
		{
			table = ViewsAppend.getSchedule(timeTable);
			log.info(table.toString());
		}catch (Exception e){
			log.error("获取课表失败",e);
		}
		SessionUtil.printSession(session);
		return table;
	}*/

	@RequestMapping(value = "/showSchedule.do",produces = "application/json;charset=utf-8")
	@ResponseBody
	private Map<String,Object> showSchedule(String studentId,HttpSession session){
		//TODO 根据学员ID查询学员本学期课表（已缴费的课程）
		//TODO 已缴费的课程的timeTable字段封装成List
		//TODO 这个人、这个学期、已缴费的
		List<ScheduleTd> timeTable = new ArrayList<>();

		String url = Constants.StudentClazzListUrl;
		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		param.put("studentId",studentId);
		String studentClazzViewInfo = HttpClientUtil.sendHttpGet(url,param);
		List<StudentClazzListColumn> studentClazzList;
		Map<String,Object> map = new HashMap<>();
		try
		{
			studentClazzList = AnalysisUtil.analyStudentClazzList(studentClazzViewInfo);
		}
		catch (Exception e)
		{
			log.error("解析失败",e);
			map.put("status","ERROR");
			SessionUtil.printSession(session);
			return map;
		}
		List<StudentClazzListColumn>  myclassList = new ArrayList<>();
		for(StudentClazzListColumn column : studentClazzList)
		{
			ScheduleTd scheduleTd = new ScheduleTd();
			scheduleTd.setInfo(column.getSpelName());
			scheduleTd.setSchedule(column.getTimeable());
			if("3".equals(column.getApplyStatus()) || "已缴费".equals(column.getApplyStatus()))
			{
				String endTime = column.getEndTime();
				String classPlace=	ViewsAppend.getClassPlace(scheduleTd);
				column.setClassPlace(classPlace);
				//只有结束时间在当前时间之后的课程才显示
				if(StringUtils.isNotEmpty(endTime) && DateUtil.compare_date(endTime,"yyyy-MM-dd")>=0){
					myclassList.add(column);
				}
			}
		}
		map.put("status","SUCCESS");
		map.put("data",myclassList);
		SessionUtil.printSession(session);
		return map;
	}

	/**
	 * 获取验证码
	 * @return
	 */
	@RequestMapping("/getPhoneCheckInfo.do")
	@ResponseBody
	private String getPhoneCheckInfo(String phoneNumber,HttpSession session){
		//TODO  生成手机验证码
		log.info("手机号码是："+phoneNumber);
		// 查询手机号绑定的账号
		String url = Constants.StudentInfoUrl;
		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		param.put("userMobile",phoneNumber);
		param.put("appKey",Constants.StudentInfoAppKey);
		log.info("==>getPhoneCheckInfo[httppostParam{"+param.toString()+"}]");
		String studentListInfo = HttpClientUtil.sendHttpPost(url,param);
		//记录日志
		try{
			BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),url,param.toString(),studentListInfo,"生成手机验证码-获取用户信息");
			log.info(logInfo.toString());
		} catch (Exception e){
			log.info("写日志生成手机验证码-获取用户信息:"+url+"。参数："+param.toString());
		}

		log.info("==>getPhoneCheckInfo[httppostResult{"+studentListInfo+"}]");
		List<StudentInfoColumn> infos = AnalysisUtil.analyStudentInfo(studentListInfo);
		if(CollectionUtils.isEmpty(infos))
		{
			log.error("学生信息解析后为空");
			SessionUtil.printSession(session);
			return "FAILD";
		}
		List<StudentInfo> studentInfos = new ArrayList<>();
		for(StudentInfoColumn studentInfo : infos)
		{
			log.info("studentList:"+studentInfo.toString());
			StudentInfo info = new StudentInfo();
			String name = studentInfo.getName();
			info.setStuName(name.substring(0,name.length() - 1)+"*");
			info.setStuSex(studentInfo.getGenderName());
			info.setBirthDay(DateUtil.getDateToString(studentInfo.getBirthday()));
			info.setGrade(StringUtils.isBlank(studentInfo.getGradeName())?"":studentInfo.getGradeName());
			info.setIndentityCard(studentInfo.getCardNo());
			info.setPhoneNumber(studentInfo.getCellPhone());
			info.setStudentId(studentInfo.getId());
			studentInfos.add(info);
		}
		session.setAttribute("cxstu_List",studentInfos);
		String studentId = infos.get(0).getId();
		String checkCode = AnalysisUtil.getCode();
		session.setAttribute(phoneNumber+"checkCode",checkCode);
		// 发生验证码
		String sendCodeUrl = Constants.SmsCodeUrl;
		Map<String,String> codeParam = new HashMap<>();
		codeParam.put("siteId",Constants.SITE_ID);
		codeParam.put("studentId",studentId);
		codeParam.put("smsCode",checkCode);
		log.info(phoneNumber+":"+studentId+"发送验证码接口参数{"+codeParam.toString()+"}");
		String codeInfo = HttpClientUtil.sendHttpPost(sendCodeUrl,codeParam);
		//记录日志
		try{
			BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),url,codeParam.toString(),codeInfo,"生成手机验证码-发送验证码");
			log.info(logInfo.toString());
		} catch (Exception e){
			log.info("写日志生成手机验证码-发送验证码:"+url+"。参数："+param.toString());
		}

		log.info(phoneNumber+":"+studentId+":发送验证码结果信息："+codeInfo);
		try
		{
			JSONObject object = JSON.parseObject(codeInfo);
			boolean result = (boolean) object.get("result");
			if(result)
			{
				log.info("getPhoneCheckInfo.do接口调用成功");
				SessionUtil.printSession(session);
				return "SUCCESS";
			}
		}
		catch (Exception e)
		{
			log.error(phoneNumber+":"+studentId+"getPhoneCheckInfo.do接口调用失败",e);
			SessionUtil.printSession(session);
			return "FAILD";
		}
		log.error(phoneNumber+":"+studentId+"getPhoneCheckInfo接口返回失败");
		SessionUtil.printSession(session);
		return "FAILD";
	}

	/**
	 * 获取验证码
	 * @return
	 */
	@RequestMapping("/getAccountInfo.do")
	@ResponseBody
	private String getAccountInfo(String phoneNumber,String classCode,HttpSession session){
		//TODO 通过手机号查询用户账号信息
		Map<String , Object> returnCode = new HashMap<>();
		List<StudentInfo> studentInfos = new ArrayList<>();
		String url = Constants.StudentInfoUrl;
		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		param.put("userMobile",phoneNumber);
		param.put("appKey",Constants.StudentInfoAppKey);
		String studentListInfo = HttpClientUtil.sendHttpPost(url,param);
		Object obj = JSON.parse(studentListInfo);
		String result="";
		if(obj instanceof JSONObject){
			JSONObject jsonObject =  JSONObject.parseObject(studentListInfo);
			if(null!=jsonObject){
				result = String.valueOf(jsonObject.get("ret"));
			}
		}

		if(StringUtils.isBlank(studentListInfo) || "USER_NOT_EXIST".equals(result))
		{

			log.error("手机号码："+phoneNumber+"没查出学员信息");
			SessionUtil.printSession(session);
			return "false";
		}
		List<StudentInfoColumn> infos = AnalysisUtil.analyStudentInfo(studentListInfo);
		if(CollectionUtils.isEmpty(infos))
		{
			log.error("学员信息解析后为空");
			SessionUtil.printSession(session);
			return "false";
		}
		for(StudentInfoColumn studentInfo : infos)
		{
			log.info("接口返回学员信息："+studentInfo.toString());
			StudentInfo studentInfo1 = new StudentInfo();
			String name = studentInfo.getName();
			studentInfo1.setStuName(name.substring(0,name.length() - 1)+"*");
			studentInfo1.setStuSex(studentInfo.getGenderName());
			studentInfo1.setBirthDay(DateUtil.getDateToString(studentInfo.getBirthday()));
			studentInfo1.setGrade(StringUtils.isBlank(studentInfo.getGradeName())?"":studentInfo.getGradeName());
			studentInfo1.setIndentityCard(studentInfo.getCardNo());
			studentInfo1.setPhoneNumber(studentInfo.getCellPhone());
			studentInfo1.setStudentId(studentInfo.getId());
			studentInfos.add(studentInfo1);
		}
		returnCode.put("childList",studentInfos);
		//保存报名信息
		AttendInfo info = (AttendInfo) session.getAttribute("attendInfo");
		if(info==null){
			info = new AttendInfo();
		}
		info.setUserPhone(phoneNumber);// 用户手机号
		info.setClassId(classCode);// 班级ID
		session.setAttribute("attendInfo",info);
		session.setAttribute("childMap",returnCode);
		session.setAttribute("msisdn",phoneNumber);
		//如果手机号码下有绑定学生（没有返回false）
		SessionUtil.printSession(session);
		return "SUCCESS";
	}
	
	/**
	 * 比对验证码
	 * @return
	 */
	@RequestMapping("/checkCode.do")
	@ResponseBody
	private String checkCode(String phoneCode,String phoneNumber,String classCode,HttpSession session){
		Map<String , Object> returnCode = new HashMap<>();
		//TODO  比对验证码
		log.info("输入的验证码："+phoneCode);
		String sessionCode = (String) session.getAttribute(phoneNumber+"checkCode");
		if(phoneCode.equals(sessionCode))
		{
			SessionUtil.printSession(session);
			return "SUCCESS";
		}
		else
		{
			SessionUtil.printSession(session);
			return "FAILD";
		}
	}
	
	/**
	 * 比对验证码
	 * @return
	 */
	@RequestMapping("/checkCodeLogin.do")
	@ResponseBody
	private String checkCodeLogin(String phoneCode,String phoneNumber,String classCode,HttpSession session){
		Map<String , Object> returnCode = new HashMap<>();
		//TODO  比对验证码
		log.info("输入的验证码："+phoneCode);
		String sessionCode = (String) session.getAttribute(phoneNumber+"checkCode");
		if(phoneCode.equals(sessionCode))
		{
			SessionUtil.printSession(session);
			return "SUCCESS";
		}
		else
		{
			SessionUtil.printSession(session);
			return "FAILD";
		}
	}

	/**
	 * 点击学员基本信息，展示学员详细信息以及报名班级信息
	 * 
	 */
	@RequestMapping("/getAttendInfo.do")
	@ResponseBody
	public Map<String, Object> getAttendInfo(String classCode,String idnumber,HttpSession session){
		log.info("==>班级代码:"+classCode+",学生ID:"+idnumber);
		Map<String, Object> showMap = new HashMap<>();
		//获取session中该账号关联的学员信息
		Map<String , Object> info  = (Map<String, Object>) session.getAttribute("childMap");
		List<StudentInfo> studentInfos = (List<StudentInfo>) info.get("childList");
		AttendInfo attendInfo = (AttendInfo) session.getAttribute("attendInfo");
		//获取预报名的班级信息
		List<ClassDetail> classList = (List<ClassDetail>)session.getAttribute("classList");
		for(ClassDetail classDetail : classList)
		{
			if(classCode.equals(classDetail.getClassCode()))
			{
				attendInfo.setClazzId(classDetail.getId());
				break;
			}
		}
		session.setAttribute("attendInfo",attendInfo);
		//获取希望展示的那个学员
		StudentInfo student = studentInfos.get(Integer.valueOf(idnumber));
		log.info("==>学生信息："+student);
		showMap.put("student", student);
		//获取预报名的班级信息
		List<ClassDetail> list = (List<ClassDetail>)session.getAttribute("classList");
		for(ClassDetail classinfo:list){
			if(classinfo.getClassCode().equals(classCode)){
				showMap.put("classinfo", classinfo);
				break;
			}
		}
		log.info("报名信息："+showMap.toString());
		SessionUtil.printSession(session);
		return showMap;
	}
	
	/**
	 * 报名
	 * @return
	 */
	@RequestMapping("/attend.do")
	@ResponseBody
	public Map<String,String> attend(String studentId,HttpSession session) {
		//报名信息
		AttendInfo info = (AttendInfo) session.getAttribute("attendInfo");
		info.setStudentId(studentId);
		session.setAttribute("attendInfo",info);
		String clazzId = info.getClazzId();

		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		param.put("clazzId",info.getClazzId());
		param.put("studentId",studentId);
		String clazzInfo = HttpClientUtil.sendHttpPost(Constants.ClazzApplyUrl,param);
		ClazzApplyColumn clazzApplyColumn = AnalysisUtil.anaylyClazzApply(clazzInfo);
		Map<String,String> map = new HashMap<>();
		if(null==clazzApplyColumn  ||StringUtils.isEmpty(clazzApplyColumn.getReserveNo()))
		{
			map.put("status","false");
			if(StringUtils.isNotEmpty(clazzInfo)){
				JSONObject object = (JSONObject) JSONObject.parse(clazzInfo);
				if(StringUtils.isEmpty(object.getString("msg"))){
					if(!StringUtils.isEmpty(object.getString("result"))){
						map.put("msg",	object.getString("result"));
					}else {
						map.put("msg",	"进入下一步");
					}

				}else {
					map.put("msg",	object.getString("msg"));
				}

			}
			SessionUtil.printSession(session);
			return map;
		}
		map.put("status","SUCCESS");
		session.setAttribute("clazzApply",clazzApplyColumn);
		map.put("reserveNo",clazzApplyColumn.getReserveNo());
		SessionUtil.printSession(session);
		return map;
	}
	
	public Map<String,List<String>> getMajorDetail(String area,String major,List<SpecialtyColumn> specialtyColumns )
	{
		List<String> list = new ArrayList<>();
		List<String> idList = new ArrayList<>();
		Map<String,List<String>> map = new HashMap<>();
		if("科技类".trim().equals(major.trim()))
		{
			String parentId = ParentId.KJL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("美术类".equals(major))
		{
			String parentId = ParentId.MSL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("实践类".equals(major))
		{
			// todo null
			String parentId = ParentId.SJL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("书法类".equals(major))
		{
			String parentId = ParentId.SFL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("语言类".equals(major)){
			String parentId = ParentId.YYBYL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("外语类".equals(major))
		{
			String parentId = ParentId.WYL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("文化类".equals(major))
		{
			String parentId = ParentId.WHL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("戏曲类".equals(major))
		{
			String parentId = ParentId.XQL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("舞蹈类".equals(major))
		{
			String parentId = ParentId.WDL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("音乐类".equals(major))
		{
			String parentId = ParentId.YYL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else if("体育类".equals(major))
		{
			String parentId = ParentId.TYL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
		else{
			String parentId = ParentId.ZHL;
			for(SpecialtyColumn specialtyColumn : specialtyColumns)
			{
				if(parentId.equals(specialtyColumn.getParentId()))
				{
					list.add(specialtyColumn.getName());
					idList.add(specialtyColumn.getId());
				}
			}
			map.put("nameList",list);
			map.put("idList",idList);
			return map;
		}
	}

	public  boolean isMessyCode(String str) {
		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);
			// 当从Unicode编码向某个字符集转换时，如果在该字符集中没有对应的编码，则得到0x3f（即问号字符?）
			//从其他字符集向Unicode编码转换时，如果这个二进制数在该字符集中没有标识任何的字符，则得到的结果是0xfffd
			//System.out.println("--- " + (int) c);
			if ((int) c == 0xfffd) {
				// 存在乱码
				//System.out.println("存在乱码 " + (int) c);
				return true;
			}
		}
		return false;
	}

	@RequestMapping("/getPrintInfo.do")
	@ResponseBody
	public Map<String,Object> getStudentClazzInfo(String studentId, HttpServletRequest request,HttpSession session)
	{
		String studentName=request.getParameter("studentName");
		if(StringUtils.isNotEmpty(studentName)){
			try {
				studentName  = new String(studentName.getBytes("UTF-8"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}



		String url = Constants.StudentClazzListUrl;
		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		param.put("studentId",studentId);
		log.info("获取打印界面信息："+param.toString());
		String studentClazzViewInfo = HttpClientUtil.sendHttpGet(url,param);
		//记录日志
		String reserveNo = (String) session.getAttribute("reserveNo");
		try{
			BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),url,param.toString(),studentClazzViewInfo,"获取打印界面信息");
			log.info(logInfo.toString());
		} catch (Exception e){
			log.info("写日志获取打印界面信息:"+url+"。参数："+param.toString());
		}

		List<StudentClazzListColumn> studentClazzList;
		Map<String,Object> map = new HashMap<>();
		try
		{
			studentClazzList = AnalysisUtil.analyStudentClazzList(studentClazzViewInfo);
		}
		catch (Exception e)
		{
			log.error("解析失败",e);
			map.put("status","ERROR");
			return map;
		}
		List<ClassDetail> list = new ArrayList<>();
		String controlYear= configService.getConfigvalue(ConfigUtil.PRINT_SHOW_YEAR,DateUtil.getYear());
		String controlTerm  =configService.getConfigvalue(ConfigUtil.PRINT_SHOW_TERM,DateUtil.getTerm());
		for(StudentClazzListColumn column : studentClazzList)
		{
			ClassDetail classDetail = new ClassDetail();
			String year = column.getYear();
			String term = column.getTerm();
			if(StringUtils.isNotEmpty(reserveNo)){
				if(("3".equals(column.getApplyStatus()) || "已缴费".equals(column.getApplyStatus())) && (controlYear.contains(year)) && (controlTerm.contains(term)) && (reserveNo.equals(column.getReserveNo())))
				{
					classDetail.setClassName(column.getName());
					classDetail.setAge(column.getApplyLimit());
					classDetail.setMajor(column.getSpelName());
					classDetail.setClassCode(column.getClazzNo());
					classDetail.setArea(column.getArea());
					classDetail.setStatus(column.getApplyStatus());
					classDetail.setScheduleInfo(column.getTimeable());
					classDetail.setTerm(column.getYear());
					classDetail.setDate(column.getClassDate());
					classDetail.setCost(column.getTotalFees());
					classDetail.setTimes(column.getTimes());
					classDetail.setSemester(column.getTerm());
					classDetail.setLevel(column.getDegree());
					classDetail.setReserveNo(column.getReserveNo());
					classDetail.setClassDate(column.getClassDate());
					classDetail.setBeginTime(column.getBeginTime());
					classDetail.setStudentName(studentName);
					//根据学生id和classid获取总共打印次数
					int num = printService.getAllPrintCount(studentId,column.getClazzNo());
					classDetail.setPrintNum(num);
					list.add(classDetail);
				}
			}else{
				if(("3".equals(column.getApplyStatus()) || "已缴费".equals(column.getApplyStatus())) && (controlYear.contains(year)) && (controlTerm.contains(term)))
				{
					classDetail.setClassName(column.getName());
					classDetail.setAge(column.getApplyLimit());
					classDetail.setMajor(column.getSpelName());
					classDetail.setClassCode(column.getClazzNo());
					classDetail.setArea(column.getArea());
					classDetail.setStatus(column.getApplyStatus());
					classDetail.setScheduleInfo(column.getTimeable());
					classDetail.setTerm(column.getYear());
					classDetail.setDate(column.getClassDate());
					classDetail.setCost(column.getTotalFees());
					classDetail.setTimes(column.getTimes());
					classDetail.setSemester(column.getTerm());
					classDetail.setLevel(column.getDegree());
					classDetail.setReserveNo(column.getReserveNo());
					classDetail.setClassDate(column.getClassDate());
					classDetail.setBeginTime(column.getBeginTime());
					classDetail.setStudentName(studentName);
					//根据学生id和classid获取总共打印次数
					int num = printService.getAllPrintCount(studentId,column.getClazzNo());
					classDetail.setPrintNum(num);
					list.add(classDetail);
				}
			}


		}

		map.put("status","SUCCESS");
		map.put("classinfo",list);
		map.put("controlYear",controlYear);
		map.put("controlTerm",controlTerm);
		return map;
	}
}
