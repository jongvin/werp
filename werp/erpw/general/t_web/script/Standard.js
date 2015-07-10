// mask value �� null �� ��� Ư���� �Է��� ���� ������ ('use' - Ư�����Է°���, 'N' - Ư�����ԷºҰ���)
var DEFAULT_USE_MASK = 'USE';

// Notnull �ʵ� bgcolor
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


// �ʱ�ȭ �Լ�
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
				// Style sheet ����
				if (obj.getAttribute("datatype") != null) S_setDefaultValue(obj);
				// event ����
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
	
	// ��� TD �ױ��� noWrap �Ӽ��� true�� ����
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
 		// history.go(-1) ȣ��� format ������
		if(document.body.getAttribute("onload") == null) document.body.onload = S_AllFormat;
	}
}

// ǥ�� submit �Լ�
function S_Submit(aFrm)
{
	if (typeof aFrm == "undefined")
	{
		C_msgOk("��ũ��Ʈ ���� ���ǵ��� ���� Form �Դϴ�.", "����");
		return false;
	}
	
	var elem = isIE ? aFrm.tags('INPUT') : aFrm.getElementsByTagName("INPUT");

	for (var i = 0; i < elem.length; i++)
	{
		var obj = elem[i];

		S_removeObjectFormat(obj); 					// ���� ����

		if (!S_ObjectValidate(obj))
		{
			S_ObjectAllFormat(aFrm);
			return false; 	// ������ ��ȿ�� �����
		}

		if(!S_ObjectNullCheck(obj))
		{
			S_ObjectAllFormat(aFrm);
			return false;	// �ʼ� �׸� ����
		}
	}
	
	S_ObjectAllFormat(aFrm);
	
	return true;
}

/*-------------------- ��ü �Ӽ��� Validate ���� �Լ� --------------------*/

// �ʼ��Է� �׸� ����
function S_ObjectNullCheck(obj)
{
	if (obj.getAttribute("notnull") != null)
	{
		if (C_isNull(obj.value))
		{
			var colName = "";
			
			if(obj.getAttribute("colName") != null) colName = "* �ʼ��Է� �׸� : " + obj.getAttribute("colName");

			C_msgOk("���� �׸��� �ʼ��Է� �׸��Դϴ�.<BR><BR>" + colName);
			obj.focus();
			obj.select();
			return false;
		}
	}

    return true;
}

// ��¥ ��ȿ�� ���� (YYYYMMDD)
function S_isValidDate(asDate)
{
	if (C_isNull(asDate)) return true;
	
	var strDate = C_removeDateTimeFormat(asDate);

	if (!C_isNum(strDate))
	{
		ERR_MSG = "���ڸ� �Է��ϼž� �մϴ�.";
		return false;
	}
	
	
	if (strDate.length != 8)
	{
		ERR_MSG = "����� 8�ڸ��� �Է��ϼž� �մϴ�.";
		return false;
	}
	
	var year  = strDate.substr(0, 4);
	var month = strDate.substr(4, 2);
	var day   = strDate.substr(6, 2);
	
	if (parseInt(year) < 1900)
	{
		ERR_MSG = "1900�� ������ �⵵�� �Է��ϼ���.";
		return false;
	}
	
	if (!C_isValidMonth(month))
	{
		ERR_MSG = "���� 1~12 ������ �Է��� �� �ֽ��ϴ�.";
		return false;
	}
	
	if (!C_isValidDay(year, month, day))
	{
		ERR_MSG = "��ȿ���� ���� �����Դϴ�.<BR>(" + year + "�� " + month + "���� " + C_getEndDay(asDate) + "�� ���� �ֽ��ϴ�)";
		return false;
	}
	
	return true;
}

// ��¥ ��ȿ�� ���� (YYYYMM)
function S_isValidMonth(asDate)
{
	if (C_isNull(asDate)) return true;
	
	var strDate = C_removeDateTimeFormat(asDate);
	if (!C_isNum(strDate))
	{
		ERR_MSG = "���ڸ� �Է��ϼž� �մϴ�.";
		return false;
	}
	
	if (strDate.length != 6)
	{
		ERR_MSG = "��� 6�ڸ��� �Է��ϼž� �մϴ�.";
		return false;
	}
	
	var year  = strDate.substr(0, 4);
	var month = strDate.substr(4, 2);
	
	if (parseInt(year) < 1900)
	{
		ERR_MSG = "1900�� ������ �⵵�� �Է��ϼ���.";
		return false;
	}
	
	if (!C_isValidMonth(month))
	{
		ERR_MSG = "���� 1~12 ������ �Է��� �� �ֽ��ϴ�.";
		return false;
	}
	
	return true;
}

