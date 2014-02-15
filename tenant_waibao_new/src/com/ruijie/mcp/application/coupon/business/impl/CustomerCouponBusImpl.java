package com.ruijie.mcp.application.coupon.business.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.business.ICustomerCouponBus;
import com.ruijie.mcp.application.coupon.dao.ICustomerCouponDao;
import com.ruijie.mcp.application.coupon.model.TenantCustomerCoupon;

public class CustomerCouponBusImpl implements ICustomerCouponBus {

	private ICustomerCouponDao customerCouponDao;

	@Override
	public int countByHql(String hql) {
		return this.customerCouponDao.countByHql(hql);
	}

	@Override
	public void delete(TenantCustomerCoupon bean) {
		this.customerCouponDao.delete(bean);
	}

	@Override
	public void deleteAll(Collection<TenantCustomerCoupon> entities) {
		this.customerCouponDao.deleteAll(entities);
	}

	@Override
	public List<TenantCustomerCoupon> find(String queryString) {
		return this.customerCouponDao.find(queryString);
	}

	@Override
	public List<TenantCustomerCoupon> find(String queryString, Object value) {
		return this.customerCouponDao.find(queryString, value);
	}

	@Override
	public List<TenantCustomerCoupon> find(String queryString, Object[] values) {
		return this.customerCouponDao.find(queryString, values);
	}

	@Override
	public List<TenantCustomerCoupon> findByNamedQuery(String queryName) {
		return this.customerCouponDao.findByNamedQuery(queryName);
	}

	@Override
	public List<TenantCustomerCoupon> findByNamedQuery(String queryName, Object value) {
		return this.customerCouponDao.findByNamedQuery(queryName, value);
	}

	@Override
	public List<TenantCustomerCoupon> findByNamedQuery(String queryName, Object[] values) {
		return this.customerCouponDao.findByNamedQuery(queryName, values);
	}

	@Override
	public int findCountByParams(String strHql, Map params) {
		return this.customerCouponDao.findCountByParams(strHql, params);

	}

	@Override
	public TenantCustomerCoupon get(Long id) {
		return this.customerCouponDao.get(id);
	}

	@Override
	public List<TenantCustomerCoupon> getLimitedObjects(String hql, int maxResult) {
		return this.customerCouponDao.getLimitedObjects(hql, maxResult);
	}

	@Override
	public List<TenantCustomerCoupon> getPagingByParams(String hql, Map params, int pageStart, int maxResult) {
		return this.customerCouponDao.getPagingByParams(hql, params, pageStart, maxResult);
	}

	@Override
	public List<TenantCustomerCoupon> getPagingObjects(String hql, int pageStart, int maxResult) {
		return this.customerCouponDao.getPagingObjects(hql, pageStart, maxResult);
	}

	@Override
	public List<TenantCustomerCoupon> list() {
		return this.customerCouponDao.list();
	}

	@Override
	public Serializable save(TenantCustomerCoupon bean) {
		return this.customerCouponDao.save(bean);
	}

	@Override
	public void saveOrUpdate(TenantCustomerCoupon bean) {
		this.customerCouponDao.saveOrUpdate(bean);
	}

	@Override
	public void saveOrUpdateAll(Collection<TenantCustomerCoupon> entities) {
		this.customerCouponDao.saveOrUpdateAll(entities);
	}

	@Override
	public void update(TenantCustomerCoupon bean) {
		this.customerCouponDao.update(bean);
	}

    public ICustomerCouponDao getCustomerCouponDao() {
        return customerCouponDao;
    }

    public void setCustomerCouponDao(ICustomerCouponDao customerCouponDao) {
        this.customerCouponDao = customerCouponDao;
    }


}
