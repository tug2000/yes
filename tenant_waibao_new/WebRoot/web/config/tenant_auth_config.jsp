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
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>css/weixin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script language="javascript" src="<%=basePath%>js/checkform.js"></script>
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>
<style type="text/css">
 .table_top {margin-top:8px;}
</style>
</head>
<title>认证配置</title>
<script type="text/javascript">
	//以 https开始的地址
	function httpsUrl(url) {
		if(url == null)
		   return false;
		url = url.toLowerCase();
		url = url.replace(/(^\s*)|(\s*$)/g, "");
		var reg = "^https:\/\/[\.a-zA-Z0-9\/]";
		var regExp = new RegExp(reg,"g");
		if(!regExp.test(url)) {
			return false;
		}
		return true;
	}
	function checkForm(){
		if(document.getElementById('duanXin').checked==true){
			document.getElementById('duanXinInvoke').value='1';
		}else{
			document.getElementById('duanXinInvoke').value='0';
		}

		if(document.getElementById('weiXin').checked==true){
			document.getElementById('weiXinInvoke').value='1';
		}else{
			document.getElementById('weiXinInvoke').value='0';
		}

		if(document.getElementById('noPwAuth').checked==true){
			document.getElementById('enableNoPw').value='1';
		}else{
			document.getElementById('enableNoPw').value='0';
		}

		var url = document.getElementById('diaplayUrl').value;
		if(document.getElementById('enableDirectDisplay').checked==true){
			if(url.length<1){
				alert("链接地址不能为空");
				return false;
			} else if(url.length>4000){
				alert("链接地址长度不能大于4000");
				return false;
			}
	 	    if(!isNull(url)) {
					if(!httpUrl(url) && !httpsUrl(url) ) {
						alert('链接地址输入不正确!必须以 http://或https://开头');
						return false;
					}
			} 
			document.getElementById('enableDirect').value='1';
			
		} else {
			var url = document.getElementById('diaplayUrl').value;
			if(url.length>4000){
				alert("链接地址长度不能大于4000");
				return false;
			}
			document.getElementById('enableDirect').value='0';
		}
 	   document.getElementById('directUrl').value = url;
		if(!Validator.Validate(document.getElementById('searchFrm'),3))return false;	
	}

	function init(){
		if('<s:property value="duanXinInvoke" />'=='1'){
			document.getElementById('duanXin').checked="checked";
		}
		if('<s:property value="weiXinInvoke" />'=='1'){
			document.getElementById('weiXin').checked="checked";
		}
		if('<s:property value="enableNoPw" />'=='1'){
			document.getElementById('noPwAuth').checked="checked";
		}
		document.getElementById('diaplayUrl').value = document.getElementById('directUrl').value;
		if('<s:property value="enableDirect" />'=='1'){
			document.getElementById('enableDirectDisplay').checked="checked";
			document.getElementById('diaplayUrl').disabled = false;
		} else {
			document.getElementById('diaplayUrl').disabled = true;
		}
		$("#preview_pt_txt_input").parent().parent().show();
		$("#preview_pt_txt_input").html('密码：xxxxxx。您也可以点击链接：http://www.ruijie.com.cn/xxxxxx，进行认证上网。'+'<s:property value="welcomeMsg" />');
		<s:if test="message != null">
			alert('<s:property value="message"/>');
		</s:if>
	}

	function checkBoxClick(){
		if(document.getElementById('enableDirectDisplay').checked==true){
			document.getElementById('diaplayUrl').disabled = false;
		}
		if(document.getElementById('enableDirectDisplay').checked==false){
			document.getElementById('diaplayUrl').disabled = true;
		}
	}

	function syncPreviewTxt(obj){
		var value = $(obj).val();
		if("" == value){
			$("#preview_pt_txt_input").parent().parent().show();
			value = value.replace(new RegExp("\n","gm"),"<br/>");
			$("#preview_pt_txt_input").html('密码：xxxxxx。您也可以点击链接：http://www.ruijie.com.cn/xxxxxx，进行认证上网。');
		}else{
			$("#preview_pt_txt_input").parent().parent().show();
			value = value.replace(new RegExp("\n","gm"),"<br/>");
			$("#preview_pt_txt_input").html('密码：xxxxxx。您也可以点击链接：http://www.ruijie.com.cn/xxxxxx，进行认证上网。'+value);
		}
	   	
	}
	
	function verify(type){	
		if(type=="duanxin"){
			if(document.getElementById('noPwAuth').checked==true){
				document.getElementById('duanXin').checked=false;
				alert("短信认证和免密码认证只能开启一个！");
			}
		} else {
			if(document.getElementById('duanXin').checked==true){
				document.getElementById('noPwAuth').checked=false;
				alert("短信认证和免密码认证只能开启一个！");
			}
		}
	}
	
