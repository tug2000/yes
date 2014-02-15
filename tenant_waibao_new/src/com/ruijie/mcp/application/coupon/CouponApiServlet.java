package com.ruijie.mcp.application.coupon;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;

import com.alibaba.fastjson.JSON;
import com.ruijie.mcp.application.coupon.appapi.AppRequest;
import com.ruijie.mcp.application.coupon.appapi.AppResponse;
import com.ruijie.mcp.application.coupon.appapi.CouponCustomerInfo;
import com.ruijie.mcp.application.coupon.appapi.LoginSuccess;
import com.ruijie.mcp.application.coupon.business.ICustomerCouponBus;
import com.ruijie.mcp.application.coupon.business.ITenantCouponBus;
import com.ruijie.mcp.application.coupon.business.ITenantCouponConsumeBus;
import com.ruijie.mcp.application.coupon.business.ITenantCouponConverBus;
import com.ruijie.mcp.application.coupon.business.ITenantWaiterBus;
import com.ruijie.mcp.application.coupon.constant.CouponConstant;
import com.ruijie.mcp.application.coupon.model.TenantCoupon;
import com.ruijie.mcp.application.coupon.model.TenantCouponConsume;
import com.ruijie.mcp.application.coupon.model.TenantCouponConver;
import com.ruijie.mcp.application.coupon.model.TenantCustomerCoupon;
import com.ruijie.mcp.application.coupon.model.TenantWaiter;
import com.ruijie.mcp.util.ServiceLocator;


public class CouponApiServlet extends HttpServlet {
    
    private Logger log = Logger.getLogger(CouponApiServlet.class);
    
    /**
     * 参数分割符
     */
    private String separator = "&";


    /**	
     * Member Description
     */
    
    private static final long serialVersionUID = -4493168076528017131L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        procAppRequest(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        procAppRequest(req, resp);
    }
    
    /**
     * 	
     * <p>Description: 处理APP请求 </p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param req
     * @param resp
     */
    private void procAppRequest(HttpServletRequest request, HttpServletResponse response){       
        try {         
            //提取请求消息
            StringBuilder sb = new StringBuilder();
            String line;
            request.setCharacterEncoding("UTF-8");
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            
            //接口方法分发
            String requestJson = sb.toString();
            String responseJson = "";
            log.info("requestJson:" + requestJson);
            AppRequest appRequest = JSON.parseObject(requestJson, AppRequest.class);
            if(appRequest.getMethod().equalsIgnoreCase(CouponConstant.METHOD_LOGIN)){ //登录
                responseJson = login(appRequest.getParameterMap());              
            }else if(appRequest.getMethod().equalsIgnoreCase(CouponConstant.METHOD_GET_COUPON_LIST)){ //获取点券列表信息
                responseJson = getCouponList(appRequest.getParameterMap());   
            }else if(appRequest.getMethod().equalsIgnoreCase(CouponConstant.METHOD_ADD_COUPON)){ //增加点券
                responseJson = addCoupon(appRequest.getParameterMap()); 
            }else if(appRequest.getMethod().equalsIgnoreCase(CouponConstant.METHOD_REDUCE_COUPON)){ //撤销点券
                responseJson = reduceCoupon(appRequest.getParameterMap()); 
            }else if(appRequest.getMethod().equalsIgnoreCase(CouponConstant.METHOD_EXCHANGE_COUPON)){ //兑换点券
                responseJson = exchangeCoupon(appRequest.getParameterMap()); 
            }else if(appRequest.getMethod().equalsIgnoreCase(CouponConstant.METHOD_UNCHANGE_COUPON)){ //撤换兑换点券
                responseJson = unchangeCoupon(appRequest.getParameterMap()); 
            }
            
            //返回消息           
            log.info("responseJson:" + responseJson);
            response.setCharacterEncoding("UTF-8");  
            response.getWriter().print(responseJson);    
            
        } catch (Exception e) {
            log.error("procAppRequest failed", e);
        }  
    }
    
