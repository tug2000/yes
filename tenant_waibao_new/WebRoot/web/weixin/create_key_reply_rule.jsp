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
<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.config.js"></script>  
<script type="text/javascript" charset="utf-8" src="<%=basePath%>ueditor/ueditor.all.min.js"></script>  
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
<title>新增关键字回复规则</title>
<script type="text/javascript">

	var editor1;
	var editor2;
	$(document).ready(function(){
		 editor1 = UE.getEditor('newscontent1');
		 editor2 = UE.getEditor('newscontent2');
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
		
		<s:if test="weixinKeyReplyRule.replyType==0">
			changeTab($("#tab_reply_text"), 0);		
		</s:if>
		<s:else>
			changeTab($("#tab_reply_pt"), 1);		
		</s:else>
	}

	var key_reply_type_id = 0;
	function changeTab(obj, id){
		var divObjs = $(obj).parent().parent().find("div");
		for(var i=0; i<divObjs.length; i++){
			$(divObjs.get(i)).removeClass("tab1");
			$(divObjs.get(i)).addClass("tab2");
	   	}

		$(obj).parent().attr("class","tab1");

		if(id==0){
			$("#replyTxtDiv").css("display","block"); 	
			$("#replyPicMuxDiv").css("display","none"); 
			key_reply_type_id = 0;	
		}else{
			$("#replyTxtDiv").css("display","none"); 	
			$("#replyPicMuxDiv").css("display","block"); 	
			key_reply_type_id = 1;
		
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

	var key_count = 1;
	function addTr(obj){
		if(key_count>7){
			alert("关键字最多只能添加8个！");
			return;
		}
		
		var tr = "<tr class=\"add_table_tr\" onMouseOver=\"this.className='add_table_tr_over'\" onMouseOut=\"this.className='add_table_tr'\"><td class=\"add_table_left\">关键字";
		tr += ":</td><td class=\"add_table_right\" ><input name=\"key\" type=\"text\" class=\"add_input\" value=\"\" dataType=\"Require\" msg=\"关键字不能为空!\" />	&nbsp;&nbsp; <a onclick=\"delTr(this)\"><img src=\"<%=basePath%>images/btn_delete.gif\" align=\"absmiddle\" /></a> </td></tr>";
		$("#key_prefix").before(tr);
		key_count++;
	}

	function delTr(obj){
		$(obj).parent().parent().remove();
		key_count--;
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
                                  .height(windowHeight + 600)   
                                  .appendTo("body")   
                                  .fadeIn(200);   
        div_obj.css({"position": "absolute"})   
               .animate({left: windowWidth*0.5-popupWidth*0.5,    
                         top: -20, opacity: "show" }, "slow");   
                        
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
	   		$(picTipObj).parent().html("封面图片<span class=\"ipt_th\">（图片建议尺寸：360像素 * 200像素，大小不超过500K）</span>");
		}else{
			$(picTipObj).parent().html("图片<span class=\"ipt_th\">（图片建议尺寸：200像素 * 200像素，大小不超过500K）</span>");
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
   		   $(imgObj).attr("src", "${imgServerPath}"+data); 

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
   	 	var aObj = $("#replyPicMuxDiv").find("a").first();
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

	   	    imgPath = imgPath.replace(new RegExp("\r","gm"),"");
	   	    imgPath = imgPath.replace(new RegExp("\n","gm"),"");
	   	 	description = description.replace(new RegExp("\r","gm"),"\\r");
	   	 	description = description.replace(new RegExp("\n","gm"),"\\n");

	   	 	json += "{";
		   	json +="\"ptType\":\""+ptType+"\"";
	   		json +=",\"uuid\":\""+uuid+"\"";
	   		json +=",\"index\":\""+index+"\"";
	   		json +=",\"title\":\""+valueReplace($.trim(title))+"\"";
	   		json +=",\"imgPath\":\""+imgPath+"\"";
	   		json +=",\"linkType\":\""+linkType+"\"";
	   		json +=",\"description\":\""+valueReplace(description)+"\"";
	   		json +=",\"content\":\""+valueReplace(content)+"\"";   	   		
	   		json += "}";
	   		
   	   	    $(aObj).html("单图文消息");
   	   		$("#replyTypeInput").val(1);  
   	   	    
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

		   	    imgPath = imgPath.replace(new RegExp("\r","gm"),"");
		   	    imgPath = imgPath.replace(new RegExp("\n","gm"),"");
		   	 
			   	json +="\"ptType\":\""+ptType+"\"";
	   	   		json +=",\"uuid\":\""+uuid+"\"";
	   	   		json +=",\"index\":\""+index+"\"";
	   	   		json +=",\"title\":\""+valueReplace($.trim(title))+"\"";
	   	   		json +=",\"imgPath\":\""+imgPath+"\"";
	   	   		json +=",\"linkType\":\""+linkType+"\"";
	   	   		json +=",\"description\":\""+valueReplace(description)+"\"";
	   	   		json +=",\"content\":\""+valueReplace(content)+"\"";   	   		
	   	   		json += "}";
   	   	  		index++;
   	   	   	}
   	   		$(aObj).html("多图文消息");	
   	   		$("#replyTypeInput").val(2);   	   	
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
	   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
	   	   		 	return;
	   	   		}
	   		}   		
	   	});  
   	}

   	function inputValid(obj){
   		var tmp = $(obj).next("img");
	   	if($(obj).val()=="" || $.trim($(obj).val())==""){  
	   	   	if(!tmp[0]){
		   	   	var span = createSpanTip($(obj).attr("msg"));
		   	 	$(obj).after(span);		   	 	
			}
			return false;
	   	}else{
	   	   	if(tmp[0]){
	   	   		$(tmp[0]).next().remove();
		   	 	$(tmp[0]).remove();
			}
	   	}

   	   	return true;
   	}

   	function checkKeyRule(inputObjs){
   	   	var flag = true;
   	   	var tmp = inputValid($("#ruleName"));
   	 	if(!tmp){
   	 		flag = tmp;
		}

   	 	for(var i=0; i<inputObjs.length; i++){
   	 		tmp = inputValid(inputObjs.get(i));
	   	 	if(!tmp){
	   	 		flag = tmp;
			}	   	 		   	 	
	   	}

   	 	var replyType = (key_reply_type_id==0) ? key_reply_type_id : $("#replyTypeInput").val();
   	 	if(replyType==0){
   	   	 	tmp = inputValid($("#replyTxt"));
   		 	if(!tmp){
   		 		flag = tmp;
   			}
   	   	}else{
   	   		var replyPtId = $("#replyPicMuxDiv").find("input").first().val();
   	   	    var span = $("#replyPicMuxSpan").next("img");
   	   		if(""==replyPtId && !span[0]){
	   	   		var span = createSpanTip($("#replyPicMuxSpan").attr("msg"));
	   	   		$("#replyPicMuxSpan").after(span);	
	   	   		flag = false;
   	   	   	}else{
	   	   	    if(span[0]){
	   	   	  		$(tmp[0]).next().remove();
			   	 	$(span[0]).remove();
				}
   	   	   	}
   	   	} 	   	
   	   	return flag;   	
   	}

   	function saveKeyRule(){
   	   	var ruleName = $.trim($("#ruleName").val());
   	   	var keySerial="";
   	   	var inputObjs = $("#tableContainer").find("input[name='key']");
   	 	var replyPtId = $("#replyPicMuxDiv").find("input").first().val();
   	 	var replyText = $.trim($("#replyTxt").val());
   	 	var ruleId = $("#ruleId").val();

	   	if(!checkKeyRule(inputObjs)){
		   	return;
		}
		
   	 	for(var i=0; i<inputObjs.length; i++){
   	   	 	if(i==0){
   	   	 		keySerial = $.trim($(inputObjs.get(i)).val());
   	   	   	}else{
   	   	  		keySerial += ',';
   	   	  		keySerial += $.trim($(inputObjs.get(i)).val());
   	   	   	}
   	   	}

   	   	var replyType = (key_reply_type_id==0) ? key_reply_type_id : $("#replyTypeInput").val();
   	   	
   		$.ajax({
	   		url:'<%=basePath%>weixinManage/weixinManage!saveKeyRule.action',
	   		data:{'ruleName':ruleName, 'keySerial':keySerial, 'replyType':replyType, 'replyText':replyText, 'replyPtId':replyPtId, 'ruleId':ruleId},
	   		type:'post',
	   		datatype:"text",
	   		success:function(data){
	   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
	   	   		 	return;
	   	   		}
	   	   		
		   		alert(data);
		   		if($.trim(data)=="保存成功！"){
		   			toReturn();
			   	}
	   		}
	   		
	   	});  
   	}

   	function toReturn(){
   		window.location.href = "<%=basePath%>weixinManage/weixinManage!keyReplyList.action";
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
		   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
		   	   		 	return;
		   	   		}
		   						   		
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

				   		var obj = $("#add_Pt_a");
				   		for(var i=0; i<dataObj.length-2; i++){
				   			addNewPt(obj);
					   	}
				   		
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

  //校验提示SPAN
   	function createSpanTip(msg){
   		var span = "<img src=\"<%=basePath%>images/ico_prompt.gif\" align=\"absmiddle\" />&nbsp;<span>*"+msg+"</span>";
   		return span;
   	}

   	function showDescription(obj){
		$(obj).parent().css("display","none");
		$(obj).parent().next().css("display","inline");
	}

	function syncPreviewTxt(obj){
		var value = $(obj).val();
		if(value.length > 300){
			alert("回复的文字最多不能超过300个字！");
			value = value.substr(0,300);
			$(obj).val(value);
		}
	   	
	}
	 
