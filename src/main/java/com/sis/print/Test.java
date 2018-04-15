package com.sis.print;

import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;

public class Test {

    private static Logger logger = Logger.getLogger(Test.class);

    public static void main(String[] args) {
        List<GoodsInfo> goods=new ArrayList<GoodsInfo>();
        goods.add(new GoodsInfo("J2EE","11800","1","11800"));
        goods.add(new GoodsInfo("大数据","14800","1","14800"));
        goods.add(new GoodsInfo("前端","11800","1","11800"));

        SalesTicket stk=new SalesTicket(goods,"测试信息","201705230010","3","38400","38400","0");
        YcPrinter p=new YcPrinter(stk);
        p.printer();
    }
}