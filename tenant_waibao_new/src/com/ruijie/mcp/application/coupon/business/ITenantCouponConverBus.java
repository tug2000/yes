package com.ruijie.mcp.application.coupon.business;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.model.TenantCouponConver;

public interface ITenantCouponConverBus {
    Serializable save(TenantCouponConver bean);

    void saveOrUpdate(TenantCouponConver bean);

    void saveOrUpdateAll(Collection<TenantCouponConver> entities);

    void update(TenantCouponConver bean);

    void delete(TenantCouponConver bean);

    void deleteAll(Collection<TenantCouponConver> entities);

    TenantCouponConver get(Long id);

    List<TenantCouponConver> find(String queryString);

    List<TenantCouponConver> find(String queryString, Object value);

    List<TenantCouponConver> find(String queryString, Object[] values);

    List<TenantCouponConver> list();

    List<TenantCouponConver> findByNamedQuery(String queryName);

    List<TenantCouponConver> findByNamedQuery(String queryName, Object value);

    List<TenantCouponConver> findByNamedQuery(String queryName, Object[] values);

    public List<TenantCouponConver> getPagingObjects(final String hql, final int pageStart, final int maxResult);

    public List<TenantCouponConver> getLimitedObjects(final String hql, final int maxResult);

    public int countByHql(final String hql);

    public List<TenantCouponConver> getPagingByParams(final String hql, final Map params, final int pageStart,
            final int maxResult);

    public int findCountByParams(String strHql, Map params);
}
