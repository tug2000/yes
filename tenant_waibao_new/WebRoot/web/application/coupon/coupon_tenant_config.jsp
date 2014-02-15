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
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>web/application/coupon/css/coupon.css" rel="stylesheet" type="text/css" />
</head>
<title>点券管理</title>
<script type="text/javascript">

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

	//保存配置
	function saveConfig(){

		var tenantName;
		var imgPath;
		var tenantTel;
		var tenantAddr;
		var appUser;
		var appPwd;

		tenantName = $("#tenant_name").val();
		imgPath = $("#img_path").val();
		tenantTel = $("#tenant_tel").val();
		tenantAddr = $("#tenant_addr").val();
		appUser = $("#app_user").val();
		appPwd = $("#app_pwd").val();

		if(""==$.trim(tenantName)){
   	   	    alert('请填写商家名称！');
   	   	    return;
   	   	}

		if(""==$.trim(imgPath)){
   	   	    alert('请上传品牌标志图片！');
   	   	    return;
   	   	}

		if(""==$.trim(tenantTel)){
   	   	    alert('请填写服务电话！');
   	   	    return;
   	   	}

		if(""==$.trim(tenantAddr)){
   	   	    alert('请填写地址！');
   	   	    return;
   	   	}

		if(""==$.trim(appUser)){
   	   	    alert('请填写E点券应用帐号名称！');
   	   	    return;
   	   	}

		if(""==$.trim(appPwd)){
   	   	    alert('请填写E点券应用帐号密码！');
   	   	    return;
   	   	}

		
		$.ajax({
	   		url:'<%=basePath%>couponManage/tenantConfig!saveTenantConfig.action',
	   		data:{'tenantName':tenantName, 'imgPath':imgPath, 'tenantTel':tenantTel, 'tenantAddr':tenantAddr, 'appUser':appUser, 'appPwd':appPwd},
	   		type:'post',
	   		datatype:"text",
	   		success:function(data){
	   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
	   	   		 	return;
	   	   		}
	   	   		
		   		alert(data);
		   		if($.trim(data)=="保存成功！"){
		   			$("#return_id").click();
			   	}
	   		}
	   		
	   	});  
	}

	//上传图片
	function ajaxupload(obj, value) {
   		if(value == null || value == '') {
   		   return;
   	    }
    	   
   		if(!isImage(value)) {
   		   alert('不支持上传该图片类型!');
   		   return;
   	    }
   	 
   	   $(obj).next().val(value);  	
   	   var form = $(obj).parent();
   	   $(form).attr("action","<%=basePath%>couponManage/tenantConfig!doUploadImage.action");
   	   $(form).ajaxSubmit(function(data) {   
   		   $("#img_id").attr("src", "${imgServerPath}"+data); 
   		   $("#img_path").val(data);
		   $("#input_single_pic").replaceWith("<input onchange=\"ajaxupload(this, this.value);\" id =\"input_single_pic\" class=\"pic_upload\" type=\"file\" name=\"upload\">");
   			
   	    });
   	}

</script>
<body  onload="MM_preloadImages('<%=basePath%>web/application/coupon/images/tc_02a.gif')">

  <div class="happ_win_cn">
  <table width="100%" border="0" cellspacing="12" cellpadding="0" class="happ_win04">
  <tr>
    <td align="right" class="happ_win_tit2">商家名称：</td>
    <td><input id="tenant_name" type="text" class="happ_ip01" size="50" value='<s:property value="tenantName" />' /></td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">品牌标志：</td>
    <td>
    <form method="post" action="" enctype="multipart/form-data">  
    
     <s:if test="imgPath != null">
		<img id="img_id" src='${imgServerPath}<s:property value="imgPath" />' width="120" height="80" />
	 </s:if>
	 <s:else>
		<img id="img_id" src="" width="120" height="80" />
	 </s:else>
               	
        <input type="button" class="btn4" value="选择图片"/>
       	<input onchange="ajaxupload(this, this.value);" id ="input_single_pic" class="pic_upload" type="file" name="upload">
       	<input name="uploadFileName" value="" type="hidden" />
       	  建议大小:宽240*高160 
       	 <input id="img_path" value='<s:property value="imgPath" />' type="hidden" />
    </form>
    </td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">服务电话：</td>
    <td><input id="tenant_tel" type="text" class="happ_ip01" size="50" value='<s:property value="tenantTel" />' /></td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">地址：</td>
    <td><input id="tenant_addr" type="text" class="happ_ip01" size="50" value='<s:property value="tenantAddr" />' /></td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">E点券应用帐号：</td>
    <td><input type="text" class="happ_ip01" id="app_user"  value='<s:property value="appUser" />' />
      </td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">E点券应用密码：</td>
    <td>
      <input type="text" class="happ_ip01" id="app_pwd" value='<s:property value="appPwd" />' /></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

  </div>
  <div class="tc_bnt02">
    <input type="button" class="btn1" onclick="saveConfig()" value="保存" />
  </div>


  <a style="display: none" href="<%=basePath%>couponManage/couponManage!showList.action" target="main_Frame"><span id="return_id"></span></a>
</body>
</html>
