package com.ruijie.mcp.application.coupon.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.ruijie.mcp.action.DataPageSupport;
import com.ruijie.mcp.application.coupon.business.ITenantWaiterBus;
import com.ruijie.mcp.application.coupon.model.TenantWaiter;
import com.ruijie.mcp.security.SecurityAppUserHolder;
import com.ruijie.mcp.util.CommonPam;
import com.ruijie.mcp.util.StringOperate;

public class TenantWaiterAction extends DataPageSupport {

    /**	
     * Member Description
     */

    private static final long serialVersionUID = -2868514856051243776L;

    private ITenantWaiterBus tenantWaiterBus;

    private String waiterName;

    /**
     * 提示消息
     */
    private String message;

    /**
     * 店员名字
     */
    private String twWaiterName;

    /**
     * 	店员APP登录名
     */
    private String twAppUserName;

    /**
     *  店员APP登录密码
     */
    private String twAppPwd;

    /**
     * 密码二次确认
     */
    private String confirmPassword;

    /**
     * 店员ID
     */
    private String twId;

    /**
     * 店员
     */
    private TenantWaiter bean;

    /**
     * 新密码
     */
    private String newPassword;

    public void setTenantWaiterBus(ITenantWaiterBus tenantWaiterBus) {
        this.tenantWaiterBus = tenantWaiterBus;
    }

    public ITenantWaiterBus getTenantWaiterBus() {
        return tenantWaiterBus;
    }

    @Override
    public List pageQueryList() {
        return null;
    }

    /**
     * 跳转新增页面	
     * <p>Description:              </p>
     * <p>Create Time: 2014-1-26   </p>
     * @author Administrator
     * @return
     */
    public String toAdd() {
        return "add";
    }

    /**
     * 根据条件查询
     * 
     * @return
     */
    public String showList() {
        Map<Object, Object> paras = new HashMap<Object, Object>();
        this.setPageNumber(CommonPam.PAGE_SIZE_NOR);// 单页展现的记录数
        this.setPageLevel(CommonPam.PAGE_SIZE_NOR);// 分几行显示

        StringBuffer sbCondition = new StringBuffer();
        StringBuffer sql = new StringBuffer();

        String tenantId = SecurityAppUserHolder.getCurrentUser().getPartyId();

        sql.append("from TenantWaiter s where 1=1 ");
        sql.append(" and s.twTenantId=:twTenantId ");
        paras.put("twTenantId", tenantId);

        // 过滤店员名字
        if (!StringOperate.isEmpty(waiterName)) {
            sbCondition.append(" and s.twWaiterName like :twWaiterName ");
            paras.put("twWaiterName", "%" + waiterName + "%");
        }

        sbCondition.append(" order by s.createTime desc ");

        int count = this.tenantWaiterBus.findCountByParams(
                "select count(*) " + sql.toString() + sbCondition.toString(), paras);
        this.setAllPageSize(count);// 设置总记录数

        int currPage = this.getCurrPage();
        int pageSize = this.getPageSize();
        int start = pageSize * currPage;
        sbCondition.append(" limit ").append(start).append(", ").append(pageSize);
        List<TenantWaiter> list = this.tenantWaiterBus.getPagingByParams(sql.toString() + sbCondition.toString(),
                paras, start, pageSize);

        setPages(list);
        return "list";
    }

    /**
     * 新增店员	
     * <p>Description:              </p>
     * <p>Create Time: 2014-1-26   </p>
     * @author Administrator
     * @return
     */
    public String add() {
        if (StringOperate.isEmpty(twWaiterName)) {
            message = "店员名称不允许为空";
            return "add";
        }

        if (StringOperate.isEmpty(twAppUserName)) {
            message = "店员app11名称不允许为空";
            return "add";
        }

        if (StringOperate.isEmpty(twAppPwd)) {
            message = "密码不允许为空";
            return "add";
        }

        if (StringOperate.isEmpty(confirmPassword)) {
            message = "确认密码不允许为空";
            return "add";
        }
        if (!twAppPwd.equals(confirmPassword)) {
            message = "两次密码输入不一致";
            return "add";
        }
        try {
            List<TenantWaiter> list = this.tenantWaiterBus.find("from TenantWaiter t where t.twWaiterName= ? ",
                    new Object[] { twWaiterName });
            if (list.size() > 0) {
                message = "店员名字已经存在!";
                return "add";
            }
        } catch (Exception e) {
            message = "添加店员失败，请联系开发人员";
            return showList();
        }
        try {
            List<TenantWaiter> list = this.tenantWaiterBus.find("from TenantWaiter t where t.twAppUserName= ? ",
                    new Object[] { twAppUserName });
            if (list.size() > 0) {
                message = "店员名字已经存在!";
                return "add";
            }
        } catch (Exception e) {
            message = "添加店员失败，请联系开发人员";
            return showList();
        }
        TenantWaiter tenantWaiter = new TenantWaiter();
        tenantWaiter.setTwWaiterName(twWaiterName);
        tenantWaiter.setTwAppUserName(twAppUserName);
        tenantWaiter.setTwAppPwd(twAppPwd);
        UUID uuid = UUID.randomUUID();
        tenantWaiter.setTwAccessToken(uuid.toString());
        tenantWaiter.setCreateTime(new Date());
        tenantWaiter.setTwTenantId(SecurityAppUserHolder.getCurrentUser().getPartyId());
        try {
            this.tenantWaiterBus.save(tenantWaiter);
        } catch (Exception e) {
            message = "添加租户管理员失败，请联系开发人员";
            return "list";
        }
        message = "保存成功！";
        return showList();
    }

