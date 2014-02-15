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
<title>租户管理员修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=basePath%>js/checkform.js"></script>
<script language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript">

	function checkForm(){
		if(!checkEmail()){
			return false;
		}
		if(!Validator.Validate(document.getElementById('searchFrm'),3)){
			return false;
		}
	}
	
	function showList(){
		document.getElementById('searchFrm').action = "<%=basePath%>tenantManage/tenantManage!showlist.action";
		document.getElementById('searchFrm').submit();
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
	 
</script>
</head>

<body class="b2" onload="init()">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>tenantManage/tenantManage!modifyTenant.action" method="post">
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div>
<div class="all2">
  <div class="content">
    <div class="m10">
    <div class="tab">
    	<div class="tab_b"><a href="#" class="tab_no">租户管理员修改</a></div>
    </div>
<div class="tab_c" valign="top">
  <div style="height:10px;"></div>
	<table class="add_table" border="0" cellspacing="0" cellpadding="0">
      	<input type="hidden" id="saUuid" name="saUuid" value='<s:property value="bean.saUuid" />' />
      	
      	  <!-- 
      	  <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'" >
          	<td class="add_table_left">认证设备IP地址：<font color="red">*</font></td>
          	<td class="add_table_right">
       			<input type="text" id="saNasIp" name="saNasIp" value='<s:property value="bean.saNasIp" />' dataType="Ip" Require="true" msg="IP地址不允许为空，格式必须是IP地址，例如：192.168.1.123" />
       		</td>
        </tr> -->
        
        <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
          	<td class="add_table_left">设备 TR069 序列号：<font color="red">*</font></td>
          	<td class="add_table_right">
       			<input type="text" id="saTr069Index" name="saTr069Index" class="add_input" value='<s:property value="bean.saTr069Index" />' dataType="Require" max="64" msg="设备 TR069 序列号不允许为空，长度不能超过64位" />
       		</td>
        </tr>
        
        <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
          	<td class="add_table_left">设备 TR069 URL：</td>
          	<td class="add_table_right">
       			<input type="text" id="saTr069Url" name="saTr069Url" class="add_input" value='<s:property value="bean.saTr069Url" />' max="256" msg="长度不能超过256位" />
       		</td>
        </tr>
        
        <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
          	<td class="add_table_left">租户使用截止日期：<font color="red">*</font></td>
          	<td class="add_table_right">
       			<input id="saPeriodTime" name="saPeriodTime" type="text" class="add_input" dataType="Require" msg="租户使用截止日期不允许为空"
            			value='<s:date name="bean.saPeriodTime" format="yyyy-MM-dd"/>' style="width:160px"
			class="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
			ondblclick="this.value=''" readonly="readonly" />
       		</td>
        </tr>
        
        <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
          	<td class="add_table_left">电话：</td>
          	<td class="add_table_right">
       			<input type="text" id="saAdminTel" name="saAdminTel" class="add_input" value='<s:property value="bean.saAdminTel" />' max="32" msg="长度不能超过32位" />
       		</td>
        </tr>
        
        <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
          	<td class="add_table_left">租户管理员姓名：</td>
         	<td class="add_table_right">
       			<input type="text" id="saAdminName" name="saAdminName" 
       			value='<s:property value="bean.saAdminName" />'max="32" class="add_input" msg="管理员姓名长度不能超过32位" />
       		</td>
        </tr>
        
        <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
          	<td class="add_table_left">邮箱地址：</td>
          	<td class="add_table_right">
       			<input type="text" id="saAdminEmail" name="saAdminEmail" class="add_input" size="80" value='<s:property value="bean.saAdminEmail" />' max="128" msg="长度不能超过128位" />
       		</td>
        </tr>
        
        <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
          	<td class="add_table_left">租户单位地址：</td>
          	<td class="add_table_right">
       			<input type="text" id="saAddress" name="saAddress" class="add_input" style="width: 550px;" size="80" value='<s:property value="bean.saAddress" />' max="128" msg="长度不能超过128位" />
       		</td>
        </tr>
        
        <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
          	<td class="add_table_left">可发送短信数量：</td>
          	<td class="add_table_right">
       			<font color="red"><s:property value="bean.saSmsQuantity" /></font> 
       			条，需要增加&nbsp;<input type="text" id="saSmsQuantity" name="saSmsQuantity" class="add_input" size="5" style="width: 20px;" value="0" onkeyup="checkSmsCount(this)" dataType="Number" max="5" maxlength="5" msg="必须为数字，长度不能超过5位" />
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
