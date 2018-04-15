package com.sis.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;

/**
 * Created by xp-zhao on 2017/12/13.
 */
@Data
@AllArgsConstructor
public class PrintInfo
{
	private String studentId;
	private String studentName;
	private String classId;
	private String oprTime;
}
