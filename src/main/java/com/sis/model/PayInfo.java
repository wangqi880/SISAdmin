package com.sis.model;

/**
 * 预约信息
 * @author Administrator
 *
 */
public class PayInfo {
	String payCode;//预约号
	String classCode ; //班级代码
	String stuId; //学生ID;
	String phone; //手机号;
	String status;//状态，是否已支付
	public String getPayCode() {
		return payCode;
	}
	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}
	public String getClassCode() {
		return classCode;
	}
	public void setClassCode(String classCode) {
		this.classCode = classCode;
	}
	public String getStuId() {
		return stuId;
	}
	public void setStuId(String stuId) {
		this.stuId = stuId;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "PayInfo [payCode=" + payCode + ", classCode=" + classCode + ", stuId=" + stuId + ", phone=" + phone
				+ ", status=" + status + ", getPayCode()=" + getPayCode() + ", getClassCode()=" + getClassCode()
				+ ", getStuId()=" + getStuId() + ", getPhone()=" + getPhone() + ", getStatus()=" + getStatus()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}

	public PayInfo() {
	}

	public PayInfo(String payCode, String classCode, String stuId, String phone, String status) {
		super();
		this.payCode = payCode;
		this.classCode = classCode;
		this.stuId = stuId;
		this.phone = phone;
		this.status = status;
	}
	
	
}