    /**
     * 	
     * <p>Description:用户登录接口: login </p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param parameterMap
     * @return
     */
    private String login(Map<String, String> parameterMap){
        String responseJson = "";
        
        // 校验入参
        if(null == parameterMap || 0 == parameterMap.size() || !parameterMap.containsKey(CouponConstant.PARAM_APP_USER_NAME) ||
          !parameterMap.containsKey(CouponConstant.PARAM_APP_PWD)){
            responseJson = getErrResponse(1, "参数不全!");
            return responseJson;
        }
        
        // 校验登录
        ITenantWaiterBus tenantWaiterBus  = (ITenantWaiterBus)ServiceLocator.getBeanByName("tenantWaiterBus");
        String appUserName = parameterMap.get(CouponConstant.PARAM_APP_USER_NAME);
        String appPwd = parameterMap.get(CouponConstant.PARAM_APP_PWD);
        List<TenantWaiter> list = tenantWaiterBus.find("from TenantWaiter t where t.twAppUserName=? and t.twAppPwd=? ", new String[]{appUserName, appPwd});
        if(null == list || 0 == list.size()){
            responseJson = getErrResponse(1, "输入用户名或密码错误!");
            return responseJson;
        }else{
            TenantWaiter tenantWaiter = list.get(0);
            LoginSuccess loginSuccess = new LoginSuccess();
            loginSuccess.setAccessToken(tenantWaiter.getTwAccessToken());
            loginSuccess.setTenantId(tenantWaiter.getTwTenantId());
            loginSuccess.setWaiterId(tenantWaiter.getTwId());
            responseJson = JSON.toJSONString(loginSuccess);
        }     
        
        return responseJson;
    }
    
    /**
     *  
     * <p>Description:获取点券接口: getCouponList </p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param parameterMap
     * @return
     */
    private String getCouponList(Map<String, String> parameterMap){
        String responseJson = "";
        
        // 校验入参
       if(null == parameterMap || 0 == parameterMap.size() || !parameterMap.containsKey(CouponConstant.PARAM_CUSTOMER_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_TENANT_ID) || !parameterMap.containsKey(CouponConstant.PARAM_COUPON_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_WAITER_ID) || !parameterMap.containsKey(CouponConstant.PARAM_ACCESS_TOKEN)){
            responseJson = getErrResponse(1, "参数不全!");
            return responseJson;
        }
        
        // 接口访问安全校验
        ITenantWaiterBus tenantWaiterBus  = (ITenantWaiterBus)ServiceLocator.getBeanByName("tenantWaiterBus");
        String requestWaiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        TenantWaiter tenantWaiter = tenantWaiterBus.get(Long.valueOf(requestWaiterId));
        if(!requestWaiterId.equals(tenantWaiter.getTwAccessToken())){
            responseJson = getErrResponse(1, "访问受限!");
            return responseJson;
        }
        
        //联立表查询数据
        JdbcTemplate jdbcTemplate  = (JdbcTemplate)ServiceLocator.getBeanByName("jdbcTemplate");
        StringBuilder sb = new StringBuilder();
        sb.append("select t.TC_COID, t.TC_COUPON_NAME, t.TC_COUPON_ICOURL, t.TC_COUPON_CONVERTIBLESUM, t.TC_COUPON_CONVERTIBLENUM, t.TC_COUPON_VALID_BEGIN,");
        sb.append(" t.TC_COUPON_VALID_END, t.TC_COUPON_PUBLISH_SUM, t.TC_COUPON_LIMIT_STATUS, t.TC_COUPON_ACTIVIYDES, t.TC_COUPON_PRIZEUNIT,");
        sb.append(" c.TCC_COUPONNUM, c.TCC_WAITCONVERNUM");
        sb.append(" from tenant_coupon t");
        sb.append(" left join tenant_customer_coupon c");
        sb.append(" on t.TC_COID=c.TCC_COID");
        sb.append(" and t.TC_COUPON_STATUS=0 and c.TCC_CUID=");
        sb.append(parameterMap.get(CouponConstant.PARAM_CUSTOMER_ID));
        List<Map<String, Object>> dataList = jdbcTemplate.queryForList(sb.toString());
        
        //查询结果转换为API格式
        List<CouponCustomerInfo> apiList = new ArrayList<CouponCustomerInfo>();
        Map<String, Object> map = null;
        if(null != dataList && dataList.size()>0){
            for(int i=0; i<dataList.size(); ++i){
                map = dataList.get(i);
                CouponCustomerInfo info = new CouponCustomerInfo();
                info.setCouponId(Long.valueOf(map.get("TC_COID").toString()));
                info.setCouponDesc(map.get("TC_COUPON_ACTIVIYDES").toString());
                info.setCouponImgUrl(map.get("TC_COUPON_ICOURL").toString());
                info.setCouponName(map.get("TC_COUPON_NAME").toString());
                info.setCouponPrizeUnit(map.get("TC_COUPON_PRIZEUNIT").toString());
                info.setCouponSum(Integer.valueOf(map.get("TC_COUPON_CONVERTIBLESUM").toString()));
                info.setCouponNum(map.get("TCC_COUPONNUM")==null ? 0 : Integer.valueOf(map.get("TCC_COUPONNUM").toString()));
                info.setWaitConverNum(map.get("TCC_WAITCONVERNUM")==null ? 0 : Integer.valueOf(map.get("TCC_WAITCONVERNUM").toString()));
                apiList.add(info);
            }
        }
        
        //转换为Json格式返回
        responseJson = JSON.toJSONString(apiList);
        return responseJson;
    }
    
