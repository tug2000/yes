package com.ruijie.mcp.application.coupon.business.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.business.ITenantCouponConverBus;
import com.ruijie.mcp.application.coupon.dao.ITenantCouponConverDao;
import com.ruijie.mcp.application.coupon.model.TenantCouponConver;

public class TenantCouponConverBusImpl implements ITenantCouponConverBus {
    
    private ITenantCouponConverDao tenantCouponConverDao;

    @Override
    public int countByHql(String hql) {
        return this.tenantCouponConverDao.countByHql(hql);
    }

    @Override
    public void delete(TenantCouponConver bean) {
        this.tenantCouponConverDao.delete(bean);
    }

    @Override
    public void deleteAll(Collection<TenantCouponConver> entities) {
        this.tenantCouponConverDao.deleteAll(entities);
    }

    @Override
    public List<TenantCouponConver> find(String queryString) {
        return this.tenantCouponConverDao.find(queryString);
    }

    @Override
    public List<TenantCouponConver> find(String queryString, Object value) {
        return this.tenantCouponConverDao.find(queryString, value);
    }

    @Override
    public List<TenantCouponConver> find(String queryString, Object[] values) {
        return this.tenantCouponConverDao.find(queryString, values);
    }

    @Override
    public List<TenantCouponConver> findByNamedQuery(String queryName) {
        return this.tenantCouponConverDao.findByNamedQuery(queryName);
    }

    @Override
    public List<TenantCouponConver> findByNamedQuery(String queryName, Object value) {
        return this.tenantCouponConverDao.findByNamedQuery(queryName, value);
    }

    @Override
    public List<TenantCouponConver> findByNamedQuery(String queryName, Object[] values) {
        return this.tenantCouponConverDao.findByNamedQuery(queryName, values);
    }

    @Override
    public int findCountByParams(String strHql, Map params) {
        return this.tenantCouponConverDao.findCountByParams(strHql, params);

    }

    @Override
    public TenantCouponConver get(Long id) {
        return this.tenantCouponConverDao.get(id);
    }

    @Override
    public List<TenantCouponConver> getLimitedObjects(String hql, int maxResult) {
        return this.tenantCouponConverDao.getLimitedObjects(hql, maxResult);
    }

    @Override
    public List<TenantCouponConver> getPagingByParams(String hql, Map params, int pageStart, int maxResult) {
        return this.tenantCouponConverDao.getPagingByParams(hql, params, pageStart, maxResult);
    }

    @Override
    public List<TenantCouponConver> getPagingObjects(String hql, int pageStart, int maxResult) {
        return this.tenantCouponConverDao.getPagingObjects(hql, pageStart, maxResult);
    }

    @Override
    public List<TenantCouponConver> list() {
        return this.tenantCouponConverDao.list();
    }

    @Override
    public Serializable save(TenantCouponConver bean) {
        return this.tenantCouponConverDao.save(bean);
    }

    @Override
    public void saveOrUpdate(TenantCouponConver bean) {
        this.tenantCouponConverDao.saveOrUpdate(bean);
    }

    @Override
    public void saveOrUpdateAll(Collection<TenantCouponConver> entities) {
        this.tenantCouponConverDao.saveOrUpdateAll(entities);
    }

    @Override
    public void update(TenantCouponConver bean) {
        this.tenantCouponConverDao.update(bean);
    }

    public ITenantCouponConverDao getTenantCouponConverDao() {
        return tenantCouponConverDao;
    }

    public void setTenantCouponConverDao(ITenantCouponConverDao tenantCouponConverDao) {
        this.tenantCouponConverDao = tenantCouponConverDao;
    }

}
