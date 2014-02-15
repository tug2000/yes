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
<link rel="stylesheet" type="text/css" href="<%=basePath%>ueditor/themes/default/ueditor.css"/> 
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/editor_config.js"></script>  
<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/editor_all_min.js"></script>  
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>	
<script type="text/javascript" src="<%=basePath%>js/Math.uuid.js"></script>	
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>
<style type="text/css">
 .table_top {margin-top:8px;}
 .mask {   
        background-color:#333;
        position:absolute;
        top:0px;
        left:0px;
        filter: Alpha(Opacity=60);
    } 
 
</style>
</head>
<title>微信基本配置</title>
<script type="text/javascript">

	var editor1;
	var editor2;
	$(document).ready(function(){
	     editor1 = new baidu.editor.ui.Editor();  
	     editor2 = new baidu.editor.ui.Editor();  
	     editor1.render('newscontent1');  
	     editor2.render('newscontent2');  
	     editor2.addListener("selectionchange", 
	    	    function(){
	    	 		var inputObjs = $("#"+cur_PT_Id).find("input");
	    	 		$(inputObjs.get(0)).val(editor2.getContent());
				} 
	     );

	     init();
	});

	function init(){
		MM_preloadImages('<%=basePath%>images/tc_02.gif');
		MM_preloadImages('<%=basePath%>images/bj_4a.gif','<%=basePath%>images/bj_5a.gif');
		var obj = $("#accountTypeRadio");
		
		<s:if test="weixinAccount.accountType==0">
			accoutTypeChang(obj, 0);
			$(obj).attr("checked","checked");
		</s:if>
		<s:elseif test="weixinAccount.accountType==1">
			accoutTypeChang(obj, 1);
			$(obj).next().attr("checked","checked");
		</s:elseif>

		<s:if test="weixinAccount.replyType==0">
			changeTab($("#concern_a_text"), 0);		
		</s:if>
		<s:else>
			changeTab($("#concern_a_pt"), 1);		
		</s:else>

		<s:if test="weixinAccount.waId==''">
			$("#concernPanel").css("display","none"); 	
			$("#keyPanel").css("display","none");
		</s:if>

		
	}

	var concern_tab_id = 0;
	function changeTab(obj, id){
		var divObjs = $(obj).parent().parent().find("div");
		for(var i=0; i<divObjs.length; i++){
			$(divObjs.get(i)).removeClass("tab1");
			$(divObjs.get(i)).addClass("tab2");
	   	}

		$(obj).parent().attr("class","tab1");

		if(id==0){
			$("#welcomeTxtDiv").css("display","block"); 	
			$("#welcomePicMuxDiv").css("display","none"); 	
			concern_tab_id = 0;
			
		}else{
			$("#welcomeTxtDiv").css("display","none"); 	
			$("#welcomePicMuxDiv").css("display","block"); 	
			concern_tab_id = 1;

		}
	}

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
				if(i==5){
					var inputObjs = $(trObjs.get(i)).find("input");
					<s:if test="weixinAccount.accountType==1">
						$(inputObjs.get(1)).css("display","");
					</s:if>
				}
			}
	   	}
	}

	var pt_tab_index = 0;
	function changePt(obj, id){
		var divObjs = $(obj).parent().parent().find("div");
		for(var i=0; i<divObjs.length; i++){
			$(divObjs.get(i)).removeClass("tc_bnt03");
			$(divObjs.get(i)).addClass("tc_bnt01");
	   	}

		$(obj).parent().attr("class","tc_bnt03");

		if(id==0){
			$("#singlePicTxt").css("display","block"); 	
			$("#multiPicTxt").css("display","none");
			pt_tab_index = 0; 	
		}else{
			$("#singlePicTxt").css("display","none"); 	
			$("#multiPicTxt").css("display","block"); 	
			pt_tab_index = 1;
		}
	}

	function toAddRule(id){
		if(id==""){
			document.getElementById('searchFrm').action = "<%=basePath%>weixinManage/weixinManage!addRule.action";
		}else{
			document.getElementById('searchFrm').action = "<%=basePath%>weixinManage/weixinManage!addRule.action?ruleId=" + id;
		}
		
		document.getElementById('searchFrm').submit();
	}

	function toEditMenu(){
		document.getElementById('searchFrm').action = "<%=basePath%>weixinManage/weixinManage!customMenus.action";
		document.getElementById('searchFrm').submit();
	}


	function addMenuItem(){
		var tr = "<tr class=\"table_list_td\" onMouseOver=\"this.className='table_list_td_over'\" onMouseOut=\"this.className='table_list_td'\"><td align=\"center\" width=\"20%\"><input type=\"text\" /></td><td nowrap=\"nowrap\" width=\"15%\"></td><td nowrap=\"nowrap\" width=\"10%\"><a href=\"#\">保存</a></td></tr>";
		$("#customMenuTable tr:last-child").after(tr);
	}

	var multi_pt_index = 3;
	var multi_pt_count = 2;
	function addNewPt(obj){
		if(multi_pt_count>=8){
			alert("多图文最多不能超过8个！");
			return;
		}
		
		var tr = "<div id=\"multi_pt_" + multi_pt_index;
		tr += "\" class=\"bj_n\" onmouseover=\"displayEditMask(this,1)\" onmouseout=\"displayEditMask(this,2)\"><div class=\"bj_ico1\" style=\"display: none;\"><a onclick=\"changePosition(this);\" onmouseout=\"MM_swapImgRestore()\" onmouseover=\"MM_swapImage('Image3','','<%=basePath%>images/bj_4a.gif',1)\">";
		tr += "<img src=\"<%=basePath%>images/bj_4.gif\" width=\"33\" height=\"33\" id=\"Image3\" /></a><a onclick=\"delPt(this)\" onmouseout=\"MM_swapImgRestore()\" onmouseover=\"MM_swapImage('Image4','','<%=basePath%>images/bj_5a.gif',1)\"><img src=\"<%=basePath%>images/bj_5.gif\" width=\"33\" height=\"33\" id=\"Image4\" /></a></div>";
		tr += "<div class=\"bj_n1\"><span name=\"title\" class=\"spanwrap\" style=\"width:236px;height:80px;\">标题</span></div><div class=\"bj_n2\"><span name=\"pic\">缩略图</span><img src=\"\" style=\"display: none;\"></img></div><input type=\"hidden\" value=\"\"/></div>";
		$(obj).parent().before(tr);
		
		multi_pt_index++;
		multi_pt_count++;
	}

	function delPt(obj){
		var div = $(obj).parent().parent();
		var nextdiv = $(div).next();
		if(multi_pt_count < 3){
			alert("不能删除，多图文最少要2个图文！");
			return;
		}
		
		var title = $(div).find("span[name='title']").first().html();
		if(""!=title && "标题"!=title && "图片标题"!=title && !confirm("确定要删除？")){
			return;			
		}
		
		$(div).remove();
		multi_pt_count--;

		// 调整编辑框位置
		var aObj;
		if(cur_PT_Id!=$(div).attr("id")){//删的是当前编辑图文
			aObj = $("#"+cur_PT_Id).find("a").first();
			$(aObj).click();
		}else{
			if($(nextdiv).attr("id")){
				aObj = $(nextdiv).find("a").first();
				$(aObj).click();
			}else{
				$("#firstPt").click();
			}
		}
		
	}

	function popupDiv(div_id) {   
        var div_obj = $("#"+div_id);  
        var windowWidth = document.body.clientWidth;       
        var windowHeight = document.body.clientHeight;  
        var popupHeight = div_obj.height();       
        var popupWidth = div_obj.width();    
        //添加并显示遮罩层   
        $("<div id='mask'></div>").addClass("mask")   
                                  .width(windowWidth)   
                                  .height(windowHeight + document.body.scrollHeight)   
                                  .appendTo("body")   
                                  .fadeIn(200);   
        div_obj.css({"position": "absolute"})   
               .animate({left: windowWidth*0.5-popupWidth*0.5,    
                         top: windowHeight*0.5-popupHeight*0.5, opacity: "show" }, "slow");   
                        
    }   
      
    function hideDiv(div_id) {   
        $("#mask").remove();   
        $("#" + div_id).animate({left: 0, top: 0, opacity: "hide" }, "slow");   
    }  

    var cur_PT_Id = "multi_pt_1";;
    function changePosition(obj)  
	 {  
	   	var hel = $(obj).parent().parent().offset().top;
	   	var base =  $("#previewDiv2").offset().top;
	   	$("#editDiv2").css("margin-top",(hel-base)+"px"); 
	   	var parentDiv = $(obj).parent().parent();
	   	cur_PT_Id = $(parentDiv).attr("id");

	   	var picTipObj = $("#editDiv2").find("span").first();
	   	if(cur_PT_Id == "multi_pt_1"){
	   		picTipObj.html("（大图片建议尺寸：360像素 * 200像素，大小不超过500K）");
		}else{
			picTipObj.html("（小图片建议尺寸：200像素 * 200像素，大小不超过500K）");
		}

	   	var spanObjs = $(parentDiv).find("span[name='title']");
	   	var title = $(spanObjs.get(0)).html();
	   	if(title=="标题" || title=="图片标题"){
			$("#multi_input_title").val("");		   	
		}else{
			$("#multi_input_title").val(title);
		}
	   	editor2.setContent($(parentDiv).find("input").first().val());
	 } 

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

   	function displayEditMask(obj, flag){
   		var divObjs = $(obj).find("div");
   		if(flag=="1"){
   			$(divObjs.get(0)).css("display","block");
   	   	}else{
   	   		$(divObjs.get(0)).css("display","none");
   	   	} 		
   	}

   	function checkBindForm(){
   	   	var flag = true;
   	   	var appidObj = $("#txt_AppId_id");
   		var tmp = $(appidObj).next("span");
   	   	if(""==$(appidObj).val()){
   	   		flag = false;  

	   	   	if(!tmp[0]){
	   	   	   	var span = createSpanTip($(appidObj).attr("msg"));
	   	   		$(appidObj).after(span);
	   	   	}	   		  	   	   	
   	   	}else{
	   	   	if(tmp[0]){
	   	   		$(tmp[0]).remove();
	   	   	}
   	   	} 	   	
   	 	

   	 	var appSecretObj = $("#txt_AppSecret_id");
   	 	tmp = $(appSecretObj).next("span");
	   	if(""==$(appSecretObj).val()){
	   		flag = false;
	   		
		   	if(!tmp[0]){
		   	   	span = createSpanTip($(appSecretObj).attr("msg"));
		   		$(appSecretObj).after(span);
			}
	   	}else{
	   		if(tmp[0]){
	   			$(tmp[0]).remove();
	   	   	}
		}

	   	return flag;

   	}

   	function createSpanTip(msg){
   		var span = "&nbsp;&nbsp;<span style=\"color: red;\">*"+msg+"</span>";
   		return span;
   	}

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
	   			alert(data);
	   			window.location.href = "<%=basePath%>weixinManage/weixinManage!list.action";
	   		}
	   		
	   	});
   	}

   	function saveConcernReply(){
   	   	var replyType = concern_tab_id + pt_tab_index;
   	   	var replyText = $.trim($("#welcomeTxt").val());
   	   	var replyPtId = $("#welcomePicMuxDiv").find("input").first().val();
   	 	var tmp = $("#welcomeTxt").next("span");
   	   	if(concern_tab_id==0 && replyText==""){  
	   	   	if(!tmp[0]){
		   	   	var span = createSpanTip($("#welcomeTxt").attr("msg"));
		   	 	$("#welcomeTxt").after(span);
			}
			return;
   	   	}else{
	   	   	if(tmp[0]){
		   	 	$(tmp[0]).remove();
			}
   	   	}

   	 	tmp = $("#welcomePicMuxSpan").next("span");	
   	 	if(concern_tab_id==1 && replyPtId==""){ 
	   	 	if(!tmp[0]){
		   	   	var span = createSpanTip("回复图文不能为空！");
		   	 	$("#welcomePicMuxSpan").after(span);				   	 	
			}
	   	 	return;	
   	   	}else{
	   	   	if(tmp[0]){
		   	 	$(tmp[0]).remove();
			}
   	   	}
   	   	
   		$.ajax({
	   		url:'<%=basePath%>weixinManage/weixinManage!saveConcernReply.action',
	   		data:{'replyType':replyType, 'replyText':replyText, 'replyPtId':replyPtId},
	   		type:'post',
	   		datatype:"text",
	   		success:function(data){
	   			alert(data);
	   		}
	   		
	   	});
   	}

   	function syncSinglePtTitle(obj){
   	   	$("#singlePtTitle").html($(obj).val());
   	}

   	function syncMultiPtTitle(obj){
   	   	var div = $("#"+cur_PT_Id);
   	   	var spanObjs = $(div).find("span[name='title']");
   	   	$(spanObjs.get(0)).html($(obj).val());
   	}

	function syncSinglePtDesc(obj){
   	   	$("#singlePtDesc").html($(obj).val());
   	}

   	function ajaxupload(obj, value, flag) {
   		if(value == null || value == '') {
   		   return;
   	    }
    	   
   		if(!isImage(value)) {
   		   alert('不支持上传该图片类型!');
   		   return;
   	   }
	 
   	   $(obj).next().val(value);  	
   	   var form = $(obj).parent().parent();
   	   $(form).attr("action","<%=basePath%>weixinManage/weixinManage!doUploadImage.action");
   	   $(form).ajaxSubmit(function(data) { 
   			if(!data.toString().indexOf("upload")==0){
	   		   alert(data);
	   		   return;
	   	   }
	   	   
   	   	   var div;
   	   	   if(flag==1){
   	   			div = $("#previewDiv1");
   	   	   }else{
   	   			div = $("#"+cur_PT_Id);
   	   	   }

   	   	   var spanObjs = $(div).find("span[name='pic']");
   		   $(spanObjs.get(0)).css("display","none"); 
   		   var imgObj = $(spanObjs.get(0)).next();
   		   $(imgObj).css("display","block");
   		   $(imgObj).attr("src", "../"+data);  

	   		if(flag==1){
				$("#input_single_pic").replaceWith("<input onchange=\"ajaxupload(this, this.value, 1);\" id =\"input_single_pic\" class=\"pic_upload\" type=\"file\" name=\"upload\">");
	   		}else{
	   			$("#input_multi_pic").replaceWith("<input onchange=\"ajaxupload(this, this.value, 2);\" id =\"input_multi_pic\" class=\"pic_upload\" type=\"file\" name=\"upload\">");
	   	   	}
   			
   	    });
   	}


   	function savePt(){
   	   	var ptType;
   	   	var title;
   	   	var imgPath;
   	   	var index=1;
   	   	var linkType=0;
   	   	var content;
   	   	var uuid ="";
   	   	var description="";
   	 	var div;
   	 	var aObj = $("#welcomePicMuxDiv").find("a").first();
	   	var json = "[";

   	 	uuid = $(aObj).next().val();
   	 	if("" == uuid){
   	 		uuid = Math.uuid();
   	   	}
   	 	
   	   	if(pt_tab_index==0){
   	   		div = $("#previewDiv1");
   	   		description=$("#descriptionTxt").val();
   	   		ptType = 0;
   	   		title = $(div).find("span[name='title']").first().html();
   	   	    imgPath = $(div).find("img").first().attr("src");
   	   	    content = editor1.getContent();

   	   	    if(""==$.trim(title) || "标题"==title){
   	   	   	    alert('请填写标题！');
   	   	   	    return;
   	   	   	}
   	   	   	
   	   		if(""==imgPath){
	   	   	    alert('请上传封面图片！');
	   	   	    return;
	   	   	}

	   	   	if(""==content || "<p></p>"==content){
	   	   	    alert('请填写文章内容！');
	   	   	    return;
	   	   	}

	   	 	imgPath = imgPath.replace(new RegExp("\r\n","gm"),"");

	   	 	json += "{";
		   	json +="\"ptType\":\""+ptType+"\"";
   	   		json +=",\"uuid\":\""+uuid+"\"";
   	   		json +=",\"index\":\""+index+"\"";
   	   		json +=",\"title\":\""+$.trim(title)+"\"";
   	   		json +=",\"imgPath\":\""+imgPath+"\"";
   	   		json +=",\"linkType\":\""+linkType+"\"";
   	   		json +=",\"description\":\""+valueReplace(description)+"\"";
   	   		json +=",\"content\":\""+valueReplace(content)+"\"";   	   		
   	   		json += "}";

   	   	    $(aObj).html("单图文");
   	   	    
   	   	}else{
   	   		ptType = 1;
   	   		description = "";
   	   	   	var divObjs = $("#previewDiv2 > div");
   	   		for(var i=0; i<divObjs.length-1; i++){
	   	   		if(i>0){
		   			json += ",";
		   	   	}
	   	   	
	   	 		json += "{";
   	   	   		
   	   			div = divObjs.get(i);
   	   	   		title = $(div).find("span[name='title']").first().html();
   	   	   	    imgPath = $(div).find("img").last().attr("src");
   	   	   	    content = $(div).find("input").first().val();

		   	   	  if(""==$.trim(title) || "标题"==title || "图片标题"==title){
		 	   	   	    alert('请填写图文【'+(i+1)+'】的标题！');
		 	   	   	    return;
		 	   	   	}
		 	   	   	
		 	   		if(""==imgPath){
		 	   			alert('请上传图文【'+(i+1)+'】的封面图片！');
			   	   	    return;
			   	   	}
		
			   	   	if(""==content || "<p></p>"==content){
		 	   			alert('请填写图文【'+(i+1)+'】的文章内容！');				   	   	
			   	   	    return;
			   	   	}

			   	imgPath = imgPath.replace(new RegExp("\r\n","gm"),"");
			   	 
			   	json +="\"ptType\":\""+ptType+"\"";
	   	   		json +=",\"uuid\":\""+uuid+"\"";
	   	   		json +=",\"index\":\""+index+"\"";
	   	   		json +=",\"title\":\""+$.trim(title)+"\"";
	   	   		json +=",\"imgPath\":\""+imgPath+"\"";
	   	   		json +=",\"linkType\":\""+linkType+"\"";
	   	   		json +=",\"description\":\""+valueReplace(description)+"\"";
	   	   		json +=",\"content\":\""+valueReplace(content)+"\"";   	   		
	   	   		json += "}";

   	   	  		index++;
   	   	   	}

   	   		$(aObj).html("多图文");	   	   	
   	   	}

   	   	json += "]";
   	 	ajaxJsonSubmit(json);
   	 	$(aObj).next().val(uuid);

   	 	hideDiv("dialogDiv");
   	   	
   	}

   	function valueReplace(v){
   		v=v.toString().replace(new RegExp('(["\"])', 'g'),"\\\"");
   		return v;
   	}
   		   	
   	function ajaxJsonSubmit(json){
   		$.ajax({
	   		url:'<%=basePath%>weixinManage/weixinManage!savePicText.action',
	   		data:{'json':json},
	   		type:'post',
	   		datatype:"text",
	   		success:function(data){
	
	   		}   		
	   	});  
   	}

   	function delRule(id){
   	   	if(confirm("确定要删除？")){
	   	   	$.ajax({
		   		url:'<%=basePath%>weixinManage/weixinManage!delRule.action',
		   		data:{'id':id},
		   		type:'post',
		   		datatype:"text",
		   		success:function(data){
			   		//alert(data);
			   		window.location.href = "<%=basePath%>weixinManage/weixinManage!list.action";
		   		}	   		
		   	});  	   	    
   	   	}	
   	}

   	function goUrl(pageIndex){
        searchFrm.currPage.value = pageIndex;
  	  	searchFrm.submit();
    }

   	function loadPicTexts(obj){
   	   	var groupId = $(obj).next().val();
   	   	if("" == groupId){
   	   	   	alert("图文为空！");
   	   	   	return;
   	   	}

	   	 $.ajax({
		   		url:'<%=basePath%>weixinManage/weixinManage!getPicTests.action',
		   		data:{'groupId':groupId},
		   		type:'post',
		   		datatype:"text",
		   		success:function(data){			   		
			   		var dataObj=eval("("+data+")");

			   		var div;
			   		if(dataObj.length==1){

			   			changePt($("#tab_pt_single"),0);
			   			div = $("#previewDiv1");
			   			$.each(dataObj,function(idx,item){ 
			   				var spanObjs = $(div).find("span[name='pic']");
			   	   		    $(spanObjs.get(0)).css("display","none"); 
			   	   		    var imgObj = $(spanObjs.get(0)).next();
			   	   		    $(imgObj).css("display","block");
				   				   				
			   	   	   		$(div).find("span[name='title']").first().html(item.title);
			   	   	  		$(div).find("span[name='desc']").first().html(item.description);
			   	   	  		$("#descriptionTxt").val(item.description);
			   	   	  		$(imgObj).attr("src", item.imgPath);
			   	   	   	    editor1.setContent(item.linkArticle);
			   	   	   	    $("#single_input_title").val(item.title);
			   				});
				   	}else{
				   		changePt($("#tab_pt_multi"),1);
				   		
				   		var divObjs = $("#previewDiv2 > div");
				   		$.each(dataObj,function(idx,item){ 
				   			div = divObjs.get(idx);
			   				var spanObjs = $(div).find("span[name='pic']");
			   	   		    $(spanObjs.get(0)).css("display","none"); 
			   	   		    var imgObj = $(spanObjs.get(0)).next();
			   	   		    $(imgObj).css("display","block");
				   				   				
			   	   	   		$(div).find("span[name='title']").first().html(item.title);
			   	   	  		$(imgObj).attr("src", item.imgPath);
			   	   	  		$(div).find("input").first().val(item.linkArticle);
			   			});
				   	
					}
			   			   		
			   		 
		   		}	   		
		   	}); 
	
	   	 popupDiv("dialogDiv"); 
   	   	
	}

   	function showDescription(obj){
		$(obj).parent().css("display","none");
		$(obj).parent().next().css("display","inline");
	}
   	   	
	 
