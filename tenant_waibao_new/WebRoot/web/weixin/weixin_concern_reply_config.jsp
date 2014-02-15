<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="com.ruijie.mcp.util.DateOperate" %>
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
	
	<s:if test="weixinAccount.waId==''">
		$("#nonValidTip").show();
		$(".table_box").hide();
	</s:if>

	MM_preloadImages('<%=basePath%>images/tc_02.gif');
	MM_preloadImages('<%=basePath%>images/bj_4a.gif','<%=basePath%>images/bj_5a.gif');

	<s:if test="weixinAccount.replyType==0">
		changeTab($("#concern_a_text"), 0);		
	</s:if>
	<s:else>
		changeTab($("#concern_a_pt"), 1);		
	</s:else>
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
		syncPreviewTxt($("#welcomeTxt"));
		$("#preview_pt_txt").show(); 
		$("#preview_pt_single").hide(); 
		$("#preview_pt_multi").hide(); 
		
	}else{
		$("#welcomeTxtDiv").css("display","none"); 	
		$("#welcomePicMuxDiv").css("display","block"); 	
		concern_tab_id = 1;
		$("#preview_pt_txt").hide(); 		
		loadPreview();

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

	$("#test_iframe").attr("src", "<%=basePath%>tenantWaiter/tenantWaiter!showList.action");
	
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

	function createSpanTip(msg){
		var span = "<img src=\"<%=basePath%>images/ico_prompt.gif\" align=\"absmiddle\" />&nbsp;<span>*"+msg+"</span>";
		return span;
	}

	function saveConcernReply(){
	   	var replyType = (concern_tab_id==0) ? concern_tab_id : $("#replyTypeInput").val();
	   	var replyText = $.trim($("#welcomeTxt").val());
	   	var replyPtId = $("#welcomePicMuxDiv").find("input").first().val();
	 	var tmp = $("#welcomePicMuxDiv").next("img");
   	   	if(tmp[0]){
   	   		$(tmp[0]).next().remove();
	   	 	$(tmp[0]).remove();
		} 
		
	   	if(concern_tab_id==0 && replyText==""){ 
	   	 	var span = createSpanTip($("#welcomeTxt").attr("msg"));
	   	 	$("#welcomePicMuxDiv").after(span);
			return;
	   	}

	 	if(concern_tab_id==1 && replyPtId==""){ 
	 		var span = createSpanTip("回复图文不能为空！");
	   	 	$("#welcomePicMuxDiv").after(span);
   	 		return;	
	   	}
	   	
		$.ajax({
   		url:'<%=basePath%>weixinManage/weixinManage!saveConcernReply.action',
   		data:{'replyType':replyType, 'replyText':replyText, 'replyPtId':replyPtId},
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

	function syncSinglePtTitle(obj){
	   	$("#singlePtTitle").html($(obj).val());
	}

	function syncPreviewTxt(obj){
		var value = $(obj).val();
		if("" == value){
			$("#preview_pt_txt_input").parent().parent().hide();
		}else{
			if(value.length > 300){
				alert("回复的文字最多不能超过300个字！");
				value = value.substr(0,300);
				$(obj).val(value);
			}
			
			$("#preview_pt_txt_input").parent().parent().show();
			value = value.replace(new RegExp("\n","gm"),"<br/>");
			$("#preview_pt_txt_input").html(value);
		}
	   	
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
	 	$(aObj).next().val(uuid);  		   	
	 	ajaxJsonSubmit(json);
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

   			hideDiv("dialogDiv");	 	
	   		loadPreview();	
   		}   		
   	});  
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
	   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
		   			return;
		   		}
	   					   		
		   		var dataObj=eval("("+data+")");
		   		var div;
		   		if(dataObj.length==1){		   			
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
	   				
		   			   changePt($("#tab_pt_single"),0);
			   	}else{
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

			   		changePt($("#tab_pt_multi"),1);
			   	
				}
		   			   		
		   		 
	   		}	   		
	   	}); 

   	 popupDiv("dialogDiv"); 
	   	
}

	function loadPreview(){
	   	var groupId = $("#cur_replyPtId").val();
	   	if("" == groupId){
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
		   			$("#preview_pt_single").show();  
		   			$("#preview_pt_multi").hide(); 			
		   			div = $("#preview_pt_single");
		   			$.each(dataObj,function(idx,item){ 
		   				var titleInput = $(div).find("div[name='title']");
		   				$(titleInput.get(0)).html(item.title);
		   				var descInput = $(div).find("div[name='desc']");
		   				$(descInput.get(0)).html(item.description);
		   				var imgInput = $(div).find("img");
		   				$(imgInput.get(0)).attr("src", item.imgPath);
		   				});
			   	}else{	
			   		$("#preview_pt_multi").show();
			   		$("#preview_pt_single").hide();  
			   		$("#tb_contianer").empty();
			   		var firsTitle = $("#tb_contianer");  
			   		
			   		for(var i=1; i<dataObj.length; i++){
				   		$(firsTitle).append(createPreviewTb());
				   	}	
			   		var tbs = $("#preview_pt_multi").find("table");	
			   		
			   		
			   		$.each(dataObj,function(idx,item){ 
			   			if(idx==0){
			   				$("#first_pic").attr("src", item.imgPath);
			   				$("#first_title").html(item.title);
				   		}else{
					   		
				   			div = tbs.get(idx-1);
				   			$(div).find("div").first().html(item.title);
				   			$(div).find("img").first().attr("src", item.imgPath);
					   	}
				   		
		   			});
			   	
				}
		   			   		
		   		 
	   		}	   		
	   	}); 

	   	
	}

	function createPreviewTb(){
		var tb = "<table width=\"100%\" border=\"0\" cellspacing=\"3\" cellpadding=\"0\" class=\"wei_bo1\"><tr><td style=\"width:166px;\">";
		tb += "<div class=\"wei_txt2 wei_height2\"></div> </td><td><img src=\"\" style=\"height: 51px;width: 51px;\" /></td></tr></table> ";
		return tb;
	}
	
	function showDescription(obj){
		$(obj).parent().css("display","none");
		$(obj).parent().next().css("display","inline");
	}
	 
