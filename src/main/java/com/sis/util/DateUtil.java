package com.sis.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil
{
    private static SimpleDateFormat sf = null;
    public static String yyyy_MM_dd_HH_mm_ss="yyyy-MM-dd HH:mm:ss";
    public static String yyyyMMdd="yyyyMMdd";
    public static String getDateToString(long time)
    {
        Date d = new Date(time);
        sf = new SimpleDateFormat("yyyy年MM月dd日");
        return sf.format(d);
    }

    public static String getDateToString(String time)
    {
        long str = Long.parseLong(time);
        return getDateToString(str);
    }

    public static void main(String[] args)
    {
        long time = 1530201600;
        System.out.println(getDateToString(time));
    }
    public static String getDateToStringFormat(String time,String format)
    {
        long str = Long.parseLong(time);
        Date d = new Date(str);
        sf = new SimpleDateFormat(format);
        return sf.format(d);
    }

    public static String getYear(){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
            Date date = new Date();
            return sdf.format(date);
    }
    //获得学期
    public static String getTerm(){
        int seasonNumber = Calendar.getInstance().get(Calendar.MONTH);
        String term = seasonNumber>=3&&seasonNumber<=6?"春季":seasonNumber>=7&&seasonNumber<=8?"暑假":seasonNumber>=9&&seasonNumber<=11?"秋季":seasonNumber>=10?"寒假":"寒假";
        return term;

    }
}
