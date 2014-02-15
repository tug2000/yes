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
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script language="javascript" src="<%=basePath%>js/checkform.js"></script>
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>
<style type="text/css">
 .table_top {margin-top:8px;}
</style>
</head>
<title>系统配置</title>
<script type="text/javascript">

	function checkForm(){
		var sn = document.getElementById('sauTr069Sn').value;
		if(sn.length<1){
			alert('序列号不允许为空');
			return false;
		} else if(sn.length>32){
			alert('序列号长度不允许大于32');
			return false;
		} else if(sn.indexOf(" ")>-1){
			alert('序列号不允许有空格');
			return false;
		}
		if(!Validator.Validate(document.getElementById('searchFrm'),3))return false;	
	}

	function init(){
		<s:if test="message != null">
			alert('<s:property value="message"/>');
		</s:if>
	}

	function checkSmsCount(obj){
		   var patrn = /^[1-9]\d*$/;
			if (!patrn.exec(obj.value)) {
				obj.value = "";
			}

			if(parseInt(obj.value)>24){
				alert("一天内上网时长不能超过24小时！");
				obj.value = "";
			}
	}

	function clearUser(){
		var userMac = document.getElementById('userMac').value;
		var reg_name=/^[0-9,a-f,A-F]{4}[.][0-9,a-f,A-F]{4}[.][0-9,a-f,A-F]{4}$/; 
		if(userMac.length<1){
			alert('Mac不能为空');
			return;
		}
		if(!reg_name.test(userMac)){
			alert('Mac格式不正确');
			return;
		}
		$.ajax({
   	   		url:'<%=basePath%>initializeUser/initializeUser!clearUserByMac.action?userMac='+userMac,
   	   		data:{},
   	   		type:'post',
   	   		datatype:"text",
   	   		success:function(data){
   		   		alert(data);
   	   		}
   	   	}); 
	 }
	
</script>
<body class="b2" style="background:#fff;" onload="init()">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>tenantConfigManage/tenantConfigManage!update.action" method="post">
<input type="hidden" id="tenantId" name="tenantId" value="<s:property value="tenantId" />" />
<input type="hidden" id="configType" name="configType" value="basic" />
  <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
    <tr class="add_table_tr" onmouseover="this.className='add_table_tr_over'" onmouseout="this.className='add_table_tr'">
          <td colspan="2" class="add_table_tit"><div class="add_table_tit1">防蹭网配置</div></td>
     </tr>
     <tr>
        <td class="table_b_a"></td>
        <td valign="top" class="table_b_b">
          <div style="margin-left: 10px;font-size:12px;margin-top: 5px;">
		  <font color="red">提示:&nbsp;</font><span style="width:100%">一天内允许的上网时长为:<input type="text" size="5"  onkeyup="checkSmsCount(this)" dataType="UnsignedInteger" msg="上网时长不能为空且必须是大于0的正整数!" name="duration" id="duration" value="<s:property value="duration" />"/>小时。</span>
		 </div>	
        </td>
        <td class="table_b_c"></td>
     </tr>
  </table>
  
  <div style="height:10px;"></div>
  <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
     <tr class="add_table_tr" onmouseover="this.className='add_table_tr_over'" onmouseout="this.className='add_table_tr'">
          <td colspan="2" class="add_table_tit"><div class="add_table_tit1">设备配置</div></td>
     </tr>
     <tr>
        <td class="table_b_a"></td>
        <td valign="top" class="table_b_b">
          <div style="margin-left: 10px;font-size:12px;margin-top: 5px;">
          	&nbsp;序列号：<input type="text" name="sauTr069Sn" id="sauTr069Sn" value="<s:property value="sauTr069Sn" />" style="width:180px"/>
          	<br/>
          	Acs Url：<input type="text" name="sauTr069Url" id="sauTr069Url" value="<s:property value="sauTr069Url" />" style="width:180px" disabled="disabled"/>
		 </div>	
        </td>
        <td class="table_b_c"></td>
     </tr>
  </table>
  
  <div style="height:10px;"></div>
  <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
     <tr class="add_table_tr" onmouseover="this.className='add_table_tr_over'" onmouseout="this.className='add_table_tr'">
          <td colspan="2" class="add_table_tit"><div class="add_table_tit1">清除用户</div></td>
     </tr>
     <tr>
        <td class="table_b_a"></td>
        <td valign="top" class="table_b_b">
          <div style="margin-left: 10px;font-size:12px;margin-top: 5px;">
          	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mac：<input type="text" id="userMac" placeholder="请输入Mac" style="width:180px" /> &nbsp;&nbsp;<input type="button" onClick="clearUser();" class="btn5" value="清除用户"/> (MAC格式"145a.05d7.d7a3")
		 </div>	
        </td>
        <td class="table_b_c"></td>
     </tr>
  </table>
  
  <div style="height:10px;"></div>
   <div style="margin-top: 10px;margin-left: auto;margin-right: auto;text-align: center;" >
       <input type="submit" onClick="return checkForm();" class="btn5" value="修改"/>&nbsp;&nbsp;
   </div>	
</form>
</body>
</html>
