<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + path + "/"; 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>锐捷营销云平台</title>
</head>

<frameset name="topA" rows="65,*" cols="*" frameborder="0" border="0">
  <frame src="include/top.jsp" name="topFrame" id="topFrame" scrolling="no" noresize="noresize" />
  <frame src="include/menu.jsp" name="lef_menu" id="lef_menu" noresize="noresize" scrolling="no" />
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>
