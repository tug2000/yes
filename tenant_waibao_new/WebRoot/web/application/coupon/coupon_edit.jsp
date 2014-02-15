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
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>	
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>
<script language="javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>web/application/coupon/css/coupon.css" rel="stylesheet" type="text/css" />
</head>
<title>点券管理</title>
<script type="text/javascript">

	function MM_swapImgRestore() { //v3.0
	  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
	}
	function MM_preloadImages() { //v3.0
	  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
	}

	function MM_findObj(n, d) { //v4.01
	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && d.getElementById) x=d.getElementById(n); return x;
	}

	function MM_swapImage() { //v3.0
	  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
	}

	$(document).ready(function(){
	     init();
	});

	//初始化
	function init(){	
		<s:if test="unit != null">
			$("#select_unit").val('<s:property value="unit"/>');
		</s:if>

		<s:if test="publishSum != null">
			$("#select_publishsum").val('<s:property value="publishSum"/>');
		</s:if>

		<s:if test="userLimit != null">
			$("#select_userlimit").val('<s:property value="userLimit"/>');
		</s:if>
		
	}

	//上传图片
	function ajaxupload(obj, value) {
   		if(value == null || value == '') {
   		   return;
   	    }
    	   
   		if(!isImage(value)) {
   		   alert('不支持上传该图片类型!');
   		   return;
   	    }
   	 
   	   $(obj).next().val(value);  	
   	   var form = $(obj).parent();
   	   $(form).attr("action","<%=basePath%>couponManage/couponEdit!doUploadImage.action");
   	   $(form).ajaxSubmit(function(data) {   
   		   $("#img_id").attr("src", "${imgServerPath}"+data); 
   		   $("#img_path").val(data);
		   $("#input_single_pic").replaceWith("<input onchange=\"ajaxupload(this, this.value);\" id =\"input_single_pic\" class=\"pic_upload\" type=\"file\" name=\"upload\">");
   			
   	    });
   	}

	//同步规则说明
   	function syncRuleDesc(obj){
   		var patrn = /^[1-9]\d*$/;
		if (!patrn.exec(obj.value)) {
			obj.value = "";
		}else{
			$("#ruleDesc").val("满"+obj.value+$("#span_desc").html());
		}
   	}

   	//同步产品单位
   	function syncUnit(){
   	   	var unit = $("#select_unit").val();
   	   	$("#span_desc").html(unit + "，免费兑换 1" + unit);
   	}

	//保存编辑
	function saveEdit(){
		var couponId;
		var couponName;
		var imgPath;
		var unit;
		var exchangeSum;
		var ruleDesc;
		var publishSum;
		var userLimit;
		var startTime;
		var endTime;

		couponId = $("#couponId").val();
		couponName = $("#couponName").val();
		imgPath = $("#img_path").val();
		unit = $("#select_unit").val();
		exchangeSum = $("#exchangeSum").val();
		ruleDesc = $("#ruleDesc").val();
		publishSum = $("#select_publishsum").val();
		userLimit = $("#select_userlimit").val();
		startTime = $("#startTime").val();
		endTime = $("#endTime").val();

		if(""==$.trim(couponName)){
   	   	    alert('请填写产品名称！');
   	   	    return;
   	   	}

		if(""==$.trim(imgPath)){
   	   	    alert('请上传产品图片！');
   	   	    return;
   	   	}

		if(""==$.trim(unit)){
   	   	    alert('请选择产品单位！');
   	   	    return;
   	   	}

		if(""==$.trim(exchangeSum)){
   	   	    alert('请填写兑换规则！');
   	   	    return;
   	   	}

		if(""==$.trim(ruleDesc)){
   	   	    alert('请填写规则说明！');
   	   	    return;
   	   	}

		if(""==$.trim(publishSum)){
   	   	    alert('请选择发行张数！');
   	   	    return;
   	   	}

		if(""==$.trim(userLimit)){
   	   	    alert('请选择用户限用！');
   	   	    return;
   	   	}

		if(""==$.trim(startTime)){
   	   	    alert('请填写有效期起始时间！');
   	   	    return;
   	   	}

		if(""==$.trim(endTime)){
   	   	    alert('请填写有效期截止时间！');
   	   	    return;
   	   	}

		
		$.ajax({
	   		url:'<%=basePath%>couponManage/couponEdit!saveCouponEdit.action',
	   		data:{'couponId':couponId, 'couponName':couponName, 'imgPath':imgPath, 'unit':unit, 'exchangeSum':exchangeSum, 'ruleDesc':ruleDesc, 'publishSum':publishSum, 'userLimit':userLimit, 'startTime':startTime, 'endTime':endTime},
	   		type:'post',
	   		datatype:"text",
	   		success:function(data){
	   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
	   	   		 	return;
	   	   		}
	   	   		
		   		alert(data);
		   		if($.trim(data)=="保存成功！"){
		   			$("#return_id").click();
			   	}
	   		}
	   		
	   	});  
	}

