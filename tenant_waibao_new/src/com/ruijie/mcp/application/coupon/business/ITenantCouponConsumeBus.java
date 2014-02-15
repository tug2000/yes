package com.ruijie.mcp.application.coupon.business;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.model.TenantCouponConsume;

public interface ITenantCouponConsumeBus {
    Serializable save(TenantCouponConsume bean);

    void saveOrUpdate(TenantCouponConsume bean);

    void saveOrUpdateAll(Collection<TenantCouponConsume> entities);

    void update(TenantCouponConsume bean);

    void delete(TenantCouponConsume bean);

    void deleteAll(Collection<TenantCouponConsume> entities);

    TenantCouponConsume get(Long id);

    List<TenantCouponConsume> find(String queryString);

    List<TenantCouponConsume> find(String queryString, Object value);

    List<TenantCouponConsume> find(String queryString, Object[] values);

    List<TenantCouponConsume> list();

    List<TenantCouponConsume> findByNamedQuery(String queryName);

    List<TenantCouponConsume> findByNamedQuery(String queryName, Object value);

    List<TenantCouponConsume> findByNamedQuery(String queryName, Object[] values);

    public List<TenantCouponConsume> getPagingObjects(final String hql, final int pageStart, final int maxResult);

    public List<TenantCouponConsume> getLimitedObjects(final String hql, final int maxResult);

    public int countByHql(final String hql);

    public List<TenantCouponConsume> getPagingByParams(final String hql, final Map params, final int pageStart, final int maxResult);

    public int findCountByParams(String strHql, Map params);
}
