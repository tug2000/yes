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
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>	
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>web/application/coupon/css/coupon.css" rel="stylesheet" type="text/css" />
</head>
<title>点券管理</title>
<style type="text/css">
.mask {   
      background-color:#333;
      position:absolute;
      top:0px;
      left:0px;
      filter: Alpha(Opacity=60);
  }
</style>
<script type="text/javascript">

	function goUrl(pageIndex){
      searchFrm.currPage.value = pageIndex;
	  searchFrm.submit();	  
    }   

	//弹出编辑商家对话框
	function popEditTenant(){
		$("#dialogDiv").height(490);
		$("#dialogTitle").html("请填写以下商家资料");
		$("#dialog_iframe").attr("src", "<%=basePath%>couponManage/tenantConfig!toConfigTenant.action");		
		popupDiv("dialogDiv");
	}
	
	//弹出编辑点券对话框
	function popEditCoupon(){
		$("#dialogDiv").height(570);
		$("#dialogTitle").html("新建E点券");
		$("#dialog_iframe").attr("src", "<%=basePath%>couponManage/couponEdit!toConfigCoupon.action");		
		popupDiv("dialogDiv");
	}

	//弹出修改点券对话框
	function popModifyCoupon(id){
		$("#dialogDiv").height(570);
		$("#dialogTitle").html("修改E点券");
		$("#dialog_iframe").attr("src", "<%=basePath%>couponManage/couponEdit!toConfigCoupon.action?couponId="+id);		
		popupDiv("dialogDiv");
	}

	//弹出对话框
	function popupDiv(div_id) {   
		
	    var div_obj = $("#"+div_id);  
	    var windowWidth = document.body.clientWidth;       
	    var windowHeight = document.body.clientHeight;  
	    var popupHeight = div_obj.height();       
	    var popupWidth = div_obj.width();    

	    //添加并显示遮罩层   
	    $("<div id='mask'></div>").addClass("mask")   
	                              .width(windowWidth)   
	                              .height(windowHeight + 600)   
	                              .appendTo("body")   
	                              .fadeIn(200);   
	    div_obj.css({"position": "absolute"})   
	           .animate({left: windowWidth*0.5-popupWidth*0.5,    
	                     top: -20, opacity: "show" }, "slow");   
	                    
	} 

	//隐藏对话框
	function hideDiv(div_id) {   
	    $("#mask").remove();   
	    $("#" + div_id).animate({left: 0, top: 0, opacity: "hide" }, "slow");   
	} 

	//删除点券
	function delCoupon(couponId){
		if(confirm("确定要删除？")){
	   	   	$.ajax({
		   		url:'<%=basePath%>couponManage/couponManage!delCoupon.action',
		   		data:{'couponId':couponId},
		   		type:'post',
		   		datatype:"text",
		   		success:function(data){
		   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
		   	   		 	return;
		   	   		}
		   	   		
			   		alert(data);
			   		if($.trim(data)=="删除成功！"){
				   		window.location.href = "<%=basePath%>couponManage/couponManage!showList.action";
				   	}			   	
		   		}	   		
		   	});  	   	    
   	   	}	
	}

	//切换报表图片
	function swapReportImg(obj, flag){
		var childs = $(obj).children();
		if(0==flag){
			$(childs.get(0)).show();
			$(childs.get(1)).hide();
		}else{
			$(childs.get(0)).hide();
			$(childs.get(1)).show();
		}
	}

	function MM_swapImgRestore() { //v3.0
		  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
	}
	
	function MM_preloadImages() { //v3.0
	  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
	}

	function MM_findObj(n, d) { //v4.01
	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && d.getElementById) x=d.getElementById(n); return x;
	}

	function MM_swapImage() { //v3.0
	  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
	}

