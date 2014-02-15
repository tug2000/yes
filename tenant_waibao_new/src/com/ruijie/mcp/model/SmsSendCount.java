package com.ruijie.mcp.model;

/**
 * SmsSendCount entity. @author MyEclipse Persistence Tools
 */

public class SmsSendCount implements java.io.Serializable {

	// Fields

	/**
	 * UUID
	 */
	private String sscUuid;
	
	/**
	 * 租户UUID
	 */
	private String sscTenantId;
	
	/**
	 * 短信发送数量
	 */
	private Integer sscSendCount;

	// Constructors

	/** default constructor */
	public SmsSendCount() {
	}

	/** minimal constructor */
	public SmsSendCount(String sscUuid, String sscTenantId) {
		this.sscUuid = sscUuid;
		this.sscTenantId = sscTenantId;
	}

	/** full constructor */
	public SmsSendCount(String sscUuid, String sscTenantId, Integer sscSendCount) {
		this.sscUuid = sscUuid;
		this.sscTenantId = sscTenantId;
		this.sscSendCount = sscSendCount;
	}

	// Property accessors

	public String getSscUuid() {
		return this.sscUuid;
	}

	public void setSscUuid(String sscUuid) {
		this.sscUuid = sscUuid;
	}

	public String getSscTenantId() {
		return this.sscTenantId;
	}

	public void setSscTenantId(String sscTenantId) {
		this.sscTenantId = sscTenantId;
	}

	public Integer getSscSendCount() {
		return this.sscSendCount;
	}

	public void setSscSendCount(Integer sscSendCount) {
		this.sscSendCount = sscSendCount;
	}

}