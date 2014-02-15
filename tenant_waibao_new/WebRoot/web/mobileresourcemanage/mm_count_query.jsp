<%@ page language="java" pageEncoding="utf-8"%>
<%@ page language="java" import="com.ruijie.mcp.security.*" %>
<%@ page language="java" import="com.ruijie.mcp.util.DateOperate" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + path + "/"; 
String userName = SecurityAppUserHolder.getCurrentUser().getUsername();

String ip = request.getHeader("x-forwarded-for");  
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("Proxy-Client-IP");  
}  
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("WL-Proxy-Client-IP");  
}  
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getRemoteAddr();  
}  

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

function exportPhoneNumber(){
	document.location="<%=basePath%>mobileResourceManage/mobileResourceManage!exportOnlineDetail.action";
}

</script>
</head>

<body class="b2">
<div class="all" style="width:720px;">
  <div class="wel">
  <li><span>
	<s:if test="nowHour<12">
		上午好！
	 </s:if>
	 <s:elseif test="nowHour>=12 && nowHour<18">
		下午好！
	 </s:elseif>
	 <s:elseif test="nowHour>=18">
		晚上好！
	 </s:elseif>
 <%=userName %> </span></li>
  <li>IP：<%=ip%>    登录时间： <%=DateOperate.getNowDateTime() %></li>
  </div>
  <div><img src="<%=basePath%>images/home1_0.gif" width="718" height="3" /></div>
  <table width="100%" border="0" cellspacing="7" cellpadding="0">
  <tr>
      <td class="home_nav8"><a onclick="exportPhoneNumber()"><div style="padding:100px 0 0 20px;">
      <div class="nav_tit1"><s:property value="mobileRegisterCount"/></div>
      <div class="nav_tit2">
      <p>已注册手机号码总数</p>
      <p>导出上网记录</p></div></div>
      </a></td>
      <td class="home_nav9"><a><div style="padding:100px 0 0 20px;">
        <div class="nav_tit1"><s:property value="onlineUserCount"/></div>
        <div class="nav_tit2">在线用户数</div></div>
      </a></td>
      <td class="home_nav10"><a><div style="padding:100px 0 0 20px;">
        <div class="nav_tit1"><s:property value="weixinRegisterCount"/></div>
        <div class="nav_tit2">关注微信用户数</div>
        </div>
      </a></td>
    </tr>
  <tr>
    <td colspan="3" class="home_nav11"><a>
        <div style="padding:10px 0 0 110px;">
          <div class="nav_tit1"><s:property value="totalRegisterCount"/></div>
          <div class="nav_tit2">注册用户总数</div>
        </div>
      </a>
    </tr>
  </table>

</div>
</body>
</html>
