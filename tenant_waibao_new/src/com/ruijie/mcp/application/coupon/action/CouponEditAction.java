package com.ruijie.mcp.application.coupon.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ruijie.mcp.application.coupon.business.ITenantCouponBus;
import com.ruijie.mcp.application.coupon.model.TenantBusinesses;
import com.ruijie.mcp.application.coupon.model.TenantCoupon;
import com.ruijie.mcp.application.coupon.model.TenantWaiter;
import com.ruijie.mcp.security.SecurityAppUserHolder;
import com.ruijie.mcp.util.FileUploadUtil;


public class CouponEditAction {
    
    private Logger log = Logger.getLogger(CouponEditAction.class);
    
    /**
     * 上传文件
     */
    private File[] upload;
    
    /**
     * 图片大小
     */
    private int maxsize = 500*1024;
    
    
    /**
     * 上传的文件名
     */
    private String uploadFileName;
    
    private String couponId;
    private String imgPath;
    private String startTime;
    private String endTime;    
    private String couponName;
    private String unit;
    private String exchangeSum;
    private String ruleDesc;
    private String publishSum;
    private String userLimit;

    
    private ITenantCouponBus tenantCouponBus;
    private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    /*
     * 进入点券配置
     */
    public String toConfigCoupon() {
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            couponId = request.getParameter("couponId");
            if(null != couponId && !couponId.isEmpty() && !"undefined".equalsIgnoreCase(couponId)){
                TenantCoupon tenantCoupon = tenantCouponBus.get(Long.valueOf(couponId));
                if(null != tenantCoupon){
                    imgPath = tenantCoupon.getTcCouponIcoUrl();
                    startTime = formatter.format(tenantCoupon.getTcValIdBeginDateTime());
                    endTime = formatter.format(tenantCoupon.getTcValIdEndDateTime());
                    couponName = tenantCoupon.getTcCouponName();
                    unit = tenantCoupon.getTcCouponPrizeUnit();
                    exchangeSum = tenantCoupon.getTcCouponConvertibleSum().toString();
                    ruleDesc = tenantCoupon.getTcCouponActiviyDes();
                    publishSum = tenantCoupon.getTcPublishSum().toString();
                    userLimit = tenantCoupon.getTcUserLimitStatus().toString();                
                }
            }

            
        } catch (Exception e) {
            log.error("toConfigCoupon failed:", e);
        }
        return "configcoupon";
    }
    
    /**
     *  ajax方式上传微信图片    
     * <p>Description:              </p>
     * <p>Create Time: 2013-11-20   </p>
     * @author linwu
     */
    public void doUploadImage() {
        try {
            HttpServletResponse response = ServletActionContext.getResponse();
            if (upload == null || upload.length == 0) {
                writeResult(response, "上传的图片不能超过500K！");
                return;
            }
            
            if(upload[0].length()>maxsize){
                writeResult(response, "上传的图片最大只能500K！");
                return;
            }           

            String relativePath = FileUploadUtil.doSave(upload[0], uploadFileName);
            writeResult(response, relativePath);
            
        } catch (Exception e) {
            log.error("doUploadImage failed:", e);
        }
        
    } 
    
    /**
     *  
     * <p>Description: 保存点券编辑 </p>
     * <p>Create Time: 2013-11-21   </p>
     * @author linwu
     */
    public void saveCouponEdit(){
        try {
            
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse response = ServletActionContext.getResponse();

            String tenantId = getTenantId();
            
            String id = request.getParameter("couponId");           
            String couponName = request.getParameter("couponName");
            String imgPath = request.getParameter("imgPath");
            String unit = request.getParameter("unit");
            String exchangeSum = request.getParameter("exchangeSum");
            String ruleDesc = request.getParameter("ruleDesc");
            String publishSum = request.getParameter("publishSum");
            String userLimit = request.getParameter("userLimit");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");                   
            
            TenantCoupon dbTenantCoupon = tenantCouponBus.getByCouponName(couponName, tenantId);
            
            TenantCoupon tenantCoupon = null;
            if(null == id || id.isEmpty() || "undefined".equalsIgnoreCase(id)){  
                //判断点券名称是否已存在
                if(null != dbTenantCoupon){
                    writeResult(response, "您输入的产品名称已存在，请重新输入！");
                    return;
                }
                tenantCoupon = new TenantCoupon();
            }else{
                tenantCoupon = tenantCouponBus.get(Long.valueOf(id));
                //判断点券名称是否已存在
                if(null != dbTenantCoupon && !dbTenantCoupon.getTcCoId().equals(tenantCoupon.getTcCoId())){
                    writeResult(response, "您输入的产品名称已存在，请重新输入！");
                    return;
                }
            }          
            
            tenantCoupon.setTcCouponActiviyDes(ruleDesc);
            tenantCoupon.setTcCouponConvertibleNum(1);
            tenantCoupon.setTcCouponConvertibleSum(Integer.valueOf(exchangeSum));
            tenantCoupon.setTcCouponIcoUrl(imgPath);
            tenantCoupon.setTcCouponName(couponName);
            tenantCoupon.setTcCouponPrizeUnit(unit);
            tenantCoupon.setTcCouponStatus(0);
            tenantCoupon.setTcCouponTenantId(tenantId);
            tenantCoupon.setTcCreateTime(null == tenantCoupon.getTcCreateTime()? new Date() : tenantCoupon.getTcCreateTime());
            tenantCoupon.setTcPublishSum(Integer.valueOf(publishSum));
            tenantCoupon.setTcSaleSum(null == tenantCoupon.getTcSaleSum()? 0 : tenantCoupon.getTcSaleSum());
            tenantCoupon.setTcUsedSum(null == tenantCoupon.getTcUsedSum()? 0 : tenantCoupon.getTcUsedSum());
            tenantCoupon.setTcUserLimitStatus(Integer.valueOf(userLimit));
            tenantCoupon.setTcUserSum(null == tenantCoupon.getTcUserSum()? 0 : tenantCoupon.getTcUserSum());
            
            tenantCoupon.setTcValIdBeginDateTime(formatter.parse(startTime));
            tenantCoupon.setTcValIdEndDateTime(formatter.parse(endTime));          
            tenantCouponBus.saveOrUpdate(tenantCoupon);

         
            writeResult(response, "保存成功！");
            
        } catch (Exception e) {
            log.error("saveTenantConfig failed:", e);
        }       
    }
    
    private String getTenantId() {
        return SecurityAppUserHolder.getCurrentUser().getPartyId();
    }
    
    private void writeResult(HttpServletResponse response, String result) {
        try {
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html");
            response.getWriter().println(result);
            response.getWriter().close();
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    public void setUpload(File[] upload) {
        this.upload = upload;
    }


    public File[] getUpload() {
        return upload;
    }


    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }


    public String getUploadFileName() {
        return uploadFileName;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setTenantCouponBus(ITenantCouponBus tenantCouponBus) {
        this.tenantCouponBus = tenantCouponBus;
    }

    public ITenantCouponBus getTenantCouponBus() {
        return tenantCouponBus;
    }

    public String getCouponId() {
        return couponId;
    }

    public void setCouponId(String couponId) {
        this.couponId = couponId;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getUnit() {
        return unit;
    }

    public void setExchangeSum(String exchangeSum) {
        this.exchangeSum = exchangeSum;
    }

    public String getExchangeSum() {
        return exchangeSum;
    }

    public void setRuleDesc(String ruleDesc) {
        this.ruleDesc = ruleDesc;
    }

    public String getRuleDesc() {
        return ruleDesc;
    }

    public void setPublishSum(String publishSum) {
        this.publishSum = publishSum;
    }

    public String getPublishSum() {
        return publishSum;
    }

    public void setUserLimit(String userLimit) {
        this.userLimit = userLimit;
    }

    public String getUserLimit() {
        return userLimit;
    }

}
