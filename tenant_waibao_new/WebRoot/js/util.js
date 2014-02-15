//判断字符串是否为空字符串
function isNull(str){
	if(str == null || str.replace(/(^\s*)|(\s*$)/g, "") == '') {
		return true;
	}
	return false;
} 

// value为图片地址
function isImage(value) {
   var suffix = value.substring(value.lastIndexOf('.') + 1);
   suffix = suffix.toLowerCase();

   if(suffix != 'jpg' && suffix != 'jpeg' && suffix != 'gif' 
		   && suffix != 'bmp' && suffix != 'png') {
	   return false;
   }
   return true;
}

//以 http开始的地址
function httpUrl(url) {
	if(url == null)
	   return false;
	url = url.toLowerCase();
	url = url.replace(/(^\s*)|(\s*$)/g, "");
	var reg = "^http:\/\/[\.a-zA-Z0-9\/]";
	var regExp = new RegExp(reg,"g");
	if(!regExp.test(url)) {
		return false;
	}
	return true;
}

//ajax sesstion超时处理
function checkAjaxSessionOut(data, redirectUrl){
	var flag = false;
	if(data.length>20){
		var value = $.trim(data.substring(0,20));
		if(value.indexOf("<!DOCTYPE html")==0){
			flag = true;
			alert("您已登录超时，请重新登录！");
			window.top.location.href = redirectUrl;				
		}
	}
	
	return flag;
}