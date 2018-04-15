package com.sis.util;

import com.sis.model.ScheduleTd;
import com.sis.model.ShowInfo;

import java.text.SimpleDateFormat;
import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 前端困难界面拼接
 * Created by 13046 on 2017/11/17.
 */
public class ViewsAppend
{
	private final static Logger             log    = LoggerFactory.getLogger(ViewsAppend.class);

	private static       Map<String,String> dayMap = new HashMap<>();
	private static       String[]           day    = {"一","二","三","四","五","六","日"};
	private static       String[]           number = {"1","2","3","4","5","6","0"};
	private static       String[]           color = {"#FFD306","#81C0C0","#9999CC","#C2FF68","#FFAD86","#A6A6D2","#CF9E9E","#00AEAE","#004B97","#842B00"};

	static long nd = 1000 * 24 * 60 * 60;
	static long nh = 1000 * 60 * 60;
	static long nm = 1000 * 60;

	static {
		for(int i = 0 ; i < 7; i++){
			dayMap.put(day[i],number[i]);
		}
	}
	public static Map<String,Object> getSchedule(List<ScheduleTd> scheduleList){
		Map<String,Object> show = new HashMap<>();
		Map<String ,ScheduleTd> tdMap = new HashMap<>();
		List<ShowInfo> showInfos = new ArrayList<>();
		for(ScheduleTd td :scheduleList){
			int max=9;
		    int min=0;
		    Random random = new Random();
		    int s = random.nextInt(max)%(max-min+1) + min;
			td.setColor(color[s]);
			String sche = td.getSchedule();
			String[] infos = sche.split(" ");
			char[] day = infos[0].toCharArray();
			//X坐标
			List<String> xList = new ArrayList<>();
			for(int i=1; i < day.length;i++){
				String x = dayMap.get(String.valueOf(day[i]));
				xList.add(x);
			}
			//Y坐标
			String time = infos[1];
			String[] classTime = time.split("-");
			String startTime = classTime[0];
			String endTime = classTime[1];
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("hh:mm");
			Date sd = new Date();
			Date ed = new Date();
			Date st = new Date();
			try
			{
				st = simpleDateFormat.parse("08:30");
				sd = simpleDateFormat.parse(startTime);
				ed = simpleDateFormat.parse(endTime);
			}catch (Exception e){
				log.error("时间解析失败",e);
			}
			long diff1 = sd.getTime()-st.getTime();
			//计算距离8.30差几分钟
			long y = diff1 / nm;
			long diff = ed.getTime() - sd.getTime();
			// 计算课程多少分钟
			long height = diff / nm;
			for(String x:xList){
				for(int i = 0;i<height;i++){
					String id= "";
					id= x+""+(i+y);
					tdMap.put(id,td);
				}
				//计算在哪里显示课程信息
				ShowInfo sinfo1 = new ShowInfo();
				sinfo1.setInfoname(td.getInfo());
				sinfo1.setInfotime(infos[1]);
				sinfo1.setInfoarea(infos[2]);
				sinfo1.setWeekInfo(infos[0]);
				sinfo1.setxString(x);
				sinfo1.setHeight(String.valueOf(height)+"px");
				showInfos.add(sinfo1);
			}
		}
		show.put("info", showInfos);
		show.put("status","SUCCESS");
		return show;
	}
}
