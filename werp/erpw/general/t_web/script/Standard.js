// mask value 가 null 일 경우 특수값 입력을 막을 것인지 ('use' - 특수값입력가능, 'N' - 특수값입력불가능)
var DEFAULT_USE_MASK = 'USE';

// Notnull 필드 bgcolor
var NOTNULL_BGCOLOR = "#FFFFB5";

if (document.getElementById && !document.all)
{
	var isNS = true;
	var isIE = false;
}
else
{
	var isIE = true;
	var isNS = false;
}


// 초기화 함수
function S_Initialize()
{
	for (var i = 0; i < document.forms.length; i++) document.forms(i).onsubmit = S_onSubmit;
	
	for (var i = 0; i < document.frames.length; i++)
	{
		var oFrame = eval("document.all." + document.frames(i).name);
		oFrame.tabIndex = -1;
	}

	var elem = null;
	var obj = null;
	
	elem = isIE ? document.all.tags('INPUT') : document.getElementsByTagName("INPUT");
	
	for (var i = 0; i < elem.length; i++)
	{
		obj = elem[i];
		
		try
		{
			if (obj == null || (typeof obj == "undefined")) continue;
			if (obj.type == null || obj.type == "undefined") continue;
		}
		catch(e)
		{
			continue;
		}

		switch (obj.type)
		{
			case "radio" :
			case "checkbox" :
			case "button" :
			case "image" :
				if (obj.getAttribute("onkeyup") == null) obj.onkeyup = S_onKeyUp;
				break;
			case "text" :
			case "password" :
				if (obj.getAttribute("right") != null) obj.style.textAlign = "right";
				if (obj.getAttribute("center") != null) obj.style.textAlign = "center";
				if (obj.getAttribute("notnull") != null) obj.style.backgroundColor = NOTNULL_BGCOLOR ;
				// Style sheet 적용
				if (obj.getAttribute("datatype") != null) S_setDefaultValue(obj);
				// event 적용
				if (obj.getAttribute("onblur") == null) obj.onblur = S_onBlur;
				if (obj.getAttribute("readonly")) break;
				if (obj.getAttribute("onfocus") == null) obj.onfocus = S_onFocus;
				if (obj.getAttribute("onkeyup") == null) obj.onkeyup = S_onKeyUp;
				//if (obj.getAttribute("onkeydown") == null) obj.onkeydown = S_onKeyDown;
				if (obj.getAttribute("onkeypress") == null) obj.onkeypress 	= S_onKeyPress;
				if (obj.getAttribute("mask") == null) obj.setAttribute("mask", DEFAULT_USE_MASK);
				
				S_setImeMode(obj);
				S_setObjectFormat(obj);
				break;
		}
	}
	
	elem = isIE ? document.all.tags('SELECT') : document.getElementsByTagName("SELECT");
	
	for (var i = 0; i < elem.length; i++)
	{
		try
		{
			if (elem[i].getAttribute("onkeyup") == null) elem[i].onkeyup = S_onKeyUp;
		}
		catch(e)
		{
			continue;
		}
	}
	
	elem = isIE ? document.all.tags('TEXTAREA') : document.getElementsByTagName("TEXTAREA");
	
	for (var i = 0; i < elem.length; i++)
	{
		try
		{
			if (elem[i] == null || (typeof elem[i] == "undefined")) continue;
			if (elem[i].getAttribute("notnull") != null) elem[i].style.backgroundColor = NOTNULL_BGCOLOR;
			S_setImeMode(elem[i]);
		}
		catch(e)
		{
			continue;
		}
	}
	
	// 모든 TD 테그의 noWrap 속성을 true로 변경
	elem = isIE ? document.all.tags('TD') : document.getElementsByTagName("TD");
	
	for (var i = 0; i < elem.length; i++)
	{
		try
		{
			if (elem[i] == null || (typeof elem[i] == "undefined")) continue;
			
			elem[i].noWrap = true;
		}
		catch(e)
		{
			continue;
		}
	}
	
	if (document.body != null)
	{
 		// history.go(-1) 호출시 format 재적용
		if(document.body.getAttribute("onload") == null) document.body.onload = S_AllFormat;
	}
}

