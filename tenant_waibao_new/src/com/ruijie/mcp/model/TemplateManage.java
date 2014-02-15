package com.ruijie.mcp.model;

/**
 * 模板列表类
 */
public class TemplateManage implements java.io.Serializable {

	/**	
     * Member Description
     */
    
    private static final long serialVersionUID = 1L;
// Fields
   /**
    * 模版UUID
    */
	private String tmUuid;
	/**
	 * 模板ID
	 */
	private String tmId;
	
	/**
	 * 模板描述
	 */
	private String tmDesc;
	
	/**
	 * 是否设置为默认状态，显示在首页，0：不显示，1：显示，只允许一条数据为1
	 */
	private Integer tmStatus;
	
	/**
	 * 是否发布，0：否，1：是
	 */
	private Integer tmIsPublish;
	
	/**
	 * 租户ID
	 */
	private String tmTenantId;
	
	/**
	 * 模板内容
	 */
	private String tmContent;
	
	/**
     * 发布模板内容
     */
    private String tmPublishContent;
    
    /**
     * 认证类型
     * 1：跳转到认证页面
     * 2：免认证上网
     */
    private Integer tmAuthType;
    
    /**
     * 模板类型
     * 0：系统默认模板
     * 1：租户模板
     */
    private Integer templateType;

	// Constructors
	
	/** default constructor */
	public TemplateManage() {
	}

	// Property accessors
	
	

	public Integer getTmIsPublish() {
		return tmIsPublish;
	}

	public String getTmUuid() {
		return tmUuid;
	}

	public void setTmUuid(String tmUuid) {
		this.tmUuid = tmUuid;
	}

	public void setTmIsPublish(Integer tmIsPublish) {
		this.tmIsPublish = tmIsPublish;
	}

	public Integer getTmStatus() {
		return tmStatus;
	}

	public void setTmStatus(Integer tmStatus) {
		this.tmStatus = tmStatus;
	}

	public String getTmId() {
		return this.tmId;
	}

	public void setTmId(String tmId) {
		this.tmId = tmId;
	}

	public String getTmDesc() {
		return this.tmDesc;
	}

	public void setTmDesc(String tmDesc) {
		this.tmDesc = tmDesc;
	}

	public String getTmTenantId() {
		return tmTenantId;
	}

	public void setTmTenantId(String tmTenantId) {
		this.tmTenantId = tmTenantId;
	}

    public String getTmContent() {
        return tmContent;
    }

    public void setTmContent(String tmContent) {
        this.tmContent = tmContent;
    }

    public String getTmPublishContent() {
        return tmPublishContent;
    }

    public void setTmPublishContent(String tmPublishContent) {
        this.tmPublishContent = tmPublishContent;
    }

    public Integer getTmAuthType() {
        return tmAuthType;
    }

    public void setTmAuthType(Integer tmAuthType) {
        this.tmAuthType = tmAuthType;
    }

    public Integer getTemplateType() {
        return templateType;
    }

    public void setTemplateType(Integer templateType) {
        this.templateType = templateType;
    }

	
}