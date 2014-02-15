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
<title>店员管理</title>
<script language="javascript"
	src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">

		<s:if test="message != null">
			alert('<s:property value="message"/>');
		</s:if>
		
	function goUrl(pageIndex){
      searchFrm.currPage.value = pageIndex;
	  searchFrm.submit();
    }   
    
	function toAdd(){
		document.getElementById('searchFrm').action = "<%=basePath%>tenantWaiter/tenantWaiter!toAdd.action";
		document.getElementById('searchFrm').submit();
	}
	
	function toDelete(twId){
		if(confirm('确认删除？')) {
		document.getElementById('searchFrm').action = "<%=basePath%>tenantWaiter/tenantWaiter!doDelete.action?twId="+twId;
		document.getElementById('searchFrm').submit();
		}
	}

	function toUpdate(twId){
		document.getElementById('searchFrm').action = "<%=basePath%>tenantWaiter/tenantWaiter!toModify.action?twId="+twId;
		document.getElementById('searchFrm').submit();
	}

</script>
<body class="b2">
	<form id="searchFrm" name="searchFrm"
		action="<%=basePath%>systemLog/systemLog!showList.action"
		method="post">
		<input type="hidden" name="currPage" value="0" />
		<div class="taole_h7">
			<img src="<%=basePath%>images/blank.gif" />
		</div>
		<div class="all2">
			<div class="content">
				<div class="m10">
					<div class="tab">
						<div class="tab_b">
							<a href="#" class="tab_no">店员管理</a>
						</div>
					</div>
					<div class="tab_c" valign="top">
						<div style="height: 10px;"></div>
						<table border="0" cellspacing="0" cellpadding="0"
							style="width: 99%">
							<tr>
								<td class="table_b_a"></td>
								<td valign="top" class="table_b_b">
									<table class="table_search" border="0" cellspacing="0"
										cellpadding="0">
										<tr>
											<td>
												<div class="table_search_a">
													店员名字：<input id="waiterNameSearch" name="waiterName"
														type="text" style="width: 160px" class="table_input"
														value='<s:property value="waiterName" />' />
												</div>

												<div class="table_search_a">
													<input id="btn_search" name="btn_search" type="submit"  style="cursor: pointer;"
														class="btn4" value="搜索" alt="搜索" />
												</div>
												<div class="table_search_a">
													<a id="btn_add" name="btn_add" class="page_link" onclick="toAdd();" />新增</a>
												</div></td>
										</tr>
									</table>
									<div class="table_list_box">
										<table border="0" cellspacing="0" cellpadding="0"
											class="table_list_table">
											<tr class="table_list_th">
												<td class="table_list_tr">店员名字</td>
												<td class="table_list_tr">APP登录用户名</td>
												<td class="table_list_tr">APP登录密码</td>
												<td class="table_list_tr">操作</td>
											</tr>

											<s:iterator value="pages" status="stat">
												<tr class="table_list_td"
													onMouseOver="this.className='table_list_td_over'"
													onMouseOut="this.className='table_list_td'">
													<td><s:property value="twWaiterName" /></td>
													<td ><s:property
															value="twAppUserName" /></td>
													<td><s:property value="twAppPwd" /></td>
													<td>
													<a href="javascript:toUpdate('<s:property value="twId" />')">修改</a>&nbsp;
													<a href="javascript:toDelete('<s:property value="twId" />')">&nbsp;删除</a>
													</td>
												</tr>
											</s:iterator>

											<tr class="table_list_td"
												onMouseOver="this.className='table_list_td_over'"
												onMouseOut="this.className='table_list_td'">
												<td colspan="7" class="page">总共 <s:property
														value="%{allPageSize}" /> 条,每页显示 <s:property
														value="%{pageSize}" /> 条,当前第 <s:if test="maxPage==0"> 0/0页 </s:if>
													<s:else>
														<s:property value="%{currPage+1}" />/<s:property
															value="%{maxPage}" />页
					</s:else> <s:if test="currPage==0">首页 | 上页 |</s:if> <s:else>
														<A href="javascript:goUrl(<s:property value="%{0}"/>)">首页</A> | <A
															href="javascript:goUrl(<s:property value="%{prvPage}"/>)">上页</A> |
					</s:else> <s:if test="currPage+1==maxPage  || maxPage==0">下页 | 尾页</s:if> <s:else>
														<A
															href="javascript:goUrl(<s:property value="%{nextPage}"/>)">下页</A> |
					<A href="javascript:goUrl(<s:property value="%{maxPage}"/>)">尾页</A>
													</s:else>&nbsp;</td>
											</tr>
										</table>
									</div></td>
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
