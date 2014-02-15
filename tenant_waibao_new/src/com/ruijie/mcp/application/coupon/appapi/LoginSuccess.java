package com.ruijie.mcp.application.coupon.appapi;

public class LoginSuccess {
    
    /**
     * 店员Id
     */
    private Long waiterId;
    
    /**
     * 租户Id
     */
    private String tenantId;
    
    /**
     * 接口访问令牌
     */
    private String accessToken;

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setWaiterId(Long waiterId) {
        this.waiterId = waiterId;
    }

    public Long getWaiterId() {
        return waiterId;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getAccessToken() {
        return accessToken;
    }

}
