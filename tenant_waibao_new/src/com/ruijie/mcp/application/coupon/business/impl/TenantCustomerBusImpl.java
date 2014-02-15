package com.ruijie.mcp.application.coupon.business.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import com.ruijie.mcp.application.coupon.business.ITenantCustomerBus;
import com.ruijie.mcp.application.coupon.dao.ITenantCustomerDao;
import com.ruijie.mcp.application.coupon.model.TenantCustomer;
import com.ruijie.mcp.weixin.model.WeixinPicText;

public class TenantCustomerBusImpl implements ITenantCustomerBus {
    private ITenantCustomerDao tenantCustomerDao;

    @Override
    public int countByHql(String hql) {
        return this.tenantCustomerDao.countByHql(hql);
    }

    @Override
    public void delete(TenantCustomer bean) {
        this.tenantCustomerDao.delete(bean);
    }

    @Override
    public void deleteAll(Collection<TenantCustomer> entities) {
        this.tenantCustomerDao.deleteAll(entities);
    }

    @Override
    public List<TenantCustomer> find(String queryString) {
        return this.tenantCustomerDao.find(queryString);
    }

    @Override
    public List<TenantCustomer> find(String queryString, Object value) {
        return this.tenantCustomerDao.find(queryString, value);
    }

    @Override
    public List<TenantCustomer> find(String queryString, Object[] values) {
        return this.tenantCustomerDao.find(queryString, values);
    }

    @Override
    public List<TenantCustomer> findByNamedQuery(String queryName) {
        return this.tenantCustomerDao.findByNamedQuery(queryName);
    }

    @Override
    public List<TenantCustomer> findByNamedQuery(String queryName, Object value) {
        return this.tenantCustomerDao.findByNamedQuery(queryName, value);
    }

    @Override
    public List<TenantCustomer> findByNamedQuery(String queryName, Object[] values) {
        return this.tenantCustomerDao.findByNamedQuery(queryName, values);
    }

    @Override
    public int findCountByParams(String strHql, Map params) {
        return this.tenantCustomerDao.findCountByParams(strHql, params);

    }

    @Override
    public TenantCustomer get(Long id) {
        return this.tenantCustomerDao.get(id);
    }

    @Override
    public List<TenantCustomer> getLimitedObjects(String hql, int maxResult) {
        return this.tenantCustomerDao.getLimitedObjects(hql, maxResult);
    }

    @Override
    public List<TenantCustomer> getPagingByParams(String hql, Map params, int pageStart, int maxResult) {
        return this.tenantCustomerDao.getPagingByParams(hql, params, pageStart, maxResult);
    }

    @Override
    public List<TenantCustomer> getPagingObjects(String hql, int pageStart, int maxResult) {
        return this.tenantCustomerDao.getPagingObjects(hql, pageStart, maxResult);
    }

    @Override
    public List<TenantCustomer> list() {
        return this.tenantCustomerDao.list();
    }

    @Override
    public Serializable save(TenantCustomer bean) {
        return this.tenantCustomerDao.save(bean);
    }

    @Override
    public void saveOrUpdate(TenantCustomer bean) {
        this.tenantCustomerDao.saveOrUpdate(bean);
    }

    @Override
    public void saveOrUpdateAll(Collection<TenantCustomer> entities) {
        this.tenantCustomerDao.saveOrUpdateAll(entities);
    }

    @Override
    public void update(TenantCustomer bean) {
        this.tenantCustomerDao.update(bean);
    }

    public ITenantCustomerDao getTenantCustomerDao() {
        return tenantCustomerDao;
    }

    public void setTenantCustomerDao(ITenantCustomerDao tenantCustomerDao) {
        this.tenantCustomerDao = tenantCustomerDao;
    }

    @Override
    public boolean isExistByOpenId(String openId) {
        List<TenantCustomer> list = tenantCustomerDao.find("from TenantCustomer where tcOpenId=? ", openId);
        if(null == list || list.size()==0){
            return false;
        }
        return true;
    }

    @Override
    public TenantCustomer getCustomerByOpenId(String openId) {
        List<TenantCustomer> list = tenantCustomerDao.find("from TenantCustomer where tcOpenId=? ", openId);
        if(null == list || list.size()==0){
            return null;
        }else{
            return list.get(0);
        }
    }
}
