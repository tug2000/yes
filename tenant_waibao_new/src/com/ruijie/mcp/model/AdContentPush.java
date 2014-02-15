package com.ruijie.mcp.model;

import java.util.Date;


/**
 * 手机广告发送功能
 * @author 林宏
 * 2013-9-10
 */
public class AdContentPush implements java.io.Serializable {

	/**
	 * 流水号
	 */
	private String apId;
	
	/**
	 * 下发内容
	 */
	private String apContent;
	
	/**
	 * 填写时间
	 */
	private Date apWriteTime;
	
	/**
	 * 发送类型
	 * 1：所有用户
	 * 2：在线用户
	 */
	private Integer apPushType;
	
	/**
	 * 租户ID
	 */
	private String apTenantId;


	/**
	 * 
	 * 
	 * @return
	 */
	private Long apCount;
	
	public String getApTenantId() {
		return apTenantId;
	}

	public void setApTenantId(String apTenantId) {
		this.apTenantId = apTenantId;
	}

	/** default constructor */
	public AdContentPush() {
	}

	// Property accessors

	public String getApContent() {
		return this.apContent;
	}

	public String getApId() {
		return apId;
	}

	public void setApId(String apId) {
		this.apId = apId;
	}

	public void setApContent(String apContent) {
		this.apContent = apContent;
	}

	public Date getApWriteTime() {
		return this.apWriteTime;
	}

	public void setApWriteTime(Date apWriteTime) {
		this.apWriteTime = apWriteTime;
	}

	public Integer getApPushType() {
		return this.apPushType;
	}

	public void setApPushType(Integer apPushType) {
		this.apPushType = apPushType;
	}

	public Long getApCount() {
		return apCount;
	}

	public void setApCount(Long apCount) {
		this.apCount = apCount;
	}


}