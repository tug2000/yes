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
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.txt01 {
   overflow:hidden; zoom:1;
 }
.num {
	clear: both;
	position: absolute;
	right: -5px;
	top: 175px;
}

.num li {
	float: left;
	list-style: none;
	color: #fff;
	text-align: center;
	line-height: 16px;
	width: 16px;
	height: 16px;
	font-family: Arial;
	font-size: 12px;
	cursor: pointer;
	margin: 1px;
	border: 1px solid #707070;
	background-color: #060a0b;
}

.num li.on {
	line-height: 18px;
	width: 18px;
	height: 18px;
	font-size: 14px;
	border: 0;
	background-color: #ce0609;
	font-weight: bold;
}
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

.gg_div_out {
	width: 550px;
	margin: auto;
	margin-top: 10px;
	border: 1px #d2d2d2 solid;
	background: #fff;
	overflow: hidden;
}

.container, .container img{max-width:330px;min-width:320px;height:200px;padding:0px 10px 5px 32px;}
.container{border:1px solid #333;}
.container img{border:0;}
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

	var ad = function (id) {
        return "string" == typeof id ? document.getElementById(id) : id;
	};
	var Extend = function(destination, source) {
	        for (var property in source) {
	                destination[property] = source[property];
	        }
	        return destination;
	};
	var CurrentStyle = function(element){
	        return element.currentStyle || document.defaultView.getComputedStyle(element, null);
	};
	var Bind = function(object, fun) {
	        var args = Array.prototype.slice.call(arguments).slice(2);
	        return function() {
	                return fun.apply(object, args.concat(Array.prototype.slice.call(arguments)));
	        };
	};
	var Tween = {
	        Quart: {
	                easeOut: function(t,b,c,d){
	                        return -c * ((t=t/d-1)*t*t*t - 1) + b;
	                }
	        },
	        Back: {
	                easeOut: function(t,b,c,d,s){
	                        if (s == undefined) s = 1.70158;
	                        return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
	                }
	        },
	        Bounce: {
	                easeOut: function(t,b,c,d){
	                        if ((t/=d) < (1/2.75)) {
	                                return c*(7.5625*t*t) + b;
	                        } else if (t < (2/2.75)) {
	                                return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
	                        } else if (t < (2.5/2.75)) {
	                                return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
	                        } else {
	                                return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
	                        }
	                }
	        }
	};
	//容器对象,滑动对象,切换数量
	var SlideTrans = function(container, slider, count, options) {
	        this._slider = ad(slider);
	        this._container = ad(container);//容器对象
	        this._timer = null;//定时器
	        this._count = Math.abs(count);//切换数量
	        this._target = 0;//目标值
	        this._t = this._b = this._c = 0;//tween参数
	        
	        this.Index = 0;//当前索引
	        
	        this.SetOptions(options);
	        
	        this.Auto = !!this.options.Auto;
	        this.Duration = Math.abs(this.options.Duration);
	        this.Time = Math.abs(this.options.Time);
	        this.Pause = Math.abs(this.options.Pause);
	        this.Tween = this.options.Tween;
	        this.onStart = this.options.onStart;
	        this.onFinish = this.options.onFinish;
	        
	        var bVertical = !!this.options.Vertical;
	        this._css = bVertical ? "top" : "left";//方向
	        
	        //样式设置
	        var p = CurrentStyle(this._container).position;
	        p == "relative" || p == "absolute" || (this._container.style.position = "relative");
	        this._container.style.overflow = "hidden";
	        this._slider.style.position = "absolute";
	        
	        this.Change = this.options.Change ? this.options.Change :
	                this._slider[bVertical ? "offsetHeight" : "offsetWidth"] / this._count;
	};
	SlideTrans.prototype = {
	  //设置默认属性
	  SetOptions: function(options) {
	        this.options = {//默认值
	                Vertical:        true,//是否垂直方向（方向不能改）
	                Auto:                true,//是否自动
	                Change:                0,//改变量
	                Duration:        50,//滑动持续时间
	                Time:                10,//滑动延时
	                Pause:                2000,//停顿时间(Auto为true时有效)
	                onStart:        function(){},//开始转换时执行
	                onFinish:        function(){},//完成转换时执行
	                Tween:                Tween.Quart.easeOut//tween算子
	        };
	        Extend(this.options, options || {});
	  },
	  //开始切换
	  Run: function(index) {
	        //修正index
	        index == undefined && (index = this.Index);
	        index < 0 && (index = this._count - 1) || index >= this._count && (index = 0);
	        //设置参数
	        this._target = -Math.abs(this.Change) * (this.Index = index);
	        this._t = 0;
	        this._b = parseInt(CurrentStyle(this._slider)[this.options.Vertical ? "top" : "left"]);
	        this._c = this._target - this._b;
	        
	        this.onStart();
	        this.Move();
	  },
	  //移动
	  Move: function() {
	        clearTimeout(this._timer);
	        //未到达目标继续移动否则进行下一次滑动
	        if (this._c && this._t < this.Duration) {
	                this.MoveTo(Math.round(this.Tween(this._t++, this._b, this._c, this.Duration)));
	                this._timer = setTimeout(Bind(this, this.Move), this.Time);
	        }else{
	                this.MoveTo(this._target);
	                this.Auto && (this._timer = setTimeout(Bind(this, this.Next), this.Pause));
	        }
	  },
	  //移动到
	  MoveTo: function(i) {
	        this._slider.style[this._css] = i + "px";
	  },
	  //下一个
	  Next: function() {
	        this.Run(++this.Index);
	  },
	  //上一个
	  Previous: function() {
	        this.Run(--this.Index);
	  },
	  //停止
	  Stop: function() {
	        clearTimeout(this._timer); this.MoveTo(this._target);
	  }
	};
	
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
	};

	function finish(){
		parent.document.getElementById('imageIframeDiv').style.display = "none";
		parent.window.addImage($("#uploadDivFlag").val(), '<%=basePath%><s:property value="ad1.aiImagePath" />', '<%=basePath%><s:property value="ad2.aiImagePath" />', $("#aiDivId").val());
	}

	function closeIframe(){
		parent.document.getElementById('imageIframeDiv').style.display = "none";
	}

	function init(){
		
	}

	//添加行
	function btnAddRow()
	{
		var rownum=$("#table1 tr").length-1;
		if(rownum>4){
			alert('最多只能添加5张图片');
			return false;
		}
		var chk="<input type='checkbox' id='chk_"+rownum+"' name='chk_"+rownum+"'/>";
		var img = '<a href="#"><img onclick="disOpDiv(null, 1, 4,null,null,\'add\')" src="<%=basePath%>web/newtemplate/images/gg_pic2.gif" width="80" height="80" /></a>';
		var btn = '<p><a href="#"><img src="<%=basePath%>web/newtemplate/images/gg_bnt1.gif" width="63" height="27" /></a></p>'+
		'<p><a href="#"><img src="<%=basePath%>web/newtemplate/images/gg_bnt2.gif" width="63" height="27" /></a></p>';
		var row='<tr class="gg_table1_td"><td>'+chk+'</td><td>'+img+'</td><td>'+rownum+'</td><td class="gg_pic_i2">'+btn+'</td></tr>';
	    $(row).insertAfter($("#table1 tr:eq("+rownum+")"));
	}

	//删除行
	function btnDeleteRow()
	{
	   $("#table1 tr").each(function(i){
	       var chk=$(this).find("input[type='checkbox']");
	       if(chk.attr("id")!="checkall")//不能删除标题行
	       {
	       if(chk.attr("checked"))
	       {
	          $(this).remove();
	       }
	       }
	    });
	}