    /**
     *  
     * <p>Description:增加点券接口: addCoupon </p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param parameterMap
     * @return
     */
    private String addCoupon(Map<String, String> parameterMap){
        String responseJson = "";
        
        // 校验入参
        if(null == parameterMap || 0 == parameterMap.size() || !parameterMap.containsKey(CouponConstant.PARAM_CUSTOMER_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_TENANT_ID) || !parameterMap.containsKey(CouponConstant.PARAM_COUPON_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_WAITER_ID) || !parameterMap.containsKey(CouponConstant.PARAM_ACCESS_TOKEN)){
            responseJson = getErrResponse(1, "参数不全!");
            return responseJson;
        }
        
        // 接口访问安全校验
        ITenantWaiterBus tenantWaiterBus  = (ITenantWaiterBus)ServiceLocator.getBeanByName("tenantWaiterBus");
        String requestWaiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        TenantWaiter tenantWaiter = tenantWaiterBus.get(Long.valueOf(requestWaiterId));
        if(!requestWaiterId.equals(tenantWaiter.getTwAccessToken())){
            responseJson = getErrResponse(1, "访问受限!");
            return responseJson;
        } 
        
        // 点券数加1
        ICustomerCouponBus customerCouponBus  = (ICustomerCouponBus)ServiceLocator.getBeanByName("customerCouponBus");
        String customerId = parameterMap.get(CouponConstant.PARAM_CUSTOMER_ID);
        String tenantId = parameterMap.get(CouponConstant.PARAM_TENANT_ID);
        String couponId = parameterMap.get(CouponConstant.PARAM_COUPON_ID);
        String waiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        List<TenantCustomerCoupon> list = customerCouponBus.find("from TenantCustomerCoupon t where t.tccCuId=? and t.tccCoId=? ", new String[]{customerId, couponId});
        TenantCustomerCoupon tenantCustomerCoupon = null;
        TenantCoupon tenantCoupon = getCouponByCouponId(Long.valueOf(couponId));

        if(null == list || 0 == list.size()){
            tenantCustomerCoupon = new TenantCustomerCoupon();
            tenantCustomerCoupon.setTccCoId(Long.valueOf(couponId));
            tenantCustomerCoupon.setTccCuId(Long.valueOf(customerId));
            tenantCustomerCoupon.setTccTenantId(tenantId);
            tenantCustomerCoupon.setTccCouponNum(1);
            tenantCustomerCoupon.setTccConvertibleNum(0);
            tenantCustomerCoupon.setTccWaitConverNum(0);
            customerCouponBus.save(tenantCustomerCoupon);
            
            //点券卡领用记录+1
            tenantCoupon.setTcUsedSum(tenantCoupon.getTcUsedSum()+1);
            int userSum = null == tenantCoupon.getTcUserSum() ? 0 : tenantCoupon.getTcUserSum();
            tenantCoupon.setTcUserSum(userSum+1);
        }else{
            tenantCustomerCoupon = list.get(0); 
            
            //发行的点券已用光
            if(tenantCoupon.getTcUsedSum()>=tenantCoupon.getTcPublishSum()){
                responseJson = getErrResponse(1, "该点券卡已用完!");
                return responseJson;
            }
            
            //顾客使用次数限制
            if(tenantCoupon.getTcUserLimitStatus()>0 && (tenantCustomerCoupon.getTccConvertibleNum()+tenantCustomerCoupon.getTccWaitConverNum() >=
                tenantCoupon.getTcUserLimitStatus()) ){
                responseJson = getErrResponse(1, "每位顾客只能领用"+tenantCoupon.getTcUserLimitStatus()+"张点券卡，该顾客不能再领用了!");
                return responseJson;
            }
            
            //点券加1
            tenantCustomerCoupon.setTccCouponNum(tenantCustomerCoupon.getTccCouponNum()+1);
            if(tenantCustomerCoupon.getTccCouponNum()>=tenantCoupon.getTcCouponConvertibleSum()){
                tenantCustomerCoupon.setTccCouponNum(0);
                tenantCustomerCoupon.setTccWaitConverNum(tenantCustomerCoupon.getTccWaitConverNum()+1);
            }
            int saleSum = null == tenantCoupon.getTcSaleSum() ? 0 : tenantCoupon.getTcSaleSum();
            tenantCoupon.setTcSaleSum(saleSum+1);
           
        }
        
        //记录点券消费日志
        ITenantCouponConsumeBus tenantCouponConsumeBus  = (ITenantCouponConsumeBus)ServiceLocator.getBeanByName("tenantCouponConsumeBus");
        TenantCouponConsume tenantCouponConsume = new TenantCouponConsume();
        tenantCouponConsume.setTcCoId(Long.valueOf(couponId));
        tenantCouponConsume.setTcCuId(Long.valueOf(customerId));
        tenantCouponConsume.setTcDate(new Date());
        tenantCouponConsume.setTcNumber(1);
        tenantCouponConsume.setTcTenantId(tenantId);
        tenantCouponConsume.setTcWaiterId(Long.valueOf(waiterId));
        tenantCouponConsumeBus.save(tenantCouponConsume);
        
        //更新点券记录数
        ITenantCouponBus tenantCouponBus  = (ITenantCouponBus)ServiceLocator.getBeanByName("tenantCouponBus");
        tenantCouponBus.update(tenantCoupon);
        
        //执行成功返回结果
        responseJson = getSuccessResponse(tenantCustomerCoupon.getTccCouponNum().toString() + separator + tenantCustomerCoupon.getTccWaitConverNum().toString());
        
        return responseJson;
    }
    
