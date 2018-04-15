package com.sis.model;

/**拼接课程表界面用
 * Created by 13046 on 2017/11/17.
 */
public class ScheduleTd
{
	private String color;
	private String info;
	private String schedule;

	public ScheduleTd() {
	}

	public ScheduleTd(String info, String schedule)
	{
		this.info = info;
		this.schedule = schedule;
	}

	public String getColor()
	{
		return color;
	}

	public void setColor(String color)
	{
		this.color = color;
	}

	public String getInfo()
	{
		return info;
	}

	public void setInfo(String info)
	{
		this.info = info;
	}

	public String getSchedule()
	{
		return schedule;
	}

	public void setSchedule(String schedule)
	{
		this.schedule = schedule;
	}
}