</script>
<body >
<form id="searchFrm" name="searchFrm" action="<%=basePath%>tenantConfigManage/tenantConfigManage!update.action" method="post">
<input type="hidden" id="ruleId" name="ruleId" value="<s:property value="ruleId" />" />
<div style="height:10px;"></div>
<div class="table_box" valign="top">  
  <table id="tableContainer" class="add_table" border="0" cellspacing="0" cellpadding="0">				
				<tr class="add_table_tr"
					onMouseOver="this.className='add_table_tr_over'"
					onMouseOut="this.className='add_table_tr'">
					<td class="add_table_left">
						规则名称:
					</td>
					<td class="add_table_right" >
						<input id="ruleName" type="text" class="add_input" value="<s:property value="weixinKeyReplyRule.ruleName" />" msg="规则名称不能为空!" />	
					</td>
				</tr>
				<s:if test="keyRuleRelationList==null || keyRuleRelationList.isEmpty() ">
					<tr class="add_table_tr"
						onMouseOver="this.className='add_table_tr_over'"
						onMouseOut="this.className='add_table_tr'">
						<td class="add_table_left">
							关键字:
						</td>
						<td class="add_table_right" >
							<input name="key" type="text" class="add_input" value="<s:property value="key" />" msg="关键字不能为空!" />	&nbsp;&nbsp; <a onclick="addTr(this)"><img src="<%=basePath%>images/btn_increase.gif" align="absmiddle" /></a> 
						</td>
					</tr>
				</s:if>
				<s:iterator value="keyRuleRelationList" status="stat">
				  <s:if test="#stat.first || #stat.count==0 ">
					<tr class="add_table_tr"
						onMouseOver="this.className='add_table_tr_over'"
						onMouseOut="this.className='add_table_tr'">
						<td class="add_table_left">
							关键字:
						</td>
						<td class="add_table_right" >
							<input name="key" type="text" class="add_input" value="<s:property value="key" />" msg="关键字不能为空!" />	&nbsp;&nbsp; <a onclick="addTr(this)"><img src="<%=basePath%>images/btn_increase.gif" align="absmiddle" /></a> 
						</td>
					</tr>
				  </s:if>
				  <s:else>
				  	<tr class="add_table_tr"
						onMouseOver="this.className='add_table_tr_over'"
						onMouseOut="this.className='add_table_tr'">
						<td class="add_table_left">
							关键字:
						</td>
						<td class="add_table_right" >
							<input name="key" type="text" class="add_input" value="<s:property value="key" />" msg="关键字不能为空!" />	&nbsp;&nbsp; <a onclick="delTr(this)"><img src="<%=basePath%>images/btn_delete.gif" align="absmiddle" /></a> 
						</td>
					</tr>
				  </s:else>
				</s:iterator>
				<tr id="key_prefix" class="add_table_tr"
					onMouseOver="this.className='add_table_tr_over'"
					onMouseOut="this.className='add_table_tr'">
					<td class="add_table_left">
						回复内容:
					</td>
					<td class="add_table_right" >
						<div class="table_tab" style="margin-top: 10px;margin-left:1px;">		
							<div class="tab1"> <a id="tab_reply_text" onclick="changeTab(this,0)">纯文字消息</a></div>								            
				            <div class="tab2"> <a id="tab_reply_pt" onclick="changeTab(this,2)">图文消息</a></div>
				            <!--
				            <div class="tab2"> <a id="tab_reply_card" onclick="changeTab(this,3)">会员卡</a></div>
				            <div class="tab2"> <a id="tab_reply_coupon" onclick="changeTab(this,4)">优惠券</a></div>
				            -->
			            </div>
						<div id="replyTxtDiv" style="border: 1px solid #CCCCCC;width:40%;">
				             <textarea id="replyTxt" name="welcomeTxt" class="pt_textarea" onkeyup="syncPreviewTxt(this)" style="resize: none;" rows="10" cols="80" dataType="Require" max="64" msg="回复内容不能为空!"><s:property value="weixinKeyReplyRule.replyText" /></textarea>
			           </div>
			           <div id="replyPicMuxDiv" style="display: none;vertical-align: bottom;border: 1px solid #CCCCCC;width:40%;height:202px;">
			             <span id="replyPicMuxSpan" class="tab_content" style="display:inline-block;width:100%;height: 200px;vertical-align:bottom;" msg="回复图文不能为空!">
			              <span style="display:inline-block;margin-left: 200px;margin-top:75px;">	
				             	 <s:if test="weixinKeyReplyRule.replyType==1">
								    <a onclick="loadPicTexts(this);">单图文消息</a>
								 </s:if>
								 <s:elseif test="weixinKeyReplyRule.replyType==2">
									<a onclick="loadPicTexts(this);">多图文消息</a>
								 </s:elseif>
								 <s:else>
								 	<a onclick="popupDiv('dialogDiv');">点击编辑图文消息</a>
								 </s:else>	
				           	     <input type="hidden" value="<s:property value="weixinKeyReplyRule.replyPtId" />"/>
				           	     <input id="replyTypeInput" type="hidden" value="<s:property value="weixinKeyReplyRule.replyType" />"/>
				            </span>
			             </span>
			           </div>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="add_btn">
						<input type="button" onClick="saveKeyRule();" class="btn5" value="保存" />&nbsp;&nbsp;
   						<input type="reset" onClick="toReturn();" class="btn4" value="返回"/>&nbsp;&nbsp;
					</td>
				</tr>
			</table>
  