    /**
     * 	
     * <p>Description: 根据Id获取点券信息 </p>
     * <p>Create Time: 2014-1-28   </p>
     * @author xwrj
     * @param couponId
     * @return
     */
    private TenantCoupon getCouponByCouponId(Long couponId){
        ITenantCouponBus tenantCouponBus  = (ITenantCouponBus)ServiceLocator.getBeanByName("tenantCouponBus");
        TenantCoupon tenantCoupon = tenantCouponBus.get(couponId);
        return tenantCoupon;
    }
    
    /**
     *  
     * <p>Description:撤销点券接口: reduceCoupon </p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param parameterMap
     * @return
     */
    private String reduceCoupon(Map<String, String> parameterMap){
        String responseJson = "";
        
        // 校验入参
        if(null == parameterMap || 0 == parameterMap.size() || !parameterMap.containsKey(CouponConstant.PARAM_CUSTOMER_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_TENANT_ID) || !parameterMap.containsKey(CouponConstant.PARAM_COUPON_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_WAITER_ID) || !parameterMap.containsKey(CouponConstant.PARAM_ACCESS_TOKEN)){
            responseJson = getErrResponse(1, "参数不全!");
            return responseJson;
        }
        
        // 接口访问安全校验
        ITenantWaiterBus tenantWaiterBus  = (ITenantWaiterBus)ServiceLocator.getBeanByName("tenantWaiterBus");
        String requestWaiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        TenantWaiter tenantWaiter = tenantWaiterBus.get(Long.valueOf(requestWaiterId));
        if(!requestWaiterId.equals(tenantWaiter.getTwAccessToken())){
            responseJson = getErrResponse(1, "访问受限!");
            return responseJson;
        } 
        
        // 点券数减1
        ICustomerCouponBus customerCouponBus  = (ICustomerCouponBus)ServiceLocator.getBeanByName("customerCouponBus");
        String customerId = parameterMap.get(CouponConstant.PARAM_CUSTOMER_ID);
        String tenantId = parameterMap.get(CouponConstant.PARAM_TENANT_ID);
        String couponId = parameterMap.get(CouponConstant.PARAM_COUPON_ID);
        String waiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        List<TenantCustomerCoupon> list = customerCouponBus.find("from TenantCustomerCoupon t where t.tccCuId=? and t.tccCoId=? ", new String[]{customerId, couponId});
        TenantCustomerCoupon tenantCustomerCoupon = null;
        TenantCoupon tenantCoupon = getCouponByCouponId(Long.valueOf(couponId));

        if(null != list && list.size()>0){
            tenantCustomerCoupon = list.get(0); 
            
            //点券减1
            tenantCustomerCoupon.setTccCouponNum(tenantCustomerCoupon.getTccCouponNum()-1);
            if(tenantCustomerCoupon.getTccCouponNum()<0){
                tenantCustomerCoupon.setTccCouponNum(tenantCoupon.getTcCouponConvertibleSum()-1);
                tenantCustomerCoupon.setTccWaitConverNum(tenantCustomerCoupon.getTccWaitConverNum()-1);
            }
           
        }else{
            responseJson = getErrResponse(1, "该顾客无点券消费记录，撤销失败!");
            return responseJson;
        }
        
        //记录点券消费日志
        ITenantCouponConsumeBus tenantCouponConsumeBus  = (ITenantCouponConsumeBus)ServiceLocator.getBeanByName("tenantCouponConsumeBus");
        TenantCouponConsume tenantCouponConsume = new TenantCouponConsume();
        tenantCouponConsume.setTcCoId(Long.valueOf(couponId));
        tenantCouponConsume.setTcCuId(Long.valueOf(customerId));
        tenantCouponConsume.setTcDate(new Date());
        tenantCouponConsume.setTcNumber(-1);
        tenantCouponConsume.setTcTenantId(tenantId);
        tenantCouponConsume.setTcWaiterId(Long.valueOf(waiterId));
        tenantCouponConsumeBus.save(tenantCouponConsume);
        
        //执行成功返回结果
        responseJson = getSuccessResponse(tenantCustomerCoupon.getTccCouponNum().toString() + separator + tenantCustomerCoupon.getTccWaitConverNum().toString());
        
        return responseJson;
    }
    
