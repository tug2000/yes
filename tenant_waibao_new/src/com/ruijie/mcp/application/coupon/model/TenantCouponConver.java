package com.ruijie.mcp.application.coupon.model;

import java.io.Serializable;
import java.util.Date;

public class TenantCouponConver implements Serializable {

    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = -8352172724146087731L;

    private Long tcConvId;

    private String tcTenantId;

    private Long tcCuId;

    private Long tcCoId;

    private Integer tcNumber;

    private Long tcWaiterId;

    private Date tcDate;

    public Long getTcConvId() {
        return tcConvId;
    }

    public void setTcConvId(Long tcConvId) {
        this.tcConvId = tcConvId;
    }

    public String getTcTenantId() {
        return tcTenantId;
    }

    public void setTcTenantId(String tcTenantId) {
        this.tcTenantId = tcTenantId;
    }

    public Long getTcCuId() {
        return tcCuId;
    }

    public void setTcCuId(Long tcCuId) {
        this.tcCuId = tcCuId;
    }

    public Long getTcCoId() {
        return tcCoId;
    }

    public void setTcCoId(Long tcCoId) {
        this.tcCoId = tcCoId;
    }

    public Integer getTcNumber() {
        return tcNumber;
    }

    public void setTcNumber(Integer tcNumber) {
        this.tcNumber = tcNumber;
    }

    public Date getTcDate() {
        return tcDate;
    }

    public void setTcDate(Date tcDate) {
        this.tcDate = tcDate;
    }

    public void setTcWaiterId(Long tcWaiterId) {
        this.tcWaiterId = tcWaiterId;
    }

    public Long getTcWaiterId() {
        return tcWaiterId;
    }

}
