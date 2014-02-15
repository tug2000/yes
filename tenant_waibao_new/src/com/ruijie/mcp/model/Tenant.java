package com.ruijie.mcp.model;

/**
 * Tenant entity. @author MyEclipse Persistence Tools
 */

public class Tenant implements java.io.Serializable {

	// Fields

	private String tenantUuid;
	private String tenantName;

	// Constructors

	/** default constructor */
	public Tenant() {
	}

	/** full constructor */
	public Tenant(String tenantName) {
		this.tenantName = tenantName;
	}

	// Property accessors

	public String getTenantUuid() {
		return this.tenantUuid;
	}

	public void setTenantUuid(String tenantUuid) {
		this.tenantUuid = tenantUuid;
	}

	public String getTenantName() {
		return this.tenantName;
	}

	public void setTenantName(String tenantName) {
		this.tenantName = tenantName;
	}

}