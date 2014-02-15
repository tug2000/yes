<%@ page language="java" pageEncoding="utf-8"%>
<%@ page language="java" import="com.ruijie.mcp.security.*" %>
<%@ page language="java" import="com.ruijie.mcp.util.DateOperate" %>
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
<link href="../css/page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
	function logout() {
		if(confirm("确定要退出吗？")){
			location.href = "<%=basePath%>j_spring_security_logout";
		}
	}
	
	function about() {
		window.alert('RG-MCP_V1.0_Build20140109\n福建星网锐捷网络有限公司\n版本所有(C) 2013');
	}
</script>
</head>

<body class="content_bj2">
<div class="wel01">
  <div class="wel03"><%=userName %> 您好，IP：<%=ip%> 登录时间： <%=DateOperate.getNowDateTime() %></div>
  <div class="wel02">
    <li><a href="<%=basePath%>j_spring_security_logout"><img src="<%=basePath%>images/06-09.gif" width="16" height="16" /> 注销</a></li>
    <li><a href="<%=basePath%>adminManage/adminManage!toModify.action"
	target="middle_web"><img src="<%=basePath%>images/06-10.gif" width="16" height="16" /> 修改密码</a></li>
    <li><a href="#" onClick="about();"><img src="<%=basePath%>images/06-11.gif" width="16" height="16" /> 关于</a></li>
  </div>
</div>
</body>
</html>
