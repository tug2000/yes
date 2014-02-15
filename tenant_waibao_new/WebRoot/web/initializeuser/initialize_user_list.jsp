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
</head>
<title>清除用户</title>
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript">

	function goUrl(pageIndex){
      searchFrm.currPage.value = pageIndex;
	  searchFrm.submit();
    }

	function isMobile(){
		var phoneNumber = document.getElementById('urPhoneNumberSearch').value;
		var patrn = /^0?(13[0-9]|15[0-9]|18[0-9]|14[0-9])[0-9]{8}$/;
		if(phoneNumber.length<1){
			return true;
		} else {
			if (!patrn.exec(phoneNumber)) {
				alert('手机号码格式不正确！');
				return false;
			} else {
				return true;
			}
		}
	}

	function clearUser(userId){
		document.getElementById('searchFrm').action = "<%=basePath%>initializeUser/initializeUser!clearUser.action?urId="+userId;
		document.getElementById('searchFrm').submit();
	}

	function init(){
		if('<s:property value="message" />' !=null && '<s:property value="message" />' !=''){
			alert('<s:property value="message" />');
		}
	}
</script>
<body class="b2" onload="init();">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>initializeUser/initializeUser!showList.action" method="post">
<input type="hidden" name="currPage" value="0" />
  <div style="height:10px;"></div>
  <table border="0" cellspacing="0" cellpadding="0" style="width:99%">
     <tr>
        <td class="table_b_a"></td>
        <td valign="top" class="table_b_b">
          <table class="table_search" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td>
                <div class="table_search_a">
                	手机号码：
                	<input id="urPhoneNumberSearch" name="urPhoneNumberSearch" type="text" style="width:160px" 
                		class="table_input" value='<s:property value="urPhoneNumberSearch" />' />
                </div>
                <div class="table_search_a">
                	Mac：
                	<input id="urMacSearch" name="urMacSearch" type="text" style="width:160px"
                		class="table_input" value='<s:property value="urMacSearch" />' />
                </div>
                <div class="table_search_a">
                	Ip：
                	<input id="urUserIpSearch" name="urUserIpSearch" type="text" style="width:160px"
                		class="table_input" value='<s:property value="urUserIpSearch" />' />
                </div>
                <div class="table_search_a"><input id="btn_search" name="btn_search" type="submit" onclick="javascript:return isMobile();" class="btn4" value="搜索" alt="搜索" /></div>
              </td>
            </tr>
          </table>
          <div class="table_list_box">
          <table border="0" cellspacing="0" cellpadding="0" class="table_list_table">
             <tr class="table_list_th">
               <td class="table_list_tr">手机号</td>
               <td class="table_list_tr">Mac</td>
               <td class="table_list_tr">Ip</td>
             </tr>
            
            <s:iterator value="pages" status="stat">
				<tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
					<td>
						<s:property value="urPhoneNumber" />
					</td>
					<td>
						<s:property value="urMac" />
					</td>
					<td>
						<s:property value="urUserIp" />&nbsp;&nbsp;&nbsp;&nbsp;<a href="clearUser('<s:property value='urId' />')">清除用户</a>
					</td>
				</tr>
			</s:iterator>
              <tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
               <td colspan="7" class="page">
             		总共 <s:property value="%{allPageSize}" />						
					条,每页显示 <s:property value="%{pageSize}" /> 条,当前第 <s:if
					test="maxPage==0"> 0/0页 </s:if> <s:else>
					<s:property value="%{currPage+1}" />/<s:property
						value="%{maxPage}" />页
					</s:else> <A href="javascript:goUrl(<s:property value="%{0}"/>)">首页</A> | <A
					href="javascript:goUrl(<s:property value="%{prvPage}"/>)">上页</A> |
					<A href="javascript:goUrl(<s:property value="%{nextPage}"/>)">下页</A>
					| <A href="javascript:goUrl(<s:property value="%{maxPage}"/>)">尾页</A>&nbsp;
               </td>
             </tr>
          </table>
          </div>
        </td>
        <td class="table_b_c"></td>
     </tr>
  </table>

</form>
</body>
</html>
