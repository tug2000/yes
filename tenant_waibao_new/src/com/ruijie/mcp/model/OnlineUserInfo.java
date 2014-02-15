package com.ruijie.mcp.model;

import java.util.Date;

/**
 * 在线用户表
 * @author 林宏
 * 2013-9-10
 */
public class OnlineUserInfo implements java.io.Serializable {

	/**
	 * ID
	 */
	private int ouId;
	
	/**
	 * MAC
	 */
	private String ouMac;
	
	/**
	 * 手机号
	 */
	private String ouMobile;
	
	/**
	 * 登录时间
	 */
	private Date ouLoginTime;
	
	/**
	 * 用户IP
	 */
	private String ouUserIp;
	
	/**
	 * 类型 
	 * 1代表手机端
	 * 2代表pc和平板端
	 * 3代表微信端
	 */
	private String ouType;
	
	/**
	 * 租户id
	 */
	private String ouTenantId;

	/**
	 * user Id
	 */
	private String ouUserId;
	// Constructors

	public String getOuType() {
		return ouType;
	}

	public void setOuType(String ouType) {
		this.ouType = ouType;
	}

	/** default constructor */
	public OnlineUserInfo() {
	}

	/** minimal constructor */
	public OnlineUserInfo(String ouMobile, Date ouLoginTime) {
		this.ouMobile = ouMobile;
		this.ouLoginTime = ouLoginTime;
	}

	/** full constructor */
	public OnlineUserInfo(String ouMobile, Date ouLoginTime, String ouUserIp) {
		this.ouMobile = ouMobile;
		this.ouLoginTime = ouLoginTime;
		this.ouUserIp = ouUserIp;
	}

	// Property accessors

	public String getOuMobile() {
		return this.ouMobile;
	}

	public void setOuMobile(String ouMobile) {
		this.ouMobile = ouMobile;
	}

	public Date getOuLoginTime() {
		return this.ouLoginTime;
	}

	public void setOuLoginTime(Date ouLoginTime) {
		this.ouLoginTime = ouLoginTime;
	}

	public String getOuUserIp() {
		return this.ouUserIp;
	}

	public void setOuUserIp(String ouUserIp) {
		this.ouUserIp = ouUserIp;
	}

	public int getOuId() {
		return ouId;
	}

	public void setOuId(int ouId) {
		this.ouId = ouId;
	}

	public String getOuMac() {
		return ouMac;
	}

	public void setOuMac(String ouMac) {
		this.ouMac = ouMac;
	}

	public String getOuTenantId() {
		return ouTenantId;
	}

	public void setOuTenantId(String ouTenantId) {
		this.ouTenantId = ouTenantId;
	}

	public String getOuUserId() {
		return ouUserId;
	}

	public void setOuUserId(String ouUserId) {
		this.ouUserId = ouUserId;
	}

}