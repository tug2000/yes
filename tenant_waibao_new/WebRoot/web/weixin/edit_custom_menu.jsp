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
 .loadmask {   
      background-color:#fff;
      position:absolute;
      top:0px;
      left:0px;
      filter: Alpha(Opacity=60);
  }
  .edittxt{
      border:1px solid #d2d2d2;
  } 
  .submenufont{
      font: 12px/30px Arial, Helvetica, sans-serif;color: #5e5e5e;
  }
</style>
</head>
<title>编辑自定义菜单</title>
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

		<s:if test="weixinAccount.accountType==0">
			$("#nonValidTip").show();
			$(".table_box").hide();
		</s:if>
	
		MM_preloadImages('<%=basePath%>images/tc_02.gif');
		MM_preloadImages('<%=basePath%>images/bj_4a.gif','<%=basePath%>images/bj_5a.gif');
		
		changePt($("#tab_txt"),0);

	  	//鼠标移动时菜单显示或隐藏
		$("#menuDiv").hover(
		function(){
		},
		function(){
			$("#menuDiv").children("div").slideUp();	
		});
	}

	function checkTitleInput(obj, menuLevel){
		var menuName = $.trim($(obj).val());
		var titleLength = menuName.replace(/[^\u0000-\u00ff]/g,"aaaa").length;
		var tmp = $(obj).next("img");
		var tipSpan;
		if(tmp[0]){
			$(tmp[0]).next().remove();
			$(tmp[0]).remove();
		}

		if(""==menuName){
			tipSpan = createSpanTip("菜单标题不能为空！");
		}else if(1==menuLevel && titleLength>16){
			tipSpan = createSpanTip("一级菜单标题不能超过4个汉字！");
		}else if(2==menuLevel && titleLength>28){
			tipSpan = createSpanTip("二级菜单标题不能超过7个汉字！");
		}
		
		$(obj).after(tipSpan);
	}

	//校验提示SPAN
   	function createSpanTip(msg){
   		var span = "<img src=\"<%=basePath%>images/ico_prompt.gif\" align=\"absmiddle\" />&nbsp;<span>*"+msg+"</span>";
   		return span;
   	}

	function addMenuItem(flag){	
		
		$(".menu_1").css("display","none");
		var trObjs = $("#customMenuTable").find("tr[name='menu1']");
		if(trObjs.length==3){
			alert('一级菜单最多只能3个！');
			return;
		}
		
		var tr = "<tr name=\"menu1\" class=\"table_list_td\" onMouseOver=\"this.className='table_list_td_over'\" onMouseOut=\"this.className='table_list_td'\">";
		tr += "<td align=\"left\" width=\"20%\" style=\"text-indent: 15px;\"><img src=\"<%=basePath%>images/cmenu_01.gif\" align=\"absmiddle\" style=\"margin-top: -1px;margin-right:3px;\"/><input type=\"text\" name=\"menu1_input\" value=\"\" class=\"edittxt\" onkeyup=\"checkTitleInput(this, 1)\"  /></td>";
		tr += "<td nowrap=\"nowrap\" width=\"15%\">";
		if(!flag){
			tr += "<a onclick=\"showInitPtDialog(this);\"><img src=\"<%=basePath%>images/cmenu_02.gif\" align=\"absmiddle\"/></a><a onclick=\"bingReplyData(this);\" style=\"display:none;\"></a><input type=\"hidden\" value=\"\" /><input type=\"hidden\" value=\"\" /></td><td nowrap=\"nowrap\" width=\"10%\">";			
		}else{
			tr += "</td><td nowrap=\"nowrap\" width=\"10%\"><a onclick=\"addSubMenuItem(this);\">添加子菜单</a>";	
		}
		tr += "&nbsp;&nbsp;<a onclick=\"deltr(this)\">删除</a>&nbsp;&nbsp;</td></tr>";
		$("#customMenuTable tr:last-child").after(tr);
	}

	function addSubMenuItem(obj){
        var index = 0;
        var appd = $(obj).parent().parent();
        var next = $(appd).next();
        while(next){
            if(!$(next).attr('name') || $(next).attr('name')=='menu1'){
                break;
            }else if($(next).attr('name')=='menu2'){
            	appd = next;
            }

            next = $(next).next();
            index++;
        }

        if(index==5){
        	alert('子菜单最多只能添加5个！');
			return;
        }

		var tr = "<tr name=\"menu2\" class=\"table_list_td\" onMouseOver=\"this.className='table_list_td_over'\" onMouseOut=\"this.className='table_list_td'\"><td align=\"left\" width=\"20%\" style=\"text-indent: 35px;\">";
        tr += "<img src=\"<%=basePath%>images/cmenu_03.gif\" style=\"margin-top: -1px; margin-right: 7px;\" align=\"absmiddle\"/><input type=\"text\" value=\"\" class=\"edittxt\" onkeyup=\"checkTitleInput(this, 2)\" /><span class=\"submenufont\" style=\"display:none;\"></span></td><td nowrap=\"nowrap\" width=\"15%\"><a onclick=\"showInitPtDialog(this);\"><img src=\"<%=basePath%>images/cmenu_02.gif\" align=\"absmiddle\"/></a>";
        tr += "<a onclick=\"bingReplyData(this);\" style=\"display:none;\"></a><input type=\"hidden\" value=\"\" /><input type=\"hidden\" value=\"\" />";
        tr += "</td><td nowrap=\"nowrap\" width=\"10%\"><a onclick=\"deltr(this)\">删除</a>&nbsp;&nbsp;</td></tr>";

        $(appd).after(tr);
	}

	function saveSubMenuItem(obj){
		var inputObjs = $(obj).parent().parent().find("input");
		var titleInput = inputObjs.get(0);
		var titleSpan = $(titleInput).next();
		$(titleInput).css("display","none"); 
		$(titleSpan).html($(inputObjs.get(0)).val());
		$(titleSpan).css("display","inline"); 
	}

	var pt_tab_index = 0;
	function changePt(obj, id){
		var divObjs = $(obj).parent().parent().find("div");
		for(var i=0; i<divObjs.length; i++){
			$(divObjs.get(i)).removeClass("tc_bnt03");
			$(divObjs.get(i)).addClass("tc_bnt01");
	   	}

		$(obj).parent().attr("class","tc_bnt03");

		divObjs = $("#dialogDiv > div");
		for(var i=0; i<divObjs.length; i++){
			if(i==id+2 || i<2 || i>=(divObjs.length-2)){
				$(divObjs.get(i)).css("display","block");
			}else{
				$(divObjs.get(i)).css("display","none"); 
			}
	   	}

	   	if(id==0){
	   		pt_tab_index = 0;
		}else if(id==1){
			pt_tab_index = 1;
		}else if(id==2){
			pt_tab_index = 2;
		}

	   	if(id==0){
	   		$("#dialogDiv").height(315);
	   		$("#dialogDiv").width(400);
		}else{
			$("#dialogDiv").height(600);
	   		$("#dialogDiv").width(900);
		}
	   	
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

	function deltr(obj){
		var tr = $(obj).parent().parent();
 		var inputObjs = $(tr).find("input");
  	   	var menuName = $(inputObjs.get(0)).val();

  	   	if("" != menuName && !confirm("确定要删除？")){
  	  	   	return;
  	  	}

  	  	if($(tr).attr("name")=="menu1"){
  	  	  	var pre = $(tr);
  	  	  	var next = $(pre).next();
  	  		while($(next).attr("name")=="menu2"){
  	  			pre = next;
  	  			next = $(next).next();  	  			
  	  			$(pre).remove();
  	  	  	}
  	  	}
		
		$(tr).remove();
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
               .animate({left: 150,    
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

   	function clickMenu(){	
   	   	var div = $("#menuDiv").children("div");
   		if($(div).is(":visible")){
   			$(div).slideUp(); 
   	   	}else{
   	   		$(div).slideDown();  	
   	   	}
   	   	
	}
	
	function syncSinglePtTitle(obj){
   	   	$("#singlePtTitle").html($(obj).val());
   	}

	function syncSinglePtDesc(obj){
   	   	$("#singlePtDesc").html($(obj).val());
   	}

   	function syncMultiPtTitle(obj){
   	   	var div = $("#"+cur_PT_Id);
   	   	var spanObjs = $(div).find("span[name='title']");
   	   	$(spanObjs.get(0)).html($(obj).val());
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
   		var json = "[";

   	 	var aObjs = $(curTdObj).find("a");
   	 	var inputObjs = $(curTdObj).find("input");

		uuid = $(inputObjs.get(1)).val();
	 	if("" == uuid){
	 		uuid = Math.uuid();
	   	}
		
   	 	if(pt_tab_index==0){
	   		var txt = $.trim($("#singleTxt").find("textarea").first().val());	   		
	   		if(txt==""){
	   			alert('回复文字不能为空！');
	   	   	    return;
		   	}	
	   		$(aObjs.get(1)).html("纯文字消息");
	   		$(inputObjs.get(0)).val("0");
	   		$(inputObjs.get(1)).val(txt);
	   	    
	   	    
	   	}else if(pt_tab_index==1){
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
	   		
	   	   	$(aObjs.get(1)).html("单图文消息");
	   		$(inputObjs.get(0)).val("1");
	   		$(inputObjs.get(1)).val(uuid);
   	   	    
   	   	    
   	   	}else if(pt_tab_index==2){
   	   		description = "";
   	   		ptType = 1;
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

  	   	 	$(aObjs.get(1)).html("多图文消息");
 	   		$(inputObjs.get(0)).val("2");
 	   		$(inputObjs.get(1)).val(uuid);
   	   		   	
   	   	}

   	   	json += "]";
   	 	ajaxPtJsonSubmit(json);

		$(aObjs.get(0)).css("display","none"); 
		$(aObjs.get(1)).css("display","block"); 
   	 	hideDiv("dialogDiv");
   	   	
   	}

   	function valueReplace(v){
   		v=v.toString().replace(new RegExp('(["\"])', 'g'),"\\\"");
   		return v;
   	}
   		   	
   	function ajaxPtJsonSubmit(json){
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

   	function ajaxSubmit(ptType, uuid, index, title, description, imgPath, linkType, content){
   		$.ajax({
		   		url:'<%=basePath%>weixinManage/weixinManage!saveSinglePicText.action',
		   		data:{'ptType':ptType, 'uuid':uuid, 'index':index, 'title':title, 'description':description, 'imgPath':imgPath, 'linkType':linkType, 'content':content},
		   		type:'post',
		   		datatype:"text",
		   		success:function(data){
		   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
		   	   		 	return;
		   	   		}
		   		}
		   		
		   	});  	   	
   	}

   	function toReturn(){
   		window.location.href = "<%=basePath%>weixinManage/weixinManage!list.action";
   	}

   	function toPublishMenu(){

        //添加并显示遮罩层     		
   		var windowWidth = document.body.clientWidth;       
        var windowHeight = document.body.clientHeight;  
        $("<div id='loadmask'></div>").addClass("loadmask")   
                                  .width(windowWidth)   
                                  .height(windowHeight)   
                                  .appendTo("body")   
                                  .fadeIn(200);

   		$("#loadingId").css({"position": "absolute"})   
        .animate({left: windowWidth*0.35,    
                  top: windowHeight*0.15, opacity: "show" }, "fast");   
   	   	
   		$.ajax({
	   		url:'<%=basePath%>weixinManage/weixinManage!publishMenu.action',
	   		data:{},
	   		type:'post',
	   		datatype:"text",
	   		success:function(data){
	   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
	   	   		 	return;
	   	   		}
	   	   		
	        	$("#loadingId").hide();  
	   		 	$("#loadmask").remove();   	        	
		   		alert(data);
	   		}
	   		
	   	});  	 
   	}

   	function isSameMenuTile(){
   		var inputObjs = $("#customMenuTable").find("input[name='menu1_input']");
   		if(inputObjs.length==2){
   			if($.trim($(inputObjs.get(0)).val())==$.trim($(inputObjs.get(1)).val())){
	   			return true;
	   	   	}
   	   	}else if(inputObjs.length==3){
	   	   	if($.trim($(inputObjs.get(0)).val())==$.trim($(inputObjs.get(1)).val()) || $.trim($(inputObjs.get(1)).val())==$.trim($(inputObjs.get(2)).val()) || 
	   		   $.trim($(inputObjs.get(0)).val())==$.trim($(inputObjs.get(2)).val())){
	   			return true;
	   	   	}
   	   	}

   	   	return false;
   		
   	}

   	function saveMenu(){
   	   	var menu_1_index=0;
   	   	var menu_2_index=0;
   	   	var trObjs = $("#customMenuTable").find("tr");
   	   	var json = "[";

   	   	if(isSameMenuTile()){
   	   	   	alert("一级菜单名称不能相同！");
   	   	   	return;
   	   	}
   	    
   	 	for(var i=1; i<trObjs.length; i++){
   	 		if(i>1){
	   			json += ",";
	   	   	}
   	   	
   	 		json += "{";
   	   	 	var trObj = trObjs.get(i);
   	 		var inputObjs = $(trObj).find("input");
   	   	 	var menuName = $.trim($(inputObjs.get(0)).val());
   	   	 	var menuLevel;
   	   	 	var menuSerial;
   	   	 	var replyType = "-1";
   	   		var replyText="";
   	   		var replyPtId="";
   	   		if(inputObjs.length>1){
   	   			replyType = $(inputObjs.get(1)).val();
   	   		
   	   	   		if(replyType=="0"){
   	   	   			replyText = $(inputObjs.get(2)).val();
   	   	   	   	}else{
   	   	   	  		replyPtId = $(inputObjs.get(2)).val();
   	   	   	   	}
   	   	   	}	

   	   	   	if(""==menuName){
   	   	  		alert("菜单标题不能为空！");
	   	   	   	return;
   	   	   	}

   	   	   	if("" == replyType){
   	   	   	   	alert("菜单：【"+menuName+"】的回复内容不能为空！");
   	   	   	   	return;
   	   	   	} 	

   	   	   	var titleLength = menuName.replace(/[^\u0000-\u00ff]/g,"aaaa").length;
   	   	 	if($(trObj).attr("name") == "menu1"){
   	   	 		if(titleLength > 16){
   	   	   	 		alert("一级菜单标题最多4个汉字，标题【"+menuName+"】超出了！");
   	   	   	 		return;
   	   	   	 	}
   	   	   	 	
   	   	 		menuLevel = 1;
   	   	 		menu_1_index++;   	 		
   	   	 		menuSerial = menu_1_index;
   	   	 		menu_2_index = 0;  	   	 		
   	   	   	}else{
   	   	 		if(titleLength > 28){
	   	   	 		alert("一级菜单标题最多7个汉字，标题【"+menuName+"】超出了！");
	   	   	 		return;
	   	   	 	}
	   	   	 	
 	   	 	
   	   	  		menuLevel = 2;
   	   	  		menu_2_index++;
   	   	   		menuSerial = menu_1_index + "" + menu_2_index;
   	   	   	}

   	   		json +="\"menuName\":\""+menuName+"\"";
   	   		json +=",\"menuLevel\":\""+menuLevel+"\"";
   	   		json +=",\"menuSerial\":\""+menuSerial+"\"";
   	   		json +=",\"replyType\":\""+replyType+"\"";
   	   		json +=",\"replyText\":\""+replyText+"\"";
   	   		json +=",\"replyPtId\":\""+replyPtId+"\"";
   	   		
   	   		json += "}";
   	   		
   	   	}

   	 	json += "]";

   	 ajaxMenuJsonSubmit(json);
   	}
   	

   	function ajaxMenuJsonSubmit(json){
   		$.ajax({
	   		url:'<%=basePath%>weixinManage/weixinManage!saveCustomMenu.action',
	   		data:{'json':json},
	   		type:'post',
	   		datatype:"text",
	   		success:function(data){
	   			if(checkAjaxSessionOut(data, "<%=basePath%>")){
	   	   		 	return;
	   	   		}
	   	   		
	   			alert(data);	   	
	   			window.location.href = "<%=basePath%>weixinManage/weixinManage!customMenus.action";			
	   		}
	   		
	   	});  
   	}

   	var curTdObj;
   	function showInitPtDialog(obj){
   		changePt($("#tab_txt"), 0);
   		
   		$("#replyTxtErea").val("");
   		
   		var div = $("#previewDiv1");
   		$("#descriptionTxt").val("");
   		$("#singlePtDesc").html("");
   		$("#single_input_title").val("");
   		$("#descriptionLi").css("display","inline"); 
   		$("#descriptionDiv").css("display","none"); 
   		$(div).find("span[name='title']").first().html("标题");
	    var spanObjs = $(div).find("span[name='pic']");
	    $(spanObjs.get(0)).css("display","block"); 
	    var imgObj = $(spanObjs.get(0)).next();
	    $(imgObj).css("display","none");
   	    $(div).find("img").first().attr("src", "");
   	    editor1.setContent("");

   	 	var divObjs = $("#previewDiv2 > div");
   		for(var i=0; i<divObjs.length-1; i++){ 		
   			div = divObjs.get(i);

   			if(i>1){
   	   			$(div).remove();
   	   			break;
   	   		}
   	   		
   	   		if(i==0){
   	   			$(div).find("span[name='title']").first().html("图片标题");   	   	   		
   	   	   	}else{
   	   			$(div).find("span[name='title']").first().html("标题");  	   	   	   	
   	   	   	}
   		    var spanObjs = $(div).find("span[name='pic']");
   		    $(spanObjs.get(0)).css("display","block"); 
   		    var imgObj = $(spanObjs.get(0)).next();
   		    $(imgObj).css("display","none");
   		}

   		$("#editDiv2").css("margin-top","20px");
   		$("#multi_input_title").val("");
   		editor2.setContent("");

   		curTdObj = $(obj).parent();
		popupDiv("dialogDiv");
   	}

   	function bingReplyData(obj){
   		curTdObj = $(obj).parent();
		
   	   	var inputObjs = $(obj).parent().find("input");
   	   	var type = $(inputObjs.get(0)).val();
   	   	var data = $(inputObjs.get(1)).val();
   	   	if(""==type || "0"==type){
   	   		changePt($("#tab_txt"), 0);
   	   		$("#replyTxtErea").val(data);
   	   	}else if("1"==type){
   	   		changePt($("#tab_single_pt"), 1);
   	   		loadPicTexts(data);  	   	   	
   		}else if("2"==type){
   			changePt($("#tab_multi_pt"), 2);
   			loadPicTexts(data);
   	   	}

   	 	popupDiv("dialogDiv");
   	}

   	function loadPicTexts(groupId){
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
				   	
					}
			   			   		
			   		 
		   		}	   		
		   	});    	   	
	}

	function editMenu(obj){
		var spanObjs = $(obj).parent().parent().find("span");
		$(spanObjs.get(0)).css("display","none"); 
		$(spanObjs.get(0)).next().css("display","inline"); 
		$(spanObjs.get(1)).css("display","none"); 
		$(spanObjs.get(1)).next().next().css("display","inline"); 
	}

	function showDescription(obj){
		$(obj).parent().css("display","none");
		$(obj).parent().next().css("display","inline");
	}

	 
