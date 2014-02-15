package com.ruijie.mcp.application.coupon.model;

import java.io.Serializable;

public class TenantCustomerCoupon implements Serializable {


    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = -8678250534546269713L;

    private Long tccId;

    private String tccTenantId;

    private Long tccCuId;

    private Long tccCoId;

    private Integer tccCouponNum;

    private Integer tccWaitConverNum;

    private Integer tccConvertibleNum;

    public Long getTccId() {
        return tccId;
    }

    public void setTccId(Long tccId) {
        this.tccId = tccId;
    }

    public String getTccTenantId() {
        return tccTenantId;
    }

    public void setTccTenantId(String tccTenantId) {
        this.tccTenantId = tccTenantId;
    }

    public Long getTccCuId() {
        return tccCuId;
    }

    public void setTccCuId(Long tccCuId) {
        this.tccCuId = tccCuId;
    }

    public Long getTccCoId() {
        return tccCoId;
    }

    public void setTccCoId(Long tccCoId) {
        this.tccCoId = tccCoId;
    }

    public Integer getTccCouponNum() {
        return tccCouponNum;
    }

    public void setTccCouponNum(Integer tccCouponNum) {
        this.tccCouponNum = tccCouponNum;
    }

    public Integer getTccWaitConverNum() {
        return tccWaitConverNum;
    }

    public void setTccWaitConverNum(Integer tccWaitConverNum) {
        this.tccWaitConverNum = tccWaitConverNum;
    }

    public Integer getTccConvertibleNum() {
        return tccConvertibleNum;
    }

    public void setTccConvertibleNum(Integer tccConvertibleNum) {
        this.tccConvertibleNum = tccConvertibleNum;
    }
}
