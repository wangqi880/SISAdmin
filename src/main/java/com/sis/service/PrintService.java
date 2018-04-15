package com.sis.service;

import com.sis.model.PrintInfo;
import org.apache.ibatis.annotations.Param;

/**
 * Created by Administrator on 2017/10/14.
 */
public interface PrintService
{
	// 记录打印操作
	int recordPrint(PrintInfo printInfo);

	// 获取用户总的打印次数
	int getAllPrintCount(@Param("studentId") String studentId,@Param("classId") String classId);

	// 获取用户当天的打印次数
	int getDayPrintCount(@Param("studentId") String studentId,@Param("classId") String classId);

}