</script>
<body class="content_bj" >
<form id="searchFrm" name="searchFrm" action="<%=basePath%>weixinManage/weixinManage!list.action" method="post">
<input type="hidden" name="currPage" value="0" />
<div class="taole_h7"><img src="<%=basePath%>images/blank.gif" /></div><span style="color: red;"></span>
<div class="table_box" valign="top">
  <div class="table_a">
    <div class="table_a_a"><img src="<%=basePath%>images/blank.gif" /></div>
    <div class="table_a_b"><img src="<%=basePath%>images/blank.gif" /></div>
  </div>
  
  <table border="0" cellspacing="0" cellpadding="0" class="table_b">
	<tr>
		<td class="table_b_a"></td>
		<td valign="top" class="table_b_b">
			<div class="table_title">
				<img src="<%=basePath%>images/ico_arrow.gif" align="absmiddle" />
				绑定微信账号
			</div>
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
						<input id="txt_AppId_id" type="text" value="<s:property value="weixinAccount.appId" />" dataType="Require" msg="AppId不能为空!" />	
					</td>
				</tr>
				<tr class="add_table_tr" style="display: none;"
					onMouseOver="this.className='add_table_tr_over'"
					onMouseOut="this.className='add_table_tr'">
					<td class="add_table_left">
						AppSecret:
					</td>
					<td class="add_table_right" >
						<input id="txt_AppSecret_id"  type="text" value="<s:property value="weixinAccount.appId" />" dataType="Require" msg="AppSecret不能为空!" />	
					</td>
				</tr>
				<tr>
					<td colspan="2" class="add_btn">
						<input type="button" onClick="saveAccountBind();" class="btn1" value="保存" />&nbsp;&nbsp;					    
					    <input name="btn_add" type="button" class="btn3" style="display: none;" value="自定义菜单" alt="自定义菜单" onclick="toEditMenu();" />
					</td>
				</tr>
			</table>
		</td>
		<td class="table_b_c"></td>
	</tr>
  </table>
  <div class="table_c">
    <div class="table_c_a"></div>
    <div class="table_c_b"></div>
  </div>
  
  <!-- 关注自动回复 -->
  <div id="concernPanel">
	  <div class="table_a table_top">
	    <div class="table_a_a"><img src="<%=basePath%>images/blank.gif" /></div>
	    <div class="table_a_b"><img src="<%=basePath%>images/blank.gif" /></div>
	  </div>
	  
	  <table border="0" cellspacing="0" cellpadding="0" class="table_b">
		<tr>
			<td class="table_b_a"></td>
			<td valign="top" class="table_b_b">
				<div class="table_title">
					<img src="<%=basePath%>images/ico_arrow.gif" align="absmiddle" />
					关注自动回复
				</div>
				<table class="add_table" border="0" cellspacing="0"
					cellpadding="0">						
					<tr class="add_table_tr">
						<td class="add_table_left">
							回复内容:
						</td>
						<td class="add_table_right">
							<div class="table_tab" style="margin-top: 10px;">
					            <div class="tab1"> <a href="#" id="concern_a_text" onclick="changeTab(this,0)">文字</a></div>
					            <div class="tab2"> <a href="#" id="concern_a_pt" onclick="changeTab(this,1)">图文</a></div>
				            </div>
							<div id="welcomeTxtDiv" class="tab_content">
					             <textarea id="welcomeTxt" name="welcomeTxt" class="tabarea"  style="resize: none;" rows="10" cols="80" msg="回复文字不能为空!"><s:property value="weixinAccount.replyText" /></textarea>
				           </div>
				           <div id="welcomePicMuxDiv" style="display: none;vertical-align: bottom;">
				             <span id="welcomePicMuxSpan" class="tab_content" style="display:inline-block;height: 100px;vertical-align:bottom;">
				             <span style="display:inline-block;margin-left: 70px;margin-top:30px;">			             
					             <s:if test="weixinAccount.replyType==1">
									<a href="#" onclick="loadPicTexts(this);">单图文</a>
								 </s:if>
								 <s:elseif test="weixinAccount.replyType==2">
									<a href="#" onclick="loadPicTexts(this);">多图文</a>
								 </s:elseif>
								 <s:else>
								 	<a href="#" onclick="popupDiv('dialogDiv');">编辑图文</a>
								 </s:else>			             	
				           	    <input type="hidden" value="<s:property value="weixinAccount.replyPtId" />"/>
				           	   </span>
				             </span>
				           </div>
						</td>
					</tr>				
					<tr>
						<td colspan="2" class="add_btn">
							<input type="button" onClick="saveConcernReply();" class="btn1" value="保存" />&nbsp;&nbsp;  								    
						</td>
					</tr>
				</table>
			</td>
			<td class="table_b_c"></td>
		</tr>
	  </table>
	  <div class="table_c">
	    <div class="table_c_a"></div>
	    <div class="table_c_b"></div>
	  </div>
  </div>
  
  <!-- 关键字自动回复 -->
  <div id="keyPanel">
  <div class="table_a table_top">
    <div class="table_a_a"><img src="<%=basePath%>images/blank.gif" /></div>
    <div class="table_a_b"><img src="<%=basePath%>images/blank.gif" /></div>
  </div>
  <table border="0" cellspacing="0" cellpadding="0" class="table_b">
     <tr>
		<td class="table_b_a"></td>
		<td valign="top" class="table_b_b">
          <div class="table_title"><img src="<%=basePath%>images/ico_arrow.gif" align="absmiddle"/> 关键字自动回复</div>
          <table class="table_search" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
            <tr>
              <td>
                <div class="table_search_a" >
                	规则名：&nbsp;&nbsp;&nbsp;
                	<input id="searchAdminId" name="ruleName" type="text" 
                		class="table_input" value='<s:property value="ruleName" />' />
                </div>
                <div class="table_search_a"><input id="btn_search" name="btn_search" type="submit" class="btn1" value="搜索" alt="搜索" /></div>
                <div class="table_search_a"><input id="btn_add" name="btn_add" type="button" class="btn1" value="新增" alt="新增" onclick="toAddRule('');" /></div>
              </td>
            </tr>
          </table>
          <div class="table_list_box">
          <table border="0" cellspacing="0" cellpadding="0" class="table_list_table">
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
             <tr class="table_list_th">
               <td class="table_list_tr">规则名</td>
               <td class="table_list_tr">关键字</td>
               <td class="table_list_tr">回复</td>
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
							文字
						 </s:if>
						 <s:elseif test="replyType==1">
							单图文
						 </s:elseif>
						 <s:elseif test="replyType==2">
							多图文
						 </s:elseif>
					</td>
					<td>
						<a href="javascript:toAddRule('<s:property value="krId" />')">修改</a>&nbsp;
						<a href="javascript:delRule('<s:property value="krId" />')">&nbsp;删除</a>
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
</div>
</form>

