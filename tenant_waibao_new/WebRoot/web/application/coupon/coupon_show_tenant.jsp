<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<%  
String path = request.getContextPath();  
String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + path + "/"; 
        
%>

<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width"/>
<title>E点券</title>
<link href="<%=basePath%>web/application/coupon/css/gd.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="wrapper">
  <div class="ban">
    <div class="logo"></div>
    <div class="ban_txt">
    <li>您有 <strong><s:property value="couponSum" /></strong> 张点券卡</li>
    <li><s:property value="expireSum" /> 张点券卡，即将到期</li>
    <li><a href="<%=basePath%>weixinPublic/weixinCoupon!showQRCode.action?tccCuId=<s:property value="tccCuId" />" >查看我的二维码 >></a></li>
    </div>
  </div>
  
  <s:if test="busCouponBean!=null&&busCouponBean!=null">
	  <div class="tit01">消费过的商家</div>
	  	<a href="<%=basePath%>weixinPublic/weixinCoupon!showCoupon.action?tccCoId=<s:property value="busCouponBean.tccCoId" />&tbId=<s:property value="busCouponBean.tbId"/>">
		  <div class="list_box">
		    <div class="list_pic"><img src="<%=basePath%><s:property value="busCouponBean.tbLogoUrl" />"/></div>
		    <div class="list_txt">
		    <li><strong><s:property value="busCouponBean.tbBusName" /></strong></li>
		    <li>您有 <s:property value="busCouponBean.detailCount" /> 张优惠券</li>
		    <li><s:property value="busExpireSum" /> 张优惠券，即将到期</li>
		    </div>  
		  </div>
		 </a>
		 
	 	<a href="<%=basePath%>weixinPublic/weixinCoupon!showCoupon.action?tccCoId=<s:property value="busCouponBean1.tccCoId" />&tbId=<s:property value="busCouponBean.tbId"/>">
		  <div class="list_box">
		    <div class="list_pic"><img src="<%=basePath%><s:property value="busCouponBean1.tbLogoUrl" />"/></div>
		    <div class="list_txt">
		    <li><strong><s:property value="busCouponBean1.tbBusName" /></strong></li>
		    <li>您有 <s:property value="busCouponBean1.detailCount" /> 张优惠券</li>
		    <li><s:property value="busExpireSum1" /> 张优惠券，即将到期</li>
		    </div>  
		  </div>
		 </a>
  	</s:if>
  	<s:if test="tenantbusbList!=null">
	  <div class="tit01">猜你喜欢</div>
	    	<s:iterator value="tenantbusbList" var="item" status="stat">
				  <div class="list_box">
				    <div class="list_pic"><img src="<%=basePath%><s:property value="tbLogoUrl" />"/></div>
				    <div class="list_txt">
				    <li><strong><s:property value="tbBusName" /></strong></li>
				    <s:iterator value="tenantCouponList"  status="stat" >
				    	<li>优惠<s:property value="#stat.Index+1" />：<s:property value="tcCouponName" /><s:property value="tcCouponActiviyDes" /></li>
				    </s:iterator>
				    </div>  
				  </div>
	  		</s:iterator>
		</div>
	</s:if>
</body>
</html>