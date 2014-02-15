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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>动态模板</title>
<style>
    .screen {
        display: none;
        position: absolute;
        height: 100%;
        width: 100%;
        top: 0;
        left: 0;
        background-color: #000000;
        z-index: 8888;
    }

    .divBg {
        position: absolute;
        height: 100%;
        width: 100%;
        top: 0;
        left: 0;
        z-index: 9100;
    }
    
    .tap2{ overflow:hidden; padding-top:3px; margin-bottom:12px;}
	.tap2 tr td{ margin-right:6px; list-style-type:none;}
	.tap2 tr td img{ width:100%;}
	.input_01{ width:200px; height:38px; font:14px/36px "微软雅黑"; background: url(<%=basePath%>images/auth/iip01.gif); border:0; text-indent:10px;}
	.bnt01{ width:84px; height:38px; font:14px/36px "微软雅黑"; background: url(<%=basePath%>images/auth/iip02.gif); border:0px; color:#fff;}

</style>
<script src="<%=basePath%>web/newtemplate/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form_latest.js"></script>
<script src="<%=basePath%>web/newtemplate/bigcolorpicker/js/jquery.bigcolorpicker.js" type="text/javascript"></script>
<link href="<%=basePath%>web/newtemplate/bigcolorpicker/css/jquery.bigcolorpicker.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>web/newtemplate/css/page.css" rel="stylesheet" type="text/css">
<script type="text/javascript"><!--

	//浏览器版本
	var userAgent = null;

	/**
	 * 生成DIV的ID
	 */
	function genericDivId() {
		//生成小于1的随便数，再乘以10000000
	    var num = Math.round(Math.random() * 10000000);
	    var divId = "div" + num;
	    return divId;
	}
	
	/**
	 * 判断鼠标是否释放，false释放，true按住鼠标左键
	 */
	var divFlag = false;
	
	/**
	 * 鼠标按下控件相对位置，左边
	 */
	var divLeft = null;
	
	/**
	 * 鼠标按下控件相对位置，上边
	 */
	var divTop = null;
	
	/**
	 * 全局DIV变量，给模板内的DIV拖动时在不同方法间传值用的
	 */
	var divObj = null;

	/**
	 * 点击模板内的DIV
	 */
	function divOnMouseDown(plugType, obj) {
	    document.body.onmousemove = divOnMouseMove;
	    document.body.onmouseup = divOnMouseUp;
		//模板里DIV的数量
	    var divSize = $("#templateDiv").find("div").size();
	    //模板内容大于1才能拖拽
	    if(divSize>1){
	    	divFlag = true;
		}
	    divObj = obj;
	    if(plugType!=0){
	    	$("#divOpBtn").show();
			$("#divProperty").show();
			$("#plugDivId").val(obj.id);
			$("#plugType").val(plugType);
			//不能直接COPY缓存中的代码，会把div上的事件也copy到编辑框中
			//$("#divProperty").html($("div").data(obj.id));
			$("#divProperty").html($("#"+obj.id).html());
		}
	}
	
	/**
	 * 移动模板内的DIV
	 */
	function divOnMouseMove() {
	    if (divFlag) {
	    	var hiddenWidget = document.getElementById('floatTemplateDiv');
		    hiddenWidget.style.backgroundImage = "url(<%=basePath%>web/newtemplate/images/yd_22.png)";
		    hiddenWidget.style.display = '';
		    $("#screenDiv").css({"opacity":"0"});
	    	$("#screenDiv").fadeIn("fast");
	    	//$("body").css({"overflow":"hidden"});
		    
	    	if(userAgent=='chrome' || userAgent=='safari'){
	        	$("#floatTemplateDiv").css({'left':event.pageX - 20 , 'top':event.pageY - 20});
			}else if(userAgent=='msie'){
		    	//IE的兼容方式
		    	hiddenWidget.style.pixelLeft = event.x + 30;
		        hiddenWidget.style.pixelTop = event.y + 30;
			}else if(userAgent=='firefox'){
				//火狐暂时不兼容
				$("#floatTemplateDiv").css({'left':event.pageX - divLeft, 'top':event.pageY - divTop});
			}else {
				$("#floatTemplateDiv").css({'left':event.pageX - widgetLeft, 'top':event.pageY - divTop});
			}
			
	        //hiddenWidget.style.pixelLeft = event.x - divLeft;
	        //hiddenWidget.style.pixelTop = event.y - divTop;
	    }
	}
	
	/**
	 * 释放鼠标事件
	 */
	function divOnMouseUp() {
		document.body.onmousemove = null;
	    $("#screenDiv").fadeOut("fast");
	    //隐藏拖拉图片
	    document.getElementById('floatTemplateDiv').style.display = 'none';
	    //鼠标已释放
	    divFlag = false;
	    //console.log('divObj:'+divObj.id);
	    //模板内遍历DIV的顶部坐标
	    var _offsetTop = null;
	    //模板内遍历DIV的高度
	    var _clientHeight = null;
	    //鼠标Y坐标
	    var _y = event.pageY;//event.y;y代表屏幕坐标，pageY页面坐标
	    //当前DIV的顶部坐标
	    var _curDivOffsetTop = divObj.offsetTop;
	    console.log("************************_curDivOffsetTop;:"+_curDivOffsetTop);
	    //当前DIV的底部坐标
	    var _curDivOffsetBottom = _curDivOffsetTop + divObj.clientHeight;
	    //当前移动DIV高度
	    var moveDivHeight = divObj.clientHeight;
	    //模板DIV
	    var template = document.getElementById('templateDiv');
	    //模板DIV顶部坐标
	    var templateOffsetTop = template.offsetTop;
	    //模板DIV的底部坐标
	    var templateOffsetBottom = template.offsetTop + template.clientHeight;
	    //模板里DIV的数量
	    var divSize = $("#templateDiv").find("div").size();
	    //如果鼠标已经移出当前DIV但是未超出模板坐标，就表示已经拖动，再进行遍历，模板内的DIV控件数量必须大于1
	    //console.log("************************_y:"+_y);
	    //console.log("************************templateOffsetTop:"+templateOffsetTop);
	    //console.log("************************templateOffsetBottom:"+templateOffsetBottom);
	    if ((_y < _curDivOffsetTop || _y > _curDivOffsetBottom) && (_y > templateOffsetTop || _y < templateOffsetBottom) && divSize > 1) {
	        //当前移动的DIV ID
	        var moveDivId = divObj.id;
	        //移除当前DIV
	        $("#" + divObj.id).remove();
	        //console.log('moveDivIdHtml---:' + $("div").data(moveDivId));
	        //在IF的时候判断是否已经添加过
	        var appendFlag = true;
	        //console.log("************************template.clientHeight;:"+template.clientHeight);
            //console.log("************************window.screen.height;:"+window.screen.height);
            //console.log("************************document.body.scrollTop;:"+document.body.scrollTop);
            //console.log("************************document.body.scrollHeight;;:"+document.body.scrollHeight);
            //console.log("************************window.screen.availHeight;;;:"+window.screen.availHeight);
	        //遍历模板DIV
	        $("#templateDiv").find("div").each(function (i) {
	            //console.log('i:' + i);
	            //console.log('id:' + this.id + ',offsetTop:' + this.offsetTop + ',clientHeight:' + this.clientHeight);
	            //遍历DIV的顶部坐标
	            _offsetTop = this.offsetTop;
	            //遍历DIV的高度
	            _clientHeight = this.clientHeight;
	            //遍历DIV的中间点
	            var offsetMiddle = _offsetTop + _clientHeight / 2;
	            //如果鼠标小于当前DIV坐标，则移除后面的DIV，添加当前DIV，再添加其它DIV
	            //console.log("moveDivId:" + moveDivId + "---this.id" + this.id);
	            //如果移动的DIV不等于当前遍历的DIV
	            if (moveDivId != this.id) {
	                //如果鼠标点小于遍历的DIV的中间点
	                if (_y < offsetMiddle) {
	                    //console.log('if--i:' + i);
	                    //先判断之前是否已经添加过，避免重复添加
	                    if (appendFlag) {
	                        //将移动的DIV内容从缓存中取出，添加到最后
	                        $("#templateDiv").append($("div").data(moveDivId));
	                        //添加过以后，标志置为false，再循环时避免重复添加
	                        appendFlag = false;
	                    }
	                    //遍历的DIV ID
	                    var tempValue = this.id;
	                    //移除当前遍历的DIV
	                    $("#" + tempValue).remove();
	                    //从缓存中取出当前遍历的DIV内容，并添加到最后
	                    $("#templateDiv").append($("div").data(tempValue));
	                } else {
	                    //console.log('else--i:' + i);
	                    //if(i==divSize-1){
	                    //如果大于等于当前遍历DIV的中间坐标，将移动的DIV内容从缓存中取出，添加到最后
	                    if (appendFlag) {
	                        //console.log('moveDivIdHtml:' + $("div").data(moveDivId));
	                        $("#templateDiv").append($("div").data(moveDivId));
	                        //添加过以后，标志置为false，再循环时不再添加
	                        appendFlag = false;
	                    }
	                    //}
	                }
	            }
	            //console.log('id:'+this.id+',offsetTop:'+this.offsetTop+',clientHeight:'+this.clientHeight);
	        });
	    }
	    document.body.onmouseup = null;
	}

	/**
	 * 鼠标按下控件相对位置，左边
	 */
	var widgetLeft;
	
	/**
	 * 鼠标按下控件相对位置，上边
	 */
	var widgetTop;
	
	/**
	 * 判断鼠标是否释放，false释放，true按住鼠标左键
	 */
	var flag = false;
	
	/**
	 * 页面ID号，根据ID打开不同的页面
	 */
	var openPageId;
	/**
	 * 鼠标按下控件
	 * @param obj
	 */
	function downWidget(imageUrl, pageId) {
	    document.body.onmousemove = moveWidget;
	    document.body.onmouseup = onMouseUp;
	    flag = true;
	    openPageId = pageId;
	    var hiddenWidget = document.getElementById('floatDiv');
	    hiddenWidget.style.backgroundImage = "url(" + imageUrl + ")";
	    hiddenWidget.style.display = '';
	    //$("#tmContent").val(event.x+'---'+event.y);
	    hiddenWidget.style.position = "absolute";
	    if(userAgent=='chrome' || userAgent=='safari'){
	    	$("#floatDiv").css({'left':event.pageX -20 , 'top':event.pageY -20});
		}else if(userAgent=='msie'){
	    	//IE的兼容方式
	    	hiddenWidget.style.pixelLeft = event.x + 15;
		    hiddenWidget.style.pixelTop = event.y + 15;
		}else if(userAgent=='firefox'){
			//火狐暂时不兼容
			$("#floatDiv").css({'left':event.pageX -20 , 'top':event.pageY -20});
		}else {
			$("#floatDiv").css({'left':event.pageX -20 , 'top':event.pageY -20});
		}
	    //hiddenWidget.style.paddingLeft = event.pageX + 15;
	    //hiddenWidget.style.paddingTop = event.pageY + 15;
	    widgetLeft = event.x - hiddenWidget.offsetLeft;
	    widgetTop = event.y - hiddenWidget.offsetTop;
	    $("#screenDiv").css({"opacity":"0"});
	    $("#screenDiv").fadeIn("fast");
	    //$("body").css({"overflow":"hidden"});
	}
	
	/**
	 * 鼠标移动控件
	 * @param obj
	 */
	function moveWidget(event) {
	    if (flag) {
	        //console.log('widgetLeft:'+widgetLeft);
	        //console.log('widgetTop:'+widgetTop);
	        //$("#textContent").val(event.y+'---'+widgetTop);
	        //$("#textContent").val(hiddenWidget.offsetLeft+'------'+hiddenWidget.offsetTop);
	        if(userAgent=='chrome' || userAgent=='safari'){
	        	$("#floatDiv").css({'left':event.pageX - widgetLeft, 'top':event.pageY - widgetTop});
			}else if(userAgent=='msie'){
		    	//IE的兼容方式
		    	var hiddenWidget = document.getElementById('floatDiv');
		    	hiddenWidget.style.pixelLeft = event.x - widgetLeft;
		        hiddenWidget.style.pixelTop = event.y - widgetTop;
			}else if(userAgent=='firefox'){
				//火狐暂时不兼容
				$("#floatDiv").css({'left':event.pageX - widgetLeft, 'top':event.pageY - widgetTop});
			}else {
				$("#floatDiv").css({'left':event.pageX - widgetLeft, 'top':event.pageY - widgetTop});
			}
	    }
	}

	/**
	 * 释放鼠标事件
	 * @param obj
	 */
	function onMouseUp(obj) {
		obj = document.getElementById('floatDiv');
	    //内容模板
	    var templateDiv = document.getElementById('templateDiv');
	    //DIV左边位置坐标
	    var offsetLeft = templateDiv.offsetLeft;
	    //DIV顶部坐标
	    var offsetTop = templateDiv.offsetTop;
	    //DIV宽度
	    var width = templateDiv.clientWidth;
	    //DIV高度
	    var height = templateDiv.clientHeight;
	    //DIV右边坐标
	    var maxRight = offsetLeft + width;
	    //DIV底部坐标
	    var maxBottom = offsetTop + height;
	    //控件左边坐标
	    var objOffsetLeft = obj.offsetLeft;
	    //控件顶部坐标
	    var objOffsetTop = obj.offsetTop;
	    /*console.log("DIV左边位置坐标："+offsetLeft);
	     console.log("DIV顶部坐标："+offsetTop);
	     console.log("DIV宽度："+width);
	     console.log("DIV高度："+height);
	     console.log("DIV右边坐标："+maxRight);
	     console.log("DIV底部坐标："+maxBottom);
	     console.log("obj左边坐标："+objOffsetLeft);
	     console.log("obj顶边坐标："+objOffsetTop);
	     console.log('--------------------');*/
	    $("#screenDiv").fadeOut("fast");
	    obj.style.display = 'none';
	    flag = false;
	    if (objOffsetLeft > offsetLeft && objOffsetLeft < maxRight && objOffsetTop > offsetTop && objOffsetTop < maxBottom) {
	    	var divId = genericDivId();
	    	//新增插件时，隐藏属性区域
	    	hiddenProperty();
	        if (openPageId == 1) {
	            openLogoUrl(divId, "A");
	        }
	        if (openPageId == 2) {
	            openText(divId);
	        }
	        if (openPageId == 3) {
	            openImageUrl(divId, "A");
	        }
	        if (openPageId == 4) {
	            openScrollUrl(divId);
	        }
	        if (openPageId == 5) {
	            openDisclaimerUrl(divId);
	        }
	    }
	
	    //console.log($("#templateDiv").find("div"));
	
	    $("#templateDiv").find("div").each(function (i) {
	        //console.log('id:' + this.id + ',offsetTop:' + this.offsetTop + ',clientHeight:' + this.clientHeight);
	    });
	}

	$(function(){
	    $("#pickBtn").bigColorpicker("color");
	    $("#pickBgBtn").bigColorpicker("backgroundColor");
	});

	function checkTemplateNameLenght(){
		var tmDesc = $("#tmDesc").val();
		if(tmDesc=='' || tmDesc.lenght>20){
			alert("模板名称长度不允许为空或长度大于20个字");
			return false;
		}
		return true;
	}

	function save(){
		if(!checkTemplateNameLenght()){
			return;
		}
		var authType = $("input[name='tmAuthType']:checked").val();
		var innerAuthContent = '<span><img onclick="entrance('+authType+')" src="<%=basePath%>web/newtemplate/images/mfsw.png" style="width:100%;"></span>';
		$("#authDiv").html(innerAuthContent);
		$("#tmContent").val($("#templateDiv").html());
		$("#adFrm").attr("action","<%=basePath%>templateManage/templateManage!updateTemplateContent.action");
		$("#adFrm").submit();
	}

	function saveText(divId){
		if(!checkTemplateNameLenght()){
			return;
		}
		$("#tmContent").val($("#templateDiv").html());
		$("#aiDivId").val(divId);
		$("#adFrm").attr("action","<%=basePath%>templateManage/templateManage!saveOrUpdateText().action");
		$("#adFrm").submit();
	}

	function finish(){
		var divStyle = ' style="clear: both; ';
		//文字颜色
		var color = $("#color").val();
		if(color==''){
			$("#tipMsg").html("请选择文字颜色");
			return;
		}
		divStyle += 'color:'+color+'; ';
		//背景颜色
		var backgroundColor = $("#backgroundColor").val();
		if(backgroundColor==''){
			$("#tipMsg").html("请选择背景颜色");
			return;
		}
		divStyle += 'background-color: '+backgroundColor+'; ';
		
		//字号
		var zihao = $("#zihao").val();
		divStyle += 'font-size:'+zihao+'px; '
		//是否加粗
		if($("#isBold").is(":checked")){
			divStyle += 'font-weight:bold; ';
		}
		//对齐方式
		var alignment = $("#alignment").val();
		divStyle += 'text-align:'+alignment+';"';
		//链接地址
		var linkUrl = $("#linkUrl").val();
		//文本内容
		var content = $("#content").val();
		if(content==''){
			$("#tipMsg").html("请填写文本内容");
			return;
		}
		if(content.length>500){
			$("#tipMsg").html("文本内容长度不能大于500字");
			return;
		}
		var divContent = '';
		if(linkUrl!=''){
			var patrn = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
			if (!patrn.exec(linkUrl)) {
				$("#tipMsg").html("请输入正确的链接地址");
				return;
			}
			if(linkUrl.length>400){
				$("#tipMsg").html("链接地址长度不能超过400个字符");
				return;
			}
			divContent += '<!--<a href="'+linkUrl+'">-->'+content+'<!--</a>-->';
		}else {
			divContent = content;
		}
		//弹出的对话框
		$("#dialogDiv").hide();

		var plugDivId = $("#plugDivId").val();
		addText(divStyle, divContent);
	}
	
	/**
	 * 打开文本编辑器，清空上一次的操作
	 */
	function initTextDiv(){
		$("#color").val('#000000');
		$("#backgroundColor").val('#FFFFFF');
		$("#zihao").val('12');
		$("#isBold").attr("checked", false);
		$("#alignment").val('left');
		$("#linkUrl").val('');
		$("#content").val('');
		$("#atId").val('');
		$("#tipMsg").html("");
	}

	/**
	 * 添加或修改LOGO
	 */
	function addLogo(imageReturnValue, divId, adUrl) {
		var logoDiv = '';
		var plugDivId = $("#plugDivId").val();
		//如果编辑的DIV-ID有值，则是编辑，反之则是新增
		var imageContent = '';
		if(adUrl!=''){
			imageContent = '<!--<a href="'+adUrl+'">--><img src="'+imageReturnValue+'" style="width:100%;"><!--</a>-->';
		}else {
			imageContent = '<img src="'+imageReturnValue+'" style="width:100%;">';
		}
		if(plugDivId!=''){
			//编辑
		    logoDiv = '<span>'+imageContent+'</span>';
	        $("#divProperty").html(logoDiv);
		    $("#"+plugDivId).html(logoDiv);
		    $("div").data(plugDivId, $("#"+plugDivId).html());
		    save();
		}else {
			//新增
			logoDiv = '<div id="' + divId + '" class="gg_widget_div" onmousedown="divOnMouseDown(1, this)" onclick="showProperty(1, this)"><span>' + imageContent+'</span></div>';
		    $("#templateDiv").append(logoDiv);
		    $("div").data(divId, logoDiv);
		    $("#tmContent").val($("#templateDiv").html());
		    save();
		}
	}

	/**
	 * 添加或修改文本
	 */
	function addText(divStyle, divContent) {
		var textDiv = '';
	    var plugDivId = $("#plugDivId").val();
		//如果编辑的DIV-ID有值，则是编辑，反之则是新增
		if(plugDivId!=''){
			//编辑
			var txtValue = '<span '+divStyle+'>' + divContent +'</span>';
			textDiv = '<div id="' + plugDivId + '" class="gg_widget_div" onmousedown="divOnMouseDown(2, this)" onclick="showProperty(2, this)"><span '+divStyle+'>' + divContent +'</span></div>';
		    $("#divProperty").html(textDiv);
		    $("#"+plugDivId).html(txtValue);
		    $("div").data(plugDivId, textDiv);
		    saveText(plugDivId);
		}else {
			//新增
			var divId = genericDivId();
		    textDiv = '<div id="' + divId + '" class="gg_widget_div" onmousedown="divOnMouseDown(2, this)" onclick="showProperty(2, this)"><span '+divStyle+'>' + divContent +'</span></div>';
		    $("#templateDiv").append(textDiv);
		    $("div").data(divId, textDiv);
		    saveText(divId);
		}
	}

	/**
	 * 添加图片广告
	 */
	function addImage(imageTyle, imageUrl1, imageUrl2, divId, adUrl1, adUrl2) {
		var imageDiv = '';
		var plugDivId = $("#plugDivId").val();
		var imageContent1 = '';
		var imageContent2 = '';
		//编辑
		if(plugDivId!=''){
			if(imageTyle == 1){
				if(adUrl1!=''){
					imageContent1 = '<!--<a href="'+adUrl1+'">--><img src="'+imageUrl1+'" style="width:100%;"><!--</a>-->';
				}else {
					imageContent1 = '<img src="'+imageUrl1+'" style="width:100%;">';
				}
				imageDiv = '<span>'+imageContent1+'</span>';
			}
			if(imageTyle == 2){
				if(adUrl1!=''){
					imageContent1 = '<!--<a href="'+adUrl1+'">--><img src="'+imageUrl1+'" style="width:49%;"><!--</a>-->';
				}else {
					imageContent1 = '<img src="'+imageUrl1+'" style="width:49%;">';
				}

				if(adUrl2!=''){
					imageContent2 = '<!--<a href="'+adUrl2+'">--><img src="'+imageUrl2+'" style="width:49%;"><!--</a>-->';
				}else {
					imageContent2 = '<img src="'+imageUrl2+'" style="width:49%;">';
				}
				
				imageDiv = '<span style="margin-left:1px; margin-right:1px;">' +imageContent1+ '</span>' + 
	            			'<span style="margin-left:1px; margin-right:1px;">' +imageContent2+ '</span>';
			}
			$("#divProperty").html(imageDiv);
		    $("#"+plugDivId).html(imageDiv);
		    $("div").data(plugDivId, $("#"+plugDivId).html());
		    save();
		}else {
			//新增
			if(imageTyle == 1){
				if(adUrl1!=''){
					imageContent1 = '<!--<a href="'+adUrl1+'">--><img src="'+imageUrl1+'" style="width:100%;"><!--</a>-->';
				}else {
					imageContent1 = '<img src="'+imageUrl1+'" style="width:100%;">';
				}
				imageDiv = '<div id="' + divId + '" class="gg_widget_div" onmousedown="divOnMouseDown(3, this)" onclick="showProperty(3, this)">' +
							'<span>'+imageContent1+'</span></div>';
			}
			if(imageTyle == 2){
				if(adUrl1!=''){
					imageContent1 = '<!--<a href="'+adUrl1+'">--><img src="'+imageUrl1+'" style="width:49%;"><!--</a>-->';
				}else {
					imageContent1 = '<img src="'+imageUrl1+'" style="width:49%;">';
				}

				if(adUrl2!=''){
					imageContent2 = '<!--<a href="'+adUrl2+'">--><img src="'+imageUrl2+'" style="width:49%;"><!--</a>-->';
				}else {
					imageContent2 = '<img src="'+imageUrl2+'" style="width:49%;">';
				}
				imageDiv = '<div id="' + divId + '" class="gg_widget_div" onmousedown="divOnMouseDown(3, this)" onclick="showProperty(3, this)">' +
				            '<span style="margin-left:1px; margin-right:1px;">' +imageContent1+ '</span>' + 
				            '<span style="margin-left:1px; margin-right:1px;">' +imageContent2+ '</span></div>';
			}
			$("#templateDiv").append(imageDiv);
		    $("div").data(divId, imageDiv);
		    $("#tmContent").val($("#templateDiv").html());
		    save();
		}
	}
	
	/**
	 * 添加滚动图片
	 */
	function addScrollImage() {
	    var divId = genericDivId();
	    var scrollImageDiv = '<div id="' + divId + '" class="gg_widget_div" onmousedown="divOnMouseDown(4, this)" onclick="showProperty(4, this)">' +
	            '<span><img src="./images/WapCircleImg01w.png"></span></div>';
	    $("#templateDiv").append(scrollImageDiv);
	    $("div").data(divId, scrollImageDiv);
	    save();
	}
	
	/**
	 * 添加免责声明
	 */
	function addDisclaimer() {
	    var divId = genericDivId();
	    var disclaimerDiv = '<div id="' + divId + '" class="gg_widget_div disclaimer_focus" onmousedown="divOnMouseDown(5, this)" onclick="showProperty(5, this)">' +
	            '<span style="color:#000000; font-size:14px;font-weight:;text-align:left;">免责声明：</span></div>';
	    $("#templateDiv").append(disclaimerDiv);
	    $("div").data(divId, disclaimerDiv);
	    save();
	}
	
	/**
	 * 打开LOGO上传页面
	 */
	function openLogoUrl(plugDivId, operatorFlag) {
		$("#imageIframeDiv").show();
		$("#imageIframe").show();
		var tmId = $("#tmId").val();
	    var url = "<%=basePath%>templateManage/templateManage!toLogoTemplate.action?&aiDivId=" + plugDivId +"&tmId="+tmId+"&operatorFlag="+operatorFlag;
	    var h = window.screen.height;
	    var w = window.screen.width;
	    $("#imageIframe").css({"width":w, "height":h});
	    $("#imageIframeDiv").css({'position':'absolute', 'left':0, 'top':0, "z-index":10000 });
	    $("#imageIframe").attr("src",url);
	}
	
	/**
	 * 打开文字编辑DIV
	 */
	function openText(plugDivId) {
		initTextDiv();
	    document.getElementById('dialogDiv').style.display = '';
	    var dialogInnerDiv = document.getElementById('dialogInnerDiv');
	    //var iTop = (window.screen.height - 450) / 2 - 50;
	    dialogInnerDiv.style.position = "absolute";
	}
	
	/**
	 * 打开图片页面
	 */
	function openImageUrl(plugDivId, operatorFlag) {
		$("#imageIframeDiv").show();
		$("#imageIframe").show();
	    var tmId = $("#tmId").val();
	    var url = "<%=basePath%>templateManage/templateManage!toImageTemplate.action?&aiDivId=" + plugDivId +"&tmId="+tmId+"&operatorFlag="+operatorFlag;
	    var h = window.screen.height;
	    var w = window.screen.width;
	    $("#imageIframe").css({"width":w, "height":h});
	    $("#imageIframeDiv").css({'position':'absolute', 'left':0, 'top':0, "z-index":10000 });
	    $("#imageIframe").attr("src",url);
	    //$("#imageIframe").css({'position':'relative', 'left':100, 'top':50, 'width':700});
	    //$("#imageIframe").attr("src",url);
	    //var iTop = (window.screen.height - 600) / 2 - 50;
	    //var iLeft = (window.screen.width - 800) / 2;
	    //imageIframe.style.position = "relative";
	    //imageIframe.style.pixelTop = 50;
	    //imageIframe.style.pixelLeft = 100;
	    //imageIframe.src = url;
	}
	
	/**
	 * 打开滚动图片页面
	 */
	function openScrollUrl(plugDivId) {
		$("#imageIframeDiv").show();
		$("#imageIframe").show();
	    var tmId = $("#tmId").val();
	    var url = "<%=basePath%>templateManage/templateManage!toScrollTemplate.action?&aiDivId=" + plugDivId +"&tmId="+tmId;
	    var h = window.screen.height;
	    var w = window.screen.width;
	    $("#imageIframe").css({"width":w, "height":h});
	    $("#imageIframeDiv").css({'position':'absolute', 'left':0, 'top':0, "z-index":10000 });
	    $("#imageIframe").attr("src",url);
	}
	
	/**
	 * 打开免责声明DIV
	 */
	function openDisclaimerUrl(plugDivId) {
		initTextDiv();
	    document.getElementById('dialogDiv').style.display = '';
	    var dialogInnerDiv = document.getElementById('dialogInnerDiv');
	    //var iTop = (window.screen.height - 450) / 2 - 50;
	    dialogInnerDiv.style.position = "relative";
	    dialogInnerDiv.style.pixelTop = 50;
	}

	function init(){
		var tmp = navigator.userAgent.toLowerCase();
		if(tmp.indexOf("chrome")>0){
			userAgent = "chrome";
			
		}
		if(tmp.indexOf("msie")>0){
			userAgent = "msie";
			
		}
		if(tmp.indexOf("firefox")>0){
			userAgent = "firefox";
			
		}
		if(tmp.indexOf("safari")>0){
			userAgent = "safari";
		}
		var authType = 1;

		<s:if test="tmBean.tmAuthType != null">
			<s:if test="tmBean.tmAuthType == 1">
				$("input[name='tmAuthType'][value=1]").attr("checked",true);
			</s:if>
			<s:if test="tmBean.tmAuthType == 2">
				authType = 2;
				$("input[name='tmAuthType'][value=2]").attr("checked",true);
			</s:if>
		</s:if>
		<s:else>
			$("input[name='tmAuthType'][value=1]").attr("checked",true);
		</s:else>
			
		<s:if test="tmContent != null">
			$("#templateDiv").html('<s:property value="tmContent" escape="ture"/>');
		</s:if>
		<s:else>
			<s:if test="tmBean.tmContent != null">
				$("#templateDiv").html('<s:property value="tmBean.tmContent" escape="ture"/>');
			</s:if>
		</s:else>
		initDivData(authType);
	}

	function initDivData(authType){
		$("#templateDiv").find("div").each(function (i) {
			$("div").data(this.id, document.getElementById(this.id).outerHTML);
		});
		var auth = '<div id="authDiv" class="gg_widget_div" onmousedown="divOnMouseDown(0, this)"><span><img onclick="entrance('+authType+')" src="<%=basePath%>web/newtemplate/images/mfsw.png" style="width:100%;"></span></div>';
		var innerAuthContent = '<span><img onclick="entrance('+authType+')" src="<%=basePath%>web/newtemplate/images/mfsw.png" style="width:100%;"></span>';
		$("div").data('authDiv', auth);
		<s:if test="tmBean.tmContent != null">
			$("#authDiv").html(innerAuthContent);
		</s:if>
		<s:else>
			$("#templateDiv").html(auth);
		</s:else>
	}

	//显示属性操作区域
	function showProperty(plugType, obj){
		
	}

	//隐藏属性操作区域
	function hiddenProperty(){
		$("#divOpBtn").hide();
		$("#divProperty").hide();
		//清空上一次点击编辑DIV的相关值
		$("#plugDivId").val('');
		$("#plugType").val('');
	}

	//AJAX获取文本DIV数据
	function getTextDivContent(){
		$("#adFrm").attr("action","<%=basePath%>templateManage/templateManage!queryTextById.action");
		$('#adFrm').ajaxSubmit(function(data) {
			var text = eval('(' + data + ')');
			$("#zihao").val(text.atTextSize);
			if(text.atIsBold=='on'){
				$("#isBold").attr("checked",'true');
			}			
			$("#color").val(text.atTextColor);
			$("#alignment").val(text.atTextAlign);
			$("#backgroundColor").val(text.atBgColor);
			$("#content").val(text.atContent);
			$("#linkUrl").val(text.atUrl);
			$("#atId").val(text.atId);
		});
	}

	//打开文本编辑DIV
	function openEditText() {
	    document.getElementById('dialogDiv').style.display = '';
	    var dialogInnerDiv = document.getElementById('dialogInnerDiv');
	    dialogInnerDiv.style.position = "absolute";
	    //dialogInnerDiv.style.pixelTop = 50;
	}

	function editPlug(){
		var openPageId = $("#plugType").val();
		var plugDivId = $("#plugDivId").val();
		if (openPageId == 1) {
            openLogoUrl(plugDivId, "U");
        }
        if (openPageId == 2) {
        	getTextDivContent();
        	openEditText();
        }
        if (openPageId == 3) {
            openImageUrl(plugDivId, "U");
        }
        if (openPageId == 4) {
            openScrollUrl(plugDivId);
        }
        if (openPageId == 5) {
            openDisclaimerUrl(plugDivId);
        }
	}

	function deletePlug(){
		var plugDivId = $("#plugDivId").val();
		$("div").removeData(plugDivId);
		$("#" + plugDivId).remove();
		save();
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
	    div_obj.css({"position": "absolute", "z-index":10000}); 
	}

	</script>
</head>

<body class="b2" onload="init()" >
<div></div>
<div id="floatDiv" style="clear:both; display:none; position: absolute; z-index: 9999; height: 64px; width: 64px; " >
    <!--  onmouseup="onMouseUp(this)"> -->
</div>

<div id="floatTemplateDiv" style="clear:both; display: none; position: absolute; z-index: 9200; height: 64px; width: 64px;" >
     <!--  onmouseup="divOnMouseUp(this)"> -->
</div>
<div id="imageIframeDiv" style="display: none; background-color: #FFF;">
	<iframe id="imageIframe" style="margin: auto;" ></iframe>
</div>
<div class="all2">

    <div style="min-height:800px">
        <div style="height:10px;"></div>
        <div class="kj">
            <div class="kj_tit">基本控件</div>
            <div style="background-image: url('<%=basePath%>web/newtemplate/images/yx3_09.gif'); width:86px; height: 71px;"
                onmousedown="downWidget('<%=basePath%>web/newtemplate/images/yd_11.png',1)"></div>
            <div style="background-image: url('<%=basePath%>web/newtemplate/images/yx3_12.gif'); width:86px; height: 71px;"
                onmousedown="downWidget('<%=basePath%>web/newtemplate/images/yd_14.png',2)"></div>
            <div style="background-image: url('<%=basePath%>web/newtemplate/images/yx3_14.gif'); width:86px; height: 71px;"
                onmousedown="downWidget('<%=basePath%>web/newtemplate/images/yd_16.png',3)"></div>
            <div style="background-image: url('<%=basePath%>web/newtemplate/images/yx3_16.gif'); width:86px; height: 71px; display:none;"
                onmousedown="downWidget('<%=basePath%>web/newtemplate/images/yd_18.png',4)"></div>
            <div style="background-image: url('<%=basePath%>web/newtemplate/images/yx3_18.gif'); width:86px; height: 71px; display:none;"
                onmousedown="downWidget('<%=basePath%>web/newtemplate/images/yd_20.png',5)"></div>
        </div>
        <div class="sj">
            <div class="sj_t">
            </div>
            <div class="sj_m" id="templateDiv">
            </div>
            <div class="sj_f"></div>
        </div>
        <div class="sx">
        <form id="adFrm" name="adFrm" action="<%=basePath%>templateManage/templateManage!updateTemplateContent.action" method="post">
      		模板名称：<input type="text" id="tmDesc" name="tmDesc" class="add_input" maxlength="20" value='<s:property value="tmBean.tmDesc"/>' />（可编辑模板名称，长度在30个字以内）<br>
      		认证选项：<s:radio list="#{'1':'跳转到认证页面','2':'免认证上网'}" name="tmAuthType" />
      		<span style="display:none">
			tmContent:<input id="tmContent" name="tmContent" type="text" />
			textContent:<input id="textContent" name="textContent" type="text" />
			aiDivId:<input id="aiDivId" name="aiDivId" type="text" />
			tmUuid:<input id="tmUuid" name="tmUuid" type="text" value='<s:property value="tmUuid"/>' />
			tmId:<input id="tmId" name="tmId" type="text" value='<s:property value="tmBean.tmId"/>' />
			atId:<input id="atId" name="text.atId" type="text" value='' />
			plugDivId:<input id="plugDivId" name="plugDivId" type="text" />
			plugType:<input id="plugType" name="plugType" type="text" /></span>
			<input id="saveBtn" onclick="save()" type="button" class="btn1" value="保存" />
			<!-- ///////////////////////////////////     -->
		        <div id="dialogDiv" class="divBg" style="display: none">
		            <div id="dialogInnerDiv" class="gg_win">
		                <div class="gg_win_tit">添加文本
		                    <div class="gg_c">
		                           <img style="cursor: pointer;" onclick="dialogDiv.style.display='none'" 
			                           	src="<%=basePath%>web/newtemplate/images/X3.gif" 
			                           	width="20" height="20" id="Image2"/>
		                    </div>
		                </div>
		                <!--编辑内容开始-->
		                <div class="gg_con">
		                    <div class="gg_tit2">字体(font)</div>
		                    <table border="0" cellspacing="5" cellpadding="0" class="gg_txt_m90">
		                        <tr>
		                            <td width="50%"><font color="red">*&nbsp;</font>文字大小：
		                            <span class="add_table_right">
		                            <select id="zihao" name="text.atTextSize">
		                            	<option value="10">10px</option>
		                            	<option value="12" selected="selected">12px</option>
		                            	<option value="14">14px</option>
		                            	<option value="16">16px</option>
		                            	<option value="18">18px</option>
		                            	<option value="20">20px</option>
		                            </select>
		    						</span></td>
		                            <td width="50%">是否加粗：
		                                <input id="isBold" name="text.atIsBold" type="checkbox" /></td>
		                        </tr>
		                        <tr>
		                            <td><font color="red">*&nbsp;</font>文字颜色：
		                            <span class="add_table_right" id="spanDiv">
		                              <input id="color" name="text.atTextColor" type="text" class="gg_input1" />&nbsp;&nbsp;<input type="button" id="pickBtn" value="选择颜色" />
		                            </span>
		                            </td>
		                            <td><font color="red">*&nbsp;</font>对齐方式：
		                                <select id="alignment" name="text.atTextAlign">
		                                    <option value="left" selected="selected">居左</option>
		                                    <option value="center">居中</option>
		                                    <option value="right">居右</option>
		                                </select>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td><font color="red">*&nbsp;</font>背景颜色：
		                            <span class="add_table_right" id="spanDiv">
		                              <input id="backgroundColor" name="text.atBgColor" type="text" class="gg_input1" />&nbsp;&nbsp;<input type="button" id="pickBgBtn" value="选择颜色" />
		                            </span>
		                            	
		                            </td>
		                            <td></td>
		                        </tr>
		                    </table>
		                    <div class="gg_tit2"><font color="red">*&nbsp;</font>文本内容（长度500字以内）</div>
		                    <div class="gg_txt_m90">
		                        <p><textarea style="resize: none;" id="content" name="text.atContent" class="add_textarea"></textarea></p>
		                        <p>链接地址：<input id="linkUrl" name="text.atUrl" type="text" class="gg_input3"/></p>
		                        <p>链接地址格式：http://www.ruijie.com.cn（长度400字符以内）</p>
		                        <p id="tipMsg" style="color: red;"></p>
		                    </div>
		                </div>
		                <div class="gg_bnt">
		                    <span class="add_btn"><input id="finishBtn" onclick="finish()" type="button" class="btn1" value="保存"/></span>
		                </div>
		                <!--编辑内容end-->
		            </div>
		        </div>
		        <!-- ///////////////////////////////////     -->
			</form>
            <div class="kj_tit">属性</div>
            <div id="divOpBtn" style="display:none; text-align: center; width: 320px;">
            	<input id="edit_btn" class="btn1" type="button" value="编辑" onClick="editPlug();" />
            	<input id="delete_btn" class="btn1" type="button" value="删除" onClick="deletePlug();">
            </div>
            <div id="divProperty" style="overflow: hidden; text-align: center; width: 320px;"></div>
        </div>

    </div>
    <div id="screenDiv" class="screen"><!--该DIV用于锁屏--></div>
</div>

</body>
</html>