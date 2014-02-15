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
	   }else if(tip == 2){
		  msg = "修改成功!"; 
	   }else {
		  msg = "操作成功!";
	   }
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<title>模板管理</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="<%=basePath%>css/page.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>css/template_manage.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>js/xytipswindows/style.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
.container,.container img {
	width: 330px;
	height: 200px;
	padding:0px 0px 0px 0px;
}

.container {
	border: 1px solid #333;
}

.container img {
	border: 0;
}
.content {
	overflow: hidden;
	zoom: 1;
	width: 330px;
}

.content ul li {
	width: auto;
	height: 149px;
	margin: 0 0px 6px 19px;
	_margin: 0 0px 6px 19px;
}
</style>

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
</style>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>web/imageselect/files/imgareaselect-anima.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>web/imageselect/files/imgareaselect-animated.css">
		<script type="text/javascript"
			src="<%=basePath%>web/imageselect/files/jquery-1.8.3.min.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>web/imageselect/files/jquery.imgareaselect.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>js/xytipswindows/jquery.XYTipsWindow.min.2.7.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>js/util.js"></script>
		
		<script type="text/javascript"
			src="<%=basePath%>js/jquery.form_latest.js"></script>
		<script type="text/javascript">
var ad = function (id) {
        return "string" == typeof id ? document.getElementById(id) : id;
};
var Extend = function(destination, source) {
        for (var property in source) {
                destination[property] = source[property];
        }
        return destination;
}
var CurrentStyle = function(element){
        return element.currentStyle || document.defaultView.getComputedStyle(element, null);
}
var Bind = function(object, fun) {
        var args = Array.prototype.slice.call(arguments).slice(2);
        return function() {
                return fun.apply(object, args.concat(Array.prototype.slice.call(arguments)));
        }
}
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
}
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
</script>
	</head>


	<body class="content_bj">
		<form id="adFrm" name="adFrm"
			action="<%=basePath%>templateManage/templateManage!configTemplate.action"
			enctype="multipart/form-data" method="post">
			<input type="hidden" name="tmId" id="tmId" value="<s:property value="adComplexTmID"/>"/> 
			<input type="hidden" name="float_img" id="float_img" value="false"/>
			<input type="hidden" name="aiId" id="aiId" value=""/>
			<input type="hidden"  id="aspectRatio" value=""/>

			<div class="mb01">
				<div class="mb01_l" style="height:auto; background-color: #333" >
					<div class="all_box">
						<div class="toplogo">
							<div class="logo">
								<s:if test="adLogo == null">
									<a  href="#" onClick="disOpDiv('null', 1, 0,null,null,'add')" ><img id="img_ad_0" name="ad"
										src="<%=basePath%>images/auth/logo.png"
										/></a>
								</s:if>
								<s:else>
									<a  href="#" onclick="disOpDiv('<s:property value="adLogo.aiId"/>', 1, 0,'<s:property value="adLogo.aiImagePath" />','<s:property value="adLogo.aiAdUrl" />','modify')"><img id="img_ad_0" name="ad"  
										src="<%=basePath%><s:property value="adLogo.aiImagePath" />" /></a>
								</s:else>
							</div>
						</div>
						<div class="tap">
							<li id="duanXinTab" onclick="displayTab('duanxin')">
								<img src='<%=basePath%>images/auth/aa1_01.png'/>
							</li>
							<li id="weiXinTab"  onclick="displayTab('weixin')">
								<img src='<%=basePath%>images/auth/aa1_01a.png'/>
							</li>
						</div>
					<div style="background-color: #FFF" >
						<div class="login_01" id="weiXinDisplayContent" style="display: none">
							<p>
								请亲移步到本店服务台。用您的微信扫描下二维码，进行上网认证。
							</p>
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
						<div class="wrapper">
							<div class="content">
								<ul>
									<li>
										<s:if test="ad1 == null">
											<a href="#" onclick="disOpDiv('null', 1, 1,null,null,'add')"><img
													id="img_ad_1"
													src="<%=basePath%>images/auth/ad1.png" width="135"
													height="139" /> </a>
										</s:if>
										<s:else>
											<a  href="#" onclick="disOpDiv('<s:property value="ad1.aiId"/>', 1, 1,'<s:property value="ad1.aiImagePath" />','<s:property value="ad1.aiAdUrl" />','modify')"><img id="img_ad_1"
													src="<%=basePath%><s:property value="ad1.aiImagePath" />"
													width="135" height="139" /> </a>
										</s:else>
									</li>
									<li>
										<s:if test="ad2 == null">
											<a href="#" onclick="disOpDiv('null', 1, 2,null,null,'add')"><img
													id="img_ad_2"
													src="<%=basePath%>images/auth/ad1.png" width="135"
													height="139" /> </a>
										</s:if>
										<s:else>
											<a  href="#;return false;" onclick="disOpDiv('<s:property value="ad2.aiId"/>', 1, 2,'<s:property value="ad2.aiImagePath" />','<s:property value="ad2.aiAdUrl" />','modify')"><img id="img_ad_2"
													src="<%=basePath%><s:property value="ad2.aiImagePath" />"
													width="135" height="139" /> </a>
										</s:else>
									</li>
								</ul>
							</div>
							<div class="container" id="idContainer2">
								<table id="idSlider2" border="0" cellpadding="0" cellspacing="0">
									<tr id="img_ad_4">
										<s:if test="ad4List == null || ad4List.size() == 0">
											<td>
												<a href="#"><img
														src="<%=basePath%>images/auth/ban.jpg" onclick="disOpDiv('null', 1,4,null,null,'add')"/>
												</a>
											</td>
										</s:if>
										<s:else>
											<s:iterator value="ad4List" status="stat">
												<td id="img_ad_<s:property value="aiImageMark" />">
													<a href="#" onClick="javascript:show_opt_div('<s:property value="aiId"/>','<s:property value="aiImageMark" />','<s:property value="aiImagePath" />','<s:property value="aiAdUrl" />');"  ><img  src="<%=basePath%><s:property value="aiImagePath" />" />
													</a>
												</td>
											</s:iterator>
										</s:else>
									</tr>
								</table>
								<ul class="num" id="idNum"></ul>
							</div>
						
							<div class="txt1" style="clear: both;">
								<s:if test="text == null">
								  <a href="#" onClick="DisTxtDiv('add')" id="img_ad_6">点击编辑文字提示信息</a>
								</s:if>
								<s:else>
								  <a href="#" onClick="DisTxtDiv('update')" id="img_ad_6"><s:property value="text.atContent"/></a>
								</s:else>
							</div>
						</div>
					</div>
				</div>
			</div>
				<div id="noteDiv" class="mb01_r" style="background:rgba(255, 255, 255, 0);border:0px;">
				  <img alt="" src="<%=basePath%>images/edit.png">
				</div>
				
				<div id="txtDiv" class="mb01_r" style="display:none">
				  <div class="tith3">
						文字描述
				  </div>
				  <div class="txt01">
				   <p>
						请填写你要描述的文字，不超过25个字 <span><font id="msgTip1" color="red"><%=msg%></font></span>
					  </p>
					   <p>
						 <input type="text" name="txtAdDesc" id="txtAdDesc" maxlength="25" value="" class="add_input_url" style="width: 330px"/>&nbsp;
					  </p>
				      <p>
						点击文字后打开的页面地址，例如: http://item.jd.com/134178.html
					  </p>
					  <p>
						 <input type="text" name="txtAdUrl" id="txtAdUrl" value="" class="add_input_url" style="width: 330px"/>&nbsp;
					  </p>
					 
					  <p style="margin:10px 0 10px 10px;">
						<input  class="btn1" type="button" value="提交" onClick="submitAdText();" />&nbsp;&nbsp;
						<input  id="delAdTextBtn" style="display: none" class="btn1" type="button" value="删除" onClick="delAdText();" />							
				       </p>
				  </div>
				</div>

				<div id="opDiv" class="mb01_r" style="display:none">
					<div class="tith3">
						<span id="optDescription">添加</span>广告图片
					</div>
					<div class="txt01">
					   
						<p>
							请选择你要发布到这个位置的图片&nbsp;&nbsp;<span><font id="msgTip" color="red"><%=msg%></font></span>
						</p>
						<p style="display:none">
							<s:radio list="#{'0':'LOGO','1':'广告1','2':'广告2','3':'广告3'}"
								name="ad" value="0" />
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
						<input id="submit_btn" class="btn1" type="button" value="提交修改" onClick="updateImage();" />&nbsp;&nbsp;		
		                  				
				    </p>
				</div>
				
			</div>
			<div id="float_opt_div" style="display:none">
			 <div align="center" style="margin-top: 25px">
			  <input type="hidden"  id="current_float_img_mark" value=""/>
			  <input type="hidden"  id="current_float_img_path" value=""/>
			  <input type="hidden"  id="current_float_img_url" value=""/>
			  <input type="hidden"  id="current_float_img_id" value=""/>
			  <input type="button"  value="新增图片"  style="cursor: pointer;" class="btn1" onClick="float_img_add()"/>&nbsp;&nbsp;
			  <input type="button"  value="修改图片"  style="cursor: pointer;" class="btn1" onClick="float_img_modify()"/>
			 </div>
			</div>
		</form>
		<form id="adTextFrm" name="adTextFrm" action="<%=basePath%>templateManage/templateManage!saveOrUpdateText.action?msgTip=3" method="post" >
		   <input type="hidden" name="text.atContent" id="atContent" value=''/> 
		   <input type="hidden" name="text.atUrl" id="atUrl" value=''/> 
		   <input type="hidden" name="text.atId" id="atId" value='<s:property value="text.atId"/>'/> 
		   <input type="hidden" name="text.atTmId" id="atTmId" value="<s:property value="adComplexTmID"/>"/> 
		</form>
		<script type="text/javascript">
		
		    function DisTxtDiv(oper) {
		    	$("#opDiv").hide();
		    	$("#noteDiv").hide();
		    	$("#txtDiv").show();
		    	if(oper == 'update') {
		    	  $("#txtAdUrl").val('<s:property value="text.atUrl"/>');
		    	  $("#txtAdDesc").val('<s:property value="text.atContent"/>');
		    	  $("#delAdTextBtn").show();
		    	}
		    	$("#msgTip").text("");
				$("#msgTip1").text("");
		    }
		    
		    function delAdText() {
		    	if(confirm("确认进行删除操作吗?")) {
		    	  $("#adTextFrm").attr("action","<%=basePath%>templateManage/templateManage!delAdText.action");
		    	  $("#adTextFrm").submit();
		    	}
		    }
		    
		    function cleanCutImageParamters() {
		    	
		    	$("#startX").val(0);
				$("#startY").val(0);
				$("#width").val(0);
				$("#height").val(0);
		    }
	
		    var operatorDivHtml = $("#operatorDiv").html();
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
				
				if(ad != null && typeof(ad) != "undefined") {
					//不是浮动图片
				
					if(ad <  4) {
				      $("input[name=ad]:eq(" + ad + ")").attr("checked",'checked'); 
				      $("#float_img").val("false");
				      
				      if(ad == 0) {
				    	  $("#aspectRatio").val("4.5:1");
				      }
				      
				      if(ad > 0 && ad <= 3) {
				    	  $("#aspectRatio").val("1:1");
				      }
				  
					}else {
					  $("#float_img").val("true");
					  $("#aspectRatio").val("1.6:1");
					}
				}
				
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
	 
	    		   window.location.href = "<%=basePath%>templateManage/templateManage!toTemplateConfig.action?ad="+data+ "&msgTip=1";         
	            });
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
	    		   window.location.href = "<%=basePath%>templateManage/templateManage!toTemplateConfig.action?ad="+ad+ "&msgTip=2";
	    	   });

	       }
	       
	       function delImage() {
	    	  
	    	   if(confirm("确定删除图片吗？")) {
	    		   var paramters = {aiId:$('#aiId').val()};
	    		   $.post("<%=basePath%>templateManage/templateManage!del.action",paramters,function() {
		    		   window.location.href = "<%=basePath%>templateManage/templateManage!toTemplateConfig.action";
		    	   });
	    	   }  	   
	       }
	       
	       function float_img_add() {
	    	   var num = $('#idNum li').length;
	    	   //如果已经满5张图片
	    	   if(num == 5) {
	    		   alert("对不起，浮动广告不能超过5张！");
	    		   $.XYTipsWindow.removeBox();
	    		   return;
	    	   }
	    	 
	    	   $.XYTipsWindow.removeBox();
	    	   disOpDiv('null',1,'4',null,null,'add');	    	  
	       }
	       
	       function float_img_modify() {
	    	   if(is_show_div == "Y") {
	    	     $.XYTipsWindow.removeBox();
	    	   }
	    	   disOpDiv($("#current_float_img_id").val(),1,$("#current_float_img_mark").val(),$("#current_float_img_path").val(),$("#current_float_img_url").val(),'modify');	
	       }
	       
	       
	       function show_opt_div(imgId,mark,path,url) {
	    	$("#current_float_img_mark").val(mark);
	    	$("#current_float_img_path").val(path);
	    	$("#current_float_img_url").val(url);
	    	$("#current_float_img_id").val(imgId);
	        var float_opt_div = $("#float_opt_div").html();
	   	   
	      
	        if(is_show_div == "Y") {
	   		$.XYTipsWindow({
	   				___title:"编辑滚动广告",
	   				___content:"text:"+float_opt_div,
	   				___width:"200",
	   				___height:"100",
	   				___dray:"___boxTitle",
	   				___showbg:true
	   			});	
	         }
	        
	        //禁用回车键，防止 IE 下 回车屏幕变黑
	        $("html").die().live("keydown",function(event){      
	            if(event.keyCode==13){  
	              return false; 
	            }      
	        });    
	       }
	       
	     
	</script>
		<script>
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
			fadeSpeed : 200,
			onSelectChange : preview,
			hide : false,
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
		
		
		function submitAdText() {
			
			if(isNull($("#txtAdDesc").val())) {
				alert('文字内容不能为空!');
				return;
			}
			
			if(!isNull($("#txtAdUrl").val())) {
				if(!httpUrl($("#txtAdUrl").val())) {
					alert('页面地址输入不正确!');
					return;
				}
				
			}
			
			$("#atContent").val($("#txtAdDesc").val());
			$("#atUrl").val($("#txtAdUrl").val());
			$("#adTextFrm").submit();
		}
		
	</script>
	</body>
</html>
