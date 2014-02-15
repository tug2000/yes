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
<title>查看发送短信</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">

	function showList(){
		document.location="<%=basePath%>adContentPushManage/adContentPushManage!showList.action";
	}
	
</script>
<body class="content_bj">
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
          <div class="table_title"><img src="<%=basePath%>images/ico_arrow.gif" align="absmiddle"/> 查看发送短信</div>
          <table class="add_table" border="0" cellspacing="0" cellpadding="0">
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              <td class="add_table_left">发送类型:</td>
              <td class="add_table_right">
				 <s:if test="adContentPush.apPushType==1">
					所有用户
				 </s:if>
				 <s:elseif test="adContentPush.apPushType==2">
					在线用户
				 </s:elseif>
            </tr>
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              <td class="add_table_left">发送内容:</td>
              <td class="add_table_right"><s:property value="adContentPush.apContent" />
            </tr>
            <tr class="add_table_tr" onMouseOver="this.className='add_table_tr_over'" onMouseOut="this.className='add_table_tr'">
              <td class="add_table_left">填写时间:</td>
              <td class="add_table_right"><s:date name="adContentPush.apWriteTime" format="yyyy年MM月dd日 HH时mm分ss秒"/>
            </tr>
            <tr>
              <td colspan="2" class="add_btn">
	              <input type="submit" class="btn1" value="提交" />&nbsp;&nbsp;
	              <input type="button" class="btn1" value="返回" onclick="showList()" />
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
</body>
</html>
