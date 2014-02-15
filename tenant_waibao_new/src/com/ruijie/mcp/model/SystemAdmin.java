package com.ruijie.mcp.model;

import java.util.Date;

import com.ruijie.mcp.network.tr069.server.CWMPSupportDevice;

/**
 * SystemAdmin entity. @author MyEclipse Persistence Tools
 */

public class SystemAdmin implements java.io.Serializable, CWMPSupportDevice {

	// Fields
	/**
	 * 主键UUID
	 */
	private String saUuid;
	
	/**
	 * 租户ID
	 */
	private String saTenantId;
	
	/**
	 * 管理员ID
	 */
	private String saAdminId;
	
	/**
	 * 管理员密码
	 */
	private String saAdminPassword;
	
	/**
	 * 管理员姓名
	 */
	private String saAdminName;
	
	/**
	 * 管理员类型
	 * 0：系统管理员
	 * 1：租户管理员
	 */
	private String saAdminType;
	
	/**
	 * 管理员电话
	 */
	private String saAdminTel;
	
	/**
	 * 管理员邮箱地址
	 */
	private String saAdminEmail;
	
	/**
	 * 租户使用有效期
	 */
	private Date saPeriodTime;
	
	/**
	 * 租户单位地址
	 */
	private String saAddress;
	
	/**
	 * 租户可用短信发送数量
	 */
	private Integer saSmsQuantity;
	/**
	 * 租户管理员状态
	 * 1：正常
	 * 2：授权到期
	 * 3：注销
	 */
	private Integer saStatus;
	
	/**
	 * 设备tr069Url
	 */
	private String saTr069Url;
	
	/**
	 * 设备tr069序列号
	 */
	private String saTr069Index;
	
	private String saTr069Username;
	
	private String saTr069Password;
	

	// Constructors
	
	/** default constructor */
	public SystemAdmin() {
	}

	// Property accessors
	
	public String getSaTr069Url() {
		return saTr069Url;
	}

	public void setSaTr069Url(String saTr069Url) {
		this.saTr069Url = saTr069Url;
	}

	public String getSaTr069Index() {
		return saTr069Index;
	}

	public void setSaTr069Index(String saTr069Index) {
		this.saTr069Index = saTr069Index;
	}

	public String getSaAddress() {
		return saAddress;
	}

	public void setSaAddress(String saAddress) {
		this.saAddress = saAddress;
	}

	public Integer getSaStatus() {
		return saStatus;
	}

	public void setSaStatus(Integer saStatus) {
		this.saStatus = saStatus;
	}

	public Date getSaPeriodTime() {
		return saPeriodTime;
	}

	public void setSaPeriodTime(Date saPeriodTime) {
		this.saPeriodTime = saPeriodTime;
	}

	public Integer getSaSmsQuantity() {
		return saSmsQuantity;
	}

	public void setSaSmsQuantity(Integer saSmsQuantity) {
		this.saSmsQuantity = saSmsQuantity;
	}

	public String getSaUuid() {
		return this.saUuid;
	}

	public void setSaUuid(String saUuid) {
		this.saUuid = saUuid;
	}

	public String getSaTenantId() {
		return this.saTenantId;
	}

	public void setSaTenantId(String saTenantId) {
		this.saTenantId = saTenantId;
	}

	public String getSaAdminId() {
		return this.saAdminId;
	}

	public void setSaAdminId(String saAdminId) {
		this.saAdminId = saAdminId;
	}

	public String getSaAdminPassword() {
		return this.saAdminPassword;
	}

	public void setSaAdminPassword(String saAdminPassword) {
		this.saAdminPassword = saAdminPassword;
	}

	public String getSaAdminName() {
		return this.saAdminName;
	}

	public void setSaAdminName(String saAdminName) {
		this.saAdminName = saAdminName;
	}

	public String getSaAdminType() {
		return this.saAdminType;
	}

	public void setSaAdminType(String saAdminType) {
		this.saAdminType = saAdminType;
	}

	public String getSaAdminTel() {
		return this.saAdminTel;
	}

	public void setSaAdminTel(String saAdminTel) {
		this.saAdminTel = saAdminTel;
	}

	public String getSaAdminEmail() {
		return this.saAdminEmail;
	}

	public void setSaAdminEmail(String saAdminEmail) {
		this.saAdminEmail = saAdminEmail;
	}
	
	@Override
	public String getUrl() {
		return saTr069Url;
	}

	@Override
	public String getIndex() {
		return saTr069Index;
	}

	@Override
	public String getPassword() {
		return saTr069Password;
	}

	@Override
	public String getUsername() {
		return saTr069Username;
	}

	public String getSaTr069Username() {
		return saTr069Username;
	}

	public void setSaTr069Username(String saTr069Username) {
		this.saTr069Username = saTr069Username;
	}

	public String getSaTr069Password() {
		return saTr069Password;
	}

	public void setSaTr069Password(String saTr069Password) {
		this.saTr069Password = saTr069Password;
	}

}