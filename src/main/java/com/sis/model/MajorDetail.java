package com.sis.model;

/**
 * @author luchenxi
 *
 */
public class MajorDetail extends Major{
	private String majorDetailName;
	private String majorDetailId;
	public String getMajorDetailName() {
		return majorDetailName;
	}
	public void setMajorDetailName(String majorDetailName) {
		this.majorDetailName = majorDetailName;
	}
	public String getMajorDetailId() {
		return majorDetailId;
	}
	public void setMajorDetailId(String majorDetailId) {
		this.majorDetailId = majorDetailId;
	}
}
