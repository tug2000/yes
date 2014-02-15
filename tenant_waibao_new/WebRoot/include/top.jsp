<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="com.ruijie.mcp.security.*" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			
	String userName = SecurityAppUserHolder.getCurrentUser().getUsername();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
	function logout() {
		if(confirm("确定要退出吗？")){
			location.href = "<%=basePath%>j_spring_security_logout";
		}
	}
	
	function about() {
		window.alert('RG-MCP_V1.01_Build20140116\n福建星网锐捷网络有限公司\n版本所有(C) 2013');
	}
</script>
</head>

<body class="b2">
<div class="top">
  <div class="logo">
  <%
	  String str = "<img  src=\"";
	  str +=basePath;
      if(userName.equals("SHWK")){
          str +="images/lg_wanke_02.gif\" />";
          out.println(str);
      }else{
          str +="images/yx1_02.gif\" />";
          out.println(str);          
      }
  %>
  </div>
  <div class="function">
  <li><a href="<%=basePath%>j_spring_security_logout"><img src="<%=basePath%>images/06-09.gif" width="16" height="16" /> 注销</a></li>
    <li><a href="<%=basePath%>adminManage/adminManage!toModify.action" target="main_Frame"><img src="<%=basePath%>images/06-10.gif" width="16" height="16" /> 修改密码</a></li>
    <li><a href="#" onClick="about();"><img src="<%=basePath%>images/06-11.gif" width="16" height="16" /> 关于</a></li>
  </div>
</div>
</body>
</html>
