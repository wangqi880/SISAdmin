package com.sis.service.impl;


import com.sis.dao.AdminUserMapper;
import com.sis.model.AdminUser;
import com.sis.service.AdminUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/28.
 */
@Service("adminUserService")
public class AdminUserServiceImpl implements AdminUserService
{
	@SuppressWarnings ("SpringJavaAutowiringInspection")
	@Autowired
	AdminUserMapper adminUserMapper;

	public int chooseUserNum()
	{
		return adminUserMapper.chooseUserNum();
	}

	public void add(AdminUser adminUser)
	{
		adminUserMapper.add(adminUser);
	}

	public AdminUser queryByUsername(String username)
	{
		return adminUserMapper.queryByUsername(username);
	}

	public void update(AdminUser adminUser)
	{
		adminUserMapper.update(adminUser);
	}

	public List<AdminUser> queryChooseUsers()
	{
		return adminUserMapper.queryChooseUsers();
	}

	public AdminUser queryByLogin(String username, String password) {
		Map map =new HashMap();
		map.put("username",username);
		map.put("password",password);
		return adminUserMapper.queryByLogin(map);
	}

	public List<AdminUser> queryAll() {
		return adminUserMapper.queryAll();
	}

	public void delete(String id) {
		adminUserMapper.delete(id);
	}

	public void updatePassword(String userId, String password) {
		Map map = new HashMap();
		map.put("userId",userId);
		map.put("password",password);
		adminUserMapper.updatePassword(map);
	}
}
