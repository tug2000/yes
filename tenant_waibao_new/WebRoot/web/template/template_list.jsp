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
<title>广告模版列表</title>
<script type="text/javascript">

	function goUrl(pageIndex){
      searchFrm.currPage.value = pageIndex;
	  searchFrm.submit();
    }
	 
	function start(tmUuid){
		if(confirm("确定要启用吗?")) {
		   $("#tmUuid").val(tmUuid);
		   $("#searchFrm").attr("action","<%=basePath%>templateList/templateList!start.action");
		   $("#searchFrm").submit();
		}		
	}
	
	function edit(tmId, tmUuid){
		$("#tmUuid").val(tmUuid);
		$("#searchFrm").attr("action","<%=basePath%>templateManage/templateManage!toDynamicTemplate.action");
		$("#searchFrm").submit();
	}
	
	function publish(tmUuid) {
		if(confirm("确定要发布吗？")){
		    $("#tmUuid").val(tmUuid);
		    $("#searchFrm").attr("action","<%=basePath%>templateList/templateList!publish.action");
		    $("#searchFrm").submit();
		}
	}

	function addTemplate(){
		$("#searchFrm").attr("action","<%=basePath%>templateManage/templateManage!addTemplate().action");
		$("#searchFrm").submit();
	}

	function del(tmUuid) {
		if(confirm("确定要删除吗？")){
		    $("#tmUuid").val(tmUuid);
		    $("#searchFrm").attr("action","<%=basePath%>templateList/templateList!deleteTemplateById.action");
		    $("#searchFrm").submit();
		}
	}
	
</script>
<body class="b2">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>templateList/templateList!showList.action" method="post">
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0"
    width="100%" height="100%" id="file" align="middle">
    <param name="allowScriptAccess" value="sameDomain" />
    <param name="movie" value="/flash/FlashFileUpload.swf?ver=2009041702" />
    <param name="quality" value="high" />
    <param name="wmode" value="transparent">
    <param name="FlashVars" value='fileTypeDescription=JPG格式图片&fileTypes=*.jpg;*.jpeg&fileSizeLimit=3000000&totalUploadSize=10240000&uploadPage=<%=basePath%>templateList/templateList!showList.action;jsessionid=${session.id}?username=${username}'>
    <embed src="<%=basePath%>flash/FlashFileUpload.swf?ver=2009041702" FlashVars='fileTypeDescription=JPG格式图片&fileTypes=*.jpg;*.jpeg&fileSizeLimit=3000000&totalUploadSize=10240000&uploadPage=<%=basePath%>templateList/templateList!showList.action;jsessionid=${session.id}?username=${username}'
        quality="high" wmode="transparent" width="600px" height="500px" name="file"
        align="middle" allowscriptaccess="sameDomain" type="application/x-shockwave-flash"
        pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object>
<input type="hidden" name="tmUuid" id="tmUuid" value=""/>
<input type="hidden" name="currPage" value="0" />
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div>
<div class="all2">
  <div class="content">
    <div class="m10">
    <div class="tab">
    	<div class="tab_b"><a href="#" class="tab_no">广告模板管理</a></div>
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
                <div class="table_search_a"><a id="btn_add" name="btn_add" class="page_link" onclick="addTemplate();" />新增</a></div>
              </td>
            </tr>
          </table>
          <div class="table_list_box">
          <table border="0" cellspacing="0" cellpadding="0" class="table_list_table">
             <tr class="table_list_th">
               <td class="table_list_tr">模板描述</td>
               <td class="table_list_tr" style="display:none">使用状态</td>
               <td class="table_list_tr">发布状态</td>
               <td class="table_list_tr">操作</td>
             </tr>
            
            <s:iterator value="pages" status="stat">
				<tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
					<td align="center" width="20%">
						<s:property value="tmDesc" />
					</td>
					<td nowrap="nowrap" width="15%" style="display:none">
						<s:if test="tmStatus==0">
							未使用
						 </s:if>
						 <s:elseif test="tmStatus==1">
							使用中
						 </s:elseif>
					</td>
					<td nowrap="nowrap" width="15%">
						<s:if test="tmIsPublish==0">
							未发布
						 </s:if>
						 <s:elseif test="tmIsPublish==1">
							已发布
						 </s:elseif>
					</td>
					<td nowrap="nowrap" width="10%">
                   		<a href="javascript:edit('<s:property value="tmId"/>','<s:property value="tmUuid"/>')">编辑</a>&nbsp;&nbsp;
                   		<!-- <a href="javascript:start('<s:property value="tmUuid" />')">停用</a>&nbsp;&nbsp; -->
                   		<a href="javascript:publish('<s:property value="tmUuid" />')">发布</a>&nbsp;&nbsp;
                   		<!-- <a href="javascript:start('<s:property value="tmUuid" />')">启用</a>&nbsp;&nbsp; -->
                   		<a href="javascript:del('<s:property value="tmUuid" />')">删除</a>
					</td>
				</tr>
			</s:iterator>
			<tr class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
               <td colspan="9" class="page">
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
          <div style="font-size: 12px; margin-left: 15px;">
          <p>温馨提示：</p>
          <p>1、系统会提供几套默认模板，您可以根据系统提供的默认模板进行编辑，也可以自定义编辑 </p>
          <p>2、点击新增或编辑默认模板进入广告编辑页面，编辑完成后返回当前页面，点击发布后，访客用户才可以看到新发布的模板， 编辑后不发布，只会显示编辑前的模板内容。</p>
          <p>3、操作顺序：<font color="red">“编辑---发布”</font>。</p>
          <p>4、同一时间只能发布一个模板。</p>
          <p>5、<font color="red">上传的图片大小不能超过500KB</font></p>
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
<script language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>

<script type="text/javascript">
  $(function() {
	<s:if test="message != null">
       alert('<s:property value="message"/>');
     </s:if>
  })
</script>
</body>
</html>
