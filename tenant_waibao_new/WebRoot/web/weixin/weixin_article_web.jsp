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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=yes" />
	<title><s:property value="weixinPicText.title" /></title>
	<style type="text/css">	
		body {
			margin: 0;
			padding: 0;
			font: 13px Helvetica;
			-webkit-text-size-adjust: none;
			min-height: 460px;
			background-repeat: repeat;
			background-position: 0 0;
		}
		a.h2, a.sh2, .page h2 {
		font-family: 'Helvetica Neue';
		}
		
		a.sh2 {
			letter-spacing: -1px;
			margin: 0;
			padding: 0 0 2px;
			color: #222;
			display: block;
			line-height: 20px;
			font-size: 19px;
			font-weight: bold;
			text-align: left;
		}
				
		a.h2{
			text-overflow: ellipsis;
			white-space: nowrap;
			overflow: hidden;
		}
		img{
			max-width: 100%;
			height: auto;
		}
		.content {
			margin-top: 15px;
			position: relative;
		}
		.post {
			background-color: #fff;
			padding: 10px;
			margin-bottom: 12px;
			margin-right: 10px;
			margin-left: 10px;
			border: 1px solid #b1b1b1;
			border-radius: 8px;
			-webkit-box-shadow: rgba(255,255,255,.8) 0px 1px 0px;
			box-shadow: rgba(255,255,255,.8) 0px 1px 0px;
		}
		.low-contrast-linen-wptouch-bg {
			background-image: url(../images/low_contrast_linen.png);
		}
		
		
	</style>

</head>
<body class="low-contrast-linen-wptouch-bg" >
	<div class="content">
	  <div class="post">
		<a class="sh2" style="padding-bottom: 10px"><s:property value="weixinPicText.title" /></a>
		<div style="color:#C0C0C0;font-size: 12px;">   <s:property value="weixinPicText.formatTime" />   &nbsp;&nbsp;    <br /></div>
	  </div>
		<div class="clearer"></div>			
        	<div class="post">
         	<div >
            	<!-- 内容主体开始  -->		           	
				<s:property value="weixinPicText.linkArticle"  escape="false"/>          	          	
            	<!-- 内容主体结束 -->			
			</div>  
    </div>
     
	</div>
</body>
</html>