</script>
<body class="b2" onload="MM_preloadImages('<%=basePath%>web/application/coupon/images/gg4_21a.gif','<%=basePath%>web/application/coupon/images/gg4_21.gif','<%=basePath%>web/application/coupon/images/happ_bnt2a.gif','<%=basePath%>web/application/coupon/images/happ_bnt1a.gif')">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>couponManage/couponManage!showList.action" method="post">
<input type="hidden" name="currPage" value="0" />
<div class="gg4_box">
  <div class="gg4_left"><a href="javascript:goUrl(<s:property value="%{prvPage}"/>)" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image2','','<%=basePath%>web/application/coupon/images/gg4_21a.gif',1)"><img src="<%=basePath%>web/application/coupon/images/gg4_20a.gif" width="50" height="88" id="Image2" /></a></div>
  <div class="gg4_m">
  <div class="h_aap02"></div>
  <div class="haap_wel">
  <div class="haap_logo">
     <s:if test="imgPath != null">
		<img src='${imgServerPath}<s:property value="imgPath" />' width="72" height="72" />
	 </s:if>
	 <s:else>
		<img src="<%=basePath%>web/application/coupon/images/4.GIF" width="72" height="72" />
	 </s:else>
  </div>
  <div class="haap_tel">
  <li><span><s:property value="tenantName" /></span></li>
  <li>电话：<s:property value="tenantTel" /></li>
  <li>地址：<s:property value="tenantAddr" /></li>
  </div>
  <div class="haap_bnt">
  <li><a onclick="popEditTenant()" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image5','','<%=basePath%>web/application/coupon/images/happ_bnt2a.gif',1)"><img src="<%=basePath%>web/application/coupon/images/happ_bnt2.gif" width="55" height="55" id="Image5" /></a></li>
  <li><a onclick="popEditCoupon()" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image6','','<%=basePath%>web/application/coupon/images/happ_bnt1a.gif',1)"><img src="<%=basePath%>web/application/coupon/images/happ_bnt1.gif" width="55" height="55" id="Image6" /></a></li>
  </div>
  </div>
  <div><img src="<%=basePath%>web/application/coupon/images/home1_2.gif" width="100%" height="3" /></div>
  <div class="happ_edj">
  	<s:iterator value="pages" status="stat">
	<li>
	    <div class="tc_c" style="margin-right:-7px;"><a onclick="delCoupon('<s:property value="tcCoId" />')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image14','','<%=basePath%>web/application/coupon/images/tc_02a.gif',1)"><img src="<%=basePath%>web/application/coupon/images/tc_01a.gif" width="27" height="27" id="Image14" /></a>
	    </div>
	    <div class="haap_bnt2"><input type="button" onclick="popModifyCoupon('<s:property value="tcCoId" />')" value="修改" class="haap_bnt2a" /></div>
	    <div class="edj_tit"><s:property value="tcCouponName" /></div>
	    <div class="edj_sj" onmouseover="swapReportImg(this, 1)" onmouseout="swapReportImg(this, 0)">
	    	<img src='${imgServerPath}<s:property value="tcCouponIcoUrl" />' width="100%" height="130" />
	    	<div style="display: none">
	    	<s:if test="tcUserSum == 0">
	    		<div class="edj_sj_pic1">
			    <div class="edj_sj_no" style="padding-top:83px;"><s:property value="tcUserSum" /></div>
			    </div>
			    <div class="edj_sj_pic2">
			    <div class="edj_sj_no" style="padding-top:83px;"><s:property value="tcSaleSum" /></div>
			    </div>
			    <div class="edj_sj_pic3">
			    <div class="edj_sj_no" style="padding-top:83px;">			    
			 </s:if>
			 <s:else>
	    	    <div class="edj_sj_pic1">
			    <div class="edj_sj_no" style='padding-top:<s:property value="83*0.1*tcSaleSum/tcUserSum" />px;'><s:property value="tcUserSum" /></div>
			    </div>
			    <div class="edj_sj_pic2">
			    <div class="edj_sj_no" style='padding-top:<s:property value="83*0.1" />px;'><s:property value="tcSaleSum" /></div>
			    </div>
			    <div class="edj_sj_pic3">			    
			 </s:else>
			    <s:if test="tcUserSum == 0">
			    	0%
			    </s:if>
			    <s:elseif test="(tcSaleSum-tcUserSum)/tcUserSum > 1">
			    	<div class="edj_sj_no" style="padding-top:0px;">100%
			    </s:elseif>
			    <s:else>
			    	<div class="edj_sj_no" style='padding-top:<s:property value="83*(1-0.9*(tcSaleSum-tcUserSum)/tcUserSum)" />px;'><s:property value="100*(tcSaleSum-tcUserSum)/tcUserSum" />%
			    </s:else>
			    </div>
			       
	    	</div>
	    	<div class="edj_sj_n">用户量 　　售出　 　回头率</div>
	    	</div>
	    </div>
	    <div class="edj_txt">
	    <p>说明：<s:property value="tcCouponActiviyDes" /></p>
	    <p>有效期：<s:date name="tcValIdBeginDateTime" format="yyyy.MM.dd"></s:date> - <s:date name="tcValIdEndDateTime" format="yyyy.MM.dd"></s:date></p>
	    <p>其它：</p>
	    </div>
	</li>
	</s:iterator>
	<s:iterator begin="pages.size+1" end="4" >
	  <li>
	    <div class="edj_tit">新建E点券</div>
	    <div class="edj_add"><a onclick="popEditCoupon()">+</a></div>
	  </li>
	</s:iterator>
  </div>
  
	<div class="gg4_page" style="margin-top:20px;">
	    <s:iterator begin="1" end="%{maxPage}" status="stat">
	        <s:if test="#stat.index == currPage">
	       	 	<a href="javascript:goUrl(<s:property value="#stat.index"/>)"><img src="<%=basePath%>web/application/coupon/images/more1.png" width="16" height="16" /></a>
	        </s:if>
	        <s:else>
	        	<a href="javascript:goUrl(<s:property value="#stat.index"/>)"><img src="<%=basePath%>web/application/coupon/images/more2.png" width="16" height="16" /></a>
	        </s:else>
	    	
	    </s:iterator>
	</div>
    
  </div>
  <div class="gg4_right"><a href="javascript:goUrl(<s:property value="%{nextPage}"/>)" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image3','','<%=basePath%>web/application/coupon/images/gg4_21.gif',1)"><img src="<%=basePath%>web/application/coupon/images/gg4_20.gif" width="50" height="88" id="Image3" /></a></div>
</div>


<!-- 弹出框--> 
<div id="dialogDiv" class="tc_dialog" style="display: none;z-index: 1;">
  <div class="tc_tit"><span id="dialogTitle"></span>
    <div class="tc_c"><a  onclick="hideDiv('dialogDiv');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image1','','<%=basePath%>images/tc_02.gif',1)"><img src="<%=basePath%>images/tc_01.gif" width="27" height="27" id="Image1" /></a>
    </div>
  </div>
  
  <iframe id="dialog_iframe" frameborder="0" src="<%=basePath%>couponManage/tenantConfig!toConfigTenant.action" width="100%" height="100%" />
  
</div>

</form>
</body>
</html>
