package com.sis.service.impl;

import com.sis.dao.CongfigMapper;
import com.sis.model.CongfigPojo;
import com.sis.service.ConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/14.
 */
@Service("configService")
public class ConfigServiceImpl implements ConfigService
{
	@SuppressWarnings ("SpringJavaAutowiringInspection")
	@Autowired
	CongfigMapper congfigMapper;
	public String getConfigvalue(String key)
	{
		String value = congfigMapper.getConfigvalue(key);
		return value;
	}

	@Override
	public String getConfigvalue(String key, String defaultValue) {
		String value = getConfigvalue(key);
		if(StringUtils.isEmpty(value)){
			value=defaultValue;
		}
		return value;
	}

	public List<CongfigPojo> listAll()
	{
		return congfigMapper.listAll();
	}

	public void add(CongfigPojo congfigPojo)
	{
		String oldValue =  congfigMapper.getConfigvalue(congfigPojo.getConfigKey());
		if(StringUtils.isEmpty(oldValue)){
			congfigMapper.add(congfigPojo);
		}

	}

	public void delelte(String id)
	{
		congfigMapper.delelte(id);
	}

	public CongfigPojo queryById(String id)
	{
		return congfigMapper.queryById(id);
	}

	public void update(CongfigPojo congfigPojo)
	{
		congfigMapper.update(congfigPojo);
	}

	@Override
	public void updateByKeyAndValue(String conf_key, String conf_value) {
		Map map = new HashMap();
		map.put("conf_key",conf_key);
		map.put("conf_value",conf_value);
		congfigMapper.updateByKeyAndValue(map);
	}
}