</script>
<body class="content_bj" >
<form id="searchFrm" name="searchFrm" action="<%=basePath%>tenantConfigManage/tenantConfigManage!update.action" method="post">
<input type="hidden" id="tenantId" name="tenantId" value="<s:property value="tenantId" />" />
<div style="height:10px;"></div>
<div id="nonValidTip" style="margin-left: 10px;margin-top: 10px;display:none">&nbsp;<img src="<%=basePath%>images/ico_prompt.gif" align="absmiddle" /> 只有服务号才能配置自定义菜单，如果您的微信账号是服务号，请先绑定为服务号再配置自定义菜单！ </div>
<div class="table_box" valign="top">
  
  <table border="0" cellspacing="0" cellpadding="0" style="width:100%">
     <tr>
        <td class="table_b_a"></td>
        <td valign="top" class="table_b_b">
          <table class="table_search" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
            <tr>
              <td>
              <div id="menuDiv" style="width: 120px;">
              <input type="button" class="btn4a" value="添加一级菜单  " onclick="clickMenu()"/>
              <div  class="menu_1" style="display: none;position: absolute;">
		          <li><a onclick="addMenuItem(true)">有子菜单</a></li>
		          <li><a onclick="addMenuItem(false)">无子菜单</a></li>
		      </div>
		      </div>
              </td>
            </tr>
          </table>
          <div class="table_list_box">
          <table id="customMenuTable" border="0" cellspacing="0" cellpadding="0" class="table_list_table" >
             <tr class="table_list_th">
               <td class="table_list_tr">菜单名称</td>
               <td class="table_list_tr">回复消息类型</td>
               <td class="table_list_tr">操作</td>
             </tr>
            	         
			<s:iterator value="customMenuList" status="stat">
				<s:if test="menuLevel==1">
					<tr name="menu1" class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
						<td align="left" width="20%" style="text-indent: 15px;">
							<img src="<%=basePath%>images/cmenu_01.gif" align="absmiddle" style="margin-top: -1px;margin-right:3px;"/> 
							<span style="font:  14px/30px Arial, Helvetica, sans-serif;" ><s:property value="menuName" /></span>
							<input type="text" name="menu1_input" value="<s:property value="menuName" />" class="edittxt" style="display:none;" onkeyup="checkTitleInput(this, 1)" />						
						</td>
						<td nowrap="nowrap" class="table_pt_link" width="15%">
							<s:if test="replyType!=-1">
								<span>
									<s:if test="replyType==0">
										纯文字消息
									 </s:if>
									 <s:elseif test="replyType==1">
										单图文消息
									 </s:elseif>
									 <s:elseif test="replyType==2">
										多图文消息
									 </s:elseif>
								</span>
								<a style="display: none;"></a>
								<a onclick="bingReplyData(this);" style="display: none" >
									<s:if test="replyType==0">
										纯文字消息
									 </s:if>
									 <s:elseif test="replyType==1">
										单图文消息
									 </s:elseif>
									 <s:elseif test="replyType==2">
										多图文消息
									 </s:elseif>
								</a>
								<input type="hidden" value="<s:property value="replyType" />" />
								<s:if test="replyType==0">
									<input type="hidden" value="<s:property value="replyText" />" />							
								</s:if>	
								<s:else>
									<input type="hidden" value="<s:property value="replyPtId" />" />		
								</s:else>
							</s:if>						
						</td>
						<td nowrap="nowrap" width="10%">
							<a onclick="editMenu(this)">编辑</a>&nbsp;&nbsp;					
							<s:if test="replyType <0">
								<a onclick="addSubMenuItem(this);">添加子菜单</a>&nbsp;&nbsp;					
							</s:if>		
	                   		<a onclick="deltr(this)">删除</a>
						</td>
					</tr>
				 </s:if>
				 <s:elseif test="menuLevel==2">
					<tr name="menu2" class="table_list_td" onMouseOver="this.className='table_list_td_over'" onMouseOut="this.className='table_list_td'">
						<td align="left" width="20%" style="text-indent: 35px;">
							<img src="<%=basePath%>images/cmenu_03.gif" align="absmiddle" style="margin-top: -1px;margin-right:3px;"/> 
							<span class="submenufont" ><s:property value="menuName" /></span>
							<input type="text" value="<s:property value="menuName" />" class="edittxt" style="display:none;" onkeyup="checkTitleInput(this, 2)" />	
						</td>
						<td nowrap="nowrap" class="table_pt_link" width="15%">
							<span>
								<s:if test="replyType==0">
									纯文字消息
								 </s:if>
								 <s:elseif test="replyType==1">
									单图文消息
								 </s:elseif>
								 <s:elseif test="replyType==2">
									多图文消息
								 </s:elseif>
							</span>
							<a style="display: none;"></a>											
							<a onclick="bingReplyData(this);" style="display: none" >
								<s:if test="replyType==0">
									纯文字消息
								 </s:if>
								 <s:elseif test="replyType==1">
									单图文消息
								 </s:elseif>
								 <s:elseif test="replyType==2">
									多图文消息
								 </s:elseif>
							</a>
							<input type="hidden" value="<s:property value="replyType" />" />
							<s:if test="replyType==0">
								<input type="hidden" value="<s:property value="replyText" />" />							
							</s:if>	
							<s:else>
								<input type="hidden" value="<s:property value="replyPtId" />" />		
							</s:else>
						</td>
						<td nowrap="nowrap" width="10%">
	                   		<a onclick="editMenu(this)">编辑</a>&nbsp;&nbsp;
	                   		<a onclick="deltr(this)">删除</a>
						</td>
					</tr>
				 </s:elseif>

			</s:iterator>
							
          </table>
          </div>
        </td>
        <td class="table_b_c"></td>
     </tr>
  </table>

 
   <div style="margin-top: 10px;margin-left: auto;margin-right: auto;text-align: center;" >
   	   <input type="button" onClick="saveMenu();" class="btn5" value="保存"/>&nbsp;&nbsp;
       <input type="button" onClick="toPublishMenu();" class="btn4" value="发布"/>&nbsp;&nbsp;
   </div>	
   
