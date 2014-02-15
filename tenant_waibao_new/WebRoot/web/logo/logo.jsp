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
<title>logo图片管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/gd.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>css/page.css" rel="stylesheet"
			type="text/css" />
<link href="<%=basePath%>web/template/css/gd.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.txt01 {
   overflow:hidden; zoom:1;
 }
.
</style>
	
</head>

<body class="content_bj">
<form id="adFrm" name="adFrm" action="<%=basePath%>logo/logoAction!upload.action" enctype="multipart/form-data" method="post">

	<div class="mb01">	
		<div class="mb01_r">
			<div class="tith3">
				修改logo图片
			</div>
			<div class="txt01">
				<p>
					请选择你要上传的logo图片
				</p>
				
				<p>
					<input type="file" name="upload" size="20"
						onchange="javascript:doUpload(this.value);"
						class="text opacity">
					<input  name="file_0" id="file_0" value="" class="add_input" />
					
					<input type="button" value="上传图片" class="btn1">
				
					<input  class="btn1" type="button" value="还原logo" onClick="reset1();">
					
				</p>		
				
				<p>
				 <font color="red">建议图片宽 1200像素、高59像素，大小不能超过500KB</font>
				</p>		
			</div>
		</div>
		
	</div>

</form>
<script type="text/javascript"
			src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
			src="<%=basePath%>js/jquery.form_latest.js"></script>
<script type="text/javascript"
			src="<%=basePath%>js/util.js"></script>
<script type="text/javascript">


 $(function() {
	 <s:if test="message != null && !message.startsWith('上传失败')">
		//alert('<s:property value="message"/>');
		$(window.top.document).find("#topFrame").attr("src","<%=basePath%>include/top.jsp");
	 </s:if>
	 
	 <s:if test="message != null && message.startsWith('上传失败')">
		alert('<s:property value="message"/>');
	 </s:if>
 });
 
 function doUpload(value) {
	  
	   if(value == null || value == '') {
		   return;
	   }
	   if(!isImage(value)) {
		   alert('不支持上传该图片类型!');
		   return;
	   }
	  $('#file_0').val(value);
	  $('#adFrm').submit();
 }
 
 function reset1() {
	if(confirm("确认要还原回系统默认的logo吗？")) {
	  $('#adFrm').attr("action","<%=basePath%>logo/logoAction!reset.action");
	  $('#adFrm').submit();
	}
}
 
</script>
</body>
</html>
