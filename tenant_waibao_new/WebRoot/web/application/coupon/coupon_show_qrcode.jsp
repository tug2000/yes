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
<link href="<%=basePath%>web/application/coupon/css/gd.css" rel="stylesheet" type="text/css" />
<title>我的二维码</title>
</head>
<body>
<div class="wrapper">
  <div class="ban">
    <div class="home_txt"><a href="javascript:history.go(-1)">返回首页</a></div>
    <div class="logo"></div>
    <div class="ban_txt">
    <li>您有 <strong><s:property value="couponSum" /></strong> 张优惠券</li>
    <li><s:property value="expireSum" /> 张优惠券，即将到期</li>
    </div>
  </div>
  <div class="tit01">我的二维码</div>
  <div class="eym"><img src="<%=basePath%><s:property value="customerBean.tcQrCodeImgUrl" />" width="300" height="300" /></div>
</div>

</body>
</html>