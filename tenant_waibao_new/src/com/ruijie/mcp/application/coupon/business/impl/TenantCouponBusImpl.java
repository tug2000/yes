package com.ruijie.mcp.application.coupon.business.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.business.ITenantCouponBus;
import com.ruijie.mcp.application.coupon.dao.ITenantCouponDao;
import com.ruijie.mcp.application.coupon.model.TenantBusinesses;
import com.ruijie.mcp.application.coupon.model.TenantCoupon;

public class TenantCouponBusImpl implements ITenantCouponBus {
    private ITenantCouponDao tenantCouponDao;

    @Override
    public int countByHql(String hql) {
        return this.tenantCouponDao.countByHql(hql);
    }

    @Override
    public void delete(TenantCoupon bean) {
        this.tenantCouponDao.delete(bean);
    }

    @Override
    public void deleteAll(Collection<TenantCoupon> entities) {
        this.tenantCouponDao.deleteAll(entities);
    }

    @Override
    public List<TenantCoupon> find(String queryString) {
        return this.tenantCouponDao.find(queryString);
    }

    @Override
    public List<TenantCoupon> find(String queryString, Object value) {
        return this.tenantCouponDao.find(queryString, value);
    }

    @Override
    public List<TenantCoupon> find(String queryString, Object[] values) {
        return this.tenantCouponDao.find(queryString, values);
    }

    @Override
    public List<TenantCoupon> findByNamedQuery(String queryName) {
        return this.tenantCouponDao.findByNamedQuery(queryName);
    }

    @Override
    public List<TenantCoupon> findByNamedQuery(String queryName, Object value) {
        return this.tenantCouponDao.findByNamedQuery(queryName, value);
    }

    @Override
    public List<TenantCoupon> findByNamedQuery(String queryName, Object[] values) {
        return this.tenantCouponDao.findByNamedQuery(queryName, values);
    }

    @Override
    public int findCountByParams(String strHql, Map params) {
        return this.tenantCouponDao.findCountByParams(strHql, params);

    }

    @Override
    public TenantCoupon get(Long id) {
        return this.tenantCouponDao.get(id);
    }

    @Override
    public List<TenantCoupon> getLimitedObjects(String hql, int maxResult) {
        return this.tenantCouponDao.getLimitedObjects(hql, maxResult);
    }

    @Override
    public List<TenantCoupon> getPagingByParams(String hql, Map params, int pageStart, int maxResult) {
        return this.tenantCouponDao.getPagingByParams(hql, params, pageStart, maxResult);
    }

    @Override
    public List<TenantCoupon> getPagingObjects(String hql, int pageStart, int maxResult) {
        return this.tenantCouponDao.getPagingObjects(hql, pageStart, maxResult);
    }

    @Override
    public List<TenantCoupon> list() {
        return this.tenantCouponDao.list();
    }

    @Override
    public Serializable save(TenantCoupon bean) {
        return this.tenantCouponDao.save(bean);
    }

    @Override
    public void saveOrUpdate(TenantCoupon bean) {
        this.tenantCouponDao.saveOrUpdate(bean);
    }

    @Override
    public void saveOrUpdateAll(Collection<TenantCoupon> entities) {
        this.tenantCouponDao.saveOrUpdateAll(entities);
    }

    @Override
    public void update(TenantCoupon bean) {
        this.tenantCouponDao.update(bean);
    }

    public ITenantCouponDao getTenantCouponDao() {
        return tenantCouponDao;
    }

    public void setTenantCouponDao(ITenantCouponDao tenantCouponDao) {
        this.tenantCouponDao = tenantCouponDao;
    }

    @Override
    public TenantCoupon getByCouponName(String couponName, String tenantId) {
        List<TenantCoupon> list = this.tenantCouponDao.find("from TenantCoupon where tcCouponTenantId=? and tcCouponName=? ", new String[]{tenantId, couponName});
        if(null != list && list.size() > 0){
            return list.get(0);
        }
        return null;
    }

}
