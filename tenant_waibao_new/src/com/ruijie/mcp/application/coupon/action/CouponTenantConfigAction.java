package com.ruijie.mcp.application.coupon.action;

import java.io.File;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ruijie.mcp.application.coupon.business.ITenantBusinessesBus;
import com.ruijie.mcp.application.coupon.business.ITenantWaiterBus;
import com.ruijie.mcp.application.coupon.model.TenantBusinesses;
import com.ruijie.mcp.application.coupon.model.TenantWaiter;
import com.ruijie.mcp.security.SecurityAppUserHolder;
import com.ruijie.mcp.util.FileUploadUtil;


public class CouponTenantConfigAction {
    
    private Logger log = Logger.getLogger(CouponTenantConfigAction.class);
    
    private ITenantBusinessesBus tenantBusinessesBus;
    private ITenantWaiterBus tenantWaiterBus;
    
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
    
    private String tenantName;
    private String imgPath;
    private String tenantTel;
    private String tenantAddr;
    private String appUser;
    private String appPwd;
    
    /*
     * 进入商家配置
     */
    public String toConfigTenant() {
        String tenantId = getTenantId();
        
        //获取商家信息
        TenantBusinesses tnantBusinesses = tenantBusinessesBus.getTenantByTenantId(tenantId);
        if(null != tnantBusinesses){
            tenantName = tnantBusinesses.getTbBusName();
            imgPath = tnantBusinesses.getTbLogoUrl();
            tenantTel = tnantBusinesses.getTbContactNumber();
            tenantAddr = tnantBusinesses.getTbAddress();
        }
        
        //获取E点券手机应用账号信息
        TenantWaiter tenantWaiter = tenantWaiterBus.getWaiterByTenantId(tenantId);
        if(null != tenantWaiter){
            appUser = tenantWaiter.getTwAppUserName();
            appPwd = tenantWaiter.getTwAppPwd();
        }
        
        return "configtenant";
    }
    
    /**
     *  
     * <p>Description: 保存商家配置 </p>
     * <p>Create Time: 2013-11-21   </p>
     * @author linwu
     */
    public void saveTenantConfig(){
        try {
            
            HttpServletRequest request = ServletActionContext.getRequest();
            String tenantId = getTenantId();
            
            String tenantName = request.getParameter("tenantName");
            String imgPath = request.getParameter("imgPath");
            String tenantTel = request.getParameter("tenantTel");
            String tenantAddr = request.getParameter("tenantAddr");
            String appUser = request.getParameter("appUser");
            String appPwd = request.getParameter("appPwd");
            
            //保存商家配置
            TenantBusinesses tnantBusinesses = tenantBusinessesBus.getTenantByTenantId(tenantId);
            if(null == tnantBusinesses){
                tnantBusinesses = new TenantBusinesses();
            }
            tnantBusinesses.setTbAddress(tenantAddr);
            tnantBusinesses.setTbBusName(tenantName);
            tnantBusinesses.setTbContactNumber(tenantTel);
            tnantBusinesses.setTbTenantId(tenantId);
            tnantBusinesses.setTbLogoUrl(imgPath);
            tenantBusinessesBus.saveOrUpdate(tnantBusinesses);
            
            //保存E点券手机应用账号信息
            TenantWaiter tenantWaiter = tenantWaiterBus.getWaiterByTenantId(tenantId);
            if(null == tenantWaiter){
                tenantWaiter = new TenantWaiter();
            }
            tenantWaiter.setCreateTime(new Date());
            tenantWaiter.setTwWaiterName("");
            tenantWaiter.setTwTenantId(tenantId);
            tenantWaiter.setTwAppPwd(appPwd);
            tenantWaiter.setTwAppUserName(appUser);
            UUID uuid = UUID.randomUUID();
            tenantWaiter.setTwAccessToken(uuid.toString());
            tenantWaiterBus.saveOrUpdate(tenantWaiter);         

            HttpServletResponse response = ServletActionContext.getResponse();
         
            writeResult(response, "保存成功！");
            
        } catch (Exception e) {
            log.error("saveTenantConfig failed:", e);
        }       
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

    public void setTenantBusinessesBus(ITenantBusinessesBus tenantBusinessesBus) {
        this.tenantBusinessesBus = tenantBusinessesBus;
    }

    public ITenantBusinessesBus getTenantBusinessesBus() {
        return tenantBusinessesBus;
    }

    public void setTenantWaiterBus(ITenantWaiterBus tenantWaiterBus) {
        this.tenantWaiterBus = tenantWaiterBus;
    }

    public ITenantWaiterBus getTenantWaiterBus() {
        return tenantWaiterBus;
    }
    
    public void setTenantName(String tenantName) {
        this.tenantName = tenantName;
    }

    public String getTenantName() {
        return tenantName;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setTenantTel(String tenantTel) {
        this.tenantTel = tenantTel;
    }

    public String getTenantTel() {
        return tenantTel;
    }

    public void setTenantAddr(String tenantAddr) {
        this.tenantAddr = tenantAddr;
    }

    public String getTenantAddr() {
        return tenantAddr;
    }

    public void setAppUser(String appUser) {
        this.appUser = appUser;
    }

    public String getAppUser() {
        return appUser;
    }

    public void setAppPwd(String appPwd) {
        this.appPwd = appPwd;
    }

    public String getAppPwd() {
        return appPwd;
    }
    
    


}
