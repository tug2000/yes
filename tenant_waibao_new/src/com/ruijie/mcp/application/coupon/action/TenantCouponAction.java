package com.ruijie.mcp.application.coupon.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ruijie.mcp.action.DataPageSupport;
import com.ruijie.mcp.application.coupon.business.ITenantBusinessesBus;
import com.ruijie.mcp.application.coupon.business.ITenantCouponBus;
import com.ruijie.mcp.application.coupon.model.TenantBusinesses;
import com.ruijie.mcp.application.coupon.model.TenantCoupon;
import com.ruijie.mcp.security.SecurityAppUserHolder;

public class TenantCouponAction extends DataPageSupport {
    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = 4913935769897857144L;
    private Logger log = Logger.getLogger(TenantCouponAction.class);

    
    private ITenantCouponBus tenantCouponBus;
    private ITenantBusinessesBus tenantBusinessesBus;

    
    private String tenantName="商家名称";
    private String imgPath;
    private String tenantTel;
    private String tenantAddr;

    @Override
    public List pageQueryList() {
        // TODO Auto-generated method stub
        return null;
    }

    public ITenantCouponBus getTenantCouponBus() {
        return tenantCouponBus;
    }

    public void setTenantCouponBus(ITenantCouponBus tenantCouponBus) {
        this.tenantCouponBus = tenantCouponBus;
    }
    
    /*
     * 查看点券列表
     */
    public String showList() {
        try {
            
            //获取商家信息
            getTenantInfo();
            
            //获取点券列表信息
            getCouponList();
            
        } catch (Exception e) {
            log.error("showList failed:", e);
        }
        
        
        
        return "list";
    }
    
    /**
     * 	
     * <p>Description:  删除点券 </p>
     * <p>Create Time: 2014-2-13   </p>
     * @author xwrj
     */
    public void delCoupon(){
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse response = ServletActionContext.getResponse();
          
            String couponId = request.getParameter("couponId");
            if(null != couponId && !couponId.isEmpty() && !"undefined".equalsIgnoreCase(couponId)){
                TenantCoupon tenantCoupon = tenantCouponBus.get(Long.valueOf(couponId));
                tenantCoupon.setTcCouponStatus(2);
                tenantCouponBus.update(tenantCoupon);
                
                writeResult(response, "删除成功！");
            }else{
                writeResult(response, "删除失败！");
            }
            
        } catch (Exception e) {
            log.error("delCoupon failed:", e);
        }
        
    }
    
    /**
     * 	
     * <p>Description:获取点券列表信息</p>
     * <p>Create Time: 2014-2-13   </p>
     * @author xwrj
     */
    public void getCouponList(){
        this.setPageNumber(4);// 单页展现的记录数
        this.setPageLevel(4);// 分几行显示
        StringBuffer hql = new StringBuffer();
        hql.append("from TenantCoupon a where a.tcCouponTenantId = :tenantId and a.tcCouponStatus=0 order by a.tcCreateTime DESC");
        Map<Object, Object> param = new HashMap<Object, Object>();
        param.put("tenantId", getTenantId());
        int count = tenantCouponBus.findCountByParams("select count(*) "
                + hql.toString(), param);
        this.setAllPageSize(count);// 设置总记录数

        List<TenantCoupon> list = tenantCouponBus.getPagingByParams(
                hql.toString(), param, this.getCurrPage() * this.getPageSize(),
                this.getPageSize());
        setPages(list);
    }
    
    /**
     * 	
     * <p>Description: 获取商家信息 </p>
     * <p>Create Time: 2014-2-13   </p>
     * @author xwrj
     */
    public void getTenantInfo(){
        String tenantId = getTenantId();
        
        //获取商家信息
        TenantBusinesses tnantBusinesses = tenantBusinessesBus.getTenantByTenantId(tenantId);
        if(null != tnantBusinesses){
            tenantName = tnantBusinesses.getTbBusName();
            imgPath = tnantBusinesses.getTbLogoUrl();
            tenantTel = tnantBusinesses.getTbContactNumber();
            tenantAddr = tnantBusinesses.getTbAddress();
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

    public ITenantBusinessesBus getTenantBusinessesBus() {
        return tenantBusinessesBus;
    }

    public void setTenantBusinessesBus(ITenantBusinessesBus tenantBusinessesBus) {
        this.tenantBusinessesBus = tenantBusinessesBus;
    }
    
    

}
