package com.ruijie.mcp.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * 手机信息功能管理
 * @author 林宏
 * 2013-9-10
 */
public class MobileResourceManage implements java.io.Serializable {

	// Fields

	/**
	 * 创建时间
	 */
	private Date mmCreateTime;
	
	/**
	 * UUID
	 */
	private int mmId;
	
	/**
	 * MAC
	 */
	private String mmMac;
	
	/**
	 * 手机号
	 */
	private String mmMobile;

	/**
	 * 注册次数
	 */
	private Integer mmRegisterNum;

	/**
	 * 上网总时长
	 */
	private Long mmTotalOnlineDulation;

	/**
	 * 类型 
	 * 1代表手机端
	 * 2代表pc和平板端
	 * 3代表微信端
	 */
	private String mmType;
	
	/**
	 * 租户ID
	 */
	private String mmTenantId;

	/** default constructor */
	public MobileResourceManage() {
	}
	
	/** minimal constructor */
	public MobileResourceManage(String mmMobile, Timestamp mmCreateTime) {
		this.mmMobile = mmMobile;
		this.mmCreateTime = mmCreateTime;
	}
	
	/** full constructor */
	public MobileResourceManage(String mmMobile, Timestamp mmCreateTime,
			Integer mmRegisterNum, Long mmTotalOnlineDulation) {
		this.mmMobile = mmMobile;
		this.mmCreateTime = mmCreateTime;
		this.mmRegisterNum = mmRegisterNum;
		this.mmTotalOnlineDulation = mmTotalOnlineDulation;
	}
	
	public Date getMmCreateTime() {
		return this.mmCreateTime;
	}

	// Constructors

	public int getMmId() {
		return mmId;
	}

	public String getMmMac() {
		return mmMac;
	}

	public String getMmMobile() {
		return this.mmMobile;
	}

	public Integer getMmRegisterNum() {
		return this.mmRegisterNum;
	}

	public Long getMmTotalOnlineDulation() {
		return this.mmTotalOnlineDulation;
	}

	// Property accessors

	public String getMmType() {
		return mmType;
	}

	public void setMmCreateTime(Date mmCreateTime) {
		this.mmCreateTime = mmCreateTime;
	}

	public void setMmId(int mmId) {
		this.mmId = mmId;
	}

	public void setMmMac(String mmMac) {
		this.mmMac = mmMac;
	}

	public void setMmMobile(String mmMobile) {
		this.mmMobile = mmMobile;
	}

	public void setMmRegisterNum(Integer mmRegisterNum) {
		this.mmRegisterNum = mmRegisterNum;
	}

	public void setMmTotalOnlineDulation(Long mmTotalOnlineDulation) {
		this.mmTotalOnlineDulation = mmTotalOnlineDulation;
	}

	public void setMmType(String mmType) {
		this.mmType = mmType;
	}

	public String getMmTenantId() {
		return mmTenantId;
	}

	public void setMmTenantId(String mmTenantId) {
		this.mmTenantId = mmTenantId;
	}

}