package com.sis.AdminController;

import com.sis.common.BaseResponse;
import com.sis.common.CodeConstraint;
import com.sis.model.CongfigPojo;
import com.sis.service.AdminUserService;
import com.sis.service.ConfigService;
import com.sis.util.ConfigUtil;
import com.sis.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

@Controller
public class AdminController {

    @Autowired
    AdminUserService adminUserService;

    @Autowired
    ConfigService configService;
    private final static Logger log = LoggerFactory.getLogger(AdminController.class);

    @RequestMapping("/admin")
    public ModelAndView admin(){
        ModelAndView modelAndView  = new ModelAndView();
        modelAndView.setViewName("admin/admin");
        return  modelAndView;
    }

    //进入维护界面
    @RequestMapping("/admin/fix")
    public ModelAndView fix(){
        ModelAndView modelAndView  = new ModelAndView();
        modelAndView.setViewName("admin/fix");
        String fixIs="0";
        try {
            fixIs = configService.getConfigvalue(ConfigUtil.FIX_IS_SHOW);
        }catch (Exception e){
            log.error("获取是否展示维护界面失败");
        }
        modelAndView.addObject("fixIs",fixIs);
        return  modelAndView;
    }

    //进入打印配置界面
    @RequestMapping("/admin/print")
    public ModelAndView print(){
        ModelAndView modelAndView  = new ModelAndView();
        modelAndView.setViewName("admin/print");
        String count="2";
        String dayCount="1";
        String year=DateUtil.getYear();
        String term=DateUtil.getTerm();
        try {
            count = configService.getConfigvalue(ConfigUtil.PRINT_COUNT);
            dayCount = configService.getConfigvalue(ConfigUtil.PRINT_COUNT_DAY);
             year=configService.getConfigvalue(ConfigUtil.PRINT_SHOW_YEAR );
            term=configService.getConfigvalue(ConfigUtil.PRINT_SHOW_TERM);

            if(StringUtils.isBlank(count))
            {
                CongfigPojo congfigPojo = new CongfigPojo();
                congfigPojo.setConfigKey(ConfigUtil.PRINT_COUNT);
                congfigPojo.setConfigValue("2");
                congfigPojo.setDesc("每个人允许打印2次");
                congfigPojo.setInsertTime(new Date().toString());
                configService.add(congfigPojo);
                count="2";
            }
            if(StringUtils.isBlank(dayCount)){
                CongfigPojo congfigPojo = new CongfigPojo();
                congfigPojo.setConfigKey(ConfigUtil.PRINT_COUNT_DAY);
                congfigPojo.setConfigValue("1");
                congfigPojo.setDesc("每个人每天允许打印1次");
                congfigPojo.setInsertTime(new Date().toString());
                configService.add(congfigPojo);
                dayCount="1";
            }
        }catch (Exception e){
            log.error("获取打印配置失败");
        }
        modelAndView.addObject("count",count);
        modelAndView.addObject("dayCount",dayCount);
        modelAndView.addObject("year",year);
        modelAndView.addObject("term",term);
        return  modelAndView;
    }

    //修改打印配置
    @RequestMapping("/admin/configprintcount")
    public String configprintcount(String countMum){
        try
        {
            configService.updateByKeyAndValue(ConfigUtil.PRINT_COUNT,countMum);
        }catch (Exception e){
            log.error("修改打印次数配置失败",e);
        }
        return  "redirect:/admin/print" ;
    }

    //修改打印配置每天
    @RequestMapping("/admin/configprintcountday")
    public String configprintcountday(String countMumDay){
        try
        {
            configService.updateByKeyAndValue(ConfigUtil.PRINT_COUNT_DAY,countMumDay);
        }catch (Exception e){
            log.error("修改打印次数配置（每天）失败",e);
        }
        return  "redirect:/admin/print" ;
    }

    //修改打印学年
    @RequestMapping("/admin/configYear")
    public String configYear(String year){
        try
        {
            configService.updateByKeyAndValue(ConfigUtil.PRINT_SHOW_YEAR,year);
        }catch (Exception e){
            log.error("修改打印学年失败",e);
        }
        return  "redirect:/admin/print" ;
    }


    //修改打印学期
    @RequestMapping("/admin/configTerm")
    public String configTerm(String term){
        try
        {
            configService.updateByKeyAndValue(ConfigUtil.PRINT_SHOW_TERM,term);
        }catch (Exception e){
            log.error("修改打印学期配置（每天）失败",e);
        }
        return  "redirect:/admin/print" ;
    }
    @RequestMapping("/admin/fixStatus")
    @ResponseBody
    public Object fix(boolean status){
        BaseResponse resp = new BaseResponse();
        resp.setCode(CodeConstraint.SUCCESS);
        resp.setInfo("success");
        String value="0";
        if(true==status){
            value="1";
        }
        try {
            configService.updateByKeyAndValue(ConfigUtil.FIX_IS_SHOW,value);
        }catch (Exception e){
            log.error("修改是否展示维护界面失败");
            resp.setCode(CodeConstraint.SUCCESS);
            resp.setInfo("error");
        }
        return  resp;
    }

    @RequestMapping("/admin/undo")
    public ModelAndView undo(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("admin/undo");
        return modelAndView;
    }
}
