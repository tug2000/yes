package com.ruijie.mcp.application.coupon.business;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.model.TenantCustomerCoupon;


public interface ICustomerCouponBus {

	Serializable save(TenantCustomerCoupon bean);

	void saveOrUpdate(TenantCustomerCoupon bean);

	void saveOrUpdateAll(Collection<TenantCustomerCoupon> entities);

	void update(TenantCustomerCoupon bean);

	void delete(TenantCustomerCoupon bean);

	void deleteAll(Collection<TenantCustomerCoupon> entities);

	TenantCustomerCoupon get(Long id);

	List<TenantCustomerCoupon> find(String queryString);

	List<TenantCustomerCoupon> find(String queryString, Object value);

	List<TenantCustomerCoupon> find(String queryString, Object[] values);

	List<TenantCustomerCoupon> list();

	List<TenantCustomerCoupon> findByNamedQuery(String queryName);

	List<TenantCustomerCoupon> findByNamedQuery(String queryName, Object value);

	List<TenantCustomerCoupon> findByNamedQuery(String queryName, Object[] values);

	public List<TenantCustomerCoupon> getPagingObjects(final String hql, final int pageStart, final int maxResult);

	public List<TenantCustomerCoupon> getLimitedObjects(final String hql, final int maxResult);

	public int countByHql(final String hql);

	public List<TenantCustomerCoupon> getPagingByParams(final String hql, final Map params, final int pageStart, final int maxResult);

	public int findCountByParams(String strHql, Map params);
	
}
