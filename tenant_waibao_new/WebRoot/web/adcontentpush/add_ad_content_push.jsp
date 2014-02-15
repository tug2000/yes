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
<title>添加发送短信</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=basePath%>js/checkform.js"></script>
<script type="text/javascript">

	function checkForm(){
		if(!Validator.Validate(document.getElementById('searchFrm'),3))return false;
	}
	
	function showList(){
		document.location="<%=basePath%>adContentPushManage/adContentPushManage!showList.action";
	}
	
	function init(){
		if('<s:property value="apPushType" />' != ''){
			document.getElementById('apPushType').value = '<s:property value="apPushType" />';
		}
	}
	
	function change(){
		if(document.getElementById('apPushType').options[0].selected){
			document.getElementById('currentSendCount').innerHTML="<s:property value='sendSmsCount' />";
           
		} else if (document.getElementById('apPushType').options[1].selected){
			document.getElementById('currentSendCount').innerHTML="<s:property value='sendOnlineSmsCount' />";
		} 
	}
	 
</script>
</head>
<body class="content_bj" onload="init()">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>adContentPushManage/adContentPushManage!addAdContentPush.action" method="post">
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div>
<div class="table_box" valign="top">
  <div class="table_a">
    <div class="table_a_a"><img src="<%=basePath%>images/blank.gif" /></div>
    <div class="table_a_b"><img src="<%=basePath%>images/blank.gif" /></div>
  </div>
  <table border="0" cellspacing="0" cellpadding="0" class="table_b">
  
     <tr>
        <td class="table_b_a"></td>
        <td valign="top" class="table_b_b">
          <div class="table_title"><img src="<%=basePath%>images/ico_arrow.gif" align="absmiddle"/> 添加发送短信</div>
          <table class="add_table" border="0" cellspacing="0" cellpadding="0">
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              <td class="add_table_left">发送类型:</td>
              <td class="add_table_right">
				<select id="apPushType" name="apPushType" onChange='javascript:change();'>
                	<option value="1">所有手机用户</option>
                	<option value="2">在线手机用户</option>
                </select>
                &nbsp;数量：<font id="currentSendCount" color="red"><s:property value="sendSmsCount" /></font>
                <input type="text" name="sendSmsCount" value='<s:property value='sendSmsCount' />' style="display:none;"/>
				<input type="text" name="sendOnlineSmsCount" value='<s:property value='sendOnlineSmsCount' />' style="display:none;"/>
              </td>
            </tr>
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              <td class="add_table_left">短信内容:</td>
              <td class="add_table_right">
              	<textarea id="apContent" name="apContent" class="add_textarea" style="resize:none;" rows="10" cols="80" dataType="Require" msg="请输入短信内容"><s:property value="apContent" /></textarea>
              </td>
            </tr>
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              <td class="add_table_left">发送数据:</td>
              <td class="add_table_right" id="showCount">
              	<div>剩余短信数量：<font color="red"><s:property value="smsQuantity" /></font>条</div>
              </td>
            </tr>
            <tr>
              <td colspan="2" class="add_btn">
              	<input type="submit" class="btn1" value="发送" onclick="return checkForm()"/>
              	<input type="button" class="btn2" value="历史记录" onclick="showList()"/>
              </td>
            </tr>
          </table>
       </td>
        <td class="table_b_c"></td>
     </tr>
  </table>
  <div class="table_c">
    <div class="table_c_a"></div>
    <div class="table_c_b"></div>
  </div>
</div>
</form>
</body>
</html>
