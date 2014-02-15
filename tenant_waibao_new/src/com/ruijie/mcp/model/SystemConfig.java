package com.ruijie.mcp.model;

/**
 * 系统配置表
 * 
 * @author 林宏 2013-9-10
 */
public class SystemConfig implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 7057381322597541512L;

	/**
	 * 流水号
	 */
	private String scId;

	/**
	 * 键值KEY 例如:短信网关IP(com.ruijie.networkip)
	 */
	private String scKey;

	/**
	 * 键值VALUE 例如:短信网关IP(192.168.1.1)
	 */
	private String scValue;

	/**
	 * 类型编号 例如：短信网关存1，防蹭网配置存2
	 */
	private Integer scType;
	
	/**
	 * 显示状态 0:不显示 1:显示且可修改  2:显示但不能修改
	 */
	private Integer scDisplayStatus;

	/**
	 * 描述
	 */
	private String scDescription;

	// Constructors

	public Integer getScType() {
		return scType;
	}

	public void setScType(Integer scType) {
		this.scType = scType;
	}

	/** default constructor */
	public SystemConfig() {
	}

	/** full constructor */
	public SystemConfig(String scKey, String scValue) {
		this.scKey = scKey;
		this.scValue = scValue;
	}

	// Property accessors

	public String getScId() {
		return this.scId;
	}

	public void setScId(String scId) {
		this.scId = scId;
	}

	public String getScKey() {
		return this.scKey;
	}

	public void setScKey(String scKey) {
		this.scKey = scKey;
	}

	public String getScValue() {
		return this.scValue;
	}

	public void setScValue(String scValue) {
		this.scValue = scValue;
	}
	

	public Integer getScDisplayStatus() {
		return scDisplayStatus;
	}

	public void setScDisplayStatus(Integer scDisplayStatus) {
		this.scDisplayStatus = scDisplayStatus;
	}

	public String getScDescription() {
		return scDescription;
	}

	public void setScDescription(String scDescription) {
		this.scDescription = scDescription;
	}

}