//EMAIL ��ȿ�� ����
function S_isValidEmail(asEmail)
{
	if (!C_isValidEmail(asEmail))
	{
		ERR_MSG = "��ȿ���� ���� �̸��� �����Դϴ�.";
		return false;
	}
	
	return true;
}

//���̵� ����
function S_isValidUserId(asValue)
{
	if (C_isNull(asValue)) return true;

	if (C_getByteLength(asValue) < 8 || C_getByteLength(asValue) > 24 )
	{
		ERR_MSG = "����� ���̵�� �ݵ�� 8�� �̻� 24���̳��� �Է��ϼž� �մϴ�.";
		return false;
	}
	
	if (C_isNum(asValue))
	{
		ERR_MSG = "���̵�� ���ڷθ� ������ �� �����ϴ�.";
		return false;
	}
	
	if (!C_isAlpha(asValue.substr(0, 1)))
	{
		ERR_MSG = "����� ���̵� ù��° ���ڴ� �ݵ�� �����ڷ� �Է��ϼž� �մϴ�.";
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
	
	// ��й�ȣ�� 6�ڸ��̻� 8�ڸ� ���� .. maxLength=10�� ���� �Ұ�
	if (C_getByteLength(asValue) < 6 || C_getByteLength(asValue) > 24)
	{
		ERR_MSG = "��й�ȣ�� �ݵ�� 6�� �̻� 24���̳��� �Է��ϼž� �մϴ�.";
		return false;
	}
	
	if (C_isNum(asValue))
	{
		ERR_MSG = "��й�ȣ�� �ݵ�� ���ĺ��� �ϳ� �̻� �����ؾ� �մϴ�.";
		return false;
	}
	
	for (i = 0; i < alpaBig.length - asValue.length + 1; i++)
	{
		if (alpaBig.substring(i, i + asValue.length) == asValue)
		{
			ERR_MSG = "ABCDEFó�� ���ӵ� ���ڴ� ����� �� �� �����ϴ�.";
			return false;
		}
	}
	
	if (asValue.indexOf(' ') > -1)
	{
		ERR_MSG = "������ �Է��� �� �����ϴ�.";
		return false;
	}
	
	for (i = 0; i < alpaSmall.length - asValue.length + 1; i++)
	{
		if ( alpaSmall.substring(i, i + asValue.length) == asValue)
		{
			ERR_MSG = "abcdefó�� ���ӵ� ���ڴ� ����� �� �� �����ϴ�.";
			return false;
		}
	}
	
	for (i = 1; i < asValue.length; i++)
	{
		if (asValue.substring(0, 1) != asValue.substring(i, i + 1)) return true;
	}
	
	ERR_MSG = "��й�ȣ�� ���� ���ڸ� �����ؼ� �Է��� �� �����ϴ�.";
	return false;
}

// 1 byte ���� ���Ͽ� �ش�� ����ũ�� �����ϴ��� ����
function S_isValidMask(asValue, asMask)
{
	if (asValue == null || C_isNull(asMask)) return true;
	if (C_isNum(asValue) || C_isAlpha(asValue) || C_isHangul(asValue)) return true;
	if (asMask == "USE") return true;
	
	//Ư�����ڸ� ���� ������� ����
	if (asMask == "N")
	{
		ERR_MSG = "�� �׸񿡴� �����̳� Ư�����ڸ� �Է��� �� �����ϴ�.";
		return false;
	}
	
	if (asMask.indexOf(asValue) >= 0) return true;
	
	var strErrMsg = "";
	
	for (var i = 0; i < asMask.length; i++)
	{
		strErrMsg = strErrMsg + "'" + asMask.charAt(i) + "', ";
	}
	
	strErrMsg = strErrMsg.substring(0, strErrMsg.length - 2);
	
	ERR_MSG = "�� �׸񿡴� '" + asValue + "' ��(��) �Է��� �� �����ϴ�.<BR>�Է°����� Ư�����ڴ� " + strErrMsg + "�� �����մϴ�.";
	return false;
}

// 1 byte ���� �־��� Ÿ������ ����
function S_isValidType(asValue, asType)
{
	if (C_isNull(asValue) || C_isNull(asType)) return true;
	if (!C_isNum(asValue) && !C_isAlpha(asValue) && !C_isHangul(asValue)) return true;

	// Ÿ�� ����
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
		
		//���� Ű ����
		if (isCorrect) break;
	}
	
	if (!isCorrect)
	{
		var strErrMsg =  S_getDisplayType(asType);
		ERR_MSG = "�� �׸񿡴� " + strErrMsg + " �� �Է��� �� �ֽ��ϴ�.";
		return false;
	}
	
	return true;
}

