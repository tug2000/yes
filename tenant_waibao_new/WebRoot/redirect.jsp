<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + path + "/"; 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Redirect</title>
<script type="text/javascript"> 
function redirect() 
{
	var wankeurl = getCookie('wankeurl');
	if(null!=wankeurl){
		window.top.location = "<%=basePath%>" + wankeurl; 
	}else{
	    window.top.location = "<%=basePath%>admin_login.jsp"; 		
	}
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
<body onload="redirect();"> 
</body> 
</html>