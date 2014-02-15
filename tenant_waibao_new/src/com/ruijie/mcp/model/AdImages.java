package com.ruijie.mcp.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

/**
 * 广告图片
 * 
 * @author lqiang
 * 
 */
public class AdImages implements Serializable {

	private static final long serialVersionUID = -7607312885104451950L;

	/**
	 * 图片ID
	 */
	private String aiId;
	/**
	 * 登录用户帐号
	 */
	private String aiSaAdminId;
	/**
	 * 图片相对路径
	 */
	private String aiImagePath;
	/**
	 * 图片标识，对应页面中位置的标识
	 */
	private String aiImageMark;
	/**
	 * 生成时间
	 */
	private Date aiCreateDate;

	/**
	 * 图片URL
	 */
	private String aiAdUrl;

	/**
	 * 广告首页的连接
	 */
	private String hrefAiAdUrl;

	/**
	 * 所属模版ID
	 */
	private String aiTmId;
	
	/**
	 * 所属DIV ID
	 */
	private String aiDivId;
	
	public String getHrefAiAdUrl() {
		if (StringUtils.isBlank(aiAdUrl)) {
			return "#";
		}
		return aiAdUrl;
	}

	public void setHrefAiAdUrl(String hrefAiAdUrl) {
		this.hrefAiAdUrl = hrefAiAdUrl;
	}

	public String getAiAdUrl() {
		if (StringUtils.isBlank(aiAdUrl)) {
			return "";
		}
		return aiAdUrl;
	}

	public void setAiAdUrl(String aiAdUrl) {
		this.aiAdUrl = aiAdUrl;
	}

	public String getAiId() {
		return aiId;
	}

	public void setAiId(String aiId) {
		this.aiId = aiId;
	}

	public String getAiSaAdminId() {
		return aiSaAdminId;
	}

	public void setAiSaAdminId(String aiSaAdminId) {
		this.aiSaAdminId = aiSaAdminId;
	}

	public String getAiImagePath() {
		return aiImagePath;
	}

	public void setAiImagePath(String aiImagePath) {
		this.aiImagePath = aiImagePath;
	}

	public String getAiImageMark() {
		return aiImageMark;
	}

	public void setAiImageMark(String aiImageMark) {
		this.aiImageMark = aiImageMark;
	}

	public Date getAiCreateDate() {
		return aiCreateDate;
	}

	public void setAiCreateDate(Date aiCreateDate) {
		this.aiCreateDate = aiCreateDate;
	}

	public String getAiTmId() {
		return aiTmId;
	}

	public void setAiTmId(String aiTmId) {
		this.aiTmId = aiTmId;
	}

    public String getAiDivId() {
        return aiDivId;
    }

    public void setAiDivId(String aiDivId) {
        this.aiDivId = aiDivId;
    }

}