</script>
<body class="b2" onload="init()" style="background:#fff;">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>tenantConfigManage/tenantConfigManage!update.action" method="post">
<input type="hidden" id="tenantId" name="tenantId" value="<s:property value="tenantId" />" />
<input type="hidden" id="configType" name="configType" value="auth" />
<table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
	<tr class="add_table_tr">
		<td valign="top">
			<table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
		     <tr class="add_table_tr" onmouseover="this.className='add_table_tr_over'" onmouseout="this.className='add_table_tr'">
		          <td colspan="2" class="add_table_tit"><div class="add_table_tit1">认证方式</div></td>
		     </tr>
		     <tr>
		        <td class="table_b_a"></td>
		        <td valign="top" class="table_b_b">
		          <div style="margin-left: 10px;font-size:12px;margin-top: 5px;">
		          	&nbsp;&nbsp;&nbsp;开启短信认证：<input name="duanXin" id="duanXin" type="checkbox" onclick="verify('duanxin')"/>（输入手机号获取上网密码，通过密码进行上网认证）
		          	<br/>
		          	&nbsp;&nbsp;&nbsp;开启微信认证：<input name="weiXin" id="weiXin" type="checkbox"/>（关注微信公众号，点击微信公众号下发的链接进行上网认证）
		          	<br/>
		          	开启免密码认证：<input name="noPwAuth" id="noPwAuth" type="checkbox" onclick="verify('nopw')"/>（输入手机号即可上网认证）
		          	
				 <input type="hidden" id="weiXinInvoke" name="weiXinInvoke" value="<s:property value="weiXinInvoke" />" />
				 <input type="hidden" id="duanXinInvoke" name="duanXinInvoke" value="<s:property value="duanXinInvoke" />" />
				 <input type="hidden" id="enableNoPw" name="enableNoPw" value="<s:property value="enableNoPw" />" />
				 </div>	
		        </td>
		        <td class="table_b_c"></td>
		     </tr>
		  </table>
		  
		  <div style="height:10px;"></div>
		  <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
		     <tr class="add_table_tr" onmouseover="this.className='add_table_tr_over'" onmouseout="this.className='add_table_tr'">
		          <td colspan="2" class="add_table_tit"><div class="add_table_tit1">短信欢迎语</div></td>
		     </tr>
		     <tr>
		        <td class="table_b_a"></td>
		        <td valign="top" class="table_b_b">
		          <div style="margin-left: 10px;font-size:12px;margin-top: 5px;">
		           <textarea id="welcomeMsg" name="welcomeMsg" class="add_textarea" style="resize: none;width:600px;" onkeyup="syncPreviewTxt(this)" 
		           				rows="10" cols="60" ><s:property value="welcomeMsg" /></textarea>
				 </div>	
		        </td>
		        <td class="table_b_c"></td>
		     </tr>
		     
		     
		     
		  </table>
		  
		  <div style="height:10px;"></div>
		  <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
		     <tr class="add_table_tr" onmouseover="this.className='add_table_tr_over'" onmouseout="this.className='add_table_tr'">
		          <td colspan="2" class="add_table_tit"><div class="add_table_tit1">认证成功跳转至指定页面</div></td>
		     </tr>
		     <tr>
		        <td class="table_b_a"></td>
		        <td valign="top" class="table_b_b">
		          <div style="margin-left: 10px;font-size:12px;margin-top: 5px;">
		          	<input name="enableDirectDisplay" id="enableDirectDisplay" type="checkbox" onClick="checkBoxClick();"/>&nbsp;开启认证成功重定向
		          		<br/>
		          	重定向主页：<input type="text" placeholder="请输入认证成功跳转地址" size="60" name="diaplayUrl" id="diaplayUrl"/>
		          	<input type="hidden" id="enableDirect" name="enableDirect" value="<s:property value="enableDirect" />" />
		          	<input type="hidden" name="directUrl" id="directUrl" value="<s:property value="directUrl" />"/>
				 </div>	
		        </td>
		        <td class="table_b_c"></td>
		     </tr>
  			</table>
		</td>
		<td style="width:80px;"></td>
			 <td style="width:600px;" >
			 <div style="height:10px;"></div>
		        	<!-- 纯文本预览 -->		
		        	<div class="wei_bg" style="white-space:normal;">
			        	<div id="preview_pt_txt" class="wei_box" style="overflow: auto;">
							<div class="wei_box2">
							<div class="wei_bg04">
							<div id="preview_pt_txt_input" class="wei_txt2 spanwrap2" style="width:140px;min-height:30px;"></div>
							</div>
							<div class="wei_bg05"></div>
							</div>
					   </div>
				   </div>
		        </td>
	</tr>
</table>
  
  
  <div style="height:10px;"></div>
   <div style="margin-top: 10px;margin-left: auto;margin-right: auto;text-align: center;" >
       <input type="submit" onClick="return checkForm();" class="btn5" value="修改"/>&nbsp;&nbsp;
   </div>	
</form>
</body>
</html>
