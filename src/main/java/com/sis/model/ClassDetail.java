package com.sis.model;


public class ClassDetail {
    //报名时首先展示信息
    private String id;
    private String age;
    private String major;
    private String classCode;
    private String className;
    private String area;
    private String status;
    private String cost;
    //详细信息
    //学年
    private String term;
    //学期
    private String semester;
    //专业程度
    private String level;
    //开课时间
    private String date;
    //课程次数
    private String times;
    //描述
    private String desc;
    //课表信息
    private String scheduleInfo;
    //能力特征
    private String ability;
    //态度特征
    private String attitudinal;
    // 学生姓名
    private String studentName;
    //缴费状态
    private String statusName;
    //预约号
    private String reserveNo;
    //开课期间
    String classDate;
    //开课开始时间
    String beginTime;
    //临时变量无业务含义
    String nowDate;

    //总共打印次数
    int printNum;

    public ClassDetail() {
    }

    public ClassDetail(String age , String major, String classCode, String className, String cost, String area, String status) {
        this.major = major;
        this.classCode = classCode;
        this.className = className;
        this.area = area;
        this.age = age;
        this.cost = cost;
        this.status = status;

    }

    @Override public String toString()
    {
        return "ClassDetail{" + "id='" + id + '\'' + ", age='" + age + '\'' + ", major='" + major + '\'' +
                ", classCode='" + classCode + '\'' + ", className='" + className + '\'' + ", area='" + area + '\'' +
                ", status='" + status + '\'' + ", cost='" + cost + '\'' + ", term='" + term + '\'' + ", semester='" +
                semester + '\'' + ", level='" + level + '\'' + ", date='" + date + '\'' + ", times='" + times + '\'' +
                ", desc='" + desc + '\'' + ", scheduleInfo='" + scheduleInfo + '\'' + ", ability='" + ability + '\'' +
                ", attitudinal='" + attitudinal + '\'' + ", studentName='" + studentName + '\'' + ", statusName='" +
                statusName + '\'' + '}';
    }

    public String getStatusName()
    {
        return statusName;
    }

    public void setStatusName(String statusName)
    {
        this.statusName = statusName;
    }

    public String getStudentName()
    {
        return studentName;
    }

    public void setStudentName(String studentName)
    {
        this.studentName = studentName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAge()
    {
        return age;
    }

    public void setAge(String age)
    {
        this.age = age;
    }

    public String getMajor()
    {
        return major;
    }

    public void setMajor(String major)
    {
        this.major = major;
    }

    public String getClassCode()
    {
        return classCode;
    }

    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }

    public String getClassName()
    {
        return className;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }

    public String getArea()
    {
        return area;
    }

    public void setArea(String area)
    {
        this.area = area;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getCost()
    {
        return cost;
    }

    public void setCost(String cost)
    {
        this.cost = cost;
    }

    public String getTerm()
    {
        return term;
    }

    public void setTerm(String term)
    {
        this.term = term;
    }

    public String getSemester()
    {
        return semester;
    }

    public void setSemester(String semester)
    {
        this.semester = semester;
    }

    public String getLevel()
    {
        return level;
    }

    public void setLevel(String level)
    {
        this.level = level;
    }

    public String getDate()
    {
        return date;
    }

    public void setDate(String date)
    {
        this.date = date;
    }

    public String getTimes()
    {
        return times;
    }

    public void setTimes(String times)
    {
        this.times = times;
    }

    public String getDesc()
    {
        return desc;
    }

    public void setDesc(String desc)
    {
        this.desc = desc;
    }

    public String getScheduleInfo()
    {
        return scheduleInfo;
    }

    public void setScheduleInfo(String scheduleInfo)
    {
        this.scheduleInfo = scheduleInfo;
    }

    public String getAbility()
    {
        return ability;
    }

    public void setAbility(String ability)
    {
        this.ability = ability;
    }

    public String getAttitudinal()
    {
        return attitudinal;
    }

    public void setAttitudinal(String attitudinal)
    {
        this.attitudinal = attitudinal;
    }

    public String getReserveNo() {
        return reserveNo;
    }

    public void setReserveNo(String reserveNo) {
        this.reserveNo = reserveNo;
    }

    public String getClassDate() {
        return classDate;
    }

    public void setClassDate(String classDate) {
        this.classDate = classDate;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getNowDate() {
        return nowDate;
    }

    public void setNowDate(String nowDate) {
        this.nowDate = nowDate;
    }

    public int getPrintNum() {
        return printNum;
    }

    public void setPrintNum(int printNum) {
        this.printNum = printNum;
    }
}