    public String doDelete() {
        try {
            bean = this.tenantWaiterBus.get(Long.parseLong(twId));
            if (bean == null) {
                message = "该店员不存在";
                return "list";
            }
        } catch (Exception e) {
            message = "删除店员失败，请联系开发人员";
            return showList();
        }
        try {
            this.tenantWaiterBus.delete(bean);
            message = "删除成功.";
        } catch (Exception e) {
            message = "删除店员失败，请联系开发人员";
            return showList();
        }
        return showList();
    }

    /**
     * 跳转修改页面	
     * <p>Description:              </p>
     * <p>Create Time: 2014-1-26   </p>
     * @author Administrator
     * @return
     */
    public String toModify() {
        if (StringOperate.isEmpty(twId)) {
            message = "店员唯一标识不允许为空";
            return showList();
        }
        try {
            bean = this.tenantWaiterBus.get(Long.parseLong(twId));
            if (bean == null) {
                message = "该用户不存在";
                return showList();
            }
        } catch (Exception e) {
            message = "修改店员失败，请联系开发人员";
            return showList();
        }

        return "update";
    }

    /**
     *  修改店员
     */
    public String modify() {
        if (StringOperate.isEmpty(twId)) {
            message = "店员唯一标识不允许为空";
            return "update";
        }
        if (StringOperate.isEmpty(twWaiterName)) {
            message = "店员名称不允许为空";
            return "add";
        }

        if (StringOperate.isEmpty(twAppUserName)) {
            message = "店员app名称不允许为空";
            return "add";
        }

        if (StringOperate.isEmpty(newPassword)) {
            message = "新密码名称不允许为空";
            return "add";
        }

        if (StringOperate.isEmpty(confirmPassword)) {
            message = "确认密码不允许为空";
            return "add";
        }
        if (!newPassword.equals(confirmPassword)) {
            message = "两次密码输入不一致";
            return "add";
        }
        try {
            bean = this.tenantWaiterBus.get(Long.parseLong(twId));
            if (bean == null) {
                message = "该店员不存在";
                return showList();
            }
        } catch (Exception e) {
            message = "修改店员失败，请联系开发人员";
            return showList();
        }

        bean.setTwWaiterName(twWaiterName);
        bean.setTwAppUserName(twAppUserName);
        bean.setTwAppPwd(newPassword);
        try {
            this.tenantWaiterBus.update(bean);
            message = "修改成功.";
        } catch (Exception e) {
            message = "修改店员失败，请联系开发人员";
            return showList();
        }
        return showList();
    }

    public void setWaiterName(String waiterName) {
        this.waiterName = waiterName;
    }

    public String getWaiterName() {
        return waiterName;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public String getTwWaiterName() {
        return twWaiterName;
    }

    public void setTwWaiterName(String twWaiterName) {
        this.twWaiterName = twWaiterName;
    }

    public String getTwAppUserName() {
        return twAppUserName;
    }

    public void setTwAppUserName(String twAppUserName) {
        this.twAppUserName = twAppUserName;
    }

    public String getTwAppPwd() {
        return twAppPwd;
    }

    public void setTwAppPwd(String twAppPwd) {
        this.twAppPwd = twAppPwd;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getTwId() {
        return twId;
    }

    public void setTwId(String twId) {
        this.twId = twId;
    }

    public TenantWaiter getBean() {
        return bean;
    }

    public void setBean(TenantWaiter bean) {
        this.bean = bean;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

}
