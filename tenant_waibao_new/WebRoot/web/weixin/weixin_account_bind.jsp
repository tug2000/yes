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
<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.config.js"></script>  
<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.all.min.js"></script>  
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>	
<script type="text/javascript" src="<%=basePath%>js/Math.uuid.js"></script>	
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>
<script type="text/javascript">

//初始化
function init(){
	var obj = $("#accountTypeRadio");
	
	<s:if test="weixinAccount.accountType==0">
		accoutTypeChang(obj, 0);
		$(obj).attr("checked","checked");
	</s:if>
	<s:elseif test="weixinAccount.accountType==1">
		accoutTypeChang(obj, 1);
		$(obj).next().attr("checked","checked");
	</s:elseif>
}

//微信账号类型切换
function accoutTypeChang(obj, id){
	var trObjs = $(obj).parent().parent().parent().find("tr");
	for(var i=0; i<trObjs.length; i++){
		if(id=="0"){
			if(i==3 || i==4){
				$(trObjs.get(i)).css("display","none");
			}
			if(i==5){
				var inputObjs = $(trObjs.get(i)).find("input");
				$(inputObjs.get(1)).css("display","none");
			}
		}else{
			if(i==3 || i==4){
				$(trObjs.get(i)).css("display","");
			}
		}
   	}
}

//保存账号绑定结果
function saveAccountBind(){
		var defaultRadio = document.getElementById("accountTypeRadio");
		var accountType = 0;
		if(!defaultRadio.checked){
			if(!checkBindForm()){
   	   	   	return;
   	   	}

			accountType = 1;
	   	}  	   	   	   	

	   	var appId = $.trim($("#txt_AppId_id").val());
	   	var appSecret = $.trim($("#txt_AppSecret_id").val());
	   	
	$.ajax({
   		url:'<%=basePath%>weixinManage/weixinManage!saveAccountBind.action',
   		data:{'accountType':accountType, 'appId':appId, 'appSecret':appSecret},
   		type:'post',
   		datatype:"text",
   		success:function(data){
   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
   	   		 	return;
   	   		} 
   	   		
   			alert(data);
   		}
   		
   	});
}

//输入校验
function checkBindForm(){
	   	var flag = true;
	   	var appidObj = $("#txt_AppId_id");
		var tmp = $(appidObj).next("img");
	   	if(""==$(appidObj).val()){
	   		flag = false;  

   	   	if(!tmp[0]){
   	   	   	var span = createSpanTip($(appidObj).attr("msg"));
   	   		$(appidObj).after(span);
   	   	}	   		  	   	   	
	   	}else{
   	   	if(tmp[0]){
   	   		$(tmp[0]).next().remove();
   	   		$(tmp[0]).remove();
   	   	}
	   	} 	   	
	 	

	 	var appSecretObj = $("#txt_AppSecret_id");
	 	tmp = $(appSecretObj).next("img");
	   	if(""==$(appSecretObj).val()){
	   		flag = false;
	   		
		   	if(!tmp[0]){
		   	   	span = createSpanTip($(appSecretObj).attr("msg"));
		   		$(appSecretObj).after(span);
			}
	   	}else{
	   		if(tmp[0]){
	   			$(tmp[0]).next().remove();
	   			$(tmp[0]).remove();
	   	   	}
		}

   	return flag;

}

//校验提示SPAN
function createSpanTip(msg){
	var span = "<img src=\"<%=basePath%>images/ico_prompt.gif\" align=\"absmiddle\" />&nbsp;<span>*"+msg+"</span>";
	return span;
}

</script>
</head>
<title>微信账号绑定</title>
<body onload="init()">
<form id="searchFrm" name="searchFrm" action="<%=basePath%>weixinManage/weixinManage!list.action" method="post">
<div style="height:10px;"></div>
  
  <table border="0" cellspacing="0" cellpadding="0" style="width:100%">
	<tr>
		<td class="table_b_a"></td>
		<td valign="top" class="table_b_b">
			<table class="add_table" border="0" cellspacing="0"
				cellpadding="0">
				<tr class="add_table_tr"
					onMouseOver="this.className='add_table_tr_over'"
					onMouseOut="this.className='add_table_tr'">
					<td class="add_table_left">
						账号类型:
					</td>
					<td class="add_table_right">
						<input type="radio" value="0" id="accountTypeRadio" onclick="accoutTypeChang(this,0)" name ="ans" checked />订阅号&nbsp;&nbsp;
						<input type="radio" value="1" onclick="accoutTypeChang(this,1)" name ="ans" />服务号&nbsp;&nbsp;
					</td>
				</tr>								
				<tr class="add_table_tr"
					onMouseOver="this.className='add_table_tr_over'"
					onMouseOut="this.className='add_table_tr'">
					<td class="add_table_left">
						URL:
					</td>
					<td class="add_table_right">
						<s:property value="url" />
					</td>
				</tr>
				<tr class="add_table_tr"
					onMouseOver="this.className='add_table_tr_over'"
					onMouseOut="this.className='add_table_tr'">
					<td class="add_table_left">
						Token:
					</td>
					<td class="add_table_right" >
						<s:property value="token" />
					</td>
				</tr>
				<tr class="add_table_tr" style="display: none;"
					onMouseOver="this.className='add_table_tr_over'"
					onMouseOut="this.className='add_table_tr'">
					<td class="add_table_left">
						AppId:
					</td>
					<td class="add_table_right" >
						<input id="txt_AppId_id" type="text" value="<s:property value="weixinAccount.appId" />" class="add_input" dataType="Require" msg="AppId不能为空!" />	
					</td>
				</tr>
				<tr class="add_table_tr" style="display: none;"
					onMouseOver="this.className='add_table_tr_over'"
					onMouseOut="this.className='add_table_tr'">
					<td class="add_table_left">
						AppSecret:
					</td>
					<td class="add_table_right" >
						<input id="txt_AppSecret_id"  type="text" value="<s:property value="weixinAccount.appSecret" />" class="add_input" dataType="Require" msg="AppSecret不能为空!" />	
					</td>
				</tr>
				<tr>
					<td colspan="2" class="add_btn">
						<input type="button" onClick="saveAccountBind();" class="btn5" value="保存" />&nbsp;&nbsp;					    
					</td>
				</tr>
			</table>
		</td>
		<td class="table_b_c"></td>
	</tr>
  </table>
  
  <div style="font-size: 12px; margin-left: 20px;margin-top:30px;">
  <p>温馨提示：</p>
  <p>1、微信公众号有2种类型：订阅号 和 服务号。请根据您申请的微信类型进行绑定。 </p>
  <p>2、URL和Token：用于与腾讯微信的对接配置。请登录腾讯微信管理后台，开启开发模式，将这里的URL和Token填到腾讯微信后台的对应URL和Token上。</p>
  <p>3、AppId和AppSecret：是服务号创建自定义菜单的令牌。请登录腾讯微信管理后台，找到腾讯微信提供的AppId和AppSecret，将其填到这里的AppId和AppSecret输入框上。</p>
  <p>4、腾讯微信管理后台地址：https://mp.weixin.qq.com/ </p>
  </div>

</div>

</body>
</html>