</div>
</form>


<!-- 弹出框 --> 
<div id="dialogDiv" class="tc_box" style="display: none;z-index: 1;">
  <div class="tc_tit">绑定回复内容
    <div class="tc_c"><a onclick="hideDiv('dialogDiv');" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image1','','<%=basePath%>images/tc_02.gif',1)"><img src="<%=basePath%>images/tc_01.gif" width="27" height="27" id="Image1" /></a>
    </div>
  </div>
  <div class="tc_bntbg">
    <div class="tc_bnt01"><a id="tab_txt" onclick="changePt(this,0)">纯文字消息</a></div>
    <div class="tc_bnt03"><a id="tab_single_pt" onclick="changePt(this,1)">单图文消息</a></div>
    <div class="tc_bnt01"><a id="tab_multi_pt" onclick="changePt(this,2)">多图文消息</a></div>
    <!--   
    <div class="tc_bnt01"><a onclick="changePt(this,3)">会员卡</a></div>
    <div class="tc_bnt01"><a onclick="changePt(this,4)">优惠券</a></div>
    --> 
  </div>
  
  <!-- 文字 --> 
  <div id="singleTxt" style="margin-top: 5px;display:none;"> 
  	<div style="margin-left: 5px">
       <textarea id="replyTxtErea" style="resize: none;border:1px solid #d2d2d2;height:175px;width:385px;" dataType="Require" max="64" msg="回复文字不能为空!"></textarea>
    </div>
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
          <input id="single_input_title" type="text" class="bj_inp2" onkeyup="syncSinglePtTitle(this)" />
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
				            <div class="tab1"> <a >文章</a></div>
				            <!--
				            <div class="tab2"> <a >会员卡</a></div>
				            <div class="tab2"> <a >优惠券</a></div>
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
				            <div class="tab1"> <a >文章</a></div>
				            <!--
				            <div class="tab2"> <a >会员卡</a></div>
				            <div class="tab2"> <a >优惠券</a></div>
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
    <input type="button" class="btn5" value="确定" onclick="savePt();" />
    <input type="reset" class="btn4"  value="取消" onclick="hideDiv('dialogDiv');" />
  </div>
</div>

<div id="loadingId" style="display: none;z-index: 1;font-size: 13px;">
   <img src="<%=basePath%>images/load.gif" ></img><span>发布中，请稍等......</span>
</div>

</body>
</html>
