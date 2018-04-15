package com.sis.service.impl;

import com.sis.dao.PrintDao;
import com.sis.model.PrintInfo;
import com.sis.service.PrintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by xp-zhao on 2017/12/14.
 */
@Service("printService")
public class PrintServiceImpl implements PrintService
{
	@SuppressWarnings ("SpringJavaAutowiringInspection")
	@Autowired
	private PrintDao printDao;

	@Override public int recordPrint(PrintInfo printInfo)
	{
		return printDao.recordPrint(printInfo);
	}

	@Override public int getAllPrintCount(String studentId,String classId)
	{
		return printDao.getAllPrintCount(studentId,classId);
	}

	@Override public int getDayPrintCount(String studentId,String classId)
	{
		return printDao.getDayPrintCount(studentId,classId);
	}
}
