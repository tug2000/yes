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
<title>系统管理员修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=basePath%>js/checkform.js"></script>
<script type="text/javascript">

	function checkForm(){
		if(!Validator.Validate(document.getElementById('searchFrm'),3))return false;
	}
	
	function init(){
		<s:if test="message != null">
			alert('<s:property value="message"/>');
		</s:if>
	}
	 
</script>
</head>

<body class="b2" onload="init()">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>templateManage/templateManage!addTemplate.action" method="post">
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div>
<div class="all2">
  <div class="content">
    <div class="m10">
    <div class="tab">
    	<div class="tab_b"><a href="#" class="tab_no">新增模板</a></div>
    </div>
<div class="tab_c" valign="top">
  <div style="height:10px;"></div>
  <table border="0" cellspacing="0" cellpadding="0" style="width:99%">
     <tr>
        <td class="table_b_a"></td>
        <td valign="top" class="table_b_b">
          <table class="add_table" border="0" cellspacing="0" cellpadding="0">
          
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              	<td class="add_table_left">模板描述：</td>
              	<td class="add_table_right">
					<input type="text" id="tmDesc" name="tmDesc" class="add_input" dataType="Require" max="64" msg="模板描述不允许为空" />
				</td>
            </tr>
            
            <tr>
              <td colspan="2" class="add_btn">
	              <input type="submit" class="btn5" value="提交" onclick="return checkForm()"/>&nbsp;&nbsp;
              </td>
            </tr>
          </table>
       </td>
        <td class="table_b_c"></td>
     </tr>
  </table>
</div>
</div>
</div>
</div>
</form>
</body>
</html>
