package com.ruijie.mcp.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
/**
 * 广告模版的文本信息
 * @author lqiang
 *
 */
public class AdText implements Serializable {

	private static final long serialVersionUID = 8176207681104947157L;
	private String atId;
	private String atContent;
	private String atUrl;
	private String atAdminId;
	private Date atCreateDate;
	private String hrefAtUrl;
	
	private String atTextSize;
	private String atIsBold;
	private String atTextColor;
	private String atBgColor;
	private String atTextAlign;
	/**
     * 所属DIV ID
     */
    private String aiDivId;

	/**
	 * 所属模版ID
	 */
	private String atTmId;

	public String getAtId() {
		return atId;
	}

	public void setAtId(String atId) {
		this.atId = atId;
	}

	public String getAtContent() {
		return atContent;
	}

	public void setAtContent(String atContent) {
		this.atContent = atContent;
	}
	
	public String getHrefAtUrl() {
		if (StringUtils.isBlank(atUrl)) {
			return "#";
		}
		return atUrl;
	}

	public void setHrefAiAdUrl(String hrefAtUrl) {
		this.hrefAtUrl = hrefAtUrl;
	}

	public String getAtUrl() {
		return atUrl;
	}

	public void setAtUrl(String atUrl) {
		this.atUrl = atUrl;
	}

	public String getAtAdminId() {
		return atAdminId;
	}

	public void setAtAdminId(String atAdminId) {
		this.atAdminId = atAdminId;
	}

	public Date getAtCreateDate() {
		return atCreateDate;
	}

	public void setAtCreateDate(Date atCreateDate) {
		this.atCreateDate = atCreateDate;
	}

	public String getAtTmId() {
		return atTmId;
	}

	public void setAtTmId(String atTmId) {
		this.atTmId = atTmId;
	}

    public String getAtTextSize() {
        return atTextSize;
    }

    public void setAtTextSize(String atTextSize) {
        this.atTextSize = atTextSize;
    }

    public String getAtIsBold() {
        return atIsBold;
    }

    public void setAtIsBold(String atIsBold) {
        this.atIsBold = atIsBold;
    }

    public String getAtTextColor() {
        return atTextColor;
    }

    public void setAtTextColor(String atTextColor) {
        this.atTextColor = atTextColor;
    }

    public String getAtBgColor() {
        return atBgColor;
    }

    public void setAtBgColor(String atBgColor) {
        this.atBgColor = atBgColor;
    }

    public String getAtTextAlign() {
        return atTextAlign;
    }

    public void setAtTextAlign(String atTextAlign) {
        this.atTextAlign = atTextAlign;
    }

    public String getAiDivId() {
        return aiDivId;
    }

    public void setAiDivId(String aiDivId) {
        this.aiDivId = aiDivId;
    }
	

}
