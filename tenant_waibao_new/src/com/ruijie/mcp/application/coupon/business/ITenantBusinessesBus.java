package com.ruijie.mcp.application.coupon.business;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.model.TenantBusinesses;

public interface ITenantBusinessesBus {

    Serializable save(TenantBusinesses bean);

    void saveOrUpdate(TenantBusinesses bean);

    void saveOrUpdateAll(Collection<TenantBusinesses> entities);

    void update(TenantBusinesses bean);

    void delete(TenantBusinesses bean);

    void deleteAll(Collection<TenantBusinesses> entities);

    TenantBusinesses get(Long id);

    List<TenantBusinesses> find(String queryString);

    List<TenantBusinesses> find(String queryString, Object value);

    List<TenantBusinesses> find(String queryString, Object[] values);

    List<TenantBusinesses> list();

    List<TenantBusinesses> findByNamedQuery(String queryName);

    List<TenantBusinesses> findByNamedQuery(String queryName, Object value);

    List<TenantBusinesses> findByNamedQuery(String queryName, Object[] values);

    public List<TenantBusinesses> getPagingObjects(final String hql, final int pageStart, final int maxResult);

    public List<TenantBusinesses> getLimitedObjects(final String hql, final int maxResult);

    public int countByHql(final String hql);
    
    public List<TenantBusinesses> getPagingByParams(final String hql, final Map params, final int pageStart, final int maxResult);

    public int findCountByParams(String strHql, Map params);
    
    public TenantBusinesses getTenantByTenantId(String tenantId);
}
