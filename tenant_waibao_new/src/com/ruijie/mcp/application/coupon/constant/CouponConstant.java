package com.ruijie.mcp.application.coupon.constant;

public interface CouponConstant {
    
    /**
     * 接口方法：登录
     */
    public static String METHOD_LOGIN = "login";
    
    /**
     * 接口方法：获取点券列表
     */
    public static String METHOD_GET_COUPON_LIST = "getCouponList";
    
    
    /**
     * 接口方法：增加点券
     */
    public static String METHOD_ADD_COUPON = "addCoupon";
    
    
    /**
     * 接口方法：撤销点券
     */
    public static String METHOD_REDUCE_COUPON = "reduceCoupon";
    
    
    /**
     * 接口方法：兑换点券
     */
    public static String METHOD_EXCHANGE_COUPON = "exchangeCoupon";
    
    
    /**
     * 接口方法：撤销兑换点券
     */
    public static String METHOD_UNCHANGE_COUPON = "unchangeCoupon";
    
    /**
     * 登录参数：App登录名
     */
    public static String PARAM_APP_USER_NAME = "appUserName";
    
    /**
     * 登录参数：App登录密码
     */
    public static String PARAM_APP_PWD = "appPwd";
    
    /**
     * 通用参数：顾客Id
     */
    public static String PARAM_CUSTOMER_ID = "customerId";
    
    /**
     * 通用参数：租户Id
     */
    public static String PARAM_TENANT_ID = "tenantId";
    
    /**
     * 通用参数：接口访问令牌
     */
    public static String PARAM_ACCESS_TOKEN = "accessToken";
    
    /**
     * 通用参数：点券Id
     */
    public static String PARAM_COUPON_ID = "couponId";
    
    /**
     * 通用参数：店员Id
     */
    public static String PARAM_WAITER_ID = "waiterId";
    
}
