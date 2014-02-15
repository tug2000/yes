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
<link href="<%=basePath%>css/weixin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>

</head>
<title>微信基本配置</title>
<script type="text/javascript">
	$(document).ready(function(){
	    init();
	});
	
	function init(){		
		<s:if test="weixinAccount.waId==''">
			$("#nonValidTip").show();
			$(".table_box").hide();
		</s:if>
	}

	//跳转到新增页面
	function toAddRule(id){
		if(id==""){
			document.getElementById('searchFrm').action = "<%=basePath%>weixinManage/weixinManage!addRule.action";
		}else{
			document.getElementById('searchFrm').action = "<%=basePath%>weixinManage/weixinManage!addRule.action?ruleId=" + id;
		}
		
		document.getElementById('searchFrm').submit();
	}

	//删除
	function delRule(id){
   	   	if(confirm("确定要删除？")){
	   	   	$.ajax({
		   		url:'<%=basePath%>weixinManage/weixinManage!delRule.action',
		   		data:{'id':id},
		   		type:'post',
		   		datatype:"text",
		   		success:function(data){
			   		window.location.href = "<%=basePath%>weixinManage/weixinManage!keyReplyList.action";
		   		}	   		
		   	});  	   	    
   	   	}	
   	}
	 
</script>
<body >
<form id="searchFrm" name="searchFrm" action="<%=basePath%>weixinManage/weixinManage!keyReplyList.action" method="post">
<div style="height:10px;"></div>
<div id="nonValidTip" style="margin-left: 10px;margin-top: 10px;display:none">&nbsp;<img src="<%=basePath%>images/ico_prompt.gif" align="absmiddle" /> 您还未绑定微信账号，请先绑定微信账号后再配置关键字自动回复！ </div>
<div class="table_box" valign="top">
  <!-- 关键字自动回复 -->
  <table border="0" cellspacing="0" cellpadding="0" style="width:100%">
     <tr>
		<td class="table_b_a"></td>
		<td valign="top" class="table_b_b">
          <table class="table_search" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
            <tr>
              <td>
                <div class="table_search_a" >
                	规则名：&nbsp;&nbsp;&nbsp;
                	<input id="searchAdminId" name="ruleName" type="text" 
                		class="table_input" value='<s:property value="ruleName" />' />
                </div>
                <div class="table_search_a"><input id="btn_search" name="btn_search" type="submit" class="btn4" value="搜索" alt="搜索" /></div>
                <div class="table_search_a"><a class="page_link" onclick="toAddRule('');" />新增</a>
              </td>
            </tr>
          </table>
          <div class="table_list_box">
          <table border="0" cellspacing="0" cellpadding="0" class="table_list_table">
             <tr class="table_list_th">
               <td class="table_list_tr">规则名</td>
               <td class="table_list_tr">关键字</td>
               <td class="table_list_tr">回复消息类型</td>
               <td class="table_list_tr">操作</td>
             </tr>
            
            <s:iterator value="pages" status="stat">
				<tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
					<td>
						<s:property value="ruleName" />
					</td>
					<td>
						<s:property value="keySerial" />
					</td>
					<td>
						<s:if test="replyType==0">
							纯文字消息
						 </s:if>
						 <s:elseif test="replyType==1">
							单图文消息
						 </s:elseif>
						 <s:elseif test="replyType==2">
							多图文消息
						 </s:elseif>
					</td>
					<td>
						<a href="javascript:toAddRule('<s:property value="krId" />')">修改</a>&nbsp;
						<a href="javascript:delRule('<s:property value="krId" />')">&nbsp;删除</a>
					</td>
				</tr>
			</s:iterator>
             <tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
               <td colspan="9" class="page">
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
  
</div>
</form>

</body>
</html>