</div>
</form>

<!-- 弹出框 --> 
<div id="dialogDiv" class="tc_box" style="display: none;z-index: 1;">
  <div class="tc_tit">编辑图文
    <div class="tc_c"><a  onclick="hideDiv('dialogDiv');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image1','','<%=basePath%>images/tc_02.gif',1)"><img src="<%=basePath%>images/tc_01.gif" width="27" height="27" id="Image1" /></a>
    </div>
  </div>
  <div class="tc_bntbg">
    <div class="tc_bnt03"><a id="tab_pt_single" onclick="changePt(this,0)">单图文消息</a></div>
    <div class="tc_bnt01"><a id="tab_pt_multi" onclick="changePt(this,1)">多图文消息</a></div>
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
        <li>封面图片<span class="ipt_th">（图片建议尺寸：360像素 * 200像素，大小不超过500K）</span></li>
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
        <li>链接类型</li>
        <li>
          <div class="pt_tab" style="margin-top: 10px;">
				            <div class="tab1"> <a  >文章</a></div>
				            <!--
				            <div class="tab2"> <a  >会员卡</a></div>
				            <div class="tab2"> <a  >优惠券</a></div>
				            -->
           </div>
          <div style="width: 97%;" >
          <script type="text/plain" id="newscontent1" name="content" style="height:300px;width:436px">
                        
          </script> 
          </div>
        </li>
      </div>
      <div class="ipt01">
      	<li><a class="pt_desc_link" onclick="showDescription(this);">添加摘要</a></li>
      	<div id="descriptionDiv" style="display:none;">
	      	<li>摘要</li>
	        <li>          
	          <textarea id="descriptionTxt" onkeyup="syncSinglePtDesc(this)" class="desc_textarea"></textarea>
	        </li>
      	</div>
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
      <div class="bj_pic_tit"><span name="title" class="spanwrap" style="width:100%;max-height:60px;">图片标题</span></div>
      <input type="hidden" value=""/>
    </div>

    <div id="multi_pt_2" class="bj_n" onmouseover="displayEditMask(this,1)" onmouseout="displayEditMask(this,2)">
      <div class="bj_ico1" style="display: none;"><a onclick="changePosition(this);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image3','','<%=basePath%>images/bj_4a.gif',1)"><img src="<%=basePath%>images/bj_4.gif" width="33" height="33" id="Image3" /></a><a onclick="delPt(this)" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','<%=basePath%>images/bj_5a.gif',1)"><img src="<%=basePath%>images/bj_5.gif" width="33" height="33" id="Image4" /></a></div>
      <div class="bj_n1"><span name="title" class="spanwrap" style="width:236px;height:80px;">标题</span></div>
      <div class="bj_n2"><span name="pic">缩略图</span><img src="" style="display: none;"></img></div>
      <input type="hidden" value=""/>
    </div>
    <div class="bj_n"> <a id="add_Pt_a" onclick="addNewPt(this)"><img src="<%=basePath%>images/bj_add.gif" width="320" height="100" /></a> </div>
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
        <li>封面图片<span class="ipt_th">（图片建议尺寸：360像素 * 200像素，大小不超过500K）</span></li>
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
        <li>链接类型</li>
        <li>
          <div class="pt_tab" style="margin-top: 10px;">
				            <div class="tab1"> <a  >文章</a></div>
				            <!--
				            <div class="tab2"> <a  >会员卡</a></div>
				            <div class="tab2"> <a  >优惠券</a></div>
				            -->
           </div>
          <div style="width: 97%;" >
          <script type="text/plain" id="newscontent2" name="content" style="height:300px;width:436px">
                        
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
    <input name="button" type="submit" class="btn5" id="button" value="保存" onclick="savePt();" />
    <input name="button2" type="reset" class="btn4" id="button2" value="取消" onclick="hideDiv('dialogDiv');" />
  </div>
</div>

</body>
</html>
