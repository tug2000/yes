package com.ruijie.mcp.application.coupon.business.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.ruijie.mcp.application.coupon.business.ITenantBusinessesBus;
import com.ruijie.mcp.application.coupon.dao.ITenantBusinessesDao;
import com.ruijie.mcp.application.coupon.model.TenantBusinesses;

public class TenantBusinessesBusImpl implements ITenantBusinessesBus {
    private ITenantBusinessesDao tenantBusinessesDao;

    @Override
    public int countByHql(String hql) {
        return this.tenantBusinessesDao.countByHql(hql);
    }

    @Override
    public void delete(TenantBusinesses bean) {
        this.tenantBusinessesDao.delete(bean);
    }

    @Override
    public void deleteAll(Collection<TenantBusinesses> entities) {
        this.tenantBusinessesDao.deleteAll(entities);
    }

    @Override
    public List<TenantBusinesses> find(String queryString) {
        return this.tenantBusinessesDao.find(queryString);
    }

    @Override
    public List<TenantBusinesses> find(String queryString, Object value) {
        return this.tenantBusinessesDao.find(queryString, value);
    }

    @Override
    public List<TenantBusinesses> find(String queryString, Object[] values) {
        return this.tenantBusinessesDao.find(queryString, values);
    }

    @Override
    public List<TenantBusinesses> findByNamedQuery(String queryName) {
        return this.tenantBusinessesDao.findByNamedQuery(queryName);
    }

    @Override
    public List<TenantBusinesses> findByNamedQuery(String queryName, Object value) {
        return this.tenantBusinessesDao.findByNamedQuery(queryName, value);
    }

    @Override
    public List<TenantBusinesses> findByNamedQuery(String queryName, Object[] values) {
        return this.tenantBusinessesDao.findByNamedQuery(queryName, values);
    }

    @Override
    public int findCountByParams(String strHql, Map params) {
        return this.tenantBusinessesDao.findCountByParams(strHql, params);

    }

    @Override
    public TenantBusinesses get(Long id) {
        return this.tenantBusinessesDao.get(id);
    }

    @Override
    public List<TenantBusinesses> getLimitedObjects(String hql, int maxResult) {
        return this.tenantBusinessesDao.getLimitedObjects(hql, maxResult);
    }

    @Override
    public List<TenantBusinesses> getPagingByParams(String hql, Map params, int pageStart, int maxResult) {
        return this.tenantBusinessesDao.getPagingByParams(hql, params, pageStart, maxResult);
    }

    @Override
    public List<TenantBusinesses> getPagingObjects(String hql, int pageStart, int maxResult) {
        return this.tenantBusinessesDao.getPagingObjects(hql, pageStart, maxResult);
    }

    @Override
    public List<TenantBusinesses> list() {
        return this.tenantBusinessesDao.list();
    }

    @Override
    public Serializable save(TenantBusinesses bean) {
        return this.tenantBusinessesDao.save(bean);
    }

    @Override
    public void saveOrUpdate(TenantBusinesses bean) {
        this.tenantBusinessesDao.saveOrUpdate(bean);
    }

    @Override
    public void saveOrUpdateAll(Collection<TenantBusinesses> entities) {
        this.tenantBusinessesDao.saveOrUpdateAll(entities);
    }

    @Override
    public void update(TenantBusinesses bean) {
        this.tenantBusinessesDao.update(bean);
    }

    public ITenantBusinessesDao getTenantBusinessesDao() {
        return tenantBusinessesDao;
    }

    public void setTenantBusinessesDao(ITenantBusinessesDao tenantBusinessesDao) {
        this.tenantBusinessesDao = tenantBusinessesDao;
    }

    @Override
    public TenantBusinesses getTenantByTenantId(String tenantId) {
        List<TenantBusinesses> list = this.tenantBusinessesDao.find("from TenantBusinesses where tbTenantId=?", tenantId);
        if(null != list && list.size() > 0){
            return list.get(0);
        }
        return null;
    }
}