</script>
<body onload="MM_preloadImages('<%=basePath%>web/application/coupon/images/tc_02a.gif')">
  <input id="couponId" value='<s:property value="couponId" />' type="hidden" />
  <div class="happ_win_cn">
  <table width="100%" border="0" cellspacing="12" cellpadding="0" class="happ_win04">
  <tr>
    <td align="right" class="happ_win_tit2">产品名称：</td>
    <td><input type="text" class="happ_ip01" value='<s:property value="couponName" />' id="couponName" size="50" /></td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2"> 产品图片：</td>
    <td><form method="post" action="" enctype="multipart/form-data">  
    
     <s:if test="imgPath != null">
		<img id="img_id" src='${imgServerPath}<s:property value="imgPath" />' width="120" height="80" />
	 </s:if>
	 <s:else>
		<img id="img_id" src="" width="120" height="80" />
	 </s:else>
               	
        <input type="button" class="btn4" value="选择图片"/>
       	<input onchange="ajaxupload(this, this.value);" id ="input_single_pic" class="pic_upload" type="file" name="upload">
       	<input name="uploadFileName" value="" type="hidden" />
       	  建议大小:宽480*高320 
       	 <input id="img_path" value='<s:property value="imgPath" />' type="hidden" />
    </form>
     </td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">产品单位：</td>
    <td><select id="select_unit" class="happ_ip01" onchange="syncUnit()">
      <option value="杯">杯</option>
      <option value="个">个</option>
      <option value="条">条</option>
      <option value="克">克</option>
      <option value="两">两</option>
      <option value="斤">斤</option>
    </select></td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">兑换规则：</td>
    <td>满  
      <input type="text" onkeyup="syncRuleDesc(this)" class="happ_ip01" id="exchangeSum" value='<s:property value="exchangeSum" />' size="6" />
     <span id="span_desc"> 杯，免费兑换 1杯</span></td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">规则说明：</td>
    <td><input type="text" class="happ_ip01" id="ruleDesc" value='<s:property value="ruleDesc" />' size="50" /></td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">发行张数：</td>
    <td><select id="select_publishsum" class="happ_ip01">
      <option value="10000000" selected="selected">不限制</option>
      <option value="100">100</option>
      <option value="200">200</option>
      <option value="500">500</option>
      <option value="1000">1000</option>
      <option value="10000">10000</option>
      <option value="20000">20000</option>
      <option value="100000">100000</option>
    </select> 
      张
</td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">每用户限用：</td>
    <td><label for="select"></label>
      <select id="select_userlimit" class="happ_ip01">
        <option value="0" selected="selected">不限制</option>
        <option value="1">兑换1次</option>
        <option value="2">兑换2次</option>
        <option value="3">兑换3次</option>
      </select></td>
  </tr>
  <tr>
    <td align="right" class="happ_win_tit2">有效期：</td>
    <td>
    <input id="startTime" name="startTime" type="text" 
                			value='<s:property value="startTime" />' style="width:160px"
							class="happ_ip01" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							ondblclick="this.value=''" readonly="readonly" />
      至
        <input id="endTime" name="endTime" type="text" 
                			value='<s:property value="endTime" />' style="width:160px"
							class="happ_ip01" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							ondblclick="this.value=''" readonly="readonly"/></td>
  </tr>
</table>

  </div>
  <div class="tc_bnt02">
    <input onclick="saveEdit()" type="button" class="btn1" value="保存" />
  </div>
  
  <a style="display: none" href="<%=basePath%>couponManage/couponManage!showList.action" target="main_Frame"><span id="return_id"></span></a>
</body>
</html>