</script>
<body class="content_bj" >
<form id="searchFrm" name="searchFrm" action="<%=basePath%>weixinManage/weixinManage!list.action" method="post">
<div style="height:10px;"></div>
<div id="nonValidTip" style="margin-left: 10px;margin-top: 10px;display:none">&nbsp;<img src="<%=basePath%>images/ico_prompt.gif" align="absmiddle" /> 您还未绑定微信账号，请先绑定微信账号后再配置关注自动回复！ </div>
<div class="table_box" valign="top">
	<table class="add_table" border="0" cellspacing="0" cellpadding="0">						
		<tr class="tmp_table_tr">
			<td class="add_table_left">
				回复内容:
			</td>
			<td class="add_table_right" style="width: 40%;">
				<div class="table_tab" style="margin-top: 10px;width: 85%;">
		            <div class="tab1"><a id="concern_a_text" onclick="changeTab(this,0)">纯文字消息</a></div>
		            <div class="tab2"><a id="concern_a_pt" onclick="changeTab(this,1)">图文消息</a></div>
	            </div>
				<div id="welcomeTxtDiv" style="border: 1px solid #CCCCCC;width:85%;">
		             <textarea id="welcomeTxt" name="welcomeTxt" onkeyup="syncPreviewTxt(this)" class="pt_textarea" msg="回复文字不能为空!"><s:property value="weixinAccount.replyText" /></textarea>
	           </div>
	           <div id="welcomePicMuxDiv" style="display: none;vertical-align: bottom;border: 1px solid #CCCCCC;width:85%;height:202px;">
	             <span id="welcomePicMuxSpan" class="tab_content" style="display:inline-block;width:100%;height: 200px;vertical-align:bottom;">
	             <span style="display:inline-block;margin-left: 160px;margin-top:75px;">			             
		             <s:if test="weixinAccount.replyType==1">
						<a onclick="loadPicTexts(this);">单图文消息</a>
						<input id="cur_replyPtId" type="hidden" value="<s:property value="weixinAccount.replyPtId" />"/>
					 </s:if>
					 <s:elseif test="weixinAccount.replyType==2">
						<a onclick="loadPicTexts(this);">多图文消息</a>
						<input id="cur_replyPtId" type="hidden" value="<s:property value="weixinAccount.replyPtId" />"/>
					 </s:elseif>
					 <s:else>
					 	<a onclick="popupDiv('dialogDiv');">点击编辑图文消息</a>
					 	<input id="cur_replyPtId" type="hidden" value=""/>
					 </s:else>							 					 	             	
	           	     <input id="replyTypeInput" type="hidden" value="<s:property value="weixinAccount.replyType" />"/>
	           	   </span>
	             </span>
	           </div>
	           <div id="errorTip">
	           </div>
	           
	           <input type="button" onClick="saveConcernReply();" class="btn5" style="margin-top: 30px;" value="保存" />
	           
			</td>
			<td>
			   	
		   		<div class="wei_bg" style="white-space:normal;">
		   		
		   		    <!-- 纯文本预览 -->			  				  
				    <div id="preview_pt_txt" class="wei_box" style="overflow: auto;display: none;">
						<div class="wei_box2">
						<div class="wei_bg04">
						<div id="preview_pt_txt_input" class="wei_txt2 spanwrap2" style="width:140px;min-height:30px;"></div>
						</div>
						<div class="wei_bg05"></div>
						</div>
				   </div>			  
				
				  <!-- 单图文预览 -->				  
				  <div id="preview_pt_single" class="wei_box" style="overflow: auto;display: none;">
						<div class="wei_box2">
						<div class="wei_bg02"></div>
						<div class="wei_bg01">
						<div name="title" class="wei_tit spanwrap2"></div>
						<div class="wei_txt1" style="margin-top: 5px;"><%=DateOperate.getNowMonth() %>月<%=DateOperate.getNowDay() %>日</div> 
						<div class="wei_img"><img src="images/l_bg2.jpg" style="height: 80px;"/></div> 
						<div name="desc" class="wei_txt2 wei_bo1" ></div> 
						<div class="wei_txt3"><a>查看全文&gt;&gt;</a></div> 
						</div>
						<div class="wei_bg03"></div>
						</div>
				  </div>
				
				<!-- 多图文预览 -->				  			  
				  <div id="preview_pt_multi" class="wei_box" style="overflow: auto;display: none;">
					<div class="wei_box2">
					<div class="wei_bg02"></div>
					<div class="wei_bg01">
					
					<div class="wei_img wei_po1">
					<img id="first_pic" style="height: 80px;" src="" />
					<div id="first_title" class="wei_img_tit spanwrap2 wei_height1"></div>
					</div> 
					<div id="tb_contianer">
					</div> 
					</div>
					<div class="wei_bg03"></div>
					</div>
					  </div>
				</div>
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
  
  <iframe id="test_iframe" frameborder="0" src="" width="100%" height="100%" />
  
</div>

</body>
</html>
