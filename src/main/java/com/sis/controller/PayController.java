package com.sis.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.sis.column.StudentClazzViewColumn;
import com.sis.column.StudentInfoColumn;
import com.sis.common.BaseLogInfo;
import com.sis.common.Constants;
import com.sis.model.ClassDetail;
import com.sis.model.PayInfo;
import com.sis.model.StudentInfo;
import com.sis.util.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

/**缴费
 * @author luchenxi
 *
 */
@Controller
@RequestMapping("pay")
public class PayController {

	private static final Logger logger = Logger.getLogger(PayController.class);

	@RequestMapping("/getBookingInfo.do")
	@ResponseBody
	public  String getBookingInfo (String phoneNumber,HttpSession session) {
		//TODO 根据预约号查询预约缴费信息
		PayInfo info;
		String url = Constants.StudentClazzViewUrl;
		Map<String,String> param = new HashMap<>();
		param.put("siteId",Constants.SITE_ID);
		param.put("reserveNo",phoneNumber);
		session.setAttribute("reserveNo",phoneNumber);
		String studentClazzView = HttpClientUtil.sendHttpGet(url,param);
		//记录日志
		try{
		BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),url,param.toString(),studentClazzView,"根据预约号查询缴费信息");
		logger.info(logInfo.toString());
		} catch (Exception e){
			logger.info("写日志记录日志失败:"+url+"。参数："+param.toString());

		}
		if(StringUtils.isBlank(studentClazzView))
		{
			SessionUtil.printSession(session);
			return "ERROR";
		}
		StudentClazzViewColumn column;
		try
		{
			column = AnalysisUtil.analyStudentClazzView(studentClazzView);
		}
		catch (Exception e)
		{
			logger.error("根据预约号解析报名信息失败:"+phoneNumber,e);
			SessionUtil.printSession(session);
			return "ERROR";
		}
		logger.info("缴费信息"+phoneNumber+":"+column.toString());
		//保存学生信息
		String studentName = column.getStudentName();
		StudentInfo stu = new StudentInfo();
		stu.setStuName(studentName);
		session.setAttribute("jfstu_List",stu);
		//保存班级信息
		ClassDetail classDetail = setClazzDetail(column);
		session.setAttribute("jfdetail_List",classDetail);
		SessionUtil.printSession(session);
		return "SUCCESS";
	}

	@RequestMapping("/getKeyNoCode.do")
	@ResponseBody
	public Map<String,String> getKeyNoCode(String payType,HttpSession session)
	{
		String num = (String) session.getAttribute("reserveNo");
		SessionUtil.printSession(session);
		return pay(payType,num,session);
	}

	public  ClassDetail setClazzDetail(StudentClazzViewColumn clazzView)
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
		classDetail.setTerm(clazzView.getTerm());
		classDetail.setDate(clazzView.getClassDate());
		classDetail.setCost(clazzView.getTotalFees());
		classDetail.setTimes(clazzView.getTimes());
		classDetail.setAbility(clazzView.getAbilitys());
		classDetail.setAttitudinal(clazzView.getAttitudes());
		classDetail.setSemester(clazzView.getTerm());
		classDetail.setLevel(clazzView.getDegree());
		classDetail.setId(clazzView.getId());
		classDetail.setStatusName(clazzView.getApplyStatusName());
		return classDetail;
	}

	public PayInfo setData(StudentClazzViewColumn clazzViewColumn)
	{
		PayInfo info = new PayInfo();
		info.setClassCode(clazzViewColumn.getClassNo());
		info.setPayCode(clazzViewColumn.getMsgCode());
		info.setPhone(clazzViewColumn.getPayNum());
		info.setStatus(clazzViewColumn.getStatus());
		info.setStuId(clazzViewColumn.getStudentName());
		return info;
	}

	@RequestMapping("/getKey.do")
	@ResponseBody
	public Map<String,String> pay(String payType,String reserveNo,HttpSession session)
	{
		Map<String,String> map = new HashMap<>();
		try
		{
			/*//获取支付秘钥
			String url = Constants.getSecretUrl;
			Map<String,String> param = new HashMap<>();
			//	AttendInfo info = (AttendInfo) session.getAttribute("attendInfo");
			param.put("siteId",Constants.SITE_ID);
			param.put("appKey",Constants.PayAppKey);
			String secret = HttpClientUtil.sendHttpGet(url,param);
			//记录日志
			try{
				BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),url,param.toString(),secret,"获取支付秘钥");
				logger.info(logInfo.toString());
			} catch (Exception e){
				logger.info("写日志获取支付秘钥:"+url+"。参数："+param.toString());
			}

			JSONObject object = JSON.parseObject(secret);
			JSONObject obj = (JSONObject) object.get("obj");
			String requestSecret = null;
			if(obj != null)
			{
				requestSecret = (String) obj.get("requestSecret");
			}
			if(StringUtils.isBlank(requestSecret))
			{
				map.put("status","false");
				logger.error("查询结果为空");
				SessionUtil.printSession(session);
				return map;
			}*/
			String requestSecret = PayUtil.getMiyao();
			if(StringUtils.isBlank(requestSecret))
			{
				map.put("status","false");
				logger.error("查询结果为空");
				SessionUtil.printSession(session);
				return map;
			}
			Map<String,String> param = new HashMap<>();
			param.put("siteId",Constants.SITE_ID);
			param.put("appKey",Constants.PayAppKey);
			//扫码支付
			String payUrl = Constants.PayUrl;
			param.put("payToken",requestSecret);
			//	param.put("studentId",info.getStudentId());
			param.put("payType",payType);
			param.put("reserveNo",reserveNo);
			String payInfo = HttpClientUtil.sendHttpGet(payUrl,param);
			//记录日志
			try{
				BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),payUrl,param.toString(),payInfo,"扫码支付");
				logger.info(logInfo.toString());
			} catch (Exception e){
				logger.info("写日志获取扫码信息:"+payUrl+"。参数："+param.toString());
			}

			if(StringUtils.isNotBlank(payInfo)){
				logger.info(reserveNo+"--payInfo:{"+payInfo+"}");
			}
			JSONObject payObject = JSON.parseObject(payInfo);
			JSONObject objStr = (JSONObject) payObject.get("obj");
			if(objStr == null)
			{
				map.put("status","false");
				logger.error(reserveNo+"查询结果为空");
				SessionUtil.printSession(session);
				return map;
			}
			String pat = (String) objStr.get("pat");
			String id = (String) objStr.get("id");
			session.setAttribute("requestSecret",requestSecret);
			//抛弃订单号不适用，使用预约号
			session.setAttribute("orderId",reserveNo);
			session.setAttribute("reserveNo",reserveNo);
			String tradeUrl = Constants.TradeUrl+pat;
			map.put("status","SUCCESS");
			map.put("codePic",tradeUrl);
			Map<String,String> clazzViewparam = new HashMap<>();
			clazzViewparam.put("siteId",Constants.SITE_ID);
			clazzViewparam.put("reserveNo",reserveNo);
			String studentClazzView = HttpClientUtil.sendHttpGet(Constants.StudentClazzViewUrl,clazzViewparam);
			//记录日志
			try{
				BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),Constants.StudentClazzViewUrl,clazzViewparam.toString(),studentClazzView,"获取学生信息支付时");
				logger.info(logInfo.toString());
			} catch (Exception e){
				logger.info("写日志学生信息支付时:"+Constants.StudentClazzViewUrl+"。参数："+param.toString());
			}


			if(StringUtils.isBlank(studentClazzView))
			{
				SessionUtil.printSession(session);
				return map;
			}
			StudentClazzViewColumn column;
			try
			{
				column = AnalysisUtil.analyStudentClazzView(studentClazzView);
				ClassDetail classDetail = new ClassDetail();
				classDetail.setStudentName(column.getStudentName());
				classDetail.setClassName(column.getName());
				classDetail.setCost(column.getTotalFees());
				classDetail.setAge(column.getApplyLimit());
				classDetail.setMajor(column.getSpelName());
				classDetail.setClassCode(column.getClassNo());
				classDetail.setClassName(column.getName());
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
				try {
					String btime = DateUtil.getDateToStringFormat(column.getBeginTime(), "yyyy-MM-dd");
					classDetail.setBeginTime(btime);
				}catch (Exception e){
					classDetail.setBeginTime(column.getBeginTime());
				}
				classDetail.setNowDate(new Date().toString());
				logger.info("预约号："+reserveNo+"||状态："+classDetail.getStatus());
				session.setAttribute("jf_stu_classInfo",classDetail);
			}
			catch (Exception e)
			{
				SessionUtil.printSession(session);
				logger.error(reserveNo+"根据预约号解析报名信息失败",e);
			}
			return map;
		}catch (Exception e){
			logger.error(reserveNo+"获取预约号失败",e);
			map.put("status","error");
			return map;
		}

	}

	@RequestMapping("/getPayStatus")
	@ResponseBody
	public String getPayStatus(HttpSession session)
	{
		logger.info("-------------------------------------------------------------------------");
		String requestSecret = (String) session.getAttribute("requestSecret");
		String orderId = (String) session.getAttribute("orderId");
		logger.info(orderId+"||pay:{requestSecret:"+requestSecret+"}");
		logger.info(orderId+"||pay:{orderId:"+orderId+"}");
		String status = "ERROR";
		if(StringUtils.isNotBlank(requestSecret) && StringUtils.isNotBlank(orderId))
		{
			status = PayUtil.payquery(requestSecret,orderId,session);
			logger.info(orderId+"||paystatus:{"+status+"}");
		}
		logger.info("-------------------------------------------------------------------------");
		SessionUtil.printSession(session);
		return status;
	}

	public static void main(String[] args) {
//		getBookingInfo("cd518993",null);
	}

}
