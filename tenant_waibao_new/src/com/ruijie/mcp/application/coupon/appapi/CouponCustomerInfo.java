package com.ruijie.mcp.application.coupon.appapi;

import java.util.Date;

public class CouponCustomerInfo {
    
    /**
     * 点券Id
     */
    private Long CouponId;
    
    /**
     * 点券名称
     */
    private String couponName;
    
    /**
     * 点券活动说明
     */
    private String couponDesc;
    
    /**
     * 点券有效期
     */
    private Date validDate;
    
    /**
     * 点券图片路径
     */
    private String couponImgUrl;
    
    /**
     * 兑换奖品单位
     */
    private String CouponPrizeUnit;
    
    /**
     * 点券总数
     */
    private Integer couponSum;
    
    /**
     * 当前点券数
     */
    private Integer couponNum;
    
    /**
     * 待兑换数
     */
    private Integer waitConverNum;

    public void setCouponId(Long couponId) {
        CouponId = couponId;
    }

    public Long getCouponId() {
        return CouponId;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponDesc(String couponDesc) {
        this.couponDesc = couponDesc;
    }

    public String getCouponDesc() {
        return couponDesc;
    }

    public void setValidDate(Date validDate) {
        this.validDate = validDate;
    }

    public Date getValidDate() {
        return validDate;
    }

    public void setCouponImgUrl(String couponImgUrl) {
        this.couponImgUrl = couponImgUrl;
    }

    public String getCouponImgUrl() {
        return couponImgUrl;
    }

    public void setCouponPrizeUnit(String couponPrizeUnit) {
        CouponPrizeUnit = couponPrizeUnit;
    }

    public String getCouponPrizeUnit() {
        return CouponPrizeUnit;
    }

    public void setCouponNum(Integer couponNum) {
        this.couponNum = couponNum;
    }

    public Integer getCouponNum() {
        return couponNum;
    }

    public void setWaitConverNum(Integer waitConverNum) {
        this.waitConverNum = waitConverNum;
    }

    public Integer getWaitConverNum() {
        return waitConverNum;
    }

    public void setCouponSum(Integer couponSum) {
        this.couponSum = couponSum;
    }

    public Integer getCouponSum() {
        return couponSum;
    }

}