// 표준 submit 함수
function S_Submit(aFrm)
{
	if (typeof aFrm == "undefined")
	{
		C_msgOk("스크립트 오류 정의되지 않은 Form 입니다.", "에러");
		return false;
	}
	
	var elem = isIE ? aFrm.tags('INPUT') : aFrm.getElementsByTagName("INPUT");

	for (var i = 0; i < elem.length; i++)
	{
		var obj = elem[i];

		S_removeObjectFormat(obj); 					// 포맷 삭제

		if (!S_ObjectValidate(obj))
		{
			S_ObjectAllFormat(aFrm);
			return false; 	// 데이터 유효성 재검증
		}

		if(!S_ObjectNullCheck(obj))
		{
			S_ObjectAllFormat(aFrm);
			return false;	// 필수 항목 검증
		}
	}
	
	S_ObjectAllFormat(aFrm);
	
	return true;
}

/*-------------------- 객체 속성별 Validate 관련 함수 --------------------*/

// 필수입력 항목 검증
function S_ObjectNullCheck(obj)
{
	if (obj.getAttribute("notnull") != null)
	{
		if (C_isNull(obj.value))
		{
			var colName = "";
			
			if(obj.getAttribute("colName") != null) colName = "* 필수입력 항목 : " + obj.getAttribute("colName");

			C_msgOk("다음 항목은 필수입력 항목입니다.<BR><BR>" + colName);
			obj.focus();
			obj.select();
			return false;
		}
	}

    return true;
}

// 날짜 유효성 검증 (YYYYMMDD)
function S_isValidDate(asDate)
{
	if (C_isNull(asDate)) return true;
	
	var strDate = C_removeDateTimeFormat(asDate);

	if (!C_isNum(strDate))
	{
		ERR_MSG = "숫자를 입력하셔야 합니다.";
		return false;
	}
	
	
	if (strDate.length != 8)
	{
		ERR_MSG = "년월일 8자리를 입력하셔야 합니다.";
		return false;
	}
	
	var year  = strDate.substr(0, 4);
	var month = strDate.substr(4, 2);
	var day   = strDate.substr(6, 2);
	
	if (parseInt(year) < 1900)
	{
		ERR_MSG = "1900년 이후의 년도를 입력하세요.";
		return false;
	}
	
	if (!C_isValidMonth(month))
	{
		ERR_MSG = "월은 1~12 까지만 입력할 수 있습니다.";
		return false;
	}
	
	if (!C_isValidDay(year, month, day))
	{
		ERR_MSG = "유효하지 않은 일자입니다.<BR>(" + year + "년 " + month + "월은 " + C_getEndDay(asDate) + "일 까지 있습니다)";
		return false;
	}
	
	return true;
}

// 날짜 유효성 검증 (YYYYMM)
function S_isValidMonth(asDate)
{
	if (C_isNull(asDate)) return true;
	
	var strDate = C_removeDateTimeFormat(asDate);
	if (!C_isNum(strDate))
	{
		ERR_MSG = "숫자를 입력하셔야 합니다.";
		return false;
	}
	
	if (strDate.length != 6)
	{
		ERR_MSG = "년월 6자리를 입력하셔야 합니다.";
		return false;
	}
	
	var year  = strDate.substr(0, 4);
	var month = strDate.substr(4, 2);
	
	if (parseInt(year) < 1900)
	{
		ERR_MSG = "1900년 이후의 년도를 입력하세요.";
		return false;
	}
	
	if (!C_isValidMonth(month))
	{
		ERR_MSG = "월은 1~12 까지만 입력할 수 있습니다.";
		return false;
	}
	
	return true;
}

