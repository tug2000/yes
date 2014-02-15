<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
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
<title>锐捷营销云平台</title>
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=basePath%>js/checkform.js"></script>
<script type="text/javascript">

	function checkForm(){
		if(!Validator.Validate(document.getElementById('searchFrm'),3))return false;
	}
	
	function init(){
		delCookie('wankeurl');
		var saAdminId = document.getElementById('saAdminId');
		saAdminId.focus();
	}

	///删除cookie
	function delCookie(name)
	{
		var exp = new Date();
		exp.setTime(exp.getTime() - 100);
		var cval=getCookie(name);
		if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString()+ ";path=/;";
	}

	//读取cookie
	function getCookie(name)
	{
		var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
		if(arr != null)
		return unescape(arr[2]);
		return null;
	}
	 
</script>
</head>

<body class="b2" onload="init()">
<div class="top2">
  <div class="logo"><img src="images/yx1_01.gif" width="331" height="64" /></div>
  <div class="function">
    <li></li>
  </div>
</div>
<form name="register" action="<%=basePath%>j_spring_security_check" method="post">
	<div class="all2 l_bg">
	  <div class="ban"><img src="images/lbg6.png" width="362" height="48" /></div>
	<div class="l_box">
	    <div class="l_box2">
	      <div class="l_tit">租户管理登录</div>
	      <div class="l_ip1"><input type="text" id="saAdminId" name="j_username" class="l_input1" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}"/></div>
	      <div class="l_ip2"><input type="password" id="saAdminPassword" name="j_password" class="l_input"/></div>
	      <div class="l_ip3"><input type="submit" name="button" id="button" value="登录" class="l_bnt"/></div>
	      <s:if test="#session.SPRING_SECURITY_LAST_EXCEPTION.message !=''">
	         <div id="errorDiv" style="margin-top: 15px;"><img src="<%=basePath%>images/ico_prompt.gif" align="absmiddle" />&nbsp;<s:property value="#session.SPRING_SECURITY_LAST_EXCEPTION.message" /></div>
	      </s:if>
	    </div>
	  </div>
	</div>
</form>
<div class="footer">版权所有 ©2000-2013  锐捷网络有限公司</div>
</body>
</html>
