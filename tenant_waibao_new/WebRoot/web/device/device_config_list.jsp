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
<title>下发升级</title>
<script language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>
<script type="text/javascript">
	function goUrl(pageIndex){
      searchFrm.currPage.value = pageIndex;
	  searchFrm.submit();
    }
    function toSendCli(checkBoxName){
    	var checkBox = document.getElementsByName(checkBoxName);
    	var paras='';
		for (var i = 0; i < checkBox.length; i++)
		 {
			  if(checkBox[i].checked == true){
			  	var id = checkBox[i].value;
			  	paras += document.getElementById('tenantId_'+id).innerHTML +',';
			  }
			  checkBox[i].onclick=function(){return false;};
		 }
    	if(paras!='' && paras.length > 0){
		  	document.getElementById('sendConfig').style.background='url(<%=basePath%>images/btn_bj4.gif) no-repeat';
		  	document.getElementById('upgradeVersion').style.background='url(<%=basePath%>images/btn_bj4.gif) no-repeat';
	    	$('#searchFrm').attr("action","<%=basePath%>deviceConfig/sendCli.action?paras="+paras);
		  	$('#searchFrm').submit();
		  	disableElement();
	  	} else {
	  		alert("未选中数据");
	  	}
	  	
    }
    
     function toUpgrate(checkBoxName){
     	var checkBox = document.getElementsByName(checkBoxName);
    	var paras='';
		for (var i = 0; i < checkBox.length; i++)
		 {
			  if(checkBox[i].checked == true){
			  	var id = checkBox[i].value;
			  	paras += document.getElementById('tenantId_'+id).innerHTML +',';
			  }
			  checkBox[i].onclick=function(){return false;};
		 }
    	if(paras!='' && paras.length > 0){
		  	document.getElementById('sendConfig').style.background='url(<%=basePath%>images/btn_bj4.gif) no-repeat';
		  	document.getElementById('upgradeVersion').style.background='url(<%=basePath%>images/btn_bj4.gif) no-repeat';
	    	$('#searchFrm').attr("action","<%=basePath%>deviceConfig/upgradeVersion.action?paras="+paras);
		  	$('#searchFrm').submit();
		  	disableElement();
	  	} else {
	  		alert("未选中数据");
	  	}
    }

    function disableElement(){
    	$('#btn_search').attr("disabled","true");
    	$('#sendConfig').attr("disabled","true");
    	$('#upgradeVersion').attr("disabled","true");
     }
    
    function checkAll(checkBoxName)
	{
     if(document.getElementById('sendConfig').disabled!=true){
    	 var checkBox = document.getElementsByName(checkBoxName);
    	 for (var i = 0; i < checkBox.length; i++)
    	 {
    	  var temp = checkBox[i];
    	  temp.checked = true;
    	 }
      }
	
	}
    function checkNone(checkBoxName)
	{
    if(document.getElementById('sendConfig').disabled!=true){
		 var checkBox = document.getElementsByName(checkBoxName);
		 for (var i = 0; i < checkBox.length; i++)
		 {
		  var temp = checkBox[i];
		  temp.checked = false;
		 }
    }
	}
    
    function init(){
        var message = '<s:property value="message"/>';
    	if(message!=null && message!=''){
    		alert(message);
    		document.getElementById('sendConfig').style.background='url(<%=basePath%>images/btn_bj3.gif) no-repeat';
	  		document.getElementById('upgradeVersion').style.background='url(<%=basePath%>images/btn_bj3.gif) no-repeat';
    		document.getElementById('sendConfig').disabled = false;
	  		document.getElementById('upgradeVersion').disabled = false;
    	}
    }
</script>
<body class="content_bj" onload="init();">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>deviceConfig/showList.action" method="post">
<input type="hidden" name="currPage" value="0" />
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div>
<div class="all2">
  <div class="content">
    <div class="m10">
    <div class="tab">
    	<div class="tab_b"><a href="#" class="tab_no">下发升级</a></div>
    </div>
<div class="tab_c" valign="top">
  <div style="height:10px;"></div>
  <table border="0" cellspacing="0" cellpadding="0" style="width:99%">
     <tr>
        <td class="table_b_a"></td>
        <td valign="top" class="table_b_b">
          <table class="table_search" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td>
                <div class="table_search_a">
                	租户：<input id="userName" name="userName" type="text" style="width:160px" class="table_input" value='<s:property value="userName" />' />
                </div>
                <div class="table_search_a"><input id="btn_search" name="btn_search" type="submit" class="btn4" onclick="javascript:return checkTime();" value="搜索" alt="搜索" /></div>
              </td>
            </tr>
          </table>
          <div class="table_list_box">
          <table border="0" cellspacing="0" cellpadding="0" class="table_list_table">
             <tr class="table_list_th">
               <td class="table_list_tr">序号</td>
               <td class="table_list_tr">租户</td>
             </tr>
              
            <s:iterator value="pages" status="stat">
            	<s:set name="stTd" value="%{#stat.getIndex()+1}"></s:set> 
				<tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
					<td>
						<input name="checkbox" type="checkbox" value="${stTd}"/>
					</td>
					<td>
						<s:property value="SA_ADMIN_ID" />
					</td>
					<td id="tenantId_${stTd}" style="display:none;"><s:property value="SA_TENANT_ID" /></td>
				</tr>
			</s:iterator>
			<tr class="table_list_tr_href">
               <td >
               		<a href="javascript:checkAll('checkbox');" >全选</a>
					<a href="javascript:checkNone('checkbox');" >全不选</a>
				</td>
               <td></td>
               <td></td>
             </tr>
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
        <td class="table_b_c"><br /></td>
     </tr>
  </table>
  <div style="margin-top: 10px;margin-left: auto;margin-right: auto;text-align: center;" >
       <input id="sendConfig" type="button" onClick="javascript:toSendCli('checkbox');" class="btn5" value="下发配置"/>&nbsp;&nbsp;
       <input id="upgradeVersion" type="button" onClick="javascript:toUpgrate('checkbox');" class="btn5" value="升级版本"/>&nbsp;&nbsp;
  </div>	
</div>
</div>
</div>
</div>
</form>
</body>
</html>
