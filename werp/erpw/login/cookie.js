<!--
function makeCookie(name, value) {
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + 100);
          document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"

//          + ( (expire) ? "; expires=" + expire.toGMTString() : "")
}

function readCookie(uName) {
	var flag = document.cookie.indexOf(uName+'=');
	if (flag != -1) { 
		flag += uName.length + 1
		end = document.cookie.indexOf(';', flag) 

		if (end == -1) end = document.cookie.length
		return unescape(document.cookie.substring(flag, end))
	}
}

function clearCookie() { 
  document.cookie="username=;expires=Sun Apr 16 00:00:01 GMT 2999" 
  alert("Your cookie has been deleted!") 
} 
//-->