package com.ruijie.mcp.application.coupon.business;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import com.ruijie.mcp.application.coupon.model.TenantCoupon;

public interface ITenantCouponBus {
    Serializable save(TenantCoupon bean);

    void saveOrUpdate(TenantCoupon bean);

    void saveOrUpdateAll(Collection<TenantCoupon> entities);

    void update(TenantCoupon bean);

    void delete(TenantCoupon bean);

    void deleteAll(Collection<TenantCoupon> entities);

    TenantCoupon get(Long id);

    List<TenantCoupon> find(String queryString);

    List<TenantCoupon> find(String queryString, Object value);

    List<TenantCoupon> find(String queryString, Object[] values);

    List<TenantCoupon> list();

    List<TenantCoupon> findByNamedQuery(String queryName);

    List<TenantCoupon> findByNamedQuery(String queryName, Object value);

    List<TenantCoupon> findByNamedQuery(String queryName, Object[] values);

    public List<TenantCoupon> getPagingObjects(final String hql, final int pageStart, final int maxResult);

    public List<TenantCoupon> getLimitedObjects(final String hql, final int maxResult);

    public int countByHql(final String hql);

    public List<TenantCoupon> getPagingByParams(final String hql, final Map params, final int pageStart,
            final int maxResult);

    public int findCountByParams(String strHql, Map params);
    
    public TenantCoupon getByCouponName(String couponName, String tenantId);
}
