package com.ruijie.mcp.application.coupon.business;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.model.TenantCustomer;

public interface ITenantCustomerBus {
    Serializable save(TenantCustomer bean);

    void saveOrUpdate(TenantCustomer bean);

    void saveOrUpdateAll(Collection<TenantCustomer> entities);

    void update(TenantCustomer bean);

    void delete(TenantCustomer bean);

    void deleteAll(Collection<TenantCustomer> entities);

    TenantCustomer get(Long id);

    List<TenantCustomer> find(String queryString);

    List<TenantCustomer> find(String queryString, Object value);

    List<TenantCustomer> find(String queryString, Object[] values);

    List<TenantCustomer> list();

    List<TenantCustomer> findByNamedQuery(String queryName);

    List<TenantCustomer> findByNamedQuery(String queryName, Object value);

    List<TenantCustomer> findByNamedQuery(String queryName, Object[] values);

    public List<TenantCustomer> getPagingObjects(final String hql, final int pageStart, final int maxResult);

    public List<TenantCustomer> getLimitedObjects(final String hql, final int maxResult);

    public int countByHql(final String hql);

    public List<TenantCustomer> getPagingByParams(final String hql, final Map params, final int pageStart,
            final int maxResult);

    public int findCountByParams(String strHql, Map params);
    
    /**
     * 	
     * <p>Description: 判断指定openId的顾客是否已存在 </p>
     * <p>Create Time: 2014-1-24   </p>
     * @author xwrj
     * @param openId
     * @return
     */
    public boolean isExistByOpenId(String openId);
    
    /**
     * 	
     * <p>Description: 根据openId获取顾客Id </p>
     * <p>Create Time: 2014-1-24   </p>
     * @author xwrj
     * @param openId
     * @return
     */
    public TenantCustomer getCustomerByOpenId(String openId);
}
