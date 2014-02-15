package com.ruijie.mcp.application.coupon.business;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.model.TenantWaiter;


public interface ITenantWaiterBus {

	Serializable save(TenantWaiter bean);

	void saveOrUpdate(TenantWaiter bean);

	void saveOrUpdateAll(Collection<TenantWaiter> entities);

	void update(TenantWaiter bean);

	void delete(TenantWaiter bean);

	void deleteAll(Collection<TenantWaiter> entities);

	TenantWaiter get(Long id);

	List<TenantWaiter> find(String queryString);

	List<TenantWaiter> find(String queryString, Object value);

	List<TenantWaiter> find(String queryString, Object[] values);

	List<TenantWaiter> list();

	List<TenantWaiter> findByNamedQuery(String queryName);

	List<TenantWaiter> findByNamedQuery(String queryName, Object value);

	List<TenantWaiter> findByNamedQuery(String queryName, Object[] values);

	public List<TenantWaiter> getPagingObjects(final String hql, final int pageStart, final int maxResult);

	public List<TenantWaiter> getLimitedObjects(final String hql, final int maxResult);

	public int countByHql(final String hql);

	public List<TenantWaiter> getPagingByParams(final String hql, final Map params, final int pageStart, final int maxResult);

	public int findCountByParams(String strHql, Map params);
	
	public TenantWaiter getWaiterByTenantId(String tenantId);
	
}
