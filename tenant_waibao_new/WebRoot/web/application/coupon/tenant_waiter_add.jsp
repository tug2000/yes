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
<title>新增店员</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=basePath%>js/checkform.js"></script>
<script language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript">

	function checkForm(){
		
		if(!Validator.Validate(document.getElementById('searchFrm'),3)){
			return false;
		}
	}

	$(document).ready(function(){
		init();
	});
	
	function init(){
		<s:if test="message != null">
			alert('<s:property value="message"/>');
		</s:if>
	}
	
	function showList(){
		document.getElementById('searchFrm').action = "<%=basePath%>tenantWaiter/tenantWaiter!showList.action";
		document.getElementById('searchFrm').submit();
	}
	
	function checkEmail() {
		var email = $("#saAdminEmail").val();
		if(email!=''){
			var patrn = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
			if (!patrn.exec(email)) {
				alert('邮箱格式不正确！');
				return false;
			} else {
				return true;
			}
		}
		return true;
	}
	
	function checkSmsCount(obj){
	   var patrn = /^[1-9]\d*$/;
		if (!patrn.exec(obj.value)) {
			obj.value = "";
		}
	}
	 
</script>
</head>

<body class="b2">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>tenantWaiter/tenantWaiter!add.action" method="post">
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div>

<div class="all2">
  <div class="content">
    <div class="m10">
    <div class="tab">
    	<div class="tab_b"><a href="#" class="tab_no">新增店员</a></div>
    </div>
<div class="tab_c" valign="top">
  <div style="height:10px;"></div>
<table class="add_table" border="0" cellspacing="0" cellpadding="0">
            
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              	<td class="add_table_left">店员名称：<font color="red">*</font></td>
             	<td class="add_table_right">
           			<input type="text" id="twWaiterName" name="twWaiterName" dataType="Require" class="add_input"
           			value='<s:property value="twWaiterName" />' max="32" msg="店员名称不允许为空，长度不能超过32位" />
           		</td>
            </tr>
            
             <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              	<td class="add_table_left">店员APP登录名：<font color="red">*</font></td>
             	<td class="add_table_right">
           			<input type="text" id="twAppUserName" name="twAppUserName" dataType="Require"  class="add_input"
           			value='<s:property value="twAppUserName" />'max="32" msg="店员APP登录名长度不能超过32位" />
           		</td>
            </tr>
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              	<td class="add_table_left">店员APP登录密码：<font color="red">*</font></td>
            	<td class="add_table_right">
					<input type="password" id="twAppPwd" name="twAppPwd" class="add_input" dataType="Require" dataType="Require" max="32" msg="密码不允许为空，长度不能超过32位" />
				</td>
            </tr>
            
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              	<td class="add_table_left">确认密码：<font color="red">*</font></td>
              	<td class="add_table_right">
					<input type="password" id="confirmPassword" name="confirmPassword" class="add_input" dataType="Repeat" to="twAppPwd" msg="两次输入的密码不一致，请重新输入"/>
				</td>
            </tr>
            
            <tr>
              <td colspan="2" class="add_btn">
	              <input type="submit" class="btn5" value="提交" onclick="return checkForm()"/>&nbsp;&nbsp;
	              <input type="button" class="btn4" value="返回" onclick="showList()"/>
              </td>
            </tr>
          </table>
</div>
</div>
</div>
</div>
</form>
</body>
</html>