    /**
     *  
     * <p>Description:兑换点券接口: exchangeCoupon </p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param parameterMap
     * @return
     */
    private String exchangeCoupon(Map<String, String> parameterMap){
        String responseJson = "";
        
        // 校验入参
        if(null == parameterMap || 0 == parameterMap.size() || !parameterMap.containsKey(CouponConstant.PARAM_CUSTOMER_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_TENANT_ID) || !parameterMap.containsKey(CouponConstant.PARAM_COUPON_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_WAITER_ID) || !parameterMap.containsKey(CouponConstant.PARAM_ACCESS_TOKEN)){
            responseJson = getErrResponse(1, "参数不全!");
            return responseJson;
        }
        
        // 接口访问安全校验
        ITenantWaiterBus tenantWaiterBus  = (ITenantWaiterBus)ServiceLocator.getBeanByName("tenantWaiterBus");
        String requestWaiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        TenantWaiter tenantWaiter = tenantWaiterBus.get(Long.valueOf(requestWaiterId));
        if(!requestWaiterId.equals(tenantWaiter.getTwAccessToken())){
            responseJson = getErrResponse(1, "访问受限!");
            return responseJson;
        } 
        
        // 兑换点券
        ICustomerCouponBus customerCouponBus  = (ICustomerCouponBus)ServiceLocator.getBeanByName("customerCouponBus");
        String customerId = parameterMap.get(CouponConstant.PARAM_CUSTOMER_ID);
        String tenantId = parameterMap.get(CouponConstant.PARAM_TENANT_ID);
        String couponId = parameterMap.get(CouponConstant.PARAM_COUPON_ID);
        String waiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        List<TenantCustomerCoupon> list = customerCouponBus.find("from TenantCustomerCoupon t where t.tccCuId=? and t.tccCoId=? ", new String[]{customerId, couponId});
        TenantCustomerCoupon tenantCustomerCoupon = null;

        if(null == list || 0 == list.size()){
            responseJson = getErrResponse(1, "该顾客累积的点券数还不够，不能兑换!");
            return responseJson;
        }else{
            tenantCustomerCoupon = list.get(0); 
            
            //累积点券数不够
            if(tenantCustomerCoupon.getTccWaitConverNum()<=0){
                responseJson = getErrResponse(1, "该顾客累积的点券数还不够，不能兑换!");
                return responseJson;
            }
            
            //兑换数减1
            tenantCustomerCoupon.setTccWaitConverNum(tenantCustomerCoupon.getTccWaitConverNum()-1);
            tenantCustomerCoupon.setTccConvertibleNum(tenantCustomerCoupon.getTccConvertibleNum()+1);
           
        }
        
        //记录点券兑换日志
        ITenantCouponConverBus tenantCouponConverBus  = (ITenantCouponConverBus)ServiceLocator.getBeanByName("tenantCouponConverBus");
        TenantCouponConver tenantCouponConver = new TenantCouponConver();
        tenantCouponConver.setTcCoId(Long.valueOf(couponId));
        tenantCouponConver.setTcCuId(Long.valueOf(customerId));
        tenantCouponConver.setTcDate(new Date());
        tenantCouponConver.setTcNumber(1);
        tenantCouponConver.setTcTenantId(tenantId);
        tenantCouponConver.setTcWaiterId(Long.valueOf(waiterId));
        tenantCouponConverBus.save(tenantCouponConver);
        
        //执行成功返回结果
        responseJson = getSuccessResponse(tenantCustomerCoupon.getTccCouponNum().toString() + separator + tenantCustomerCoupon.getTccWaitConverNum().toString());
        
        return responseJson;
    }
    
