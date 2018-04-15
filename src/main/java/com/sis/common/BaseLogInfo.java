package com.sis.common;

public class BaseLogInfo {
    private String logId;
    //调用时间
    private String date;
    //调用远程接口
    private String interfacePath;
    //调用参数
    private String param;
    //调用返回结果
    private String resultData;
    //描述
    private String desc;

    public BaseLogInfo(String date, String interfacePath, String param, String resultData, String desc) {
        this.date = date;
        this.interfacePath = interfacePath;
        this.param = param;
        this.resultData = resultData;
        this.desc = desc;
    }

    @Override
    public String toString() {
        return logId+"|"+date+"|"+interfacePath+"|"+param+"|"+resultData+"|"+desc;
    }

    public String getLogId() {
        return logId;
    }

    public void setLogId(String logId) {
        this.logId = logId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getInterfacePath() {
        return interfacePath;
    }

    public void setInterfacePath(String interfacePath) {
        this.interfacePath = interfacePath;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public String getResultData() {
        return resultData;
    }

    public void setResultData(String resultData) {
        this.resultData = resultData;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
