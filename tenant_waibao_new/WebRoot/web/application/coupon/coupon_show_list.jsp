<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>web/application/css/gd.css" rel="stylesheet" type="text/css" />
<title>我的E点券</title>
<script type="text/javascript">
function init(){
	<s:if test="message != null">
		alert('<s:property value="message"/>');
	</s:if>
}
</script>
</head>
<body onload="init()">
<div class="wrapper">
  <div class="ban2">
    <div class="home_txt"><a href="javascript:history.go(-1)">返回首页</a></div>
    <div class="logo"><img src="<%=basePath%><s:property value="bean.tbLogoUrl" />" width="82" height="64" /></div>
    <div class="ban_txt2">
    <li><strong><s:property value="bean.tbBusName" /></strong></li>
    <li>电话：<s:property value="bean.tbContactNumber" /></li>
    <li>地址：<s:property value="bean.tbAddress" /></li>
    </div>
  </div>
  <s:if test="couponList!=null">
  <div class="tit01">我的E点券</div>
   <s:iterator value="couponList" var="item"  status="stat">
	  <div class="list_box">
	    <div class="list_pic"><img src="<%=basePath%><s:property value="%{#item[0].tcCouponIcoUrl}" />"/></div>
	    <div class="list_txt2">
	    <li><strong><s:property value="%{#item[0].tcCouponName}" /></strong></li>
	    <li>您已累积 <span><s:property value="%{#item[1].tccCouponNum}" /></span> 张免费券和 <span><s:property value="%{#item[1].tccWaitConverNum}" /></span> 积分</li>
	    <li>活动说明：<s:property value="%{#item[0].tcCouponActiviyDes}" /></li>
	    <li>有效期至：<s:date name="%{#item[0].tcValIdEndDateTime}"  format="yyyy-MM-dd"/></li>
	    </div>  
	  </div>
  </s:iterator>
  </s:if>
  <s:if test="otherList!=null">
  <div class="tit01">其它优惠</div>
     <s:iterator value="otherList" var="item" status="stat">
	  <div class="list_box">
	    <div class="list_pic"><img src="<%=basePath%><s:property value="%{#item[0].tcCouponIcoUrl}" />"/></div>
	    <div class="list_txt2">
	      <li><strong><s:property value="%{#item[0].tcCouponName}" /></strong></li>
	      <li>活动说明：<s:property value="%{#item[0].tcCouponActiviyDes}" /></li>
	      <li>有效期至：<s:date name="%{#item[0].tcValIdEndDateTime}"  format="yyyy-MM-dd"/></li>
	    </div>
	  </div>
	 </s:iterator>
	 </s:if>
</div>
</body>
</html>