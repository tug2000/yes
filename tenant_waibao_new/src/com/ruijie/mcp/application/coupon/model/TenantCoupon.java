package com.ruijie.mcp.application.coupon.model;

import java.io.Serializable;
import java.util.Date;

public class TenantCoupon implements Serializable {

    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = 4505296248227824384L;

    private Long tcCoId;

    private String tcCouponTenantId;

    private String tcCouponName;

    private String tcCouponIcoUrl;

    /**
     * 兑换奖品个数
     */
    private Integer tcCouponConvertibleNum;
    
    /**
     * 可兑换的下限数
     */
    private Integer tcCouponConvertibleSum;
    
    /**
     * 点券卡发行数量
     */
    private Integer tcPublishSum;
    
    /**
     * 点券已使用数量
     */
    private Integer tcUsedSum;
    
    /**
     * 顾客限用次数，0：不限制，1：限用1张，2：限用2张，....
     */
    private Integer tcUserLimitStatus;

    /**
     * 有效期起始时间
     */
    private Date tcValIdBeginDateTime;
    
    /**
     * 点券状态，0：正常使用，1：暂停使用，2：已删除
     */
    private Integer tcCouponStatus;
    
    /**
     * 用户量
     */
    private Integer tcUserSum;
    
    /**
     * 售出量
     */
    private Integer tcSaleSum;
    
    
    /**
     * 有效期截止时间
     */
    private Date tcValIdEndDateTime;

    private String tcCouponActiviyDes;

    private String tcCouponPrizeUnit;

    private Date tcCreateTime;

    public Long getTcCoId() {
        return tcCoId;
    }

    public void setTcCoId(Long tcCoId) {
        this.tcCoId = tcCoId;
    }

    public String getTcCouponTenantId() {
        return tcCouponTenantId;
    }

    public void setTcCouponTenantId(String tcCouponTenantId) {
        this.tcCouponTenantId = tcCouponTenantId;
    }

    public String getTcCouponName() {
        return tcCouponName;
    }

    public void setTcCouponName(String tcCouponName) {
        this.tcCouponName = tcCouponName;
    }

    public String getTcCouponIcoUrl() {
        return tcCouponIcoUrl;
    }

    public void setTcCouponIcoUrl(String tcCouponIcoUrl) {
        this.tcCouponIcoUrl = tcCouponIcoUrl;
    }

    public String getTcCouponActiviyDes() {
        return tcCouponActiviyDes;
    }

    public void setTcCouponActiviyDes(String tcCouponActiviyDes) {
        this.tcCouponActiviyDes = tcCouponActiviyDes;
    }

    public String getTcCouponPrizeUnit() {
        return tcCouponPrizeUnit;
    }

    public void setTcCouponPrizeUnit(String tcCouponPrizeUnit) {
        this.tcCouponPrizeUnit = tcCouponPrizeUnit;
    }

    public void setTcCouponConvertibleNum(Integer tcCouponConvertibleNum) {
        this.tcCouponConvertibleNum = tcCouponConvertibleNum;
    }

    public Integer getTcCouponConvertibleNum() {
        return tcCouponConvertibleNum;
    }

    public void setTcCouponConvertibleSum(Integer tcCouponConvertibleSum) {
        this.tcCouponConvertibleSum = tcCouponConvertibleSum;
    }

    public Integer getTcCouponConvertibleSum() {
        return tcCouponConvertibleSum;
    }

    public void setTcValIdBeginDateTime(Date tcValIdBeginDateTime) {
        this.tcValIdBeginDateTime = tcValIdBeginDateTime;
    }

    public Date getTcValIdBeginDateTime() {
        return tcValIdBeginDateTime;
    }

    public void setTcValIdEndDateTime(Date tcValIdEndDateTime) {
        this.tcValIdEndDateTime = tcValIdEndDateTime;
    }

    public Date getTcValIdEndDateTime() {
        return tcValIdEndDateTime;
    }

    public void setTcPublishSum(Integer tcPublishSum) {
        this.tcPublishSum = tcPublishSum;
    }

    public Integer getTcPublishSum() {
        return tcPublishSum;
    }

    public void setTcUserLimitStatus(Integer tcUserLimitStatus) {
        this.tcUserLimitStatus = tcUserLimitStatus;
    }

    public Integer getTcUserLimitStatus() {
        return tcUserLimitStatus;
    }

    public void setTcUsedSum(Integer tcUsedSum) {
        this.tcUsedSum = tcUsedSum;
    }

    public Integer getTcUsedSum() {
        return tcUsedSum;
    }

    public void setTcCouponStatus(Integer tcCouponStatus) {
        this.tcCouponStatus = tcCouponStatus;
    }

    public Integer getTcCouponStatus() {
        return tcCouponStatus;
    }

    public void setTcUserSum(Integer tcUserSum) {
        this.tcUserSum = tcUserSum;
    }

    public Integer getTcUserSum() {
        return tcUserSum;
    }

    public void setTcSaleSum(Integer tcSaleSum) {
        this.tcSaleSum = tcSaleSum;
    }

    public Integer getTcSaleSum() {
        return tcSaleSum;
    }

    public void setTcCreateTime(Date tcCreateTime) {
        this.tcCreateTime = tcCreateTime;
    }

    public Date getTcCreateTime() {
        return tcCreateTime;
    }
}
