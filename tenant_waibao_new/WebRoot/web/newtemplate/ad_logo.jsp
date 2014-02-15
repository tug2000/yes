<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + path + "/"; 
String msg = "";
if(request.getParameter("msgTip") != null) {
   int tip = Integer.valueOf(request.getParameter("msgTip"));
   if(tip == 1) {
	  msg = "上传成功!"; 
   }else {
	  msg = "修改成功!"; 
   }
}

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<style type="text/css">
	/*------flashbanner style end--------*/
	.opacity {
		opacity: 0;
		FILTER: Alpha(Opacity =   0);
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
	
	.div_out {
		width: 650px;
		margin: auto;
		margin-top: 20px;
		border: 1px #d2d2d2 solid;
		background: #fff;
		overflow: hidden;
	}
</style>
</head>
<body style="background: #fff">
	<form id="adFrm" name="adFrm"
			action="<%=basePath%>templateManage/templateManage!toSimpleTemplate.action"
			enctype="multipart/form-data" method="post">
		<input type="hidden" name="tmId" id="tmId" value="<s:property value="tmId"/>" />
		<input type="hidden" name="aiId" id="aiId" value='<s:property value="ad1.aiId"/>' />
		<input type="hidden" id="ad" name="ad" value="1" />
		<input type="hidden" id="aiDivId" name="aiDivId" value='<s:property value="aiDivId"/>' />
		<input type="hidden" id="operatorFlag" name="operatorFlag" value='<s:property value="operatorFlag"/>' />
		<div id="opDiv" class="div_out">
			<div class="gg_win_tit">
				添加LOGO标志
				<div class="gg_c">
					<img style="cursor: pointer;" onclick="closeIframe()" src="<%=basePath%>web/newtemplate/images/X3.gif" width="20" height="20" id="Image14" />
				</div>
			</div>
			<div class="txt01">
				<p>
					请选择你要发布到这个位置的图片 <span><font id="msgTip" color="red"><%=msg%></font>
					</span>
				</p>
				
				<p>
					<s:if test="ad1 != null">
						<img id="ad_1" width="150px" height="100px" src="${imgServerPath}<s:property value="ad1.aiImagePath" />"
									width="100%" style="cursor: pointer;"
									onClick="disOpDiv('<s:property value="ad1.aiImagePath" />','<s:property value="ad1.aiAdUrl" />')" />
						<span class="add_btn"><input id="finishBtn" onclick="finish()" type="button" class="btn4" value="保存图片"/></span>			
					</s:if>
				</p>
				
				<p>点击图片后打开的页面地址，例如: http://www.ruijie.com.cn</p>
				<p>
					<input type="text" name="aiAdUrl" id="aiAdUrl" size="60" value='<s:property value="ad1.aiAdUrl" />' class="add_input_url" />&nbsp;
					<span id="spanMsg" style="color:red;"></span>
					<s:if test="ad1 != null">
						<input id="saveLinkBtn" onclick="saveLinkUrl()" type="button" class="btn4" value="保存地址"/>
					</s:if>
				</p>
				
				<p style="color: red">上传的图片大小不能超过500KB</p>
				<p>
					<input type="file" name="upload" size="20"
						onchange="javascript:ajaxupload(this.value);" class="text opacity">
					<input name="file_0" id="file_0" value="" class="add_input" /> <input
						type="button" value="选择图片" class="btn4"> 
					<span id="operatorDiv">
						
					</span>
					<span id="operatorDiv_submit" style="display: none">
						<input id="modify_btn" class="btn4" type="button" value="编辑图片" onClick="readyCutImage();">
						<input id="delete_btn" class="btn4" type="button" value="删除图片" onClick="delImage();">
						<input id="submit_btn" class="btn4" type="button" value="提交编辑" onClick="updateImage();" />
					</span>
				</p>
	
				<div></div>
				<div class="frame adEditDiv" id="cut_div">
					<img id="photo" style="visibility: hidden">
				</div>
				<div id="preview"
					style="width: 100px; height: 100px; overflow: hidden;">
					<!-- <img id="adImage" src="http://localhost/mcp/web/imageselect/files/flower2.jpg" style="width: 100px; height: 100px;">-->
				</div>
				<div style="display: none">
					x : <input id="startX" name="startX" readonly="readonly" /> y : <input
						id="startY" name="startY" readonly="readonly" /> <br /> 宽: <input
						id="width" name="width" readonly="readonly" /> 高: <input
						id="height" name="height" readonly="readonly" /> <br /> <input
						type="hidden" name="cut_img_id" id="cut_img_id" value="" />
				</div>
				
			</div>
		</div>
	</form>
	
	<script type="text/javascript">

		function finish(){
			parent.document.getElementById('imageIframeDiv').style.display = "none";
			parent.window.addLogo($("#ad_1").attr("src"), $("#aiDivId").val(), $("#aiAdUrl").val());
		}

		function closeIframe(){
			parent.document.getElementById('imageIframeDiv').style.display = "none";
		}
		
		function cleanCutImageParamters() {
			$("#startX").val(0);
			$("#startY").val(0);
			$("#width").val(0);
			$("#height").val(0);
		}
	
		function disOpDiv(imagePath,adUrl){
			cleanCutImageParamters();
			//取消图片选择区域
			cut_ias.cancelSelection();
			
			$("#opDiv").show();
			$("#txtDiv").hide();
			
			if(imagePath != null && typeof(imagePath) != "undefined") {
			   $("#photo").attr("src","${imgServerPath}" + imagePath); 
			   $("#photo").css("visibility","visible");	
			   $("#operatorDiv_submit").show();
			}
			
			if(adUrl != null && typeof(adUrl) != "undefined") {
			   $("#aiAdUrl").val(adUrl);	
			}else {
			   $("#aiAdUrl").val("");	
			}
		}
	
		 function updateImage() {
			   if(!confirm("确定提交所有修改操作吗？")) {
				   return false;
			   }
			   var aiId = $("#aiId").val();
			 
			   var x = $("#startX").val();
			   var y = $("#startY").val();
			   var width = $("#width").val();
			   var height =$("#height").val();
			  
			   var aiAdUrl = $("#aiAdUrl").val();
			   var aiDivId = $("#aiDivId").val();
			   var uploadDivFlag = $("#uploadDivFlag").val();
			   var operatorFlag = $("#operatorFlag").val();
			   var tmId = $("#tmId").val();
			   if(!isNull(aiAdUrl)) {
				    var patrn = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
					if (!patrn.exec(aiAdUrl)){
						alert('页面地址输入不正确!必须以 http:// 开头');
						return;
					}
				}
			   var paramters = {aiId:aiId,imageX:x,imageY:y,imageWidth:width,imageHeight:height,aiAdUrl:aiAdUrl};
			   $.post("<%=basePath%>templateManage/templateManage!updateImage.action",paramters,function(ad) {
				   window.location.href = "<%=basePath%>templateManage/templateManage!toLogoTemplate.action?ad="
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

				window.location.href = "<%=basePath%>templateManage/templateManage!toLogoTemplate.action?ad="
					+data+ "&msgTip=1&aiDivId="+aiDivId+"&uploadDivFlag="+uploadDivFlag +"&tmId="+tmId+"&operatorFlag="+operatorFlag;
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
	
		  var cut_ias = $('#photo').imgAreaSelect({
			instance: true,
			handles : true,
			//aspectRatio : '2:1',
			fadeSpeed : 200,
			onSelectChange : preview,
			hide : false
		  });
	
		function readyCutImage() {
			var img = new Image();
			img.src =$('#photo').attr("src") ;
			var w = img.width;
			var h = img.height;
		   
			if(56 > w || 76 > h) {
				alert('图片太小，不支持剪裁！\n\n剪裁功能只适用于宽56像素以上，高76像素以上的图片！');
				return;
			}
			cut_ias.setOptions({show: true, x1: 0, y1: 0, x2: 56, y2: 76 });
			cut_ias.update();
			
			$("#startX").val(0);
			$("#startY").val(0);
			$("#width").val(56);
			$("#height").val(76);
		}
		 
		 function delImage(mark) {
			   if(confirm("确定删除图片吗？")) {
				   $('#adFrm').attr("action","<%=basePath%>templateManage/templateManage!del.action");
				   $('#adFrm').ajaxSubmit(function() {
					   var operatorFlag = $("#operatorFlag").val();
					   window.location.href = "<%=basePath%>templateManage/templateManage!toLogoTemplate.action";
							});
			}
		}
	
		$(function() {
			var ad = '<s:property value="ad"/>';
			ad = ad + "";
			if (ad != "") {
				$("#ad_1").click();
			}
		});
	
		$(function() {
			$("#startX").val(0);
			$("#startY").val(0);
			$("#width").val(0);
			$("#height").val(0);
		});

		function saveLinkUrl(){
			var linkUrl = $("#aiAdUrl").val();
			var patrn = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
			if (!patrn.exec(linkUrl)) {
				$("#spanMsg").html("请输入正确的链接地址");
				return;
			}
			$("#adFrm").attr("action","<%=basePath%>templateManage/templateManage!saveImageLinkUrl.action?operatorFlag="+operatorFlag);
			$('#adFrm').ajaxSubmit(function(data) {
				$("#spanMsg").html(data);
			});
		}
</script>
</body>
</html>