    /**
     *  
     * <p>Description:撤销兑换点券接口: unchangeCoupon </p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param parameterMap
     * @return
     */
    private String unchangeCoupon(Map<String, String> parameterMap){
        String responseJson = "";
        
        // 校验入参
        if(null == parameterMap || 0 == parameterMap.size() || !parameterMap.containsKey(CouponConstant.PARAM_CUSTOMER_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_TENANT_ID) || !parameterMap.containsKey(CouponConstant.PARAM_COUPON_ID) ||
          !parameterMap.containsKey(CouponConstant.PARAM_WAITER_ID) || !parameterMap.containsKey(CouponConstant.PARAM_ACCESS_TOKEN)){
            responseJson = getErrResponse(1, "参数不全!");
            return responseJson;
        }
        
        // 接口访问安全校验
        ITenantWaiterBus tenantWaiterBus  = (ITenantWaiterBus)ServiceLocator.getBeanByName("tenantWaiterBus");
        String requestWaiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        TenantWaiter tenantWaiter = tenantWaiterBus.get(Long.valueOf(requestWaiterId));
        if(!requestWaiterId.equals(tenantWaiter.getTwAccessToken())){
            responseJson = getErrResponse(1, "访问受限!");
            return responseJson;
        } 
        
        // 撤销兑换点券
        ICustomerCouponBus customerCouponBus  = (ICustomerCouponBus)ServiceLocator.getBeanByName("customerCouponBus");
        String customerId = parameterMap.get(CouponConstant.PARAM_CUSTOMER_ID);
        String tenantId = parameterMap.get(CouponConstant.PARAM_TENANT_ID);
        String couponId = parameterMap.get(CouponConstant.PARAM_COUPON_ID);
        String waiterId = parameterMap.get(CouponConstant.PARAM_WAITER_ID);
        List<TenantCustomerCoupon> list = customerCouponBus.find("from TenantCustomerCoupon t where t.tccCuId=? and t.tccCoId=? ", new String[]{customerId, couponId});
        TenantCustomerCoupon tenantCustomerCoupon = null;

        if(null == list || 0 == list.size()){
            responseJson = getErrResponse(1, "该顾客无点券消费记录，撤销兑换失败!");
            return responseJson;
        }else{
            tenantCustomerCoupon = list.get(0); 
            
            //兑换数减1
            tenantCustomerCoupon.setTccWaitConverNum(tenantCustomerCoupon.getTccWaitConverNum()+1);
            tenantCustomerCoupon.setTccConvertibleNum(tenantCustomerCoupon.getTccConvertibleNum()-1);
           
        }
        
        //记录点券兑换日志
        ITenantCouponConverBus tenantCouponConverBus  = (ITenantCouponConverBus)ServiceLocator.getBeanByName("tenantCouponConverBus");
        TenantCouponConver tenantCouponConver = new TenantCouponConver();
        tenantCouponConver.setTcCoId(Long.valueOf(couponId));
        tenantCouponConver.setTcCuId(Long.valueOf(customerId));
        tenantCouponConver.setTcDate(new Date());
        tenantCouponConver.setTcNumber(-1);
        tenantCouponConver.setTcTenantId(tenantId);
        tenantCouponConver.setTcWaiterId(Long.valueOf(waiterId));
        tenantCouponConverBus.save(tenantCouponConver);
        
        //执行成功返回结果
        responseJson = getSuccessResponse(tenantCustomerCoupon.getTccCouponNum().toString() + separator + tenantCustomerCoupon.getTccWaitConverNum().toString());
        
        return responseJson;
    }
    
    
    /**
     * 	
     * <p>Description: 生成错误Json信息</p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param msg
     * @return
     */
    private String getErrResponse(Integer errcode, String msg){
        String responseJson = "";
        AppResponse appResponse = new AppResponse();
        appResponse.setErrcode(errcode);
        appResponse.setErrmsg(msg);
        responseJson = JSON.toJSONString(appResponse);
        return responseJson;
    }
    
    /**
     *  
     * <p>Description: 生成成功Json信息</p>
     * <p>Create Time: 2014-1-27   </p>
     * @author xwrj
     * @param msg
     * @return
     */
    private String getSuccessResponse(String additionInfo){
        String responseJson = "";
        AppResponse appResponse = new AppResponse();
        appResponse.setErrcode(0);
        appResponse.setAdditionInfo(additionInfo);
        responseJson = JSON.toJSONString(appResponse);
        return responseJson;
    }

}