//EMAIL 유효성 검증
function S_isValidEmail(asEmail)
{
	if (!C_isValidEmail(asEmail))
	{
		ERR_MSG = "유효하지 않은 이메일 형식입니다.";
		return false;
	}
	
	return true;
}

//아이디 검증
function S_isValidUserId(asValue)
{
	if (C_isNull(asValue)) return true;

	if (C_getByteLength(asValue) < 8 || C_getByteLength(asValue) > 24 )
	{
		ERR_MSG = "사용자 아이디는 반드시 8자 이상 24자이내로 입력하셔야 합니다.";
		return false;
	}
	
	if (C_isNum(asValue))
	{
		ERR_MSG = "아이디는 숫자로만 구성할 수 없습니다.";
		return false;
	}
	
	if (!C_isAlpha(asValue.substr(0, 1)))
	{
		ERR_MSG = "사용자 아이디 첫번째 문자는 반드시 영문자로 입력하셔야 합니다.";
		return false;
	}
	
	for (var i = 0; i < asValue.length; i++)
	{
		if (!S_isValidMask(asValue.charAt(i), "N") && S_isValidType(asValue.charAt(i), "AN")) return false;
	}
	
	return true;
}

function S_isValidPassword(asValue)
{
	var alpaBig		= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var alpaSmall	= "abcdefghijklmnopqrstuvwxyz";
	var num 		= "01234567890";
	var i			= 0;
	
	if (C_isNull(asValue)) return true;
	
	// 비밀번호는 6자리이상 8자리 이하 .. maxLength=10로 변경 할것
	if (C_getByteLength(asValue) < 6 || C_getByteLength(asValue) > 24)
	{
		ERR_MSG = "비밀번호는 반드시 6자 이상 24자이내로 입력하셔야 합니다.";
		return false;
	}
	
	if (C_isNum(asValue))
	{
		ERR_MSG = "비밀번호는 반드시 알파벳을 하나 이상 포함해야 합니다.";
		return false;
	}
	
	for (i = 0; i < alpaBig.length - asValue.length + 1; i++)
	{
		if (alpaBig.substring(i, i + asValue.length) == asValue)
		{
			ERR_MSG = "ABCDEF처럼 연속된 문자는 사용할 수 가 없습니다.";
			return false;
		}
	}
	
	if (asValue.indexOf(' ') > -1)
	{
		ERR_MSG = "공백은 입력할 수 없습니다.";
		return false;
	}
	
	for (i = 0; i < alpaSmall.length - asValue.length + 1; i++)
	{
		if ( alpaSmall.substring(i, i + asValue.length) == asValue)
		{
			ERR_MSG = "abcdef처럼 연속된 문자는 사용할 수 가 없습니다.";
			return false;
		}
	}
	
	for (i = 1; i < asValue.length; i++)
	{
		if (asValue.substring(0, 1) != asValue.substring(i, i + 1)) return true;
	}
	
	ERR_MSG = "비밀번호는 같은 문자만 연속해서 입력할 수 없습니다.";
	return false;
}

// 1 byte 값에 대하여 해당된 마스크가 존재하는지 검증
function S_isValidMask(asValue, asMask)
{
	if (asValue == null || C_isNull(asMask)) return true;
	if (C_isNum(asValue) || C_isAlpha(asValue) || C_isHangul(asValue)) return true;
	if (asMask == "USE") return true;
	
	//특수문자를 전부 사용하지 못함
	if (asMask == "N")
	{
		ERR_MSG = "이 항목에는 공백이나 특수문자를 입력할 수 없습니다.";
		return false;
	}
	
	if (asMask.indexOf(asValue) >= 0) return true;
	
	var strErrMsg = "";
	
	for (var i = 0; i < asMask.length; i++)
	{
		strErrMsg = strErrMsg + "'" + asMask.charAt(i) + "', ";
	}
	
	strErrMsg = strErrMsg.substring(0, strErrMsg.length - 2);
	
	ERR_MSG = "이 항목에는 '" + asValue + "' 을(를) 입력할 수 없습니다.<BR>입력가능한 특수문자는 " + strErrMsg + "만 가능합니다.";
	return false;
}

