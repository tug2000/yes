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
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript">

//当前选中的菜单项
var cur_menu="menu1";

$(document).ready(function(){	

	//自适应main窗口高度和宽度
	var mainheight = $(window).height()-10;
	$("#main").height(mainheight);
	var mainwidth = $(window).width()-65;
	$("#main").width(mainwidth);

	//鼠标移动时菜单显示或隐藏
	$('.nav li').hover(
	function(){
		var openMenu= $(this).find('.nav01').first();
		$(openMenu).show();
		
		var imgObj= $(this).find('img').first();
		if($(this).attr("id")!= cur_menu){
			$(imgObj).attr("src",$(imgObj).attr("light"));
		}
		
	},
	function(){
		var openMenu= $(this).find('.nav01').first();
		$(openMenu).hide();
		var imgObj= $(this).find('img').first();
		if($(this).attr("id")!= cur_menu){
			$(imgObj).attr("src",$(imgObj).attr("dark"));
		}
	
	});

	//绑定菜单项点击事件
	$('.nav li').click(
			function(){
				var li;
				var imgObj;
				var liObjs = $('.nav li');
				for(var i=0; i<liObjs.length; i++){
					li = $(liObjs.get(i));
					if($(li).attr("id")){
						imgObj= $(li).find('img').first();
						$(imgObj).attr("src",$(imgObj).attr("dark"));
					}
				}

				imgObj= $(this).find('img').first();
				$(imgObj).attr("src",$(imgObj).attr("light"));
				cur_menu = $(this).attr("id");
				
			});
		
});


</script>
</head>

<body class="b2" >
  <div class="nav">
  <li id="menu1" style="margin-top: 10px;"><a href="<%=basePath%>mobileResourceManage/mobileResourceManage!onlineUserCount.action" target="main_Frame"><img src="<%=basePath%>images/yx4_02.gif" dark="<%=basePath%>images/yx3_02.gif" light="<%=basePath%>images/yx4_02.gif" width="56" height="64" /></a></li>
  <!-- <li id="menu2"><a href="<%=basePath%>templateList/templateList!showList.action" target="main_Frame"><img src="<%=basePath%>images/yx3_11.gif" dark="<%=basePath%>images/yx3_11.gif" light="<%=basePath%>images/yx4_11.gif"  width="56" height="64"  /></a></li> -->
  <!-- <li id="menu3"><a href="#" target="main_Frame"><img src="<%=basePath%>images/yx3_29.gif" dark="<%=basePath%>images/yx3_29.gif" light="<%=basePath%>images/yx4_29.gif"  width="56" height="64"  /></a></li> -->	
   <li id="menu8" ><a href="<%=basePath%>tenantWaiter/tenantWaiter!showList.action" target="main_Frame"><img src="<%=basePath%>images/yx3_15.gif" dark="<%=basePath%>images/yx3_15.gif" light="<%=basePath%>images/yx4_15.gif"  width="56" height="64"  /></a>
  <li id="menu4" ><a href="<%=basePath%>weixinManage/weixinManage!configindex.action" target="main_Frame"><img src="<%=basePath%>images/yx3_15.gif" dark="<%=basePath%>images/yx3_15.gif" light="<%=basePath%>images/yx4_15.gif"  width="56" height="64"  /></a>
  <!-- <ul style="position:relative;">
	  	<div class="nav01" style="position:absolute;top:-74px;left:55px;display:none">
			<li><a href="main.jsp" target="main_Frame">基本配置</a></li>
			<li><a href="main.jsp" target="main_Frame">会员卡</a></li>
			<li><a href="main.jsp" target="main_Frame">优惠券</a></li>
		</div>
  	</ul>  -->	
  </li>
 <!-- <li id="menu5"><a href="<%=basePath%>tenantConfigManage/tenantConfigManage!list.action" target="main_Frame"><img src="<%=basePath%>images/yx3_26.gif" dark="<%=basePath%>images/yx3_26.gif" light="<%=basePath%>images/yx4_26.gif" width="56" height="64"  /></a></li> -->	
  <li id="menu6"><a href="<%=basePath%>systemLog/systemLog!showList.action" target="main_Frame"><img src="<%=basePath%>images/yx3_27.gif" dark="<%=basePath%>images/yx3_27.gif" light="<%=basePath%>images/yx4_27.gif" width="56" height="64" /></a></li>
 <!-- <li id="menu7"><a href="<%=basePath%>onlineDetailManage/onlineDetailManage!showList.action" target="main_Frame"><img src="<%=basePath%>images/yx3_24.gif" dark="<%=basePath%>images/yx3_24.gif" light="<%=basePath%>images/yx4_24.gif" width="56" height="64" /></a></li> -->	
  <li id="menu9" ><a href="<%=basePath%>couponManage/couponManage!showList.action" target="main_Frame"><img src="<%=basePath%>images/yx3_15.gif" dark="<%=basePath%>images/yx3_15.gif" light="<%=basePath%>images/yx4_15.gif"  width="56" height="64"  /></a>

  </div>
  <div class="right_01">
    <script type="text/javascript">  
		var randomnumber=Math.floor(Math.random()*100000);  	
		document.write('<iframe id="main" name="main_Frame" scrolling="auto" frameborder="0" src="<%=basePath%>mobileResourceManage/mobileResourceManage!onlineUserCount.action?randomnumber='+randomnumber+'"/>');  	
	</script> 
  </div>
 </body>
</html>
