package com.sis.common;

public class ReplaceArea
{
    private static String SCDJ = "顺城大街校区";
    private static String XLJ = "小南街校区";
    private static String JLT = "九里堤校区";
    private static String BHXL = "百花西路校区";
    private static String JSNL = "建设南路校区";
    private static String SQJY = "锦城公园校区";

    public static String getArea(String num)
    {
        String area = null;
        switch (num)
        {
            case "1":
                area = SCDJ;
                break;
            case "2":
                area = XLJ;
                break;
            case "3":
                area = JLT;
                break;
            case "4":
                area = BHXL;
                break;
            case "5":
                area = JSNL;
                break;
            case "6":
                area = SQJY;
                break;

        }
        return area;
    }
}
