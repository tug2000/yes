package com.ruijie.mcp.model;

import java.util.Date;

/**
 * UserRegister entity. @author MyEclipse Persistence Tools
 */

public class UserRegister implements java.io.Serializable {

	// Fields
	private int urId;
	private String urPhoneNumber;
	private String urMac;
	private String urUserIp;
	private String urMessageCode;
	private Date urCreateTime;
	private Date urPeriodValidateTime;
	private Integer urTotalOnlineTime;
	/**
	 * 类型 
	 * 1代表手机端
	 * 2代表pc和平板端
	 * 3代表微信端
	 */
	private String urType;
	private String urTenantId;
	/**
	 * 是否已经认证
	 * 0代表未认证
	 * 1代表已认证过
	 */
	private String urIfInitialize;
	
	

	// Constructors

	public String getUrIfInitialize() {
		return urIfInitialize;
	}

	public void setUrIfInitialize(String urIfInitialize) {
		this.urIfInitialize = urIfInitialize;
	}

	public String getUrType() {
		return urType;
	}

	public void setUrType(String urType) {
		this.urType = urType;
	}

	/** default constructor */
	public UserRegister() {
	}

	/** minimal constructor */
	public UserRegister(String urMessageCode, Date urCreateTime, Date urPeriodValidateTime) {
		this.urMessageCode = urMessageCode;
		this.urCreateTime = urCreateTime;
		this.urPeriodValidateTime = urPeriodValidateTime;
	}

	/** full constructor */
	public UserRegister(String urUserIp, String urMessageCode, Date urCreateTime, Date urPeriodValidateTime, Integer urAppliedFrequency,
			Date urCurrentDeadlineTime) {
		this.urUserIp = urUserIp;
		this.urMessageCode = urMessageCode;
		this.urCreateTime = urCreateTime;
		this.urPeriodValidateTime = urPeriodValidateTime;
		this.urTotalOnlineTime = urTotalOnlineTime;
		this.urTenantId = urTenantId;
		this.urType = urType;
	}

	public String getUrPhoneNumber() {
		return urPhoneNumber;
	}

	public void setUrPhoneNumber(String urPhoneNumber) {
		this.urPhoneNumber = urPhoneNumber;
	}

	public String getUrUserIp() {
		return urUserIp;
	}

	public void setUrUserIp(String urUserIp) {
		this.urUserIp = urUserIp;
	}

	public String getUrMessageCode() {
		return urMessageCode;
	}

	public void setUrMessageCode(String urMessageCode) {
		this.urMessageCode = urMessageCode;
	}

	public Date getUrCreateTime() {
		return urCreateTime;
	}

	public void setUrCreateTime(Date urCreateTime) {
		this.urCreateTime = urCreateTime;
	}

	public Date getUrPeriodValidateTime() {
		return urPeriodValidateTime;
	}

	public void setUrPeriodValidateTime(Date urPeriodValidateTime) {
		this.urPeriodValidateTime = urPeriodValidateTime;
	}

	public Integer getUrTotalOnlineTime() {
		return urTotalOnlineTime;
	}

	public void setUrTotalOnlineTime(Integer urTotalOnlineTime) {
		this.urTotalOnlineTime = urTotalOnlineTime;
	}

	public int getUrId() {
		return urId;
	}

	public void setUrId(int urId) {
		this.urId = urId;
	}

	public String getUrMac() {
		return urMac;
	}

	public void setUrMac(String urMac) {
		this.urMac = urMac;
	}

	public String getUrTenantId() {
		return urTenantId;
	}

	public void setUrTenantId(String urTenantId) {
		this.urTenantId = urTenantId;
	}

}