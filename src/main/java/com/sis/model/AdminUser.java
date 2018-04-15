package com.sis.model;

import lombok.Data;

/**
 * Created by Administrator on 2017/10/28.
 */
@Data
public class AdminUser
{
	String id;
	String username;
	String password;
	String name;
	String msisdn;
	String insertTime;
	String updateTime;
	String role;
}
