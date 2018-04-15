package com.sis.print;

import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import java.awt.print.*;

public class YcPrinter{
    private SalesTicket salesTicket;

    public YcPrinter(SalesTicket salesTicket){
        this.salesTicket=salesTicket;
    }

    public void printer() {
        try {
            PrintService defaultService = PrintServiceLookup.lookupDefaultPrintService();
            //Book 类提供文档的表示形式，该文档的页面可以使用不同的页面格式和页面 painter
            Book book = new Book(); //要打印的文档

            //PageFormat类描述要打印的页面大小和方向
            PageFormat pf = new PageFormat();  //初始化一个页面打印对象
            pf.setOrientation(PageFormat.PORTRAIT); //设置页面打印方向，从上往下，从左往右

            //设置打印纸页面信息。通过Paper设置页面的空白边距和可打印区域。必须与实际打印纸张大小相符。
            Paper paper = new Paper();
            paper.setSize(158,30000);// 纸张大小
            paper.setImageableArea(0,0,158,30000);// A4(595 X 842)设置打印区域，其实0，0应该是72，72，因为A4纸的默认X,Y边距是72
            pf.setPaper(paper);

            book.append(salesTicket,pf);

//            PrinterJob job = PrinterJob.getPrinterJob();   //获取打印服务对象
            PrinterJob job = (PrinterJob) defaultService.createPrintJob();
            job.setPageable(book);  //设置打印类

            job.print(); //开始打印
        } catch (PrinterException e) {
            e.printStackTrace();
        }
    }
}