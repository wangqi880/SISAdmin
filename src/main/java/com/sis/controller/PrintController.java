package com.sis.controller;

import com.sis.model.Commodity;
import com.sis.model.PrintInfo;
import com.sis.service.ConfigService;
import com.sis.service.PrintService;
import com.sis.util.CharUtils;
import com.sis.util.ConfigUtil;
import com.sis.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.awt.print.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping ("/print")
public class PrintController {

    @Autowired
    private ConfigService configService;

    @Autowired
    private PrintService  printService;

    /**
     * 查看是否有打印资格（是否达到最高打印次数，是否到达每日上限等）
     * @return
     */
    @RequestMapping("/getRecord.do")
    @ResponseBody
    public Map<String,String> getPrintStatus(String studentId,String studentName, String classId){
        System.out.println("print-------->stuid:"+studentId+"---- name:"+studentName+"----classCode:"+classId);
        Map<String,String> returnMap = new HashMap<>();
        // 每个课程总可以打印的限制
        String printCount = configService.getConfigvalue(ConfigUtil.PRINT_COUNT);
        if(StringUtils.isEmpty(printCount)){
            printCount="3";
        }
        //每个课程每天打印数量
         String printCountDay = configService.getConfigvalue(ConfigUtil.PRINT_COUNT_DAY);
         if(StringUtils.isEmpty(printCountDay)){
            printCountDay="1";
        }
        //根据学生ID 和 班级ID 查询有打印次数是否超出上限  或者  超出每日上限
        //总共的打印次数
        int userCount = printService.getAllPrintCount(studentId,classId);
        if(userCount > Integer.valueOf(printCount))
        {
            returnMap.put("status","false");
            returnMap.put("messageinfo","每课打印总次数超出限制"+userCount+"次");
            return returnMap;
        }
        int userCountDay = printService.getDayPrintCount(studentId,classId);
        if(userCountDay >= Integer.valueOf(printCountDay))
        {
            returnMap.put("status","false");
            returnMap.put("messageinfo","每天打印次数超出限制,每天每课"+userCountDay+"次");
            return returnMap;
        }
        returnMap.put("status","ture"); //超出上限返回false，否则ture
        returnMap.put("messageinfo","可以打印");
        return returnMap;
    }

    /**
     * 打印操作记录下来
     */
    @RequestMapping("/record.do")
    @ResponseBody
    public void printRecord(String studentId,String studentName,String classId){
        System.out.println("print-------->stuid:"+studentId+"---- name:"+studentName+"----classCode:"+classId);
        if(CharUtils.isMessyCode(studentName)){
            studentName="名字乱码";
        }
        long oprTime=System.currentTimeMillis();
        String date= DateUtil.getDateToStringFormat(String.valueOf(oprTime),DateUtil.yyyyMMdd);
        PrintInfo printInfo = new PrintInfo(studentId,studentName,classId, String.valueOf(date));
        printService.recordPrint(printInfo);
    }
    public static void main(String[] args) {
    }

    /**
     * 打印小票
     *
     * @param order
     *            订单号
     * @param num
     *            数量
     * @param sum
     *            总金额
     * @param practical
     *            实收
     * @param change
     *            找零
     */
    private static void PrintSale(String order, String num, String sum, String practical, String change) {
        try {
            // 通俗理解就是书、文档
            Book book = new Book();
            // 设置成竖打
            PageFormat pf = new PageFormat();
            pf.setOrientation(PageFormat.PORTRAIT);

            ArrayList<Commodity> cmd_list = new ArrayList<Commodity>();
            // 取出数据
            for (int i = 0; i < cmd_list.size(); i++) {
//                Collect c = cmd_list.get(i);
//                Commodity cd = new Commodity(c.getName(), String.valueOf(c.getSell()), String.valueOf(c.getNum()),
//                        String.valueOf(c.getTotal()), c.getCode());
//                cmd_list.add(cd);
            }

            // 通过Paper设置页面的空白边距和可打印区域。必须与实际打印纸张大小相符。
            Paper paper = new Paper();
            paper.setSize(158, 30000);// 纸张大小
            paper.setImageableArea(0, 0, 158, 30000);// A4(595 X
            // 842)设置打印区域，其实0，0应该是72，72，因为A4纸的默认X,Y边距是72
            pf.setPaper(paper);

//            book.append(new SalesTicket(cmd_list, Windows.user_num, order, num, sum, practical, change), pf);

            // 获取打印服务对象
            PrinterJob job = PrinterJob.getPrinterJob();
            // 设置打印类
            job.setPageable(book);

            try {
                job.print();
            } catch (PrinterException e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
