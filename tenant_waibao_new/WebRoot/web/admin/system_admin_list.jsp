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
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
</head>
<title>租户管理</title>
<script language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">

	function goUrl(pageIndex){
    	searchFrm.currPage.value = pageIndex;
		searchFrm.submit();
    }
	
	function toUpdate(saUuid){
		document.getElementById('searchFrm').action = "<%=basePath%>tenantManage/tenantManage!toModifyTenant.action?saUuid="+saUuid;
		document.getElementById('searchFrm').submit();
	}
	function toDelete(saUuid){
		if(confirm('确认删除？')) {
		document.getElementById('searchFrm').action = "<%=basePath%>tenantManage/tenantManage!toDeleteTenant.action?saUuid="+saUuid;
		document.getElementById('searchFrm').submit();
		}
	}
	
	function toAdd(){
		document.getElementById('searchFrm').action = "<%=basePath%>tenantManage/tenantManage!toAdd.action";
		document.getElementById('searchFrm').submit();
	}
	
	function unsubscribe(saUuid){
		if(!confirm("您确定要注销该租户？")){
			return;
		}
		document.getElementById('searchFrm').action = "<%=basePath%>tenantManage/tenantManage!unsubscribe.action?saUuid="+saUuid;
		document.getElementById('searchFrm').submit();
		document.getElementById('searchFrm').action = "<%=basePath%>tenantManage/tenantManage!showlist.action";
	}
	
	function normal(saUuid){
		if(!confirm("您确定要恢复该租户？")){
			return;
		}
		document.getElementById('searchFrm').action = "<%=basePath%>tenantManage/tenantManage!normal.action?saUuid="+saUuid;
		document.getElementById('searchFrm').submit();
		document.getElementById('searchFrm').action = "<%=basePath%>tenantManage/tenantManage!showlist.action";
	}

	$(document).ready(function(){
		init();
	});
	
	function init(){
		<s:if test="message != null">
			alert('<s:property value="message"/>');
		</s:if>
	}

	function loginTenant(saUuid, user, status){	

		if(!confirm("登录租户，将退出当前系统管理员的后台，模拟登录到该租户后台。确定登录？")){
			return;
		}

		$.ajax({
	   		url:'<%=basePath%>tenantManage/tenantManage!getTenantInfo.action',
	   		data:{'saUuid':saUuid},
	   		type:'post',
	   		datatype:"text",
	   		success:function(data){

	   			if(parseInt(status)>1){
	   				user += "_#$%*!()";
		   		}
		   		
	   			$.ajax({
	   		   		url:'<%=basePath%>j_spring_security_check',
	   		   		data:{'j_username':user, 'j_password':$.trim(data)},
	   		   		type:'post',
	   		   		datatype:"text",
	   		   		success:function(data){
	   		   			$("#tenantLink").click();
	   		   		}
	   		   		
	   		   	});  
	   		}
	   		
	   	}); 

	}
	 
</script>
<body class="b2" >
<form id="searchFrm" name="searchFrm" action="<%=basePath%>tenantManage/tenantManage!showlist.action" method="post">
<input type="hidden" name="currPage" value="0" />
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div>
<div class="all2">
  <div class="content">
    <div class="m10">
    <div class="tab">
    	<div class="tab_b"><a href="#" class="tab_no">租户管理列表</a></div>
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
                	租户管理员账号：&nbsp;&nbsp;&nbsp;
                	<input id="searchAdminId" name="searchAdminId" type="text" 
                		class="table_input" value='<s:property value="searchAdminId" />' />
                </div>
                <div class="table_search_a"><input id="btn_search" name="btn_search" type="submit" class="btn4" value="搜索" alt="搜索" /></div>
                <div class="table_search_a"><input id="btn_add" name="btn_add" type="button" class="btn5" value="新增" alt="新增" onclick="toAdd();" /></div>
              </td>
            </tr>
          </table>
          <div class="gdx"><img name="" src="" width="1" height="1" alt="" /></div>
          <div class="table_list_box">
          <table border="0" cellspacing="0" cellpadding="0" class="table_list_table">
             <tr class="table_list_th">
               <td class="table_list_tr">租户管理员账号</td>
               <td class="table_list_tr">租户管理员姓名</td>
               <td class="table_list_tr">租户企业名称</td>
               <td class="table_list_tr">联系电话</td>
               <td class="table_list_tr">租户使用截止日期</td>
               <td class="table_list_tr">可发送短信数量</td>
               <td class="table_list_tr">租户状态</td>
               <td class="table_list_tr">操作</td>
             </tr>
            
            <s:iterator value="pages" status="stat">
				<tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
					<td>
						<s:property value="saAdminId" />
					</td>
					<td>
						<s:property value="saAdminName" />
					</td>
					<td>
						<s:property value="tenantName" />
					</td>
					<td>
						<s:property value="saAdminTel" />
					</td>
					<td>
						<s:date name="saPeriodTime" format="yyyy年MM月dd日"/>
					</td>
					<td>
						<s:property value="saSmsQuantity" />
					</td>
					<td>
						 <s:if test="saStatus==1">
							正常
						 </s:if>
						 <s:elseif test="saStatus==2">
							授权到期
						 </s:elseif>
						 <s:elseif test="saStatus==3">
							注销
						 </s:elseif>
					</td>
					<td>
						<a href="javascript:loginTenant('<s:property value="saUuid" />', '<s:property value="saAdminId" />', '<s:property value="saStatus" />')">&nbsp;登录</a>
						<s:if test="saStatus!=3">
							<a href="javascript:toUpdate('<s:property value="saUuid" />')">修改</a>&nbsp;
						</s:if>
                   		<s:if test="saStatus==1">
							<a href="javascript:unsubscribe('<s:property value="saUuid" />')">注销</a>
						</s:if>
                   		<s:elseif test="saStatus==3">
							<a href="javascript:normal('<s:property value="saUuid" />')">恢复</a>
						</s:elseif>
						<a href="javascript:toDelete('<s:property value="saUuid" />')">&nbsp;删除</a>
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
  <a href="<%=basePath%>index.jsp" rel="external" style="display:none;" target="_parent"><span id="tenantLink"></span></a> 
</div>
</div>
</div>
</div>
</form>
</body>
</html>
