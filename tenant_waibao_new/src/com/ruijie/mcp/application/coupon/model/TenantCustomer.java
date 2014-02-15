package com.ruijie.mcp.application.coupon.model;

import java.io.Serializable;
import java.util.Date;

public class TenantCustomer implements Serializable {


    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = 4163365625359868567L;

    private Long tcCuId;

    private Long tcQrCodeNnm;

    private String tcQrCodeImgUrl;

    /**
     * 顾客来源，0：微信，1：微博
     */
    private Integer tcCustomerSource;

    private String tcOpenId;

    private String tcThirdPartyName;

    private String tcThirdPartyAccount;

    private Date tcCreateTime;

    public Long getTcCuId() {
        return tcCuId;
    }

    public void setTcCuId(Long tcCuId) {
        this.tcCuId = tcCuId;
    }

    public Long getTcQrCodeNnm() {
        return tcQrCodeNnm;
    }

    public void setTcQrCodeNnm(Long tcQrCodeNnm) {
        this.tcQrCodeNnm = tcQrCodeNnm;
    }

    public String getTcQrCodeImgUrl() {
        return tcQrCodeImgUrl;
    }

    public void setTcQrCodeImgUrl(String tcQrCodeImgUrl) {
        this.tcQrCodeImgUrl = tcQrCodeImgUrl;
    }

    public String getTcOpenId() {
        return tcOpenId;
    }

    public void setTcOpenId(String tcOpenId) {
        this.tcOpenId = tcOpenId;
    }

    public String getTcThirdPartyName() {
        return tcThirdPartyName;
    }

    public void setTcThirdPartyName(String tcThirdPartyName) {
        this.tcThirdPartyName = tcThirdPartyName;
    }

    public String getTcThirdPartyAccount() {
        return tcThirdPartyAccount;
    }

    public void setTcThirdPartyAccount(String tcThirdPartyAccount) {
        this.tcThirdPartyAccount = tcThirdPartyAccount;
    }

    public Date getTcCreateTime() {
        return tcCreateTime;
    }

    public void setTcCreateTime(Date tcCreateTime) {
        this.tcCreateTime = tcCreateTime;
    }

    public void setTcCustomerSource(Integer tcCustomerSource) {
        this.tcCustomerSource = tcCustomerSource;
    }

    public Integer getTcCustomerSource() {
        return tcCustomerSource;
    }
}