// ������ ��ȿ������
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
			case "DOTCURRENCY" : 	// �ݾ� ��ȿ ����
				str = C_removeComma(str);
				if (obj.getAttribute("decimalplace") != null)
				{
					if (str.lastIndexOf('.') > 0)
					{
						if ((str.length - str.indexOf('.') - 1) > (Number(obj.getAttribute("decimalplace"))))
						{
							C_msgOk("�Ҽ��� �Ʒ� " + obj.getAttribute("decimalplace") + "�ڸ����� �Է°����մϴ�.");
							obj.focus();
							return false;
						}
						
						// �Ҽ������� �ڸ��� ��ŭ 0���� ä���
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
			case "CURRENCY" : 	// �ݾ� ��ȿ ����
				str = C_removeComma(str);
				break;
			case "DATE" : 	// ���� ��ȿ ����
				if (!S_isValidDate(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "DATEYM" : 	// ���� ��ȿ ����
				if (!S_isValidMonth(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "EMAIL" : 	// EMAIL ��ȿ ����
				if (!S_isValidEmail(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "REGNO" : 	// �ֹι�ȣ ��ȿ�� ����
				if (!C_isValidRegNo(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "REGNO2" : 	// �ֹι�ȣ ��ȿ�� ����
				if (!C_isValidRegNo(str))
				{
					C_msgOk(ERR_MSG);
					//obj.focus();
					//obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "CUSTNO" : 	// ����ڹ�ȣ ��ȿ�� ����
				if (!C_isValidCustNo(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "USERID" :	// ���̵� ����
				if (!S_isValidUserId(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "PASSWORD" : // ��й�ȣ ����
				if (!S_isValidPassword(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "LOCALNUM" : // ��ȭ��ȣ ���� ����
				if (!C_isValidPhoneNum(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			case "ACCTNO" : // xxxx������¹�ȣ ����
				if (C_isValidAcctNo(str))
				{
					C_msgOk(ERR_MSG);
					obj.focus();
					obj.value = "";
					//obj.select();
					return false;
				}
				break;
			default :  // 'A','N','H' ����ũ ����
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

	//�ִ� ���� ����
	if (!C_isNull(maxLength))
	{
		var			iLength = C_getByteLength(str);
		if(datatype == "DATE" ||datatype ==  "DATEYM")
		{
			iLength = C_getByteLength(C_removeDateTimeFormat(str));
		}
		if (maxLength < iLength)
		{
			C_msgOk("�Է°����� ���ڼ��� " + maxLength + "�� ���� �Դϴ�.<BR>���ڼ��� �ٿ��ֽʽÿ�.(�ѱ��� 2���ڷ� �ν��մϴ�)");
			obj.focus();
			return false;
		}
	}

	//�ּ� ���� ����
	if (!C_isNull(minLength))
	{
		if (C_getByteLength(str) == 0) return true;
		if (minLength > C_getByteLength(str))
		{
			C_msgOk("�ּ� " + minLength + "�� �̻��� �Է��ϼž� �մϴ�.(�ѱ��� 2���ڷ� �ν��մϴ�)");
			obj.focus();
			return false;
		}
	}
	
	//low ��ȿ�� ����
	if (!C_isNull(lowBound))
	{
		if (eval(str - lowBound) < 0 )
		{
			C_msgOk("" + C_toNumberFormatString(lowBound) + " �̻��� �Է��ϼž� �մϴ�.");
			obj.focus();
			obj.select();
			return false;
		}
	}
	
	//high ��ȿ�� ����
	if (!C_isNull(highBound))
	{
		if (eval(str - highBound) > 0 )
		{
			C_msgOk("" + C_toNumberFormatString(highBound) + " �̸��� �Է��ϼž� �մϴ�.");
			obj.focus();
			obj.select();
			return false;
		}
	}

	return true;
}

/*-------------------- ǥ�� ���� �̺�Ʈ ���� �Լ� --------------------*/
// Form�� onSubmit �̺�Ʈ
function S_onSubmit()
{
	return false;
}

// ���� onKeyUp �̺�Ʈ
function S_onKeyUp(obj)
{
	if (event.keyCode == 8 || event.keyCode == 9 || 
		event.keyCode == 35 || event.keyCode == 36 || event.keyCode == 37 ||
		event.keyCode == 38 || event.keyCode == 40 || event.keyCode == 45 ||
		event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 16) return;
	
	if (obj == null) var obj = this;
	
	//�ڵ� ��Ŀ�� �̵�
	if (event.keyCode == 13)
	{
		S_nextFocus(obj);
		return;
	}
	
	//�ڵ� ��Ŀ�� �̵�
	if (obj.tagName != null && obj.tagName == "INPUT")
	{
		var maxlength = obj.getAttribute("maxLength");
	
		if (maxlength != null && maxlength > 0)
		{
			if (C_getByteLength(obj.value) >= maxlength) S_nextFocus(obj);
		}
	}
}

// ���� onKeyPress �̺�Ʈ
function S_onKeyPress(obj)
{
	if (obj == null) var obj = this;
	
	var datatype = C_toUpperCase(obj.getAttribute("datatype"));
	//var format   = C_toUpperCase(obj.getAttribute("format"));
	var mask     = C_toUpperCase(obj.getAttribute("mask"));
	var key      = String.fromCharCode (event.keyCode);
	var str      = C_Trim(obj.value);

	if (datatype == "USERID" || datatype == "PASSWORD") return;
	
	// ������ Ÿ�� ����
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

// ���� onKeyDown �̺�Ʈ
function S_onKeyDown(obj)
{
	if (obj == null) var obj = this;	
	if (event.keyCode == 13) S_nextFocus(obj);
}

// ���� onBlur �̺�Ʈ
function S_onBlur(obj)
{
	if (obj == null) var obj = this;
	if (obj.getAttribute("uppercase") != null) obj.value = C_toUpperCase(obj.value);
	if (obj.getAttribute("lowercase") != null) obj.value = C_toLowerCase(obj.value);
	if (!obj.getAttribute("readonly"))
	{
		if (!S_ObjectValidate(obj)) return false; 	// ������ ��ȿ�� ����
		S_setObjectFormat(obj);	// ��������
	}

	return true;
}

// ���� onFocus �̺�Ʈ
function S_onFocus(obj)
{
	if (obj == null) var obj = this;
	if (!obj.getAttribute("readonly")) // readOnly �Ǿ� �ִ� ��쿡�� ���� ���� ����
	{
		S_removeObjectFormat(obj);	// ���˻���
		obj.select();
	}
}

/*-------------------- ǥ�� ���� ���� �Լ� --------------------*/

// �⺻ ����Ʈ ���� �����Ѵ�.
function S_setDefaultValue(obj)
{
	var datatype = C_toUpperCase(obj.getAttribute("datatype"));

	// Style sheet ����
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

// ��� Form�� ������
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
		S_setObjectFormat(elem[i]); //���� ����
	}
}

// ��� ���� ����
function S_setObjectFormat(obj)
{
	var format = C_toUpperCase(obj.getAttribute("format"));
	var str = obj.value;
	
	if (C_isNull(str)) return;
	if (format == null) return;
	
	switch (format)
	{
		case "CURRENCY" : 		//�ݾ� ����
			obj.value = C_toNumberFormatString(str);
			break;
		case "DOTCURRENCY" : 		//'.' �ִ� �ݾ� ����
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
		case "DATEYM" : 			//��¥ ����(���)
		case "DATE" : 			//��¥ ����(�����)
			obj.value = C_toDateFormatString(str);
			break;
		case "REGNO" : 			//�ֹε�� ����
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 6) + "-" + str.substr(6, 7);
			break;
		case "CUSTNO" : 		//����ڹ�ȣ ����
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 3) + "-" + str.substr(3, 2) + "-" + str.substr(5, 5);
			break;
		case "ACCTNO" : 		//���¹�ȣ ����
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 3) + "-" + str.substr(3, 5) + "-" + str.substr(8, 2);
			break;
		case "CARDNO" : 		//ī���ȣ ����
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 4) + "-" + str.substr(4, 4) + "-" + str.substr(8, 4) + "-" + str.substr(12, 4);
			break;
		case "POSTNO" : 		//�����ȣ ����
			str = str.replace(/-/g, "");
			obj.value = str.substr(0, 3) + "-" + str.substr(3, 3);
			break;
	}
}

// ���� ����
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
			case "REGNO" : 			//��¥ ����
				obj.value = str.replace(/-/g, "");
				break;
			case "CURRENCY" : 		// �ݾ�
			case "DOTCURRENCY" : 	// �ݾ�
				obj.value = str.replace(/\,/g, "");
				break;
		}
	}
}

// Ÿ�Ժ� ���� �޼��� ����
function S_getDisplayType(asType)
{
	var strMsg = "";
	
	for (var i = 0; i < asType.length; i++)
	{
		switch(asType.charAt(i))
		{
			case 'A' :
					strMsg += ",������";
					break;
			case 'N' :
					strMsg += ",����";
					break;
			case 'H' :
					strMsg += ",�ѱ�";
					break;
		}
	}
	
	return strMsg.substring(1);
}

// Ÿ�Ժ� ���� �޼��� ����
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
	// ������ü�� ���
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
	// ���� ������
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