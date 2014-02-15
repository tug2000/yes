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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="<%=basePath%>css/page.css" rel="stylesheet"
			type="text/css" />
		<style type="text/css">
.er01 {
	width: 600px;
	margin: auto;
	min-height: 350px;
	padding-top: 150px;
}

.er01a {
	width: 241px;
	float: left;
}

.er01b {
	width: 350px;
	float: right;
	margin-top: 50px;
	font: 14px/1.6 Arial, Helvetica, sans-serif;
}

.er_bnt {
	background: url(<%=basePath%>images/404Bnt.png);
	width: 90px;
	height: 31px;
	font: bold 12px/31px Arial, Helvetica, sans-serif;
	color: #fff;
	border: 0;
}
</style>
<script type="text/javascript">
	function backIndex() {
		window.top.location="<%=basePath%>index.jsp";
	}
</script>
	</head>

	<body>
		<div class="er01">
			<div class="er01a">
				<img src="<%=basePath%>images/500.gif" width="241" height="152" />
			</div>
			<div class="er01b">
				<p>
					不好意思，页面异常，请联系系统管理员或开发人员。
				</p>
				<p>
					<input type="button" value="点此返回" class="er_bnt" onclick="backIndex()" />
				</p>
			</div>
		</div>
	</body>
</html>

</html>