</script>
</head>
<body onload="init()">
	<form id="adFrm" name="adFrm"
		action="<%=basePath%>templateManage/templateManage!toScrollTemplate.action"
		enctype="multipart/form-data" method="post">
		<input type="hidden" name="tmId" id="tmId" value="<s:property value="tmId"/>" />
		<input type="hidden" name="aiId" id="aiId" value="" />
		<input type="hidden" name="ad" id="ad" />
		<input type="hidden" id="aiDivId" name="aiDivId" />
		<input type="hidden" id="uploadDivFlag" name="uploadDivFlag" value='<s:property value="uploadDivFlag"/>' />
		<input type="hidden" name="float_img" id="float_img" value="true"/>

		<!--选择图片模式后弹出的页面，上传功能-->
		<div id="uploadImageDiv" class="gg_win">
			<div class="gg_win_tit">
				添加滚动图片
				<div class="gg_c">
					<img style="cursor: pointer;" onclick="closeIframe()" src="<%=basePath%>web/newtemplate/images/X3.gif" width="20" height="20" id="Image4" />
				</div>
			</div>
			<!--编辑内容开始-->
			<div class="gg_con">
				<table id="table1" width="100%" border="0" cellspacing="0" cellpadding="3" class="gg_txt_m90 gg_table1">
					<tr class="gg_table1_tit">
						<th width="5%">选择</td>
						<th width="20%">图片</td>
						<th width="60%">链接地址</td>
						<th width="15%">操作</td>
					</tr>
					<s:iterator value="ad4List" status="stat">
						<tr class="gg_table1_td">
							<td>
								<input type='checkbox' id='chk_<s:property value="%{#stat.index}" />' name='chk_<s:property value="%{#stat.index}" />'/>
							</td>
							<td>
								<img style="cursor: pointer;" onclick="disOpDiv(null, 1, 1,null,null,'add')" src='${imgServerPath}<s:property value="aiImagePath" />' width="80" height="80" />
							</td>
							<td>
								<s:property value="aiAdUrl" />
							</td>
							<td>
								<p><img style="cursor: pointer;" src="<%=basePath%>web/newtemplate/images/gg_bnt1.gif" width="63" height="27" /></p>
								<p><img style="cursor: pointer;" src="<%=basePath%>web/newtemplate/images/gg_bnt2.gif" width="63" height="27" /></p>
							</td>
						</tr>
					</s:iterator>
				</table>
			</div>
			<!--编辑内容end-->
			<div class="gg_bnt">
				<span class="add_btn"><input type="button" class="btn1" value="添加" onclick="btnAddRow()" /></span>
				<span class="add_btn"><input type="button" class="btn1" value="删除" onclick="btnDeleteRow()" /></span>
			</div>
		</div>
		
		<div id="opDiv" class="gg_div_out" style="display:none">
			<div class="tith3">
				<span id="optDescription">添加</span>广告图片
			</div>
			<div class="txt01">
				<p>
					请选择你要发布到这个位置的图片 <span><font id="msgTip" color="red"><%=msg%></font>
					</span>
				</p>
				
				<p>
					<input type="file" name="upload" size="20" onchange="javascript:ajaxupload(this.value);" class="text opacity">
					<input name="file_0" id="file_0" value="" class="add_input" /><input type="button" value="选择" class="btn1"> 
					<span id="operatorDiv">
						<input id="modify_btn" class="btn1" type="button" value="剪裁" onClick="readyCutImage();">
						<input id="delete_btn" class="btn1" type="button" value="删除" onClick="delImage();">
					</span>
					<span id="operatorDiv_submit" style="display: none">
						<input id="submit_btn" class="btn1" type="button" value="修改" onClick="updateImage();" />
					</span>
					<s:if test="ad1 != null">
	                    <span class="add_btn"><input id="finishBtn" onclick="finish()" type="button" class="btn1" value="保存"/></span>
					</s:if>
				</p>

				<p>点击图片后打开的页面地址，例如: http://www.ruijie.com.cn</p>
				<p>
					<input type="text" name="aiAdUrl" id="aiAdUrl" value=""
						class="add_input_url" />&nbsp;
				</p>

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
		
		<div class="container" id="idContainer2">
			<table id="idSlider2" border="0" cellpadding="0" cellspacing="0">
				<tr id="img_ad_4">
					<s:if test="ad4List == null || ad4List.size() == 0">
						<td>
							<img src="<%=basePath%>images/auth/ban.jpg"/>
						</td>
					</s:if>
					<s:else>
						<s:iterator value="ad4List" status="stat">
							<td id="img_ad_<s:property value="aiImageMark" />">
								<img  src="${imgServerPath}<s:property value="aiImagePath" />" />
							</td>
						</s:iterator>
					</s:else>
				</tr>
			</table>
			<ul class="num" id="idNum"></ul>
		</div>
	</form>
	
	<script type="text/javascript">
	
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
		$("#txtDiv").hide();	
		$("#noteDiv").hide();
		cleanCutImageParamters();
		//取消图片选择区域，避免前一张图片选择后切换到后一张 保留区域的问题
		cut_ias.cancelSelection();
		if(flag==1){
			$("#opDiv").show();
		}
		if(flag==2){
			$("#opDiv").hide();
		}

		if(ad != 'null' && ad != null) {
			$("#ad").val(ad);
		}else {
			$("#ad").val("");
		}

		$("#aspectRatio").val("3:2");
		
		if(imagePath != null && typeof(imagePath) != "undefined") {
		   $("#photo").attr("src","<%=basePath%>" + imagePath); 
		   $("#photo").css("visibility","visible");	
		}else {
		   $("#photo").remove("src"); 
		   $("#photo").css("visibility","hidden");
		}
		
		if(adUrl != null && typeof(adUrl) != "undefined") {
		   $("#aiAdUrl").val(adUrl);	
		}else {
		   $("#aiAdUrl").val("");	
		}
		
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
		}
		
		$("#msgTip").text("");
		$("#msgTip1").text("");

		$("#aspectRatio").val("1.6:1");
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
		   if(!isNull(aiAdUrl)) {
				if(!httpUrl(aiAdUrl)) {
					alert('页面地址输入不正确!必须以 http:// 开头');
					return;
				}
				
			}
			
		   var paramters = {aiId:aiId,imageX:x,imageY:y,imageWidth:width,imageHeight:height,aiAdUrl:aiAdUrl};
		   $.post("<%=basePath%>templateManage/templateManage!updateImage.action",paramters,function(ad) {
			   window.location.href = "<%=basePath%>templateManage/templateManage!toScrollTemplate.action?ad="+ad+"&aiDivId="+aiDivId+"&uploadDivFlag="+uploadDivFlag;
		   });

	}

	function ajaxupload(value) {
	  debugger;
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
		var aiDivId = $("#aiDivId").val();
		var uploadDivFlag = $("#uploadDivFlag").val();
		var tmId = $("#tmId").val();
	   	if((data + "").length > 10) {
			alert(data);
			return;
	   	}
	
	   	window.location.href = "<%=basePath%>templateManage/templateManage!toScrollTemplate.action?ad="
		   	+data+"&msgTip=1&aiDivId="+aiDivId+"&uploadDivFlag="+uploadDivFlag +"&tmId="+tmId;
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
		aspectRatio : '3:2',
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
	   
	   cut_ias.setOptions({aspectRatio:$("#aspectRatio").val(), show: true, x1: 0, y1: 0, x2: 56, y2: 76 });
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
				   window.location.href = "<%=basePath%>templateManage/templateManage!toScrollTemplate.action";
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

	$(function() {
		 var img_n = 1;
		 var float_num = 0;
		 <s:if test="ad4List != null && ad4List.size() > 0">
		     img_n = '<s:property value="ad4List.size()"/>';
		 </s:if>
		 float_image(img_n);
	 });
	 
	 $(function() {
		 $("#startX").val(0);
		 $("#startY").val(0);
		 $("#width").val(0);
		 $("#height").val(0); 
	 });
	 
	 var is_show_div = "Y";
	 $(function() {
		 <s:if test="message != null">
		    alert('<s:property value="message"/>');
	    </s:if>
	    
	    var ad = '<s:property value="ad"/>';
	    ad = ad + "";
	   
	    if(ad.indexOf("_") > 0) {
	      is_show_div = "N";
	      $("#img_ad_" + ad).find("a").eq(0).click();
	      float_img_modify();
	      is_show_div = "Y";
	    }else if(parseInt(ad) < 6){
	      $("#img_ad_"+ad).parent().click();
	    }else {
	      $("#img_ad_"+ad).click();
	    }
	    
	    $("#msgTip").text("<%=msg%>");
		$("#msgTip1").text("<%=msg%>");
	});
	
	
	 
	 function float_image(img_n) {
		var forEach = function(array, callback, thisObject){
		        if(array.forEach){
		                array.forEach(callback, thisObject);
		        }else{
		                for (var i = 0, len = array.length; i < len; i++) { callback.call(thisObject, array[i], i, array); }
		        }
		};
		//注意，这里  st 为全局变量！ 待优化
	    st = new SlideTrans("idContainer2", "idSlider2", img_n, { Vertical: false });
		var nums = [];
		//插入数字
		for(var i = 0, n = st._count - 1; i <= n;){
		        (nums[i] = ad("idNum").appendChild(document.createElement("li"))).innerHTML = ++i;
		}
		forEach(nums, function(o, i){
		        o.onmouseover = function(){ o.className = "on"; st.Auto = false; st.Run(i); };
		        o.onmouseout = function(){ o.className = ""; st.Auto = true; st.Run(); };
		});
		//设置按钮样式
		st.onStart = function(){
		        forEach(nums, function(o, i){ o.className = st.Index == i ? "on" : ""; });
		};
		st.Run();
	 }

	</script>
</body>
</html>