// 1 byte 값이 주어진 타입인지 검증
function S_isValidType(asValue, asType)
{
	if (C_isNull(asValue) || C_isNull(asType)) return true;
	if (!C_isNum(asValue) && !C_isAlpha(asValue) && !C_isHangul(asValue)) return true;

	// 타입 검증
	var isCorrect = false;
	
	for (var i = 0; i < asType.length; i++)
	{
		switch(asType.charAt(i))
		{
			case 'A' :
				isCorrect = C_isAlpha(asValue);
				break;
			case 'N' :
				isCorrect = C_isNum(asValue);
				break;
			case 'H' :
				isCorrect = C_isHangul(asValue);
				break;
		}
		
		//정규 키 검증
		if (isCorrect) break;
	}
	
	if (!isCorrect)
	{
		var strErrMsg =  S_getDisplayType(asType);
		ERR_MSG = "이 항목에는 " + strErrMsg + " 만 입력할 수 있습니다.";
		return false;
	}
	
	return true;
}

// 데이터 유효성검증
function S_ObjectValidate(obj)
{
	var datatype		= C_toUpperCase(obj.getAttribute("datatype"));
	var mask 			= C_toUpperCase(obj.getAttribute("mask"));
	var format			= C_toUpperCase(obj.getAttribute("format"));
	var minLength 		= obj.getAttribute("minLength");
	var maxLength 		= obj.getAttribute("maxLength");
	var lowBound 		= parseFloat(obj.getAttribute("lowBound"));
	var highBound 		= parseFloat(obj.getAttribute("highBound"));
	var str = C_Trim(obj.value);

	if (C_isNull(str) || str.length == 0) return true;

	if (!C_isNull(datatype) || !C_isNull(mask))
	{
		ERR_MSG = "";
		
		switch (datatype)
		{
			case "DOTCURRENCY" : 	// 금액 유효 검증
				str = C_removeComma(str);
				if (obj.getAttribute("decimalplace") != null)
				{
					if (str.lastIndexOf('.') > 0)
					{
						if ((str.length - str.indexOf('.') - 1) > (Number(obj.getAttribute("decimalplace"))))
						{
							C_msgOk("소숫점 아래 " + obj.getAttribute("decimalplace") + "자리까지 입력가능합니다.");
							obj.focus();
							return false;
						}
						
						// 소수점이하 자리수 만큼 0으로 채우기
						obj.value = str.substring(0, str.lastIndexOf('.')) + "." + C_RPad(str.substr(str.lastIndexOf('.') + 1), Number(obj.getAttribute("decimalplace")), "0");
						str = obj.value;
					}
					else
					{
						obj.value += "." + C_RPad("", Number(obj.getAttribute("decimalplace")), "0");
						str = obj.value;
					}
				}
				break;
			case "CURRENCY" : 	// 금액 유효 검증
				str = C_removeComma(str);
				break;
			case "DATE" : 	// 일자 유효 검증
				if (!S_isValidDate(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "DATEYM" : 	// 일자 유효 검증
				if (!S_isValidMonth(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "EMAIL" : 	// EMAIL 유효 검증
				if (!S_isValidEmail(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "REGNO" : 	// 주민번호 유효성 검증
				if (!C_isValidRegNo(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "REGNO2" : 	// 주민번호 유효성 검증
				if (!C_isValidRegNo(str))
				{
					C_msgOk(ERR_MSG);
					//obj.focus();
					//obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "CUSTNO" : 	// 사업자번호 유효성 검증
				if (!C_isValidCustNo(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "USERID" :	// 아이디 검증
				if (!S_isValidUserId(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "PASSWORD" : // 비밀번호 검증
				if (!S_isValidPassword(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "LOCALNUM" : // 전화번호 국번 검증
				if (!C_isValidPhoneNum(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "ACCTNO" : // xxxx은행계좌번호 검증
				if (C_isValidAcctNo(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			default :  // 'A','N','H' 마스크 검증
				for (var i = 0; i < str.length; i++)
				{
					if (!S_isValidMask(str.charAt(i), mask) && S_isValidType(str.charAt(i), datatype))
					{
						C_msgOk(ERR_MSG);
						obj.focus();
						obj.value = "";
						//obj.select();
						return false;
					}
				}
		}
	}

	//최대 길이 검증
	if (!C_isNull(maxLength))
	{
		var			iLength = C_getByteLength(str);
		if(datatype == "DATE" ||datatype ==  "DATEYM")
		{
			iLength = C_getByteLength(C_removeDateTimeFormat(str));
		}
		if (maxLength < iLength)
		{
			C_msgOk("입력가능한 글자수는 " + maxLength + "자 까지 입니다.<BR>글자수를 줄여주십시오.(한글은 2글자로 인식합니다)");
			obj.focus();
			return false;
		}
	}

	//최소 길이 검증
	if (!C_isNull(minLength))
	{
		if (C_getByteLength(str) == 0) return true;
		if (minLength > C_getByteLength(str))
		{
			C_msgOk("최소 " + minLength + "자 이상을 입력하셔야 합니다.(한글은 2글자로 인식합니다)");
			obj.focus();
			return false;
		}
	}
	
	//low 유효값 검증
	if (!C_isNull(lowBound))
	{
		if (eval(str - lowBound) < 0 )
		{
			C_msgOk("" + C_toNumberFormatString(lowBound) + " 이상을 입력하셔야 합니다.");
			obj.focus();
			obj.select();
			return false;
		}
	}
	
	//high 유효값 검증
	if (!C_isNull(highBound))
	{
		if (eval(str - highBound) > 0 )
		{
			C_msgOk("" + C_toNumberFormatString(highBound) + " 미만을 입력하셔야 합니다.");
			obj.focus();
			obj.select();
			return false;
		}
	}

	return true;
}

/*-------------------- 표준 공통 이벤트 관련 함수 --------------------*/
// Form의 onSubmit 이벤트
function S_onSubmit()
{
	return false;
}

// 공통 onKeyUp 이벤트
function S_onKeyUp(obj)
{
	if (event.keyCode == 8 || event.keyCode == 9 || 
		event.keyCode == 35 || event.keyCode == 36 || event.keyCode == 37 ||
		event.keyCode == 38 || event.keyCode == 40 || event.keyCode == 45 ||
		event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 16) return;
	
	if (obj == null) var obj = this;
	
	//자동 포커스 이동
	if (event.keyCode == 13)
	{
		S_nextFocus(obj);
		return;
	}
	
	//자동 포커스 이동
	if (obj.tagName != null && obj.tagName == "INPUT")
	{
		var maxlength = obj.getAttribute("maxLength");
	
		if (maxlength != null && maxlength > 0)
		{
			if (C_getByteLength(obj.value) >= maxlength) S_nextFocus(obj);
		}
	}
}

// 공통 onKeyPress 이벤트
function S_onKeyPress(obj)
{
	if (obj == null) var obj = this;
	
	var datatype = C_toUpperCase(obj.getAttribute("datatype"));
	//var format   = C_toUpperCase(obj.getAttribute("format"));
	var mask     = C_toUpperCase(obj.getAttribute("mask"));
	var key      = String.fromCharCode (event.keyCode);
	var str      = C_Trim(obj.value);

	if (datatype == "USERID" || datatype == "PASSWORD") return;
	
	// 데이터 타입 검증
	switch (datatype)
	{
		case "CURRENCY" :
			if ( !(S_isValidMask(key, "-,") && S_isValidType(key, "N")) ) event.returnValue = false;
			break;
		case "DOTCURRENCY" :
			if ( !(S_isValidMask(key, "-,.") && S_isValidType(key, "N")) ) event.returnValue = false;
			break;
		case "DATE" :
			if ( !(S_isValidMask(key, "N") && S_isValidType(key, "N")) ) event.returnValue = false;
			break;
		case "DATEYM" :
			if ( !(S_isValidMask(key, "N") && S_isValidType(key, "N")) ) event.returnValue = false;
			break;
		case "EMAIL" :
			if ( !(S_isValidMask(key, "@.") && S_isValidType(key, "AN")) ) event.returnValue = false;
			break;
		case "REGNO" :
			if ( !(S_isValidMask(key, "N") && S_isValidType(key, "N")) ) event.returnValue = false;
			break;
		case "CUSTNO" :
			if ( !(S_isValidMask(key, "N") && S_isValidType(key, "N")) ) event.returnValue = false;
			break;
		case "LOCALNUM" :
			if ( !(S_isValidMask(key, "N") && S_isValidType(key, "N")) ) event.returnValue = false;
			break;
		case "ACCTNO" :
			if ( !(S_isValidMask(key, "N") && S_isValidType(key, "N")) ) event.returnValue = false;
			break;
		default :
			if ( C_isNull(obj.getAttribute("mask")) ) obj.setAttribute("mask", DEFAULT_USE_MASK);
			if ( !(S_isValidMask(key, mask) && S_isValidType(key, datatype)) ) event.returnValue = false;
	}
}

// 공통 onKeyDown 이벤트
function S_onKeyDown(obj)
{
	if (obj == null) var obj = this;	
	if (event.keyCode == 13) S_nextFocus(obj);
}

// 공통 onBlur 이벤트
function S_onBlur(obj)
{
	if (obj == null) var obj = this;
	if (obj.getAttribute("uppercase") != null) obj.value = C_toUpperCase(obj.value);
	if (obj.getAttribute("lowercase") != null) obj.value = C_toLowerCase(obj.value);
	if (!obj.getAttribute("readonly"))
	{
		if (!S_ObjectValidate(obj)) return false; 	// 데이터 유효성 검증
		S_setObjectFormat(obj);	// 포맷적용
	}

	return true;
}

// 공통 onFocus 이벤트
function S_onFocus(obj)
{
	if (obj == null) var obj = this;
	if (!obj.getAttribute("readonly")) // readOnly 되어 있는 경우에는 포맷 삭제 금지
	{
		S_removeObjectFormat(obj);	// 포맷삭제
		obj.select();
	}
}

/*-------------------- 표준 공통 관련 함수 --------------------*/

// 기본 디폴트 값을 정의한다.
function S_setDefaultValue(obj)
{
	var datatype = C_toUpperCase(obj.getAttribute("datatype"));

	// Style sheet 적용
	switch (datatype)
	{
		case "CURRENCY" :
			obj.maxLength = obj.maxLength > 50 ? 50 : obj.maxLength; 
			obj.setAttribute("format", "CURRENCY");
			break;
		case "DOTCURRENCY" :
			obj.maxLength = obj.maxLength > 50 ? 50 : obj.maxLength; 
			obj.setAttribute("format", "DOTCURRENCY");
			break;
		case "DATE" :
			obj.setAttribute("format", "DATE");
			//obj.setAttribute("maxLength", "8");
			break;
		case "DATEYM" :
			obj.setAttribute("format", "DATEYM");
			//obj.setAttribute("maxLength", "6");
			break;
		case "EMAIL" :
			break;
		case "REGNO" :
			obj.setAttribute("format", "REGNO");
			//obj.setAttribute("maxLength", "13");
			break;
		case "CUSTNO" :
			obj.setAttribute("format", "CUSTNO");
			//obj.setAttribute("maxLength", "10");
			break;
		case "LOCALNUM" :
			obj.setAttribute("maxLength", "3");
			break;
		case "ACCTNO" :
			obj.setAttribute("format", "ACCTNO");
			//obj.setAttribute("maxLength", "10");
			break;
		case "USERID" :
			//obj.setAttribute("maxLength", "24");
			break;
		case "PASSWORD" :
			//obj.setAttribute("maxLength", "24");
			break;
		default :
			if (obj.getAttribute("mask") == null || C_Trim(obj.getAttribute("mask")) == "") obj.setAttribute("mask", DEFAULT_USE_MASK);
	}

	var format = C_toUpperCase(obj.getAttribute("format"));
	
	switch (format)
	{
		case "CURRENCY" :
		case "DOTCURRENCY" :
			obj.style.textAlign="right";
			break;
		case "DATE" :
			break;
		case "DATEYM" :
			break;
		case "EMAIL" :
			break;
		case "REGNO" :
			break;
		case "CUSTNO" :
			break;
		case "LOCALNUM" :
			break;
		case "ACCTNO" :
			break;
		case "POSTNO" :
			break;
	}
}

// 모든 Form의 포맷팅
function S_AllFormat()
{
	var elemFrm = document.all.tags('FORM');
	
	for (var i = 0; i < elemFrm.length; i++)
	{
		try
		{
 			S_ObjectAllFormat(elemFrm[i]);
 		}
 		catch(e)
 		{
 		}
	}							
}

function S_ObjectAllFormat(aFrm)
{
	var elem = aFrm.tags('INPUT');
	
	for (var i = 0; i < elem.length; i++)
	{
		S_setObjectFormat(elem[i]); //포맷 적용
	}
}

// 출력 포맷 적용
function S_setObjectFormat(obj)
{
	var format = C_toUpperCase(obj.getAttribute("format"));
	var str = obj.value;
	
	if (C_isNull(str)) return;
	if (format == null) return;
	
	switch (format)
	{
		case "CURRENCY" : 		//금액 형식
			obj.value = C_toNumberFormatString(str);
			break;
		case "DOTCURRENCY" : 		//'.' 있는 금액 형식
			str = C_toNumberFormatString(str);
			
			if (obj.getAttribute("decimalplace") != null)
			{
				if (str.lastIndexOf('.') < 0) str += "." + C_RPad("", Number(obj.getAttribute("decimalplace")), "0");
				
				var decimalplace = Number(obj.getAttribute("decimalplace"));
				var afterNo = str.substr(str.indexOf(".") + 1, str.length - str.indexOf(".") + 1);
				
				if (afterNo.length < decimalplace)
				{
					obj.value = str.substr(0, str.indexOf(".")) + "." + C_RPad(afterNo, decimalplace, "0");
				}
				else
				{
					obj.value = str.substr(0, str.indexOf(".")) + "." + afterNo.substr(0, decimalplace);
				}
			}
			else
			{
				obj.value = str;
			}
			break;
		case "DATEYM" : 			//날짜 형식(년월)
		case "DATE" : 			//날짜 형식(년월일)
			obj.value = C_toDateFormatString(str);
			break;
		case "REGNO" : 			//주민등록 형식
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 6) + "-" + str.substr(6, 7);
			break;
		case "CUSTNO" : 		//사업자번호 형식
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 3) + "-" + str.substr(3, 2) + "-" + str.substr(5, 5);
			break;
		case "ACCTNO" : 		//계좌번호 형식
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 3) + "-" + str.substr(3, 5) + "-" + str.substr(8, 2);
			break;
		case "CARDNO" : 		//카드번호 형식
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 4) + "-" + str.substr(4, 4) + "-" + str.substr(8, 4) + "-" + str.substr(12, 4);
			break;
		case "POSTNO" : 		//우편번호 형식
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 3) + "-" + str.substr(3, 3);
			break;
	}
}

// 포맷 삭제
function S_removeObjectFormat(obj)
{
	var format = C_toUpperCase(obj.getAttribute("format"));
	var str = obj.value;
	
	if (format != null)
	{
		switch (format)
		{
			case "DATE":
			case "DATEYM":
			case "ACCTNO":
			case "CARDNO":
			case "CUSTNO":
			case "POSTNO":
			case "REGNO" : 			//날짜 형식
				obj.value = str.replace(/-/g, "");
				break;
			case "CURRENCY" : 		// 금액
			case "DOTCURRENCY" : 	// 금액
				obj.value = str.replace(/\,/g, "");
				break;
		}
	}
}

// 타입별 에러 메세지 설정
function S_getDisplayType(asType)
{
	var strMsg = "";
	
	for (var i = 0; i < asType.length; i++)
	{
		switch(asType.charAt(i))
		{
			case 'A' :
					strMsg += ",영문자";
					break;
			case 'N' :
					strMsg += ",숫자";
					break;
			case 'H' :
					strMsg += ",한글";
					break;
		}
	}
	
	return strMsg.substring(1);
}

// 타입별 에러 메세지 설정
function S_nextFocus(obj)
{
	var isNext = false;
	//var elem = isIE ? document.all.tags('INPUT') : document.getElementsByTagName("INPUT");
	var elem = isIE ? document.all : document.all;
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].tagName != "INPUT" && elem[i].tagName != "TEXTAREA" && elem[i].tagName != "SELECT") continue;
		
		if (elem[i].hideFocus == true) continue;
		
		if (isNext)
		{
			if (elem[i].tagName == "INPUT" || elem[i].tagName == "TEXTAREA")
			{
				if (elem[i].type == null || elem[i].type == "undefined" || elem[i].type == "hidden" ) continue;
				
				if (elem[i].type == "text" || elem[i].type == "password")
				{
					if (elem[i].type == "text" && (elem[i].readOnly == true || elem[i].disabled == true)) continue;
				}
			}
			else if (elem[i].tagName == "SELECT")
			{
				if (elem[i].disabled == true) continue;
			}
			
			try
			{
				elem[i].focus();
			}
			catch(e)
			{
			}
			
			break;
		}
		
		if (elem[i] == obj) isNext = true;
	}
	// 최종객체인 경우
	try
	{
		obj.blur();
	}
	catch(e)
	{
	}
}

function S_setImeMode(obj)
{
	// 현재 사용안함
	/*
	var datatype = C_toUpperCase(obj.getAttribute("datatype"));
	
	if (datatype == null)
	{
		obj.style.imeMode = "auto";
	}
	else if (datatype != null && datatype.indexOf("H") > -1)
	{
		obj.style.imeMode = "active";
	}
	else
	{
		obj.style.imeMode = "disabled";
	}
	*/
}

/*
	PopupOpen_AccSlipRetrieve (
		vsSLIP_ID,
		vsSLIP_IDSEQ,
		vsMAKE_DT,
		vsMAKE_SEQ,
		vsSLIP_KIND_TAG,
		vsMAKE_COMP_CODE,
		vsREADONLY_TF
	);
*/
function PopupOpen_AccSlipRetrieve (
	pSLIP_ID,
	pSLIP_IDSEQ,
	pMAKE_DT,
	pMAKE_SEQ,
	pSLIP_KIND_TAG,
	pMAKE_COMP_CODE,
	pREADONLY_TF
) {
	var lrArgs = new Array();
	var lsURL = "../01/t_WSlipR.jsp";
	lrArgs.opener          = window;
	lrArgs.SLIP_ID        = pSLIP_ID;
	lrArgs.SLIP_IDSEQ     = pSLIP_IDSEQ;
	lrArgs.MAKE_DT        = pMAKE_DT;
	lrArgs.MAKE_SEQ       = pMAKE_SEQ;
	lrArgs.SLIP_KIND_TAG  = pSLIP_KIND_TAG;
	lrArgs.MAKE_COMP_CODE = pMAKE_COMP_CODE;
	lrArgs.READONLY_TF    = pREADONLY_TF;

	var lrRet = null;
	lrRet = window.showModalDialog(lsURL,lrArgs,"center:yes; dialogWidth:1024px; dialogHeight:830px; status:no; help:no; scroll:no") ;
}