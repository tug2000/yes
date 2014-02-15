<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
<title>配置</title>
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){	
	//自适应main窗口高度和宽度
	var mainheight = $(window).height()-10;
	$("#system_config_main").height(mainheight);
	var mainwidth =  $(window).width()-25;
	$("#system_config_main").width(mainwidth);
});

function changeWxTab(obj, id){
	var divObjs = $(obj).parent().parent().find("div");
	for(var i=0; i<divObjs.length; i++){
		$(divObjs.get(i)).removeClass("tab_b");
		$(divObjs.get(i)).addClass("tab_a");
   	}

	$(obj).parent().attr("class","tab_b");

}

</script>
</head>

<body class="b2" >
<div class="all2">
  <div class="content">
    <div class="m10">
    <div class="tab">
    <div class="tab_b"><a href="<%=basePath%>tenantConfigManage/tenantConfigManage!basicConfig.action" target="system_config_Frame" onclick="changeWxTab(this)" class="tab_no">系统配置</a></div>
    <div class="tab_a"><a href="<%=basePath%>tenantConfigManage/tenantConfigManage!authConfig.action" target="system_config_Frame" onclick="changeWxTab(this)" class="tab_no">认证配置</a></div>
    </div>
    <div id="config_tab" class="tab_c">
      <iframe id="system_config_main" name="system_config_Frame" frameborder="0" src="<%=basePath%>tenantConfigManage/tenantConfigManage!basicConfig.action"/> 
    </div>
  </div>
</div>
</div>
</body>
</html>
