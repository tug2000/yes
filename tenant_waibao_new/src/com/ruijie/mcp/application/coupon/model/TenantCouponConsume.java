package com.ruijie.mcp.application.coupon.model;

import java.io.Serializable;
import java.util.Date;

public class TenantCouponConsume implements Serializable {

    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = -6753341163441954594L;

    private Long tcCcId;

    private String tcTenantId;

    private Long tcCuId;

    private Long tcCoId;

    private Integer tcNumber;

    private Long tcWaiterId;

    private Date tcDate;

    public Long getTcCcId() {
        return tcCcId;
    }

    public void setTcCcId(Long tcCcId) {
        this.tcCcId = tcCcId;
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
