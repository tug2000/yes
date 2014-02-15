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
<title>系统日志</title>
<script language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">

	function goUrl(pageIndex){
      searchFrm.currPage.value = pageIndex;
	  searchFrm.submit();
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
<body class="b2">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>systemLog/systemLog!showList.action" method="post">
<input type="hidden" name="currPage" value="0" />
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div>
<div class="all2">
  <div class="content">
    <div class="m10">
    <div class="tab">
    	<div class="tab_b"><a href="#" class="tab_no">系统日志</a></div>
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
                	操作员：<input id="slAdminIdSearch" name="slAdminIdSearch" type="text" style="width:160px"
                		class="table_input" value='<s:property value="slAdminIdSearch" />' />
                </div>
                <div class="table_search_a">
                	日志内容：<input id="slContentSearch" name="slContentSearch" type="text" style="width:160px"
                		class="table_input" value='<s:property value="slContentSearch" />' />
                </div>
                <div class="table_search_a">
                	开始时间：<input id="startTime" name="startTime" type="text" 
                			value='<s:property value="startTime" />' style="width:160px"
							class="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							ondblclick="this.value=''" readonly="readonly" />
				</div>
                <div class="table_search_a">
                	结束时间：<input id="endTime" name="endTime" type="text" 
                			value='<s:property value="endTime" />' style="width:160px"
							class="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							ondblclick="this.value=''" readonly="readonly"/>
				</div>
                <div class="table_search_a"><input id="btn_search" name="btn_search" type="submit" class="btn4" onclick="javascript:return checkTime();" value="搜索" alt="搜索" /></div>
              </td>
            </tr>
          </table>
          <div class="table_list_box">
          <table border="0" cellspacing="0" cellpadding="0" class="table_list_table">
             <tr class="table_list_th">
               <td class="table_list_tr">操作员</td>
               <td class="table_list_tr">日志内容</td>
               <td class="table_list_tr">记录时间</td>
             </tr>
            
            <s:iterator value="pages" status="stat">
				<tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
					<td>
						<s:property value="slAdminId" />
					</td>
					<td align="left" width="50%">
						<s:property value="slContent" />
					</td>
					<td>
					    <!--<s:property value="SL_CREATE_TIME" />-->
						<s:date name="slCreateTime" format="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
			</s:iterator>
			
             <tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
               <td colspan="7" class="page">
             		总共 <s:property value="%{allPageSize}" />						
					条,每页显示 <s:property value="%{pageSize}" /> 条,当前第 
					<s:if test="maxPage==0"> 0/0页 </s:if>
					<s:else>
						<s:property value="%{currPage+1}" />/<s:property value="%{maxPage}" />页
					</s:else> 
					<s:if test="currPage==0">首页 | 上页 |</s:if>
					<s:else>
						<A href="javascript:goUrl(<s:property value="%{0}"/>)">首页</A> | <A
						href="javascript:goUrl(<s:property value="%{prvPage}"/>)">上页</A> |
					</s:else>
					 
					<s:if test="currPage+1==maxPage  || maxPage==0">下页 | 尾页</s:if>
					<s:else>
					<A href="javascript:goUrl(<s:property value="%{nextPage}"/>)">下页</A> |
					<A href="javascript:goUrl(<s:property value="%{maxPage}"/>)">尾页</A>
					</s:else>&nbsp;
               </td>
             </tr>
          </table>
          </div>
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
