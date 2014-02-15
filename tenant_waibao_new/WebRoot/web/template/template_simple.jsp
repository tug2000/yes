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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>模板管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=basePath%>css/auth.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>css/gd.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>js/xytipswindows/style.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>web/imageselect/files/imgareaselect-anima.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>web/imageselect/files/imgareaselect-animated.css">
		<script type="text/javascript"
			src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>web/imageselect/files/jquery.imgareaselect.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>js/util.js"></script>	
		<script type="text/javascript"
			src="<%=basePath%>js/jquery.form_latest.js"></script>
<style type="text/css">
/*------flashbanner style end--------*/
.opacity {
	opacity: 0;
	FILTER: Alpha(Opacity = 0);
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

</style>
</head>
<body class="content_bj">
<form id="adFrm" name="adFrm" action="<%=basePath%>templateManage/templateManage!toSimpleTemplate.action" enctype="multipart/form-data" method="post">
    <input type="hidden" name="tmId" id="tmId" value="<s:property value="adSimpleTmID"/>"/>
    <input type="hidden" name="aiId" id="aiId" value="<s:property value="ad1.aiId"/>"/>
    <input type="hidden" name="ad"  value="1"/>
	<div class="mb01">
		<div class="mb01_l" style="height:auto; background-color: #666" >
			<div class="all_box">
					<div class="tap_ad">
							<li id="duanXinTab" onclick="displayTab('duanxin')">
								<img src='<%=basePath%>images/auth/aa1_01.png'/>
							</li>
							<li id="weiXinTab"  onclick="displayTab('weixin')">
								<img src='<%=basePath%>images/auth/aa1_01a.png'/>
							</li>
					</div>
					<div style="background-color: #FFF" >
						<div class="login_01" id="weiXinDisplayContent" style="display: none">
							<font color="black">请亲移步到本店服务台。用您的微信扫描下二维码，进行上网认证</font>
							<div class="banner_weixin_pic">
								<img src="<%=basePath%>web/template/images/2.jpg" />
							</div>
						</div>
						<div class="login_01" id="duanXinDisplayContent">
							<li>
								<input id="phoneNumber" name="phoneNumber" value="请输入手机号"
									onfocus="this.value=''"
									onblur="if(this.value==''){this.value='请输入手机号'}" type="text"
									class="input_01"/>
							</li>
		
							<li>
								<div id="getPhoneNumber">
									<input name="提交" type="button" onclick="send()" class="bnt01" value="发送"/>
								</div>
								<div id="countDownSpan" style="display: none">
									<span class='count_down_span_text'></span>
								</div>
							</li>

							<li>
								<input id="password" name="password" 
									class="input_01"
									value="请输入密码"
									onfocus="this.value=''"
									onblur="if(this.value==''){this.type='text';this.value='请输入密码'}"
									type="text" class="input_01" onkeydown='this.type="password";'/>
							</li>
							<li>
								<input name="提交" type="button" onclick="authenticate();"
									class="bnt01" value="认证"/>
							</li>
						</div>
				
				    <div class="banner">
				   		<s:if test="ad1 == null">
							<a href="#" onClick="disOpDiv(null,null)" ><img name="ad"
								src="<%=basePath%>images/auth/ban.jpg" /></a>
						</s:if>
						<s:else>
							<a href="#" id="ad_1" onClick="disOpDiv('<s:property value="ad1.aiImagePath" />','<s:property value="ad1.aiAdUrl" />')">
							<img src="<%=basePath%><s:property value="ad1.aiImagePath" />" /></a>
						</s:else>
				    </div>
				    </div>
				</div>
			</div>
		
		<div id="noteDiv" class="mb01_r" style="background:rgba(255, 255, 255, 0);border:0px; display:none">
		  <img alt="" src="<%=basePath%>images/edit.png">
		</div>
		
		<div id="opDiv" class="mb01_r">
			<div class="tith3">
				<span id="optDescription">添加</span>广告图片
			</div>
			<div class="txt01" style="overflow: hidden;">
				<p>
					请选择你要发布到这个位置的图片 <span><font id="msgTip" color="red"><%=msg%></font></span>
				</p>
				
				<p>
					<input type="file" name="upload" size="20"
						onchange="javascript:ajaxupload(this.value);"
						class="text opacity">
					<input name="file_0" id="file_0" value="" class="add_input" />
					<input type="button" value="选择图片" class="btn1">
					<span id="operatorDiv">
					
					<input id="modify_btn" class="btn1" type="button" value="剪裁图片" onClick="readyCutImage();">
					<!--  <input id="submit_btn" class="btn1" type="button" value="提交修改" onClick="updateImage();" />-->
					<input id="delete_btn" class="btn1" type="button" value="删除图片" onClick="delImage();">
				    </span>
				</p>
				
				
				 <p>
					点击图片后打开的页面地址，例如: http://item.jd.com/134178.html
				</p>
		     	<p>
				    <input type="text" name="aiAdUrl" id="aiAdUrl" value="" class="add_input_url" />&nbsp;
				</p>
				
				<div></div>
				<div class="frame adEditDiv" id="cut_div">
					<img id="photo" style="visibility: hidden" >
				</div>
				<div id="preview"
					style="width: 100px; height: 100px; overflow: hidden;">
					<!-- <img id="adImage" src="<%=basePath%>web/imageselect/files/flower2.jpg" style="width: 100px; height: 100px;">-->
				</div>
				<div style="display: none">
					x :
					<input id="startX" name="startX" readonly="readonly" />
					y :
					<input id="startY" name="startY" readonly="readonly" />
					<br />
					宽:
					<input id="width" name="width" readonly="readonly" />
					高:
					<input id="height" name="height" readonly="readonly" />
					<br />
					<input type="hidden" name="cut_img_id" id="cut_img_id" value="" />
				</div>
			</div>
			 <p id="operatorDiv_submit" style="margin:10px 0 10px 10px;display: none">
				<input id="submit_btn" class="btn1" type="button" value="提交修改" onClick="updateImage();" />						
	    	</p>
           
		</div>
		
	</div>

</form>

<script type="text/javascript">
function displayTab(type){
	var duanXinTab = document.getElementById('duanXinTab');
	var weiXinTab = document.getElementById('weiXinTab');
	var weiXinDisplayContent = document.getElementById('weiXinDisplayContent');
	var duanXinDisplayContent = document.getElementById('duanXinDisplayContent');
	if(type=='duanxin'){
		weiXinTab.innerHTML="<img src='<%=basePath%>images/auth/aa1_01a.png'/>";
		duanXinTab.innerHTML="<img src='<%=basePath%>images/auth/aa1_01.png'/>";
		weiXinDisplayContent.style.display='none';
		duanXinDisplayContent.style.display='';
		
	}
	if(type=='weixin'){
		duanXinTab.innerHTML="<img src='<%=basePath%>images/auth/aa1_02.png'/>";
		weiXinTab.innerHTML="<img src='<%=basePath%>images/auth/aa1_02a.png'/>";
		duanXinDisplayContent.style.display='none';
		weiXinDisplayContent.style.display='';
	}
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
	
	
	if(imagePath != null && typeof(imagePath) != "undefined") {
	   $("#photo").attr("src","<%=basePath%>" + imagePath); 
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
	   if(!isNull(aiAdUrl)) {
			if(!httpUrl(aiAdUrl)) {
				alert('页面地址输入不正确!必须以 http:// 开头');
				return;
			}
			
		}
	   var paramters = {aiId:aiId,imageX:x,imageY:y,imageWidth:width,imageHeight:height,aiAdUrl:aiAdUrl};
	   $.post("<%=basePath%>templateManage/templateManage!updateImage.action",paramters,function(ad) {
		   window.location.href = "<%=basePath%>templateManage/templateManage!toSimpleTemplate.action?ad="+ad + "&msgTip=2";
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
		if(!httpUrl(aiAdUrl)) {
			alert('页面地址输入不正确!必须以 http:// 开头');
			return;
		}
		
   }
   
   $('#file_0').val(value);
   $('#adFrm').attr("action","<%=basePath%>templateManage/templateManage!doUploadImage.action");
   $('#adFrm').ajaxSubmit(function(data) { 
	   
	   if((data + "").length > 10) {
		   alert(data);
		   return;
	      }
	
	   window.location.href = "<%=basePath%>templateManage/templateManage!toSimpleTemplate.action?ad="+data+ "&msgTip=1";         
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
	aspectRatio : '1:1.41',
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
			   window.location.href = "<%=basePath%>templateManage/templateManage!toSimpleTemplate.action"; 
		   });
	   }  	   
 }
 
 $(function() {
	 var ad = '<s:property value="ad"/>';
	 ad = ad + "";
	 if(ad != "") {
		 $("#ad_1").click();
	 }
 });
 
 $(function() {
	 $("#startX").val(0);
	 $("#startY").val(0);
	 $("#width").val(0);
	 $("#height").val(0); 
 });
</script>
</body>
</html>
