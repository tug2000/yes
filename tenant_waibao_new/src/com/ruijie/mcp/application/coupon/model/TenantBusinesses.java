package com.ruijie.mcp.application.coupon.model;

import java.io.Serializable;

public class TenantBusinesses implements Serializable {
    /**	
     * Member Description
     */

    private static final long serialVersionUID = 1L;

    /**
     * 序号Id
     */
    private Long tbId;

    /**
     * 租户ID
     */
    private String tbTenantId;

    /**
     * logo路径
     */
    private String tbLogoUrl;

    /**
     * 商家名字
     */
    private String tbBusName;

    /**
     * 联系电话
     */
    private String tbContactNumber;

    /**
     * 地址
     */
    private String tbAddress;

    public Long getTbId() {
        return tbId;
    }

    public void setTbId(Long tbId) {
        this.tbId = tbId;
    }

    public String getTbTenantId() {
        return tbTenantId;
    }

    public void setTbTenantId(String tbTenantId) {
        this.tbTenantId = tbTenantId;
    }

    public String getTbLogoUrl() {
        return tbLogoUrl;
    }

    public void setTbLogoUrl(String tbLogoUrl) {
        this.tbLogoUrl = tbLogoUrl;
    }

    public String getTbBusName() {
        return tbBusName;
    }

    public void setTbBusName(String tbBusName) {
        this.tbBusName = tbBusName;
    }

    public String getTbContactNumber() {
        return tbContactNumber;
    }

    public void setTbContactNumber(String tbContactNumber) {
        this.tbContactNumber = tbContactNumber;
    }

    public String getTbAddress() {
        return tbAddress;
    }

    public void setTbAddress(String tbAddress) {
        this.tbAddress = tbAddress;
    }
}
