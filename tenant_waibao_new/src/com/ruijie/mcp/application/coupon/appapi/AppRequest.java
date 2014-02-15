package com.ruijie.mcp.application.coupon.appapi;

import java.util.Map;

/**
 * 
 * <p>Title: APP调用的请求参数对象</p>
 * <p>Description: Function Description </p>
 * <p>Copyright: Copyright (c) 2014     </p>
 * <p>Company: Ruijie Co., Ltd.       </p>
 * <p>Create Time: 2014-1-26           </p>
 * @author xwrj
 * <p>Update Time:                      </p>
 * <p>Updater:                          </p>
 * <p>Update Comments:                  </p>
 */
public class AppRequest {
    
    /**
     * 调用的方法名
     */
    private String method;
    
    /**
     * 需要的参数
     */
    private Map<String, String> parameterMap;
    
    public void setMethod(String method) {
        this.method = method;
    }
    public String getMethod() {
        return method;
    }
    public void setParameterMap(Map<String, String> parameterMap) {
        this.parameterMap = parameterMap;
    }
    public Map<String, String> getParameterMap() {
        return parameterMap;
    }

}
