package com.ruijie.mcp.application.coupon.business.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.business.ITenantWaiterBus;
import com.ruijie.mcp.application.coupon.dao.ITenantWaiterDao;
import com.ruijie.mcp.application.coupon.model.TenantWaiter;

public class TenantWaiterBusImpl implements ITenantWaiterBus {

	private ITenantWaiterDao tenantWaiterDao;

	@Override
	public int countByHql(String hql) {
		return this.tenantWaiterDao.countByHql(hql);
	}

	@Override
	public void delete(TenantWaiter bean) {
		this.tenantWaiterDao.delete(bean);
	}

	@Override
	public void deleteAll(Collection<TenantWaiter> entities) {
		this.tenantWaiterDao.deleteAll(entities);
	}

	@Override
	public List<TenantWaiter> find(String queryString) {
		return this.tenantWaiterDao.find(queryString);
	}

	@Override
	public List<TenantWaiter> find(String queryString, Object value) {
		return this.tenantWaiterDao.find(queryString, value);
	}

	@Override
	public List<TenantWaiter> find(String queryString, Object[] values) {
		return this.tenantWaiterDao.find(queryString, values);
	}

	@Override
	public List<TenantWaiter> findByNamedQuery(String queryName) {
		return this.tenantWaiterDao.findByNamedQuery(queryName);
	}

	@Override
	public List<TenantWaiter> findByNamedQuery(String queryName, Object value) {
		return this.tenantWaiterDao.findByNamedQuery(queryName, value);
	}

	@Override
	public List<TenantWaiter> findByNamedQuery(String queryName, Object[] values) {
		return this.tenantWaiterDao.findByNamedQuery(queryName, values);
	}

	@Override
	public int findCountByParams(String strHql, Map params) {
		return this.tenantWaiterDao.findCountByParams(strHql, params);

	}

	@Override
	public TenantWaiter get(Long id) {
		return this.tenantWaiterDao.get(id);
	}

	@Override
	public List<TenantWaiter> getLimitedObjects(String hql, int maxResult) {
		return this.tenantWaiterDao.getLimitedObjects(hql, maxResult);
	}

	@Override
	public List<TenantWaiter> getPagingByParams(String hql, Map params, int pageStart, int maxResult) {
		return this.tenantWaiterDao.getPagingByParams(hql, params, pageStart, maxResult);
	}

	@Override
	public List<TenantWaiter> getPagingObjects(String hql, int pageStart, int maxResult) {
		return this.tenantWaiterDao.getPagingObjects(hql, pageStart, maxResult);
	}

	@Override
	public List<TenantWaiter> list() {
		return this.tenantWaiterDao.list();
	}

	@Override
	public Serializable save(TenantWaiter bean) {
		return this.tenantWaiterDao.save(bean);
	}

	@Override
	public void saveOrUpdate(TenantWaiter bean) {
		this.tenantWaiterDao.saveOrUpdate(bean);
	}

	@Override
	public void saveOrUpdateAll(Collection<TenantWaiter> entities) {
		this.tenantWaiterDao.saveOrUpdateAll(entities);
	}

	@Override
	public void update(TenantWaiter bean) {
		this.tenantWaiterDao.update(bean);
	}

    public ITenantWaiterDao getTenantWaiterDao() {
        return tenantWaiterDao;
    }

    public void setTenantWaiterDao(ITenantWaiterDao tenantWaiterDao) {
        this.tenantWaiterDao = tenantWaiterDao;
    }

    @Override
    public TenantWaiter getWaiterByTenantId(String tenantId) {
        List<TenantWaiter> list = this.tenantWaiterDao.find("from TenantWaiter where twTenantId=?", tenantId);
        if(null != list && list.size() > 0){
            return list.get(0);
        }
        return null;
    }



}
