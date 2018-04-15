package com.sis.model;

/**
 * 账号信息
 * Created by 13046 on 2017/11/10.
 */
public class StudentInfo
{
	private String studentId;
	private String stuName;
	private String stuSex;
	private String birthDay;
	private String phoneNumber;
	private String indentityCard;
	private String schoolName;
	private String parentName;
	private String familyCall;
	private String grade;
	private String attentionInfo;

	public StudentInfo() {
	}

	public StudentInfo(String stuName, String stuSex, String birthDay, String phoneNumber, String indentityCard,
					   String schoolName, String parentName, String familyCall, String grade, String attentionInfo)
	{
		this.stuName = stuName;
		this.stuSex = stuSex;
		this.birthDay = birthDay;
		this.phoneNumber = phoneNumber;
		this.indentityCard = indentityCard;
		this.schoolName = schoolName;
		this.parentName = parentName;
		this.familyCall = familyCall;
		this.grade = grade;
		this.attentionInfo = attentionInfo;
	}

	@Override public String toString()
	{
		return "StudentInfo{" + "stuName='" + stuName + '\'' + ", stuSex='" + stuSex + '\'' + ", birthDay='" +
			birthDay + '\'' + ", phoneNumber='" + phoneNumber + '\'' + ", indentityCard='" + indentityCard +
			'\'' + ", schoolName='" + schoolName + '\'' + ", parentName='" + parentName + '\'' +
			", familyCall='" + familyCall + '\'' + ", grade='" + grade + '\'' + ", attentionInfo='" +
			attentionInfo + '\'' + '}';
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getStuName()
	{
		return stuName;
	}

	public void setStuName(String stuName)
	{
		this.stuName = stuName;
	}

	public String getStuSex()
	{
		return stuSex;
	}

	public void setStuSex(String stuSex)
	{
		this.stuSex = stuSex;
	}

	public String getBirthDay()
	{
		return birthDay;
	}

	public void setBirthDay(String birthDay)
	{
		this.birthDay = birthDay;
	}

	public String getPhoneNumber()
	{
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber)
	{
		this.phoneNumber = phoneNumber;
	}

	public String getIndentityCard()
	{
		return indentityCard;
	}

	public void setIndentityCard(String indentityCard)
	{
		this.indentityCard = indentityCard;
	}

	public String getSchoolName()
	{
		return schoolName;
	}

	public void setSchoolName(String schoolName)
	{
		this.schoolName = schoolName;
	}

	public String getParentName()
	{
		return parentName;
	}

	public void setParentName(String parentName)
	{
		this.parentName = parentName;
	}

	public String getFamilyCall()
	{
		return familyCall;
	}

	public void setFamilyCall(String familyCall)
	{
		this.familyCall = familyCall;
	}

	public String getGrade()
	{
		return grade;
	}

	public void setGrade(String grade)
	{
		this.grade = grade;
	}

	public String getAttentionInfo()
	{
		return attentionInfo;
	}

	public void setAttentionInfo(String attentionInfo)
	{
		this.attentionInfo = attentionInfo;
	}
}
