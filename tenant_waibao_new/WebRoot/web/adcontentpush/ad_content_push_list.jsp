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
<title>发送短信列表</title>
<script language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">

	function goUrl(pageIndex){
      searchFrm.currPage.value = pageIndex;
	  searchFrm.submit();
    }
	
    function toDetail(apId){
    	document.getElementById('searchFrm').action = "<%=basePath%>adContentPushManage/adContentPushManage!toDetail.action?apId="+apId;
		document.getElementById('searchFrm').submit();
	}
    
	function toUpdate(apId){
		document.getElementById('searchFrm').action = "<%=basePath%>adContentPushManage/adContentPushManage!toUpdate.action?apId="+apId;
		document.getElementById('searchFrm').submit();
	}
	
	function toAdd(){
		document.getElementById('searchFrm').action = "<%=basePath%>adContentPushManage/adContentPushManage!toAdd.action";
		document.getElementById('searchFrm').submit();
	}
	 
	function toSend(apId){
		document.getElementById('searchFrm').action = "<%=basePath%>adContentPushManage/adContentPushManage!toSend.action?apId="+apId;
		document.getElementById('searchFrm').submit();
	}
	 
	function del(apId){
		if(confirm("确定要删除吗？")){
			document.getElementById('searchFrm').action = "<%=basePath%>adContentPushManage/adContentPushManage!deleteById.action?apId="+apId;
			document.getElementById('searchFrm').submit();
			resetAction();
		}
	}
	 
	function init(){
		<s:if test="message != null">
			alert('<s:property value="message"/>');
		</s:if>
		document.getElementById('searchFrm').action = "<%=basePath%>adContentPushManage/adContentPushManage!showList.action";
		if('<s:property value="apPushTypeSearch" />' != ''){
			document.getElementById('apPushTypeSearch').value = '<s:property value="apPushTypeSearch" />';
		}
	}
	
	function resetAction(){
		document.getElementById('searchFrm').action = "<%=basePath%>adContentPushManage/adContentPushManage!showList.action";
	}
	 
	function checkTime(){
    	var startTime = searchFrm.startTime.value;
    	var endTime = searchFrm.endTime.value;
    	if(startTime!=''){
    		if(endTime!=''){
    			if(startTime>endTime){
    				alert("开始时间不能小于结束时间");
    				return false;
    			}
    		} else {
    			alert("结束时间不能为空！");
    			return false;
    		}
    	} else {
    		if(endTime!=''){
    			alert("开始时间不能为空！");
    			return false;
    		}
    		return true;
    	}
    	
    }
</script>
<body class="content_bj" onload="init()">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>adContentPushManage/adContentPushManage!showList.action" method="post">
<input type="hidden" name="currPage" value="0" />
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
          <div class="table_title"><img src="<%=basePath%>images/ico_arrow.gif" align="absmiddle"/> 广告发送管理</div>
          <table class="table_search" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td>
                <div class="table_search_a">
                	广告内容：<input id="apContentSearch" name="apContentSearch" type="text" 
                		class="table_input" value='<s:property value="apContentSearch" />' />
                </div>
                <div class="table_search_a">
                	开始时间：<input id="startTime" name="startTime" type="text" 
                			value='<s:property value="startTime" />' style="width:160px"
							class="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							ondblclick="this.value=''" readonly="readonly" />
				</div>
                <div class="table_search_a">
                	结束时间：<input id="endTime" name="endTime" type="text" 
                			value='<s:property value="endTime" />' style="width:160px"
							class="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							ondblclick="this.value=''" readonly="readonly"/>
				</div>
                <div class="table_search_a">发送类型：
                <select id="apPushTypeSearch" name="apPushTypeSearch">
                	<option value="">请选择</option>
                	<option value="1">所有手机用户</option>
                	<option value="2">在线手机用户</option>
                </select>
				</div>
                <div class="table_search_a"><input id="btn_search" name="btn_search" type="submit" class="btn1" value="搜索" alt="搜索" onclick="javascript:return checkTime();" /></div>
                <div class="table_search_a"><input id="btn_add" name="btn_add" type="button" class="btn1" value="新增" alt="新增" onclick="toAdd();" /></div>
              </td>
            </tr>
          </table>
          <div class="table_list_box">
          <table border="0" cellspacing="0" cellpadding="0" class="table_list_table">
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
             <tr class="table_list_th">
               <td class="table_list_tr">广告内容</td>
               <td class="table_list_tr">填写时间</td>
               <td class="table_list_tr">发送类型</td>
                <td class="table_list_tr">发送数量</td>
               <td class="table_list_tr">操作</td>
             </tr>
            
            <s:iterator value="pages" status="stat">
				<tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
					<td align="left" width="50%">
						<s:if test="apContent.length()>=100">
							<s:property value="apContent.substring(0,100)+'...'" />
						</s:if>
						<s:else>
							<s:property value="apContent" />
						</s:else>
					</td>
					<td nowrap="nowrap" width="15%">
						<s:date name="apWriteTime" format="yyyy年MM月dd日 HH时mm分ss秒"/>
					</td>
					<td nowrap="nowrap" width="15%">
						<s:if test="apPushType==1">
							所有手机用户
						 </s:if>
						 <s:elseif test="apPushType==2">
							在线手机用户
						 </s:elseif>
					</td>
					<td nowrap="nowrap" width="15%">
						<s:property value="apCount" />
					</td>
					<td nowrap="nowrap" width="10%">
                   		<input style="display:none" type="image" src="<%=basePath%>images/ico_edit.gif" title="编辑" align="absmiddle" 
                   			onclick="toUpdate('<s:property value="apId" />')" />&nbsp;&nbsp;
                   		<a href="javascript:toSend('<s:property value="apId" />')">重新发送</a>
                   	    <!--  <input type="text" value="重新发送" title="发送" align="absmiddle" 
                   			onclick="toSend('<s:property value="apId" />')" />&nbsp;&nbsp;-->
                   		<input style="display:none" type="image" src="<%=basePath%>images/ico_detail.gif" title="查看" align="absmiddle" 
                   			onclick="toDetail('<s:property value="apId" />')" />&nbsp;&nbsp;
                   		
                   		<input style="display:none" type="image" src="<%=basePath%>images/ico_delete.gif" title="删除" align="absmiddle" 
                   			onclick="del('<s:property value="apId" />')" />
					</td>
				</tr>
			</s:iterator>
          </table>
          </div>
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
