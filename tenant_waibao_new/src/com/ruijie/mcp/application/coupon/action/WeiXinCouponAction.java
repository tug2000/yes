package com.ruijie.mcp.application.coupon.action;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.jdbc.core.JdbcTemplate;

import com.ruijie.mcp.application.coupon.business.ICustomerCouponBus;
import com.ruijie.mcp.application.coupon.business.ITenantBusinessesBus;
import com.ruijie.mcp.application.coupon.business.ITenantCouponBus;
import com.ruijie.mcp.application.coupon.business.ITenantCustomerBus;
import com.ruijie.mcp.application.coupon.model.TenantBusinesses;
import com.ruijie.mcp.application.coupon.model.TenantCoupon;
import com.ruijie.mcp.application.coupon.model.TenantCustomer;
import com.ruijie.mcp.application.coupon.model.TenantCustomerCoupon;
import com.ruijie.mcp.util.StringOperate;

public class WeiXinCouponAction {

    /**	
     * Member Description
     */

    private static final long serialVersionUID = 1L;

    private Logger log = Logger.getLogger(WeiXinCouponAction.class);

    private ITenantCouponBus tenantCouponBus;

    private ICustomerCouponBus customerCouponBus;

    private ITenantBusinessesBus tenantBusinessesBus;

    private ITenantCustomerBus tenantCustomerBus;

    private TenantBusinesses bean;

    private TenantCustomer customerBean;

    /**顾客ID
     * 
     */
    private Long tccCuId;

    /**
     * 点券ID
     */
    private String tccCoId;

    /**
     * 商家ID
     */
    private String tbId;

    private JdbcTemplate jdbcTemplate;

    /**
     * 点券统计
     */
    private int couponCount;

    /**
     * 提示消息
     */
    private String message;

    /**
     * 点券总数
     */
    private Integer couponSum;

    private List tenantList;

    private List tenantbusbList;

    private List tenantCouponList;

    private List couponList;

    private List otherList;

    private Map<String, Object> busCouponBean;

    private Map<String, Object> busCouponBean1;

    private int busExpireSum;

    private int busExpireSum1;

    /**
     * 即将到期的点券数
     */
    private Integer expireSum;

    private Long EXPIRE_TIME = 7 * 24 * 3600L;

    private String customerId;

    /**
     *  
     * <p>Description:  显示二维码 </p>
     * <p>Create Time: 2013-11-23   </p>
     * @author linwu
     * @return
     */
    public String showQRCode() {
        if (StringOperate.isEmpty(tccCuId.toString())) {
            message = "点券ID唯一标识不允许为空";
            return showTenant();
        }
        Map<Object, Object> paras = new HashMap<Object, Object>();
        StringBuffer sql = new StringBuffer();
        String hql = "select count(tcc.tccId)  from TenantCustomerCoupon tcc,TenantBusinesses tb"
                + " where 1=1 and tcc.tccTenantId=tb.tbTenantId and tcc.tccCuId = :tccCuId  ";
        paras.put("tccCuId", 1L);
        this.tccCuId = 1L;

        try {
            // 您有几张优惠券
            calculateCouponSum(Long.valueOf(tccCuId));
            calculateExpireCouponSum(Long.valueOf(tccCuId));
            customerBean = this.tenantCustomerBus.get(tccCuId);
        } catch (Exception e) {
            log.error("showQRCode fail", e);
        }
        return "qrcode";
    }

    /**
     *  
     * <p>Description:  显示点券 </p>
     * <p>Create Time: 2013-11-23   </p>
     * @author linwu
     * @return
     */
    public String showCoupon() {
        if (StringOperate.isEmpty(tccCoId)) {
            message = "点券ID唯一标识不允许为空";
            return showTenant();
        }
        if (StringOperate.isEmpty(tbId)) {
            message = "商家ID唯一标识不允许为空";
            return showTenant();
        }

        Map<Object, Object> paras = new HashMap<Object, Object>();
        try {
            bean = this.tenantBusinessesBus.get(Long.parseLong(tbId));
        } catch (Exception e) {
            log.error("showCoupon fail", e);
        }

        StringBuffer hql = new StringBuffer();
        hql.append(" from TenantCoupon t,TenantCustomerCoupon tcc where 1=1 ");
        hql.append(" and t.tcCouponTenantId=tcc.tccTenantId");
        hql.append(" and t.tcCoId= :tcCoId");
        hql.append(" order by t.tcCoId desc ");
        paras.put("tcCoId", Long.parseLong(tccCoId));
        try {
            couponList = this.tenantCouponBus.getPagingByParams(hql.toString(), paras, 0, 2);
        } catch (Exception e) {
            log.error("showCoupon fail", e);
        }

        StringBuffer hql1 = new StringBuffer();
        hql1.append(" from TenantCoupon t,TenantCustomerCoupon tcc where 1=1 ");
        hql1.append(" and t.tcCouponTenantId=tcc.tccTenantId");
        hql1.append(" and t.tcCoId not in :tcCoId");
        hql1.append(" order by t.tcCoId desc ");
        paras.put("tcCoId", Long.parseLong(tccCoId));
        try {
            otherList = this.tenantCouponBus.getPagingByParams(hql.toString(), paras, 0, 5);

        } catch (Exception e) {
            log.error("showCoupon fail", e);
        }
        return "coupon";
    }

    /**
     * 	
     * <p>Description: 计算点券总数 </p>
     * <p>Create Time: 2014-2-5   </p>
     * @author linwu
     */
    private void calculateCouponSum(Long customId) {
        List<TenantCustomerCoupon> list = customerCouponBus.find("from TenantCustomerCoupon where tccCuId=?", customId);
        if (null == list) {
            couponSum = 0;
        }

        couponSum = list.size();
    }

    /**
     *  
     * <p>Description: 计算即将到期的点券数 </p>
     * <p>Create Time: 2014-2-5   </p>
     * @author linwu
     */
    private void calculateExpireCouponSum(Long customId) {
        List<TenantCoupon> list = tenantCouponBus.find(
                "from TenantCoupon t where t.tcCoId in (select tccCoId from TenantCustomerCoupon where tccCuId=?)",
                customId);
        if (null == list) {
            expireSum = 0;
        }

        Date date = new Date();
        expireSum = 0;
        for (TenantCoupon tenantCoupon : list) {
            if (tenantCoupon.getTcValIdEndDateTime().getTime() - date.getTime() <= EXPIRE_TIME) {
                expireSum++;
            }
        }
    }

    /**
     *  
     * <p>Description:  显示消费过的店家 </p>
     * <p>Create Time: 2013-11-23   </p>
     * @author linwu
     * @return
     */
    public String showTenant() {
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            tenantList = new ArrayList();
            customerId = request.getParameter("customerId");
            tccCuId = Long.parseLong(customerId);
            Map<Object, Object> paras = new HashMap<Object, Object>();
            StringBuffer sql = new StringBuffer();
            StringBuffer sql1 = new StringBuffer();
            StringBuffer sql2 = new StringBuffer();
            // 计算点券总数
            calculateCouponSum(Long.valueOf(customerId));

            sql.append(" select count(tcc.TCC_ID) detailCount ,tb.TB_ID tbId,tb.TB_BUSNAME tbBusName,tb.TB_LOGOURL tbLogoUrl,"
                    + "tcc.TCC_COUPONNUM tccCouponNum,tc.TC_COID tccCoId ,GROUP_CONCAT(tc.TC_COUPON_VALID_END) eadDate from tenant_customer_coupon tcc ,"
                    + "tenant_businesses tb,tenant_coupon tc where 1=1 ");
            sql.append(" and tcc.TCC_TENANT_ID=tb.TB_TENANT_ID ");
            sql.append(" and tb.TB_TENANT_ID=tc.TC_TENANT_ID");
            sql.append(" and tcc.TCC_CUID = " + customerId);
            sql.append(" group by tb.TB_BUSNAME ");
            sql.append(" order by tb.TB_ID desc ");
            sql.append(" limit 2 ");
            
            // 第一项消费过的商家
            List<Map<String, Object>> busCouponlist = jdbcTemplate.queryForList(sql.toString());
            if (busCouponlist.size()<=0){
               return "tenant";
            }
            
            busCouponBean = (Map<String, Object>) busCouponlist.get(0);
            if (busCouponBean.get("eadDate") != null) {
                String[] strDatas = busCouponBean.get("eadDate").toString().split(",");
                for (String strData : strDatas) {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = format.parse(strData);
                    Date dateNow = new Date();
                    busExpireSum = 0;
                    if (date.getTime() - dateNow.getTime() <= EXPIRE_TIME) {
                        busExpireSum++;
                    }
                }
            }
            // 第二项消费过的商家
            busCouponBean1 = (Map<String, Object>) busCouponlist.get(1);
            if (busCouponBean1.get("eadDate") != null) {
                String[] strDatas1 = busCouponBean1.get("eadDate").toString().split(",");
                for (String strData : strDatas1) {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = format.parse(strData);
                    Date dateNow = new Date();
                    busExpireSum1 = 0;
                    if (date.getTime() - dateNow.getTime() <= EXPIRE_TIME) {
                        busExpireSum1++;
                    }
                }
            }
            // 计算即将到期的总点券数
            calculateExpireCouponSum(Long.valueOf(customerId));

            // 猜你喜欢
            sql1.append("select tb.TB_BUSNAME tbBusName,tb.TB_LOGOURL tbLogoUrl "
                    + "from tenant_customer_coupon tcc,tenant_coupon tc,tenant_businesses tb where 1=1 ");
            sql1.append(" and tcc.TCC_TENANT_ID=tc.TC_TENANT_ID");
            sql1.append(" and tc.TC_TENANT_ID=tb.TB_TENANT_ID");
            sql1.append(" and tcc.TCC_COID not in( select TC_COID from tenant_coupon where TC_COID = " + customerId
                    + ")");
            sql1.append(" order by tcc.TCC_ID desc ");
            sql1.append(" limit 5 ");
            tenantbusbList = jdbcTemplate.queryForList(sql1.toString());

            // 猜你喜欢优惠1，2
            sql2.append("select tc.TC_COUPON_NAME tcCouponName,tc.TC_COUPON_ACTIVIYDES tcCouponActiviyDes "
                    + "from tenant_customer_coupon tcc,tenant_coupon tc,tenant_businesses tb where 1=1 ");
            sql2.append(" and tcc.TCC_TENANT_ID=tc.TC_TENANT_ID");
            sql2.append(" and tc.TC_TENANT_ID=tb.TB_TENANT_ID");
            sql2.append(" and tcc.TCC_COID not in( select TC_COID from tenant_coupon where TC_COID = " + customerId
                    + ")");
            sql2.append(" order by tcc.TCC_ID desc ");
            sql2.append(" limit 2 ");
            tenantCouponList = jdbcTemplate.queryForList(sql2.toString());

        } catch (Exception e) {
            log.error("showCoupon fail", e);
        }
        return "tenant";
    }

    public void setCouponSum(Integer couponSum) {
        this.couponSum = couponSum;
    }

    public Integer getCouponSum() {
        return couponSum;
    }

    public void setExpireSum(Integer expireSum) {
        this.expireSum = expireSum;
    }

    public Integer getExpireSum() {
        return expireSum;
    }

    public void setTenantCouponBus(ITenantCouponBus tenantCouponBus) {
        this.tenantCouponBus = tenantCouponBus;
    }

    public ITenantCouponBus getTenantCouponBus() {
        return tenantCouponBus;
    }

    public void setCustomerCouponBus(ICustomerCouponBus customerCouponBus) {
        this.customerCouponBus = customerCouponBus;
    }

    public ICustomerCouponBus getCustomerCouponBus() {
        return customerCouponBus;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public ITenantBusinessesBus getTenantBusinessesBus() {
        return tenantBusinessesBus;
    }

    public void setTenantBusinessesBus(ITenantBusinessesBus tenantBusinessesBus) {
        this.tenantBusinessesBus = tenantBusinessesBus;
    }

    public ITenantCustomerBus getTenantCustomerBus() {
        return tenantCustomerBus;
    }

    public void setTenantCustomerBus(ITenantCustomerBus tenantCustomerBus) {
        this.tenantCustomerBus = tenantCustomerBus;
    }

    public TenantBusinesses getBean() {
        return bean;
    }

    public void setBean(TenantBusinesses bean) {
        this.bean = bean;
    }

    public TenantCustomer getCustomerBean() {
        return customerBean;
    }

    public void setCustomerBean(TenantCustomer customerBean) {
        this.customerBean = customerBean;
    }

    public Long getTccCuId() {
        return tccCuId;
    }

    public void setTccCuId(Long tccCuId) {
        this.tccCuId = tccCuId;
    }

    public String getTccCoId() {
        return tccCoId;
    }

    public void setTccCoId(String tccCoId) {
        this.tccCoId = tccCoId;
    }

    public String getTbId() {
        return tbId;
    }

    public void setTbId(String tbId) {
        this.tbId = tbId;
    }

    public int getCouponCount() {
        return couponCount;
    }

    public void setCouponCount(int couponCount) {
        this.couponCount = couponCount;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List getTenantList() {
        return tenantList;
    }

    public void setTenantList(List tenantList) {
        this.tenantList = tenantList;
    }

    public List getTenantbusbList() {
        return tenantbusbList;
    }

    public void setTenantbusbList(List tenantbusbList) {
        this.tenantbusbList = tenantbusbList;
    }

    public List getTenantCouponList() {
        return tenantCouponList;
    }

    public void setTenantCouponList(List tenantCouponList) {
        this.tenantCouponList = tenantCouponList;
    }

    public List getOtherList() {
        return otherList;
    }

    public void setOtherList(List otherList) {
        this.otherList = otherList;
    }

    public List getCouponList() {
        return couponList;
    }

    public void setCouponList(List couponList) {
        this.couponList = couponList;
    }

    public Map<String, Object> getBusCouponBean() {
        return busCouponBean;
    }

    public void setBusCouponBean(Map<String, Object> busCouponBean) {
        this.busCouponBean = busCouponBean;
    }

    public Map<String, Object> getBusCouponBean1() {
        return busCouponBean1;
    }

    public void setBusCouponBean1(Map<String, Object> busCouponBean1) {
        this.busCouponBean1 = busCouponBean1;
    }

    public int getBusExpireSum() {
        return busExpireSum;
    }

    public void setBusExpireSum(int busExpireSum) {
        this.busExpireSum = busExpireSum;
    }

    public int getBusExpireSum1() {
        return busExpireSum1;
    }

    public void setBusExpireSum1(int busExpireSum1) {
        this.busExpireSum1 = busExpireSum1;
    }

}
