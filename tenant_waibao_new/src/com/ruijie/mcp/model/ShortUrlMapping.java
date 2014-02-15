package com.ruijie.mcp.model;

import java.util.Date;

public class ShortUrlMapping implements java.io.Serializable {

    
    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = -6549971181373989456L;

    /**
     * uuId
     */
    private String suId;
    
    /**
     * 短链接 编码
     */
    private String shortCode;
    
    /**
     * 长链接
     */
    private String longURL;
    
    /**
     * 创建时间
     */
    private Date createTime;

    public void setSuId(String suId) {
        this.suId = suId;
    }

    public String getSuId() {
        return suId;
    }

    public void setLongURL(String longURL) {
        this.longURL = longURL;
    }

    public String getLongURL() {
        return longURL;
    }

    public void setShortCode(String shortCode) {
        this.shortCode = shortCode;
    }

    public String getShortCode() {
        return shortCode;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getCreateTime() {
        return createTime;
    }
    
}
