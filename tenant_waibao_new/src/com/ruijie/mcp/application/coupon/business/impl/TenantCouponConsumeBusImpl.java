package com.ruijie.mcp.application.coupon.business.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import com.ruijie.mcp.application.coupon.business.ITenantCouponConsumeBus;
import com.ruijie.mcp.application.coupon.dao.ITenantCouponConsumeDao;
import com.ruijie.mcp.application.coupon.model.TenantCouponConsume;

public class TenantCouponConsumeBusImpl implements ITenantCouponConsumeBus {

    private ITenantCouponConsumeDao tenantCouponConsumeDao;

    @Override
    public int countByHql(String hql) {
        return this.tenantCouponConsumeDao.countByHql(hql);
    }

    @Override
    public void delete(TenantCouponConsume bean) {
        this.tenantCouponConsumeDao.delete(bean);
    }

    @Override
    public void deleteAll(Collection<TenantCouponConsume> entities) {
        this.tenantCouponConsumeDao.deleteAll(entities);
    }

    @Override
    public List<TenantCouponConsume> find(String queryString) {
        return this.tenantCouponConsumeDao.find(queryString);
    }

    @Override
    public List<TenantCouponConsume> find(String queryString, Object value) {
        return this.tenantCouponConsumeDao.find(queryString, value);
    }

    @Override
    public List<TenantCouponConsume> find(String queryString, Object[] values) {
        return this.tenantCouponConsumeDao.find(queryString, values);
    }

    @Override
    public List<TenantCouponConsume> findByNamedQuery(String queryName) {
        return this.tenantCouponConsumeDao.findByNamedQuery(queryName);
    }

    @Override
    public List<TenantCouponConsume> findByNamedQuery(String queryName, Object value) {
        return this.tenantCouponConsumeDao.findByNamedQuery(queryName, value);
    }

    @Override
    public List<TenantCouponConsume> findByNamedQuery(String queryName, Object[] values) {
        return this.tenantCouponConsumeDao.findByNamedQuery(queryName, values);
    }

    @Override
    public int findCountByParams(String strHql, Map params) {
        return this.tenantCouponConsumeDao.findCountByParams(strHql, params);

    }

    @Override
    public TenantCouponConsume get(Long id) {
        return this.tenantCouponConsumeDao.get(id);
    }

    @Override
    public List<TenantCouponConsume> getLimitedObjects(String hql, int maxResult) {
        return this.tenantCouponConsumeDao.getLimitedObjects(hql, maxResult);
    }

    @Override
    public List<TenantCouponConsume> getPagingByParams(String hql, Map params, int pageStart, int maxResult) {
        return this.tenantCouponConsumeDao.getPagingByParams(hql, params, pageStart, maxResult);
    }

    @Override
    public List<TenantCouponConsume> getPagingObjects(String hql, int pageStart, int maxResult) {
        return this.tenantCouponConsumeDao.getPagingObjects(hql, pageStart, maxResult);
    }

    @Override
    public List<TenantCouponConsume> list() {
        return this.tenantCouponConsumeDao.list();
    }

    @Override
    public Serializable save(TenantCouponConsume bean) {
        return this.tenantCouponConsumeDao.save(bean);
    }

    @Override
    public void saveOrUpdate(TenantCouponConsume bean) {
        this.tenantCouponConsumeDao.saveOrUpdate(bean);
    }

    @Override
    public void saveOrUpdateAll(Collection<TenantCouponConsume> entities) {
        this.tenantCouponConsumeDao.saveOrUpdateAll(entities);
    }

    @Override
    public void update(TenantCouponConsume bean) {
        this.tenantCouponConsumeDao.update(bean);
    }

    public ITenantCouponConsumeDao getTenantCouponConsumeDao() {
        return tenantCouponConsumeDao;
    }

    public void setTenantCouponConsumeDao(ITenantCouponConsumeDao tenantCouponConsumeDao) {
        this.tenantCouponConsumeDao = tenantCouponConsumeDao;
    }

}
