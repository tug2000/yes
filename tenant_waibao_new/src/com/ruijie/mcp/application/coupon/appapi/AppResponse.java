package com.ruijie.mcp.application.coupon.appapi;

public class AppResponse {
    
    /**
     * 错误编码，0：执行成功，1：执行异常，2：业务失败
     */
    private Integer errcode;
    
    /**
     * 错误描述
     */
    private String errmsg;
    
    /**
     * 附加信息
     */
    private String additionInfo;

    public void setErrcode(Integer errcode) {
        this.errcode = errcode;
    }

    public Integer getErrcode() {
        return errcode;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }

    public String getErrmsg() {
        return errmsg;
    }

    public void setAdditionInfo(String additionInfo) {
        this.additionInfo = additionInfo;
    }

    public String getAdditionInfo() {
        return additionInfo;
    }

}
