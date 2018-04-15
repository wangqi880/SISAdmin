package com.sis.util;

import com.sis.controller.AttendController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;
import java.util.Enumeration;

/**
 * Created by 13046 on 2017/11/22.
 */
public class SessionUtil
{
	private final static Logger log = LoggerFactory.getLogger(SessionUtil.class);

	public static void printSession(HttpSession session){
		Enumeration<String> keys  =  session.getAttributeNames();
		log.info("===============================================");
		while(keys.hasMoreElements()){
			String key = keys.nextElement();
			log.info(key+":"+session.getAttribute(key).toString());
		}
		log.info("===============================================");
	}
}
