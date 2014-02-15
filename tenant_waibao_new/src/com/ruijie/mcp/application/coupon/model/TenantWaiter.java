package com.ruijie.mcp.application.coupon.model;

import java.io.Serializable;
import java.util.Date;

public class TenantWaiter implements Serializable  {

    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = -7651322901231677824L;
    
    private Long twId;
    
    /**
     * 租户Id
     */
    private String twTenantId;
    
    /**
     * 店员名字
     */
    private String twWaiterName;
    
    /**
     * 店员APP登录名
     */
    private String twAppUserName;
    
    /**
     * 店员APP登录密码
     */
    private String twAppPwd;
    
    /**
     * 接口调用令牌
     */
    private String twAccessToken;
    
    /**
     * 创建时间
     */
    private Date createTime;
    
    public void setTwId(Long twId) {
        this.twId = twId;
    }
    public Long getTwId() {
        return twId;
    }
    public void setTwTenantId(String twTenantId) {
        this.twTenantId = twTenantId;
    }
    public String getTwTenantId() {
        return twTenantId;
    }
    public void setTwWaiterName(String twWaiterName) {
        this.twWaiterName = twWaiterName;
    }
    public String getTwWaiterName() {
        return twWaiterName;
    }
    public void setTwAppUserName(String twAppUserName) {
        this.twAppUserName = twAppUserName;
    }
    public String getTwAppUserName() {
        return twAppUserName;
    }
    public void setTwAppPwd(String twAppPwd) {
        this.twAppPwd = twAppPwd;
    }
    public String getTwAppPwd() {
        return twAppPwd;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setTwAccessToken(String twAccessToken) {
        this.twAccessToken = twAccessToken;
    }
    public String getTwAccessToken() {
        return twAccessToken;
    }

}
