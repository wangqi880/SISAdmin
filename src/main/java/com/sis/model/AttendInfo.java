package com.sis.model;

/**
 * @author luchenxi
 *
 */
public class AttendInfo {
	private String area;
	private String major;
	private String majorDetail;
	private String majorDetailId;
	private String agePart;
	private String schedule;
	private String userPhone;
	private String classId;
	private String clazzId;
	private String studentId;

	public String getClazzId() {
		return clazzId;
	}

	public void setClazzId(String clazzId) {
		this.clazzId = clazzId;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getMajorDetailId() {
		return majorDetailId;
	}

	public void setMajorDetailId(String majorDetailId) {
		this.majorDetailId = majorDetailId;
	}

	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getMajorDetail() {
		return majorDetail;
	}
	public void setMajorDetail(String majorDetail) {
		this.majorDetail = majorDetail;
	}
	public String getAgePart() {
		return agePart;
	}
	public void setAgePart(String agePart) {
		this.agePart = agePart;
	}
	public String getSchedule() {
		return schedule;
	}
	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}

	@Override public String toString()
	{
		return "AttendInfo{" + "area='" + area + '\'' + ", major='" + major + '\'' + ", majorDetail='" +
			majorDetail + '\'' + ", agePart='" + agePart + '\'' + ", schedule='" + schedule + '\'' +
			", userPhone='" + userPhone + '\'' + ", classId='" + classId + '\'' + '}';
	}
}