<!-- 弹出框 --> 
<div id="dialogDiv" class="tc_box" style="display: none;z-index: 1;">
  <div class="tc_tit">编辑图文
    <div class="tc_c"><a href="#" onclick="hideDiv('dialogDiv');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image1','','<%=basePath%>images/tc_02.gif',1)"><img src="<%=basePath%>images/tc_01.gif" width="27" height="27" id="Image1" /></a>
    </div>
  </div>
  <div class="tc_bntbg">
    <div class="tc_bnt03"><a id="tab_pt_single" onclick="changePt(this,0)">单图文消息</a></div>
    <div class="tc_bnt01"><a id="tab_pt_multi"  onclick="changePt(this,1)">多图文消息</a></div>
  </div>
  
  <!-- 单图文 --> 
  <div id="singlePicTxt" class="tc_cn" style="margin-top: 5px;"> 
  <div id="previewDiv1" class="bj_left">
    <div style="margin-left: 10px;margin-top:10px;"><span name="title" id="singlePtTitle" class="spanwrap" style="width:328px;max-height:60px;">标题</span></div>
    <div class="bj_pic">
      <div class="bj_pic_fm"><span name="pic">封面图片</span><img src="" style="height: 160px;width:330px;display:none;"></img></div>
    </div>   
    <div style="margin-left: 10px;margin-top:10px;"><span name="desc" id="singlePtDesc" class="spanwrap" style="font-size: 13px;width:328px;max-height:60px;"></span></div>  
  </div>
  <div id="editDiv1" class="bj_right">
    <div class="bj_right_i"><img src="<%=basePath%>images/bj_i.gif" width="13" height="24" /></div>
    <div class="bj_right_n">
      <div class="ipt01">
        <li>标题</li>
        <li>          
          <input type="text" id="single_input_title" class="bj_inp2" onkeyup="syncSinglePtTitle(this)" />
        </li>
      </div>
      <div class="ipt01">
        <li>封面<span class="ipt_th">（大图片建议尺寸：360像素 * 200像素，大小不超过500K）</span></li>
        <li>
         <form method="post" action="" enctype="multipart/form-data">
        	<div class="bj_inp3">	        	
	        	<input onchange="ajaxupload(this, this.value, 1);" id ="input_single_pic" class="pic_upload" type="file" name="upload">
	        	<input name="uploadFileName" value="" type="hidden" />
        	</div>
         </form>
          
        </li>
      </div>
      <div class="ipt01">
      	<li><a href="#" onclick="showDescription(this);">添加摘要</a></li>
      	<div id="descriptionDiv" style="display:none;">
	      	<li>摘要</li>
	        <li>          
	          <textarea id="descriptionTxt" onkeyup="syncSinglePtDesc(this)" class="desc_textarea"></textarea>
	        </li>
      	</div>
      </div>
      <div class="ipt01">
        <li>链接</li>
        <li>
          <div class="table_tab" style="margin-top: 10px;">
				            <div class="tab1"> <a href="#" >文章</a></div>
				            <!--
				            <div class="tab2"> <a href="#" >会员卡</a></div>
				            <div class="tab2"> <a href="#" >优惠券</a></div>
				            -->
           </div>
          <div style="width: 97%;" >
          <script type="text/plain" id="newscontent1" name="content" style="width:200px">
                        
          </script> 
          </div>
        </li>
      </div>
    </div>
 
  </div> 
  </div>
  
  <!-- 多图文 --> 
  <div id="multiPicTxt" class="tc_cn" style="margin-top: 5px;display:none;"> 
  <div class="bj_left" id="previewDiv2">
    <div id="multi_pt_1" class="bj_pic" onmouseover="displayEditMask(this,1)" onmouseout="displayEditMask(this,2)">
      <div class="bj_pic_ico" style="display: none;"><a id="firstPt" onclick="changePosition(this);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image5','','<%=basePath%>images/bj_4a.gif',1)"><img src="<%=basePath%>images/bj_4.gif" width="33" height="33" id="Image5" /></a></div>
      <div class="bj_pic_fm"><span name="pic">封面图片</span><img src="" style="display: none;width:330px;height: 100%;"></img></div>
      <div class="bj_pic_tit"><span class="spanwrap" name="title" style="width:100%;max-height:60px;">图片标题</span></div>
      <input type="hidden" value=""/>
    </div>

    <div id="multi_pt_2" class="bj_n" onmouseover="displayEditMask(this,1)" onmouseout="displayEditMask(this,2)">
      <div class="bj_ico1" style="display: none;"><a onclick="changePosition(this);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image3','','<%=basePath%>images/bj_4a.gif',1)"><img src="<%=basePath%>images/bj_4.gif" width="33" height="33" id="Image3" /></a><a onclick="delPt(this)" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','<%=basePath%>images/bj_5a.gif',1)"><img src="<%=basePath%>images/bj_5.gif" width="33" height="33" id="Image4" /></a></div>
      <div class="bj_n1"><span name="title" class="spanwrap" style="width:236px;height:80px;">标题</span></div>
      <div class="bj_n2"><span name="pic">缩略图</span><img src="" style="display: none;"></img></div>
      <input type="hidden" value=""/>
    </div>
    <div class="bj_n"> <a onclick="addNewPt(this)"><img src="<%=basePath%>images/bj_add.gif" width="320" height="100" /></a> </div>
  </div>
  <div class="bj_right" id="editDiv2">
    <div class="bj_right_i"><img src="<%=basePath%>images/bj_i.gif" width="13" height="24" /></div>
    <div class="bj_right_n">
      <div class="ipt01">
        <li>标题</li>
        <li>
          <input type="text" id="multi_input_title" class="bj_inp2" onkeyup="syncMultiPtTitle(this)" />
        </li>
      </div>
      <div class="ipt01">
        <li>封面<span class="ipt_th">（大图片建议尺寸：360像素 * 200像素，大小不超过500K）</span></li>
        <li>
          <form method="post" action="" enctype="multipart/form-data">
        	<div class="bj_inp3">	        	
	        	<input onchange="ajaxupload(this, this.value, 2);" id ="input_multi_pic" class="pic_upload" type="file" name="upload">
	        	<input name="uploadFileName" value="" type="hidden" />
        	</div>
          </form>
        </li>
      </div>
      <div class="ipt01">
        <li>链接</li>
        <li>
          <div class="table_tab" style="margin-top: 10px;">
				            <div class="tab1"> <a href="#" >文章</a></div>
				            <!--
				            <div class="tab2"> <a href="#" >会员卡</a></div>
				            <div class="tab2"> <a href="#" >优惠券</a></div>
				            -->
           </div>
          <div style="width: 97%;" >
          <script type="text/plain" id="newscontent2" name="content" style="width:200px">
                        
          </script> 
          </div>
        </li>
      </div>
    </div>
 
  </div> 
  </div>
  
  <div style="height: 5px;width:100%;border-bottom:1px #CCC solid; ">
  </div>
  <div class="tc_bnt02">
    <input name="button" type="submit" class="tc_bnt02a" id="button" value="保存" onclick="savePt();" />
    <input name="button2" type="reset" class="tc_bnt02b" id="button2" value="取消" onclick="hideDiv('dialogDiv');" />
  </div>
</div>

</body>
</html>
