package com.sis.dao;

import com.sis.model.PrintInfo;
import org.apache.ibatis.annotations.Param;

import javax.annotation.PreDestroy;

/**
 * Created by xp-zhao on 2017/11/17.
 */
public interface PrintDao
{
	// 记录打印操作
	int recordPrint(PrintInfo printInfo);

	// 获取用户总的打印次数
	int getAllPrintCount(@Param("studentId") String studentId,@Param("classId") String classId);

	// 获取用户当天的打印次数
	int getDayPrintCount(@Param("studentId") String studentId,@Param("classId") String classId);
}
