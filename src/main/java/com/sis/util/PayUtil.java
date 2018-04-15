package com.sis.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.sis.common.BaseLogInfo;
import com.sis.common.Constants;
import com.sis.controller.AttendController;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class PayUtil
{
    private final static Logger log = LoggerFactory.getLogger(PayUtil.class);
    public static String payquery(String payToken,String orderId,HttpSession session)
    {
        String url = Constants.QueryPayUrl;
        Map<String,String> param = new HashMap<>();
        param.put("siteId",Constants.SITE_ID);
        param.put("appKey",Constants.PayAppKey);
        param.put("payToken",payToken);
        param.put("orderId",orderId);
        String payInfo = HttpClientUtil.sendHttpGet(url,param);
        //记录日志
        try{
            BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),url,param.toString(),payInfo,"轮训支付确认");
            log.info(logInfo.toString());
        } catch (Exception e){
            log.info("写日志轮训支付确认:"+url+"。参数："+param.toString());
        }
        if(StringUtils.isEmpty(payInfo)){
            return "ERROR";
        }
        JSONObject object = JSON.parseObject(payInfo);

        //判断是否是秘钥过期
        String code = object.getString("code");
        if("500".equals(code)){
            String requestSecret = getMiyao();
            session.setAttribute("requestSecret",requestSecret);
        }

        String result = (String) object.get("type");
        if("SUCCESS".equals(result))
        {
            String payStatus = (String) object.get("payStatus");
            if("YFK".equals(payStatus))
            {
                return "SUCCESS";
            }
            else
            {
                return "ERROR";
            }
        }
        return "ERROR";
    }

    //获取支付秘钥
    public static String getMiyao(){
        //请求秘钥错误
        //获取支付秘钥
        String secretUrl = Constants.getSecretUrl;
        Map<String,String> secretParam = new HashMap<>();
        secretParam.put("siteId",Constants.SITE_ID);
        secretParam.put("appKey",Constants.PayAppKey);
        String secret = HttpClientUtil.sendHttpGet(secretUrl,secretParam);
        //记录日志
        try{
            BaseLogInfo logInfo = new BaseLogInfo(new Date().toString(),secretUrl,secretParam.toString(),secret,"获取支付秘钥");
            log.info(logInfo.toString());
        } catch (Exception e){
            log.info("写日志获取支付秘钥:"+secretUrl+"。参数："+secretParam.toString());
        }

        JSONObject secretObject = JSON.parseObject(secret);
        JSONObject obj = (JSONObject) secretObject.get("obj");
        String requestSecret = null;
        if(obj != null)
        {
            requestSecret = (String) obj.get("requestSecret");
            return  requestSecret;
        }
        return null;
    }
}
