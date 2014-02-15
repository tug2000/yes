<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String msg = "";
	if (request.getParameter("msgTip") != null) {
		int tip = Integer.valueOf(request.getParameter("msgTip"));
		if (tip == 1) {
			msg = "上传成功!";
		} else {
			msg = "修改成功!";
		}
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
/*------flashbanner style end--------*/
.opacity {
	opacity: 0;
	FILTER: Alpha(Opacity = 0);
	cursor: pointer;
}

.text {
	border: 1px solid #c0c1b3;
}

.text.opacity {
	position: absolute;
	height: 30px;
	width: 260px !important;
}

.text.file {
	width: 150px !important;
	width: 156px;
	z-index: 100;
}

.text.file_btn {
	height: 30px;
	margin: 0 0 -1px 0;
	width: auto !important;
	width: 60px;
	background: #f0f0f0;
	padding: ;
}

.gg_div_out {
	width: 650px;
	margin: auto;
	margin-top: 10px;
	border: 1px #d2d2d2 solid;
	background: #fff;
	overflow: hidden;
}

.gg_win_local {
    width: 650px;
    min-height: 450px;
    _height: 450px;
    border: 1px #999999 solid;
    background: #fff;
    margin: auto;
    color: #000;
    margin-top: 20px;
}
</style>
<link href="<%=basePath%>web/newtemplate/css/page.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>web/imageselect/files/imgareaselect-anima.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>web/imageselect/files/imgareaselect-animated.css">
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery.imgareaselect.js"></script>
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>web/imageselect/files/jquery.imgareaselect.js"></script>
<script type="text/javascript" src="<%=basePath%>js/util.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>
<script type="text/javascript">

	function finish(){
		var t = '<s:property value="uploadDivFlag"/>';
		//var width;
		//var height;
		var patrn = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
		var aiAdUrl1 = $("#aiAdUrl1").val();
		if (t == 1) {
			if (aiAdUrl1!='' && !patrn.exec(aiAdUrl1)) {
				$("#spanMsg1").html("请输入正确的链接地址");
				return;
			}
			<s:if test="ad1 == null">
				alert('图片1不请允许为空，请上传图片');
				return;
			</s:if>

			saveLinkUrl('<s:property value="ad1.aiId"/>', aiAdUrl1, 1);
			/*
			var img = new Image();
			img.src =$('#ad_1').attr("src") ;
			width = img.width;
			height = img.height;
			if(320 > width || 30 > height) {
			   alert('图片1太小！\n\n请上传宽320像素以上，高30像素以上的图片！');
			   return;
		   	}
			*/
		}
		
		if (t == 2) {
			var aiAdUrl2 = $("#aiAdUrl2").val();
			if (aiAdUrl1!='' && !patrn.exec(aiAdUrl1)) {
				$("#spanMsg1").html("请输入正确的链接地址");
				return;
			}
			if (aiAdUrl2!='' && !patrn.exec(aiAdUrl2)) {
				$("#spanMsg2").html("请输入正确的链接地址");
				return;
			}
			saveLinkUrl('<s:property value="ad1.aiId"/>', aiAdUrl1, 1);
			saveLinkUrl('<s:property value="ad2.aiId"/>', aiAdUrl2, 2);
			<s:if test="ad1 == null">
				alert('图片1不请允许为空，请上传图片');
				return;
			</s:if>
			/*
			var img1 = new Image();
			img1.src =$('#ad_1').attr("src") ;
			width = img1.width;
			height = img1.height;
			if(160 > width || 106 > height) {
			   alert('图片1太小！\n\n请上传宽160像素以上，高106像素以上的图片的图片！');
			   return;
		   	}
			*/
			<s:if test="ad2 == null">
				alert('图片2不请允许为空，请上传图片');
				return;
			</s:if>
			/*
			var img2 = new Image();
			img2.src =$('#ad_2').attr("src") ;
			width = img2.width;
			height = img2.height;
			if(160 > width || 106 > height) {
			   alert('图片2太小！\n\n请上传宽160像素以上，高106像素以上的图片的图片！');
			   return;
		   	}
		   	*/
		}
		
		parent.document.getElementById('imageIframeDiv').style.display = "none";
		parent.window.addImage($("#uploadDivFlag").val(), $("#ad_1").attr("src"),
				$("#ad_2").attr("src"), $("#aiDivId").val(),
				 $("#aiAdUrl1").val(), $("#aiAdUrl2").val());
	}
	
	function displayUploadDiv(t) {
		if (t == 1) {
			$("#firstImage").show();
		}
		if (t == 2) {
			$("#firstImage").show();
			$("#secondImage").show();
		}
		$("#uploadDivFlag").val(t);
		$("#chooseDiv").hide();
        $("#uploadImageDiv").show();
    }

	function closeIframe(){
		parent.document.getElementById('imageIframeDiv').style.display = "none";
	}

	function init(){
		<s:if test="aiDivId != null">
			$("#aiDivId").val('<s:property value="aiDivId"/>');
		</s:if>

		<s:if test="uploadDivFlag != null">
			var t = '<s:property value="uploadDivFlag"/>';
			if (t == 1) {
				$("#firstImage").show();
			}
			if (t == 2) {
				$("#firstImage").show();
				$("#secondImage").show();
			}
			$("#chooseDiv").hide();
	        $("#uploadImageDiv").show();
		</s:if>
	
		<s:if test="ad1 != null">
			$("#aiDivId").val('<s:property value="ad1.aiDivId"/>');
			$("#firstImage").show();
			$("#chooseDiv").hide();
	        $("#uploadImageDiv").show();
		</s:if>
		<s:if test="ad2 != null">
			$("#aiDivId").val('<s:property value="ad2.aiDivId"/>');
			$("#firstImage").show();
			$("#secondImage").show();
			$("#uploadDivFlag").val("2");
		</s:if>
	}
</script>
</head>
<body onload="init()">
	<form id="adFrm" name="adFrm"
		action="<%=basePath%>templateManage/templateManage!toImageTemplate.action"
		enctype="multipart/form-data" method="post">
		<input type="hidden" name="tmId" id="tmId" value="<s:property value="tmId"/>" />
		<input type="hidden" name="aiId" id="aiId" value="" />
		<input type="hidden" name="ad" id="ad" />
		<input type="hidden" id="aiDivId" name="aiDivId" />
		<input type="hidden" id="uploadDivFlag" name="uploadDivFlag" value='<s:property value="uploadDivFlag"/>' />
		<input type="hidden" id="operatorFlag" name="operatorFlag" value='<s:property value="operatorFlag"/>' />
		<div id="chooseDiv" class="gg_win_local">
			<div class="gg_win_tit">
				添加图片
				<div class="gg_c">
					<img style="cursor: pointer;" onclick="closeIframe()" src="<%=basePath%>web/newtemplate/images/X3.gif" width="20" height="20" id="Image3" />
				</div>
			</div>
			<!--编辑内容开始-->
			<div class="gg_con">
				<div class="gg_tit2">请选择您需要的模板</div>
				<table width="100%" border="0" cellspacing="7" cellpadding="0"
					class="gg_txt_m90 gg_f16">
					<tr>
						<td width="50%" align="center">单张图片</td>
						<td width="50%" align="center">两张并排图片</td>
					</tr>
					<tr>
						<td align="center">
								<img style="cursor: pointer;" onclick="displayUploadDiv(1)" 
									src="<%=basePath%>web/newtemplate/images/gg_pic3.gif"
									width="256" height="256" id="Image5" />
						</td>
						<td align="center">
								<img style="cursor: pointer;" onclick="displayUploadDiv(2)" 
									src="<%=basePath%>web/newtemplate/images/gg_pic4.gif"
									width="256" height="256" id="Image6" />
						</td>
					</tr>
				</table>
			</div>
			<!--编辑内容end-->
		</div>

		<!--选择图片模式后弹出的页面，上传功能-->
		<div id="uploadImageDiv" class="gg_win_local" style="display: none;">
			<div class="gg_win_tit">
				添加图片
				<div class="gg_c">
					<img style="cursor: pointer;" onclick="closeIframe()" src="<%=basePath%>web/newtemplate/images/X3.gif" width="20" height="20" id="Image14" />
				</div>
			</div>
			<!--编辑内容开始-->
			<div class="gg_con">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="gg_txt_m90 gg_table1">
					<tr class="gg_table1_tit">
						<td width="20%">缩略图</td>
						<td width="80%">链接地址（例如: http://www.ruijie.com.cn）</td>
					</tr>
					<tr id="firstImage" style="display: none;" class="gg_table1_td">
						<td>
							<s:if test="ad1 != null">
									<img id="ad_1" width="80" height="80" 
										onclick="disOpDiv('<s:property value="ad1.aiId"/>', 1, 1,'<s:property value="ad1.aiImagePath" />','<s:property value="ad1.aiAdUrl" />','modify')"
										src="${imgServerPath}<s:property value="ad1.aiImagePath" />"
										width="100%" style="cursor: pointer;" />
							</s:if>
							<s:else>
								<img onclick="disOpDiv('null', 1, 1,null,null,'add')"
									src="<%=basePath%>web/newtemplate/images/gg_pic2.gif"
									width="80" height="80" />
							</s:else>
						</td>
						<td class="gg_pic_i">
							<input type="text" id="aiAdUrl1" name="ad1.aiAdUrl" value='<s:property value="ad1.aiAdUrl" />' size="50" class="add_input_url" />
							<s:if test="ad1 != null">
								<input id="saveLinkBtn1" onclick="saveLinkUrl('<s:property value="ad1.aiId"/>', aiAdUrl1.value, 1)" type="button" class="btn4" value="保存地址"/>
							</s:if>
							<br>
							<span id="spanMsg1" style="color:red;"></span>
						</td>
					</tr>
					<tr id="secondImage" style="display: none;" class="gg_table1_td">
						<td>
							<s:if test="ad2 != null">
								<img id="ad_2" width="80" height="80" 
									onclick="disOpDiv('<s:property value="ad2.aiId"/>', 1, 2,'<s:property value="ad2.aiImagePath" />','<s:property value="ad2.aiAdUrl" />','modify')"
									src="${imgServerPath}<s:property value="ad2.aiImagePath" />"
									width="100%" style="cursor: pointer;" />
							</s:if>
							<s:else>
								<img onclick="disOpDiv('null', 1, 2,null,null,'add')"
									src="<%=basePath%>web/newtemplate/images/gg_pic2.gif"
									width="80" height="80" />
							</s:else>
						</td>
						<td class="gg_pic_i">
							<input type="text" id="aiAdUrl2" name="ad2.aiAdUrl" value='<s:property value="ad2.aiAdUrl" />' size="50" class="add_input_url" />
							<s:if test="ad2 != null">
								<input id="saveLinkBtn2" onclick="saveLinkUrl('<s:property value="ad2.aiId"/>',aiAdUrl2.value, 2)" type="button" class="btn4" value="保存地址"/>
							</s:if>
							<br>
							<span id="spanMsg2" style="color:red;"></span>
						</td>
					</tr>
					<s:if test="ad1 != null">
						<tr id="thirdTr" class="gg_table1_td">
							<td colspan="2">
								<span class="add_btn"><input id="finishBtn" onclick="finish()" type="button" class="btn4" value="保存图片"/></span>
							</td>
						</tr>
					</s:if>
				</table>
			</div>

			<div id="opDiv" class="gg_div_out" style="display:none">
				<div class="gg_win_tit">
					<span id="optDescription">添加</span>广告图片
				</div>
				<div class="txt01">
					<p style="color: red">上传的图片大小不能超过500KB</p>
					<p>
						请选择你要发布到这个位置的图片 <span><font id="msgTip" color="red"><%=msg%></font>
						</span>
					</p>
					
					<p>
						<input type="file" id="upload" name="upload" size="20" onchange="javascript:ajaxupload(this.value);" class="text opacity">
						<input name="file_0" id="file_0" value="" class="add_input" />
						<input type="button" value="选择图片" class="btn4"> 
						<span id="operatorDiv">
							<input id="modify_btn" class="btn4" type="button" value="编辑图片" onClick="readyCutImage();">
							<input id="delete_btn" class="btn4" type="button" value="删除图片" onClick="delImage();">
						</span>
						<span id="operatorDiv_submit" style="display: none">
							<input id="submit_btn" class="btn4" type="button" value="提交编辑" onClick="updateImage();" />
						</span>
					</p>

					<input type="hidden" name="aiAdUrl" id="aiAdUrl" />

					<div></div>
					<div class="frame adEditDiv" id="cut_div">
						<img id="photo" style="visibility: hidden">
					</div>
					<div id="preview"
						style="width: 100px; height: 100px; overflow: hidden;"></div>
					<div style="display: none">
						x : <input id="startX" name="startX" readonly="readonly" /> y : <input
							id="startY" name="startY" readonly="readonly" /> <br /> 宽: <input
							id="width" name="width" readonly="readonly" /> 高: <input
							id="height" name="height" readonly="readonly" /> <br /> <input
							type="hidden" name="cut_img_id" id="cut_img_id" value="" />
					</div>
				</div>
			</div>
		</div>
	</form>

	<form id="adTextFrm" name="adTextFrm"
		action="<%=basePath%>templateManage/templateManage!saveOrUpdateTextForBank.action?msgTip=3"
		method="post">
		<input type="hidden" name="text.atContent" id="atContent" value='' />
		<input type="hidden" name="text.atId" id="atId"
			value='<s:property value="text.atId"/>' /> <input type="hidden"
			name="text.atTmId" id="atTmId"
			value="<s:property value="adBankTmID"/>" />
	</form>
	
	<script type="text/javascript">
	
	var cut_ias = $('#photo').imgAreaSelect({
		instance: true,
		handles : true,
		aspectRatio : '3:2',
		fadeSpeed : 200,
		onSelectChange : preview,
		hide : false
	});
		
	function cleanCutImageParamters() {
		$("#startX").val(0);
		$("#startY").val(0);
		$("#width").val(0);
		$("#height").val(0);
	}

	var operatorDivHtml = $("#operatorDiv").html();
	/**
     * @param imgId		数据库图片的ID
     * @param flag		点击图片的时候让编辑框出来		
     * @param ad		图片位置
     * @param imagePath	图片路径
     * @param adUrl		图片URL链接地址
     * @param optFlag	操作标识 add modify
     */
	function disOpDiv(imgId, flag, ad,imagePath,adUrl,optFlag){
		if(ad != 'null' && ad != null) {
			$("#ad").val(ad);
			var tmp;
			var patrn = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
			if(ad==1){
				tmp = $("#aiAdUrl1").val();
				if(!isNull(tmp)) {
					if (!patrn.exec(tmp)){
						alert('页面地址输入不正确!必须以 http:// 开头');
						return;
					}
					$('#aiAdUrl').val(tmp);
			   }
			}
			if(ad==2){
				tmp = $("#aiAdUrl2").val();
				if(!isNull(tmp)) {
					if (!patrn.exec(tmp)){
						alert('页面地址输入不正确!必须以 http:// 开头');
						return;
					}
					$('#aiAdUrl').val(tmp);
			   }
			}
		}else {
			$("#ad").val("");
		}
		cleanCutImageParamters();
		//取消图片选择区域，避免前一张图片选择后切换到后一张 保留区域的问题
		cut_ias.cancelSelection();
		if(flag==1){
			$("#opDiv").show();
		}
		if(flag==2){
			$("#opDiv").hide();
		}
		
		if(imagePath != null && typeof(imagePath) != "undefined") {
		   $("#photo").attr("src","${imgServerPath}" + imagePath); 
		   $("#photo").css("visibility","visible");	
		}else {
		   $("#photo").remove("src"); 
		   $("#photo").css("visibility","hidden");
		}
		/*
		if(adUrl != null && typeof(adUrl) != "undefined") {
		   $("#aiAdUrl").val(adUrl);	
		}else {
		   $("#aiAdUrl").val("");	
		}
		*/
		if(optFlag == 'add') {
			$("#operatorDiv").empty();
			$("#optDescription").text("添加");
			$("#operatorDiv_submit").hide();
		}else {
			$("#operatorDiv").html(operatorDivHtml);
			$("#optDescription").text("修改");
			$("#operatorDiv_submit").show();
		}
		
		if(imgId != 'null' && imgId != null) {
			$("#aiId").val(imgId);
		}else {
			$("#aiId").val("");
			$("#upload").click();
		}
		
		$("#msgTip").text("");
		$("#msgTip1").text("");
	}

	 function updateImage() {
		 var x = $("#startX").val();
		 var y = $("#startY").val();
		 var width = $("#width").val();
		 var height =$("#height").val();
		   
		 var t = $("#uploadDivFlag").val();
			if(t==1){
				if(320 > width || 30 > height) {
				   alert('图片太小，不支持剪裁！\n\n剪裁功能只适用于宽320像素以上，高30像素以上的图片！');
				   return;
			   	}
			}
			if(t==2){
				if(160 > width || 30 > height) {
				   alert('图片太小，不支持剪裁！\n\n剪裁功能只适用于宽320像素以上，高30像素以上的图片！');
				   return;
			   	}
			}
			
		   if(!confirm("确定提交所有修改操作吗？")) {
			   return false;
		   }
		   var aiId = $("#aiId").val();
		 
		   
		  
		   var aiAdUrl = $("#aiAdUrl").val();
		   var aiDivId = $("#aiDivId").val();
			var uploadDivFlag = $("#uploadDivFlag").val();
			var tmId = $("#tmId").val();
			var operatorFlag = $("#operatorFlag").val();
		   if(!isNull(aiAdUrl)) {
			    var patrn = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
				if (!patrn.exec(aiAdUrl)){
					alert('页面地址输入不正确!必须以 http:// 开头');
					return;
				}
			}
			
		   var paramters = {aiId:aiId,imageX:x,imageY:y,imageWidth:width,imageHeight:height,aiAdUrl:aiAdUrl};
		   $.post("<%=basePath%>templateManage/templateManage!updateImage.action",paramters,function(ad) {
			   window.location.href = "<%=basePath%>templateManage/templateManage!toImageTemplate.action?ad="
				   +ad+"&aiDivId="+aiDivId+"&uploadDivFlag="+uploadDivFlag +"&tmId="+tmId+"&operatorFlag="+operatorFlag;
		   });

	}

	function ajaxupload(value) {
	  
	   if(value == null || value == '') {
		   return;
	   }
	   if(!isImage(value)) {
		   alert('不支持上传该图片类型!');
		   return;
	   }
	   
	   var aiAdUrl = $('#aiAdUrl').val();
	   if(!isNull(aiAdUrl)) {
		    var patrn = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
			if (!patrn.exec(aiAdUrl)){
				alert('页面地址输入不正确!必须以 http:// 开头');
				return;
			}
	   }
	   
	   $('#file_0').val(value);
	   $('#adFrm').attr("action","<%=basePath%>templateManage/templateManage!doUploadImage.action");
	   $('#adFrm').ajaxSubmit(function(data) { 
		var aiDivId = $("#aiDivId").val();
		var uploadDivFlag = $("#uploadDivFlag").val();
		var operatorFlag = $("#operatorFlag").val();
		var tmId = $("#tmId").val();
	   	if((data + "").length > 10) {
			alert(data);
			return;
	   	}
	
	   	window.location.href = "<%=basePath%>templateManage/templateManage!toImageTemplate.action?ad="
		   	+data+"&msgTip=1&aiDivId="+aiDivId+"&uploadDivFlag="+uploadDivFlag +"&tmId="+tmId+"&operatorFlag="+operatorFlag;
	    });
	}

	function preview(img, selection) {
		if (!selection.width || !selection.height)
			return;
		var scaleX = 100 / selection.width;
		var scaleY = 100 / selection.height;

		$('#preview img').css({
			width : Math.round(scaleX * 300),
			height : Math.round(scaleY * 300),
			marginLeft : -Math.round(scaleX * selection.x1),
			marginTop : -Math.round(scaleY * selection.y1)
		});
		
		$("#startX").val(selection.x1);
		$("#startY").val(selection.y1);
		$("#width").val(selection.width);
		$("#height").val(selection.height);
	}

	function readyCutImage() {
		debugger;
		var img = new Image();
		img.src =$('#photo').attr("src") ;
		var w = img.width;
		var h = img.height;
	   	var t = $("#uploadDivFlag").val();
		if(t==1){
			if(320 > w || 30 > h) {
			   alert('图片太小，不支持剪裁！\n\n剪裁功能只适用于宽320像素以上，高30像素以上的图片！');
			   return;
		   	}
			cut_ias.setOptions({aspectRatio:'', show: true, x1: 0, y1: 0, x2: 320, y2: 30 });
			$("#width").val(320);
			$("#height").val(30);
		}
		if(t==2){
			if(160 > w || 30 > h) {
			   alert('图片太小，不支持剪裁！\n\n剪裁功能只适用于宽320像素以上，高30像素以上的图片！');
			   return;
		   	}
			$("#aspectRatio").val("3:2");
			cut_ias.setOptions({aspectRatio:$("#aspectRatio").val(), show: true, x1: 0, y1: 0, x2: 150, y2: 100 });
			$("#width").val(150);
			$("#height").val(100);   
		}
	   
	   //cut_ias.setOptions({aspectRatio:$("#aspectRatio").val(), show: true, x1: 0, y1: 0, x2: 320, y2: 76 });
	   //cut_ias.setOptions({show: true, x1: 0, y1: 0, x2: 320, y2: 76 });
	   cut_ias.update();
	
	   $("#startX").val(0);
	   $("#startY").val(0);
	   
	 }
	function delImage(mark) {
		if(confirm("确定删除图片吗？")) {
			var paramters = {aiId:$('#aiId').val()};
			$.post("<%=basePath%>templateManage/templateManage!del.action",paramters,function() {
				var aiDivId = $("#aiDivId").val();
				var uploadDivFlag = $("#uploadDivFlag").val();
				var tmId = $("#tmId").val();
				var operatorFlag = $("#operatorFlag").val();
				   window.location.href = "<%=basePath%>templateManage/templateManage!toImageTemplate.action?aiDivId="
					   +aiDivId+"&uploadDivFlag="+uploadDivFlag +"&tmId="+tmId+"&operatorFlag="+operatorFlag;
			});
		}
	}

	$(function() {
		var ad = '<s:property value="ad"/>';
		ad = ad + "";
		if (ad == "1") {
			$("#ad_1").click();
		}
		if (ad == "2") {
			$("#ad_2").click();
		}
	});

	$(function() {
		$("#startX").val(0);
		$("#startY").val(0);
		$("#width").val(0);
		$("#height").val(0);
	});

	function saveLinkUrl(aiId, aiAdUrl, position){
		var patrn = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
		if (!patrn.exec(aiAdUrl)) {
			if(position==1){
				$("#spanMsg1").html("请输入正确的链接地址");
			}
			if(position==2){
				$("#spanMsg2").html("请输入正确的链接地址");
			}
			return;
		}
		$("#aiId").val(aiId);
		$("#aiAdUrl").val(aiAdUrl);
		$("#adFrm").attr("action","<%=basePath%>templateManage/templateManage!saveImageLinkUrl.action");
		$('#adFrm').ajaxSubmit(function(data) {
			if(position==1){
				$("#spanMsg1").html(data);
				$("#spanMsg2").html("");
			}
			if(position==2){
				$("#spanMsg2").html(data);
				$("#spanMsg1").html("");
			}
		});
		$("#aiId").val("");
		$("#aiAdUrl").val("");
	}
</script>

</body>
</html>