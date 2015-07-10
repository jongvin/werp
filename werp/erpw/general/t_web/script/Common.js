// Result OK
var RECEIVE_DATA_OK = "S_OK";

// 에러메세지
var ERR_MSG = "";

// Commit 여부
var isWork = false;

// Title 필드 bgcolor
var TITLE_BGCOLOR = "#E8F2FD";

// Wait 프레임 객체
var frmWait = null;
var WAIT_PAGE = "../common/Wait.html";

// 이벤트 발생 객체
var C_EventObject = null;

// 프로그램 권한(U:쓰기, R:읽기, S:저장, P:보고서)
var C_ProgAuthority = "";

// keyCode 값
var C_keyCode = "";

// 표준버트 color
var MOUSE_OVER="#FF0000";
var MOUSE_OUT="#000000";

var S_MOUSE_OVER="#FFFFFF";
var S_MOUSE_OUT="#333333";

var DEFAULT_ROW_BGCOLOR = "#ffffff";
var ROW_SELECT_BGCOLOR = "#D5D5D5";
var ROW_MOUSEOVER_BGCOLOR = "#E5E5E5";
var ROW_MOUSEOUT_BGCOLOR = "#D5D5D5";
var POPUP_ROW_SELECT_BGCOLOR = "#D5D5D5";
var POPUP_ROW_MOUSEOVER_BGCOLOR = "#E5E5E5";
var POPUP_ROW_MOUSEOUT_BGCOLOR = "#D5D5D5";

var MSG_NO_DATA = "자료가 없습니다";
var MSG_SAVE_OK = "저장완료";
var MSG_DELETE_OK = "삭제완료";

var HOME_URL = "http://localhost/DBHM/";
// 공통 페이지 경로
var COMM_PATH = "../common/";

var	C_arrDateInfos = new Array();

/*-------------------- 날짜팝업을 위한 정보 --------------------*/
function	C_DatePopInfo(arTextControl,arButtonControl,arDateTag)
{
	try
	{
		this.TextControl = arTextControl;
		this.ButtonControl = arButtonControl;
		this.DateTag = arDateTag;
		this.CalendarID = arTextControl.id;
		arButtonControl.attachEvent ("onclick", new Function("C_popDatePopup(" + arTextControl.id +",'"+arDateTag+ "' );"));
	}
	catch (e)
	{
		C_msgOk("C_DatePopInfo 에러 : " + e.message, "에러");
	}
}
function	C_addDateCol(arTextControl,arButtonControl,arDateTag)
{
	try
	{
		var objDateInfo = new C_DatePopInfo(arTextControl,arButtonControl,arDateTag);
		
		if (C_arrDateInfos == null) C_arrDateInfos = new Array();
		
		C_arrDateInfos.push(objDateInfo);
	}
	catch (e)
	{
		C_msgOk("날짜 컬럼 등록 에러 : " + e.message, "에러");
		return false;
	}
}
function	C_popDatePopup(arTextControl,arDateTag)
{
	C_Calendar(arTextControl.id, arDateTag, arTextControl.value);
}
function	C_CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (C_arrDateInfos == null) C_arrDateInfos = new Array();
	for(var i = 0 ; i < C_arrDateInfos.length ; i ++)
	{
		if(C_arrDateInfos[i].CalendarID == asCalendarID)
		{
			C_arrDateInfos[i].TextControl.value = asDate;
		}
	}
}

/*-------------------- 웹페이지 초기화 --------------------*/
function C_Initialize()
{
	try
	{
		// 프로그램 권한
		C_ProgAuthority = document.location.href.substring(document.location.href.length - 1).toUpperCase();
		
		document.body.onselectstart = C_processMouse;
		document.body.oncontextmenu = C_processMouse;
		document.body.ondragstart = C_processMouse;
		
		document.body.onkeydown = C_processKey;
		
		// Windows XP SP2 관련
		if (window.dialogTop != null)
		{
			var isXpSP2 = false;
			
			if (window.navigator.userAgent.indexOf("Windows NT 5.1") > -1)
			{
				if (window.navigator.userAgent.indexOf("SV1") > -1)
				{
					isXpSP2 = true;
				}
			}
			
			// 서비스팩 패치후 사용 안함
			if (isXpSP2)
			{
				//alert("당신에 운영체제는 Windows XP SP2 입니다.");
				//var intDalHeight = window.dialogHeight.substring(0, window.dialogHeight.indexOf("px"));
				//window.dialogHeight = (parseInt(intDalHeight) + 20).toString() + "px";
			}
		}
	}
	catch (E)
	{
		alert("C_Initialize() 초기화 오류 : " + E.message, "에러");
	}
	
	try
	{
		S_Initialize();
	}
	catch (E)
	{
		//C_msgOk("S_Initialize() 함수가 존재하지 않습니다.", "에러");
		//C_msgOk("S_Initialize() : " + E.message, "에러");
	}
	
	try
	{
		G_Initialize();
	}
	catch (E)
	{
		//C_msgOk("G_Initialize() 함수가 존재하지 않습니다.", "에러");
		//C_msgOk("G_Initialize() : " + E.message, "에러");
	}
	
	try
	{
		// 공통버튼 보이기
		top.frames['main_title'].mouse_over();
	}
	catch (E)
	{
		//C_msgOk("공통버튼 : " + E.message, "에러");
	}
	
	try
	{
		Initialize();
	}
	catch (E)
	{
		//C_msgOk("Initialize() 함수가 존재하지 않습니다.", "에러");
		C_msgOk("Initialize() : " + E.message, "에러");
	}
}

function C_processMouse()
{
	return true;
} 				

function C_processKey()
{
	if (event.keyCode == 8)
	{
		if (event.srcElement.type == "text" || event.srcElement.type == "textarea" || event.srcElement.type == "password")
		{
			if (event.srcElement.readOnly) event.returnValue = false;
		}
		else
		{
			event.returnValue = false;
		}
	}
	else if (event.ctrlLeft == true && event.shiftLeft == true && event.keyCode == 80)
	{
		C_msgError(document.location.href, "Page 정보");
	}
	else if (event.altLeft == true)
	{
		if (C_EventObject != null && C_EventObject != "undefined")
		{
			if (event.keyCode == 82) // 조회(ALT+R)
			{
				try
				{
					C_keyCode = event.keyCode;
					btnquery_onclick();
				}
				catch (e)
				{
					if (typeof(btnquery_onclick) == "function")
					{
						C_msgOk("공통버튼(조회) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
					}
					else
					{
						C_msgOk("공통버튼(조회) 개발자 정의 함수가 존재하지 않습니다.", "에러");
					}
				}
			}
			else if (event.keyCode == 65 && (C_ProgAuthority == "U")) // 추가(ALT+A)
			{
				try
				{
					C_keyCode = event.keyCode;
					btnadd_onclick();
				}
				catch (e)
				{
					if (typeof(btnadd_onclick) == "function")
					{
						C_msgOk("공통버튼(추가) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
					}
					else
					{
						C_msgOk("공통버튼(추가) 개발자 정의 함수가 존재하지 않습니다.", "에러");
					}
				}
			}
			else if (event.keyCode == 73 && (C_ProgAuthority == "U")) // 삽입(ALT+I)
			{
				try
				{
					C_keyCode = event.keyCode;
					btninsert_onclick();
				}
				catch (e)
				{
					if (typeof(btninsert_onclick) == "function")
					{
						C_msgOk("공통버튼(삽입) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
					}
					else
					{
						C_msgOk("공통버튼(삽입) 개발자 정의 함수가 존재하지 않습니다.", "에러");
					}
				}
			}
			else if (event.keyCode == 68 && (C_ProgAuthority == "U")) // 삭제(ALT+D)
			{
				try
				{
					C_keyCode = event.keyCode;
					btndelete_onclick();
				}
				catch (e)
				{
					if (typeof(btndelete_onclick) == "function")
					{
						C_msgOk("공통버튼(삭제) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
					}
					else
					{
						C_msgOk("공통버튼(삭제) 개발자 정의 함수가 존재하지 않습니다.", "에러");
					}
				}
			}
			else if (event.keyCode == 83 && (C_ProgAuthority == "U" || C_ProgAuthority == "S")) // 저장(ALT+S)
			{
				document.body.focus();
				
				try
				{
					C_keyCode = event.keyCode;
					btnsave_onclick();
				}
				catch (e)
				{
					if (typeof(btnsave_onclick) == "function")
					{
						C_msgOk("공통버튼(저장) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
					}
					else
					{
						C_msgOk("공통버튼(저장) 개발자 정의 함수가 존재하지 않습니다.", "에러");
					}
				}
			}
			else if (event.keyCode == 70 ) // 찾기(ALT+F)
			{
				document.body.focus();
				
				try
				{
					C_keyCode = event.keyCode;
					btnfind_onclick();
				}
				catch (e)
				{
					if (typeof(btnsave_onclick) == "function")
					{
						C_msgOk("공통버튼(저장) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
					}
					else
					{
						C_msgOk("공통버튼(저장) 개발자 정의 함수가 존재하지 않습니다.", "에러");
					}
				}
			}
			else if (event.keyCode == 67 && (C_ProgAuthority == "U" || C_ProgAuthority == "S")) // 복제(ALT+C)
			{
				//document.body.focus();
				
				try
				{
					C_keyCode = event.keyCode;
					btndup_onclick();
				}
				catch (e)
				{
					if (typeof(btnsave_onclick) == "function")
					{
						C_msgOk("공통버튼(저장) 개발자 정의 함수 Call 에러 : " + e.message, "에러");
					}
					else
					{
						C_msgOk("공통버튼(저장) 개발자 정의 함수가 존재하지 않습니다.", "에러");
					}
				}
			}
			
		}
	}
	
	try
	{
		// 개발자 재정의 함수
		document_onKeyDown();
	}
	catch (e)
	{
	}
} 				

function C_Submit(readForm, sendForm)
{
	try
	{
		sendForm.action = readForm.action;
		sendForm.target = readForm.target;
		sendForm.method = readForm.method;
		
		//암호화 적용
		//if (EncForm2(readForm, sendForm)) sendForm.submit();
		
		//암호화 미적용
		readForm.submit();
	}
	catch (E)
	{
		C_msgOk("C_Submit Error : " + E.message, "에러");
	}
}

/*-------------------- 윈도우 관련 함수 --------------------*/
// 새창 여는 함수
function C_openWindow(asURL, asName, aiSizeW, aiSizeH)
{
	var intLeft  = screen.width / 2 - aiSizeW / 2;
	var intTop  = screen.height / 2 - aiSizeH / 2;

	opt = ",toolbar=no,menubar=no,location=no,scrollbars=no,status=yes";
	window.open(asURL, asName, "left=" + intLeft + ",top=" +  intTop + ",width=" + aiSizeW + ",height=" + aiSizeH  + opt);
}

// 확인 메세지 창
// 영문자 'O'를 리턴
function C_msgOk(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "확인" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertOk.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "O" : arrRtn;
}

// 확인/취소 메세지 창
// 영문자 'O','C'를 리턴
function C_msgOkCancel(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "선택" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertOkCancel.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "C" : arrRtn;
}

// 예/아니오 메세지 창
// 영문자 'Y','N'을 리턴
function C_msgYesNo(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "선택" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertYesNo.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "N" : arrRtn;
}

// 예/아니오/취소 메세지 창
// 영문자 'Y','N','C'를 리턴
function C_msgYesNoCancel(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "선택" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertYesNoCancel.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "C" : arrRtn;
}

// 에러 메세지 창
// 영문자 'O'를 리턴
function C_msgError(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "에러" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertError.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "O" : arrRtn;
}

// 달력 창(asCalendarID:달력ID, asType:달력타입[D,M], asDate:초기설정 날자, aiTopPos: 표시위치_Y, aiLeftPos: 표시위치_X)
function C_Calendar(asCalendarID, asType, asDate, aiTopPos, aiLeftPos)
{
	var frmCalender = document.getElementById("C_frmCalender");
	var lsType = "D";
	var liTop = aiTopPos;
	var liLeft = aiLeftPos;
	var liWidth = 0;
	var liHeight = 0;
	var liX = 0;
	var liY = 0;
	
	if (event != null)
	{
		// 이벤트 발생 객체
		C_EventObject = event.srcElement;
		liX = event.clientX - event.offsetX;
		liY = event.clientY - event.offsetY;
	}
	else // event 객체가 null인 경우(가우스 그리드)
	{
		try
		{
			if (C_EventObject != null && C_EventObject != "undefined")
			{
				var datasetinfo = G_searchDataSetInfo(C_EventObject.DataID);
				
				liX = datasetinfo.grid_x + datasetinfo.grid_event_x;
				liY = datasetinfo.grid_y + datasetinfo.grid_event_y;
			}
		}
		catch (e)
		{
			C_EventObject = null;
			liX = document.body.clientWidth / 2 + 73;
			liY = document.body.clientHeight / 2 + 105;
		}
	}
	
	if (frmCalender == null)
	{
		frmCalender = document.createElement("<iframe id='C_frmCalender' width='206' height='190' onBlur='C_CalendarHide(-1)' style='position:absolute;' frameborder='1' scrolling='no'></iframe>");
		document.body.insertBefore(frmCalender);
	}
	
	if (asType != null && !C_isNull(asType)) lsType = asType;
	
	if (lsType == "M")
	{
		liWidth = 206;
		liHeight = 104;
	}
	else
	{
		liWidth = 206;
		liHeight = 190;
	}
	
	if (aiTopPos == null)
	{
		liTop = document.body.clientHeight - liY > 210 ? liY + 20 : liY - 192;
	}
	
	if (aiLeftPos == null)
	{
		liLeft = liX > 186 ? liX - 186 : liX;
	}
	
	frmCalender.width = liWidth;
	frmCalender.height = liHeight;
	frmCalender.style.top = liTop;
	frmCalender.style.left = liLeft;
	frmCalender.src = COMM_PATH + "Calendar.jsp?CID=" + asCalendarID + "&TYPE=" + lsType + "&DATE=" + asDate;
}

// 이미 생성된 달력 창을 보이게 할때 사용
function C_CalendarShow()
{
	var frmCalender = document.getElementById("C_frmCalender");
	
	if (frmCalender != null)
	{
		frmCalender.style.visibility = "visible";
	}
}

// 달력 창이 닫힐때 호출되는 메소드(asCalendarID가 (-1)인 경우는 취소됨을 의미함)
function C_CalendarHide(asCalendarID, asDate)
{
	var frmCalender = document.getElementById("C_frmCalender");
	
	if (frmCalender != null)
	{
		frmCalender.style.visibility = "hidden";
	}
	
	// asCalendarID : -1 <-- 취소를 의미함
	// CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay) <- 개발자 재정의 함수
	if (asCalendarID != -1)
	{
		try
		{
			C_CalendarResult(asCalendarID, asDate, asDate.substring(0, 4), asDate.substring(5, 7), asDate.substring(8));
		}
		catch (e)
		{
		}
		try
		{
			G_CalendarResult(asCalendarID, asDate, asDate.substring(0, 4), asDate.substring(5, 7), asDate.substring(8));
		}
		catch (e)
		{
		}
		try
		{
			CalendarResult(asCalendarID, asDate, asDate.substring(0, 4), asDate.substring(5, 7), asDate.substring(8));
		}
		catch (e)
		{
			if (typeof(CalendarResult) == "function")
			{
				C_msgOk("CalendarResult 개발자 정의 함수 Call 에러 : " + e.message, "에러");
			}
			else
			{
				C_msgOk("CalendarResult 개발자 정의 함수가 존재하지 않습니다.", "에러");
			}
		}
	}
	
	try
	{
		// 달력을 호출한 객체에게 포커스를 넘긴다.
		if (C_EventObject != null && C_EventObject != "undefined") C_EventObject.focus();
	}
	catch (e)
	{
	}
}

// LOV 호출
function C_LOV(asLovName, aArgs, aAutoLoad)
{
	return C_LOV_NEW(asLovName, null, aArgs, aAutoLoad, 'F');
}

function C_LOV_NEW(asLovName, asCtrl, aArgs, aAutoLoad, aMultiSelect)
{
	var lrArgsExt = new Array();
	
	//alert(this.id);

	var lrArgs = null;
	var lsAutoLoad = "F";

	try
	{	
		if (C_isNull(asLovName))
		{
			C_msgError("LOV의 이름이 널(Null)입니다.");
			return;
		}
		
		if(aArgs == null || aArgs == undefined)
		{
			lrArgs = new C_Dictionary();
		}
		else
		{
			lrArgs = aArgs;
		}
		
		lrArgsExt.opener = window;
		lrArgsExt.ctrl = asCtrl;
		lrArgsExt.lrArgs = lrArgs;
		
		if (aAutoLoad != null && !C_isNull(aAutoLoad)) lsAutoLoad = aAutoLoad;
		
		return window.showModalDialog(COMM_PATH + "Lov.jsp?LOV_NAME=" + asLovName + "&AUTO_LOAD=" + aAutoLoad + "&MULTI_SELECT=" + aMultiSelect + "&r", lrArgsExt, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no; resizable:no");
	}
	catch (e)
	{
		C_msgOk("C_LOV 에러 : " + e.message, "에러");
		return null;
	}
}

function C_AutoLov(arDataset, asLovName, aArgs, aAutoLoad)
{
	var lrArgs = null;
	var lrReturn = null;
	
	try
	{
		if (C_isNull(asLovName))
		{
			C_msgError("LOV의 이름이 널(Null)입니다.");
			return null;
		}
		
		if(aArgs == null || aArgs == undefined)
		{
			lrArgs = new C_Dictionary();
		}
		else
		{
			lrArgs = aArgs;
		}

		var arrKeys = null;
		var arrItems = null;
		var	strArgs = "";
		
		if (lrArgs != null)
		{
			arrKeys = lrArgs.keys();
			arrItems = lrArgs.items();
		
			for (var i = 0; i < arrKeys.length; i++)
			{
				strArgs += arrKeys[i] + "=" + arrItems[i] + "&";
			}
		
			strArgs = strArgs.substr(0, strArgs.length - 1);
		}
		
		G_Load(arDataset, COMM_PATH + "LovAuto_q.jsp?LOV_NAME=" + asLovName + "&" + strArgs);
		
		if(arDataset.CountRow == 1)
		{
			lrReturn = lrArgs;
			lrReturn.removeAll();
			
			for (var i = 1; i <= arDataset.CountColumn; i++)
			{
				lrReturn.set(arDataset.ColumnID(i), arDataset.ColumnString(1, i));
			}
			
			return lrReturn;
		}
		
		lrReturn = C_LOV(asLovName, lrArgs, aAutoLoad);
		return lrReturn;
	}
	catch (e)
	{
		C_msgOk("C_AutoLov 에러 : " + e.message, "에러");
		return null;
	}
}

/*-------------------- 데이터 관련 함수 --------------------*/
function C_ReceiveData(asURL)
{
	var arrRtn;
	//var intLeft  = screen.width / 2 - aiSizeW / 2;
	//var intTop  = screen.height / 2 - aiSizeH / 2;
	
	if (C_isNull(asURL)) return null;

	return window.showModalDialog(asURL, null, "dialogHide:yes; center:no; dialogTop:" + screen.height + "; dialogLeft:" + screen.width + "; dialogWidth:100; dialogHeight:100; status:yes; help:no; scroll:no");
}

/*-------------------- 유효성 관련 함수 --------------------*/
// 입력값이 NULL인지 체크
function C_isNull(asValue)
{
    if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "")
    {
        return true;
    }
    
    return false;
}

// 숫자검증
function C_isNum(asValue)
{
	if (C_isNull(asValue)) return false;
	
	for (var i = 0; i < asValue.length; i++)
	{
		if (asValue.charAt(i) < '0' || asValue.charAt(i) > '9')
		{
			return false;
		}
	}
	
	return true;
}

// 영문자검증
function C_isAlpha(asValue)
{
	if (C_isNull(asValue)) return false
	
	for (var i = 0; i < asValue.length; i++)
	{
		if (!((asValue.charAt(i) >='a' && asValue <= 'z') || (asValue.charAt(i) >= 'A' && asValue <= 'Z')))
		{
			return false;
		}
	}

	return true;
}

// 한글검증
function C_isHangul(asValue)
{
	if (C_isNull(asValue)) return false;
	
	for (var i = 0; i < asValue.length; i++)
	{
		var c = escape(asValue.charAt(i));
		
		if (c.indexOf("%u") == -1)
		{
			return false;
		}
	}
	
	return true;		
}

/*
  입력값이 이메일 형식인지 체크
  ex) if (!C_isValidEmail(form.email.value)) {
          alert("올바른 이메일 주소가 아닙니다.");
      }
*/
function C_isValidEmail(asValue)
{
	var strFormat = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	return C_isValidFormat(asValue, strFormat);
}

// 입력값이 전화번호 형식(숫자-숫자-숫자)인지 체크
function C_isValidPhone(asValue) {
	var strFormat = /^(\d+)-(\d+)-(\d+)$/;
	return C_isValidFormat(asValue, strFormat);
}

//주민등록번호 유효성 검증
function C_isValidRegNo(asValue)
{
	var arrRegNo = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	var intSum = 0;
	var intMod = 0;
	var i = 0;
	
	if (C_isNull(asValue)) return true;
	
	var strValue = asValue.toString().replace(/-/g, "");
	
	if (C_getByteLength(strValue) == 10)
	{
		return C_isValidCustNo(strValue);
	}

	if (C_getByteLength(strValue) != 13 || !C_isNum(strValue))
	{
		ERR_MSG = "주민등록번호는 13자리 숫자입니다.";
		return false;
	}

	for (i = 0; i < 13; i++) arrRegNo[i] = strValue.substr(i, 1);
	
	for (i = 0; i < 12; i++) intSum += arrRegNo[i] * ((i > 7) ? (i - 6) : (i + 2));
	
	intMod = 11 - intSum % 11;
	
	if (intMod >= 10) intMod -= 10;
	
	if (intMod != arrRegNo[12])
	{
		ERR_MSG = "올바르지 않은 주민등록번호입니다.";
		return false;
	}
	
	return true;
}

//사업자번호 유효성 검증
function C_isValidCustNo(asValue)
{
	var intSumMod = 0;
	
	if (C_isNull(asValue)) return true;
	
	var strValue = asValue.toString().replace(/-/g, "");
	
	if (C_getByteLength(strValue) == 13)
	{
		return C_isValidRegNo(strValue);
	}
	
	if (C_getByteLength(strValue) != 10 || !C_isNum(strValue))
	{
		ERR_MSG = "사업자등록번호는 10자리 숫자입니다.";
		return false;
	}
	
	intSumMod += parseInt(strValue.substr(0, 1));
	intSumMod += parseInt(strValue.substr(1, 1)) * 3 % 10;
	intSumMod += parseInt(strValue.substr(2, 1)) * 7 % 10;
	intSumMod += parseInt(strValue.substr(3, 1)) * 1 % 10;
	intSumMod += parseInt(strValue.substr(4, 1)) * 3 % 10;
	intSumMod += parseInt(strValue.substr(5, 1)) * 7 % 10;
	intSumMod += parseInt(strValue.substr(6, 1)) * 1 % 10;
	intSumMod += parseInt(strValue.substr(7, 1)) * 3 % 10;
	intSumMod += Math.floor(parseInt(strValue.substr(8, 1)) * 5 / 10);
	intSumMod += parseInt(strValue.substr(8, 1)) * 5 % 10;
	intSumMod += parseInt(strValue.substr(9, 1));
	
	if (intSumMod % 10 != 0)
	{
		ERR_MSG = "올바르지 않은 사업자등록번호입니다.";
		return false;
	}
	
	return	true;
}

// xxxx은행 계좌번호 검증
function C_isValidAcctNo(asValue)
{
	var intSum = 0;
	var intValue = 0;
	var intCheckDigit = parseInt(asValue.substring(10));
	
	if (C_isNull(asValue)) return true;
	
	var strValue = asValue.toString().replace(/-/g, "");
	
	if (C_getByteLength(strValue) != 11 || !C_isNum(strValue))
	{
		ERR_MSG = "계좌번호는 '-'를 제외한 11자리 숫자입니다.";
		return false;
	}
	
	for (var i = 0; i <=9 ; i++)
	{
		intValue = strValue.substr(i, 1);
		
		if (i == 0 || i == 2 || i == 4 || i == 6 || i == 8)
		{
			intValue *= 1;
		}
		else {
			intValue *= 2;
		}
		
		intSum += intValue;
	}
	
	var intLast = 10 - (intSum - (Math.floor(intSum / 10) * 10));
	
	if (intLast == 10) intLast = 0;
	if (intLast != intCheckDigit)
	{
		ERR_MSG = "올바르지 않은 계좌번호입니다.";
		return false;
	}
	
	return true;
}

/*-------------------- 문자열 관련 함수 --------------------*/
// 캐릭터 타입 검증 'H'-한글, 'E'-영문, 'N'-숫자, 'Z'-기타
function C_getCharType(asValue)
{
	var bolHan = false;
	var bolAlp = false;
	var bolNum = false;
	var bolEtc = false;
	
	var retStr = "";

	if (C_isNull(asValue))
	{
		return "";
	}
	
	for (var i = 0; i < asValue.length; i++)
	{
		if (C_isAlpha(asValue.charAt(i)))
		{
			bolAlp = true;
			retStr += "E";
		}
		else if (C_isNum(asValue.charAt(i)))
		{
			bolNum = true;
			retStr += "N";
		}
		else if (C_isHangul(asValue.charAt(i)))
		{
			bolHan = true;
			retStr += "H";
		}
		else
		{
			bolEtc = true;
			retStr += "Z";
		}
	}
	
	return retStr;
}

/*
  입력값에 특정 문자(chars)가 있는지 체크
  특정 문자를 허용하지 않으려 할 때 사용
  ex) if (containsChars(form.name,"!,*&^%$#@~;")) {
          alert("이름 필드에는 특수 문자를 사용할 수 없습니다.");
      }
*/
function C_containsChars(asValue, asChars)
{
	for (var i = 0; i < asValue.length; i++)
	{
		if (asChars.indexOf(asValue.charAt(i)) != -1)	return true;
	}
	
	return false;
}

/*
  입력값이 특정 문자(chars)만으로 되어있는지 체크
  특정 문자만 허용하려 할 때 사용
  ex) if (!C_containsCharsOnly("M", "MW")) {
          alert("성별 필드에는 M,W 문자만 사용할 수 있습니다.");
      }
*/
function C_containsCharsOnly(asValue, asChars)
{
	for (var i = 0; i < asValue.length; i++)
	{
		if (asChars.indexOf(asValue.charAt(i)) == -1) return false;
	}
	
	return true;
}

/*
  입력값이 사용자가 정의한 포맷 형식인지 체크
  자세한 format 형식은 자바스크립트의 'regular expression'을 참조
*/
function C_isValidFormat(asValue, asFormat)
{
	if (C_isNull(asValue)) return true;
	if (asValue.search(asFormat) != -1) return true; //올바른 포맷 형식

	return false;
}

/*
  입력값의 바이트 길이를 리턴
  ex) if (getByteLength(form.title) > 100) {
          alert("제목은 한글 50자(영문 100자) 이상 입력할 수 없습니다.");
      }
*/
function C_getByteLength(asValue)
{
	var byteLength = 0;
	var	lsEsc = "%B2%B3%B4%B7%A8%AD%B1%D7%F7%B0%A7%B8%A1%BF%A4%B6%AE%C6%D0%AA%3F%3F%D8%BA%DE%BD%BC%BE%E6%F0%F8%DF%FE%B9";
	
	for (var i = 0; i < asValue.length; i++)
	{
		var oneChar = escape(asValue.charAt(i));
		
		if (oneChar.length == 1 )
		{
			byteLength ++;
		}
		else if (oneChar.indexOf("%u") != -1)
		{
			byteLength += 2;
		}
		else if (oneChar.indexOf("%") != -1)
		{
			if(lsEsc.indexOf(oneChar) != -1)
			{
				byteLength += 2;
			}
			else
			{
				byteLength += oneChar.length / 3;
			}
		}
	}
	
	return byteLength;
}

// 문자열에 있는 특정문자패턴을 다른 문자패턴으로 바꾸는 함수.
function C_Replace(asTarget, asSearch, asReplace)
{
	var strTemp = "";

	for (var i = 0 ; i < asTarget.length ; i++)
	{
		if (asTarget.charAt(i) != asSearch)
		{
			strTemp = strTemp + asTarget.charAt(i);
		}
		else
		{
			strTemp = strTemp + asReplace;
		}
	}
	
	return strTemp;
}

// 문자열에서 좌우 공백제거
function C_Trim(asValue)
{
	var intStart = 0;
	var intEnd   = 0;

	for (var i = 0 ; i < asValue.length ; i++)
	{
		if (asValue.charAt(i) != " ")
		{
			intStart = i;
			break;
		}
	}
	
	for (var j = asValue.length - 1 ; j >= 0 ; j--)
	{
		if (asValue.charAt(j) != " ")
		{
			intEnd = j + 1;
			break;
		}
	}
	
	return asValue.substring(intStart, intEnd);
}

// 문자열을 숫자 포맷으로 변경한다.(abDot : true(소수점 포함), false(소수점 미포함))
function C_toNumberFormatString(asValue, abDot)
{
	if (C_isNull(asValue)) return "";
	
	//var intNumber = parseFloat(C_removeComma(asValue), 10);
	var intNumber = C_removeComma(asValue, abDot);
	var bolMinus = false;
	var bolDot = false;
	var dotPos;
	var dotU;
	var dotD;
	var commaFlag;
	var strOut = "";

	if (intNumber < 0)
	{
		intNumber *= -1; 
		bolMinus = true;
	}
	
	if (intNumber.toString().indexOf(".") > -1)
	{
		if (abDot == false)
		{
			intNumber = intNumber.substring(0, intNumber.toString().indexOf("."));
		}
	}

	if (intNumber.toString().indexOf(".") > -1)
	{
		dotPos = intNumber.toString().split(".");
		//dotU = dotPos[0];
		dotU = Number(dotPos[0], 10).toString();
		dotD = dotPos[1];
		bolDot = true;
	}
	else
	{
		//dotU = intNumber.toString();
		dotU = Number(intNumber.toString(), 10).toString();
		dotD = "";
	}

	commaFlag = dotU.length % 3;
	
	if (commaFlag)
	{
		strOut = dotU.substring(0, commaFlag);
		if (dotU.length > 3) strOut += ",";
	}
	
	for (var i = commaFlag; i < dotU.length; i+=3)
	{
		strOut += dotU.substring(i, i + 3) ;
		if (i < dotU.length - 3) strOut += ",";
	}
	
	if (bolMinus) strOut = "-" + strOut;
	if (bolDot) strOut = strOut + "." + dotD;
	
	return strOut;
}

// 입력값에서 콤마 및 공백을 없앤다.(abDot : true(소수점 포함), false(소수점 미포함))
function C_removeComma(asValue, abDot)
{
	var intNumber = asValue.toString().replace(/,/g, "").replace(/ /g, "");
	
	if (intNumber.toString().indexOf(".") > -1)
	{
		if (abDot == false)
		{
			intNumber = intNumber.substring(0, intNumber.toString().indexOf("."));
		}
	}
	
    return intNumber;
}
//입력값에서 콤마 및 공백을 없애고 숫자형식 문자열을 되돌린다.
function	C_getNumberTypeString(asValue)
{
	var		lsRet = C_removeComma(asValue,false);
	if(C_isNull(lsRet))
	{
		return "0";
	}
	else
	{
		return lsRet;
	}
}
// Left 빈자리 만큼 strPadChar 을 붙인다.
function C_LPad(strValue, intLength, strPadChar)
{
	var strTemp = "";
	var intPadCnt = intLength - strValue.length;
	
	for (var i = 0; i < intPadCnt; i++) strTemp += strPadChar;
	
	return strTemp + strValue;
}

// Right 빈자리 만큼 strPadChar 을 붙인다.
function C_RPad(strValue, intLength, strPadChar)
{
	var strTemp = "";
	var intPadCnt = intLength - strValue.length;
	
	for (var i = 0; i < intPadCnt; i++) strTemp += strPadChar;
	
	return strValue + strTemp;
}

// 대문자변환
function C_toUpperCase(asValue)
{
	if(C_isNull(asValue)) return asValue;
	return asValue.toUpperCase();
}

// 소문자변환
function C_toLowerCase(asValue)
{
	if(C_isNull(asValue)) return asValue;
	return asValue.toLowerCase();
}

/*
문자열을 입력한 포맷으로 변경한다.
ex) alert(C_StringFM("123456789", "xxx-xxx-xxxx"));
*/
function C_StringFM(strValue, strFormat)
{
	var strData;
	var strPattern;
	var intLen;
	var intPos;
	
	intPos = -1;
	strPattern = /-/g;
	
	if (strValue == null || strValue.length < 1 || strFormat == null || strFormat.length < 1) return strValue;

	strData = strValue.replace(strPattern, "");

	intLen = strData.length;

	if (intLen != strFormat.replace(strPattern, "").length) return strValue;

	while (true)
	{
		intPos = strFormat.indexOf("-", intPos + 1);

		if (intPos < 1) break;
		
		strData = strData.substr(0, intPos) + "-" + strData.substr(intPos);
	}

	return strData;
}

// 한글변환시 bolTag에 true를 넘기고 서버 코딩에서 사용시 반드시 디코딩한다.
function C_Encode(strValue, bolTag)
{
	return bolTag == true ? escape(encodeURI(strValue)) : encodeURI(strValue) ;
}

// 한글이 인코딩된 경우 bolTag에 true를 넘긴다.
function C_Decode(strValue, bolTag)
{
	return bolTag == true ? decodeURI(unescape(strValue)) : decodeURI(strValue);
}

/*-------------------- 체크박스와 라디오버튼 관련 함수 --------------------*/
// 해당 폼에 선택된 체크박스나 라디오버튼이 있는지 체크
function C_isCheckedRadio(aObj)
{
	var elem = isIE ? aObj.all.tags('INPUT') : aObj.getElementsByTagName("INPUT");
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].type != "radio" && elem[i].type != "checkbox") continue;
		if (elem[i].checked) return true;
	}
	
	return false;
}

// 해당 폼에 선택된 체크박스나 라디오버튼이 그 개수를 반환
function C_countCheckedRadio(aObj)
{
	var elem = isIE ? aObj.all.tags('INPUT') : aObj.getElementsByTagName("INPUT");
	var intCount = 0;
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].type != "radio" && elem[i].type != "checkbox") continue;
	    if (elem[i].checked) intCount++;
	}
	
	return intCount;
}

// 해당 폼에 모든 체크박스를 선택한다.
function C_checkAll(aObj)
{
	var elem = isIE ? aObj.all.tags('INPUT') : aObj.getElementsByTagName("INPUT");
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].type != "checkbox") continue;
	    elem[i].checked = true;
	    C_RowSelect(elem[i]);
	}
}

// 해당 폼에 모든 체크박스의 선택을 취소한다.
function C_uncheckAll(aObj)
{
	var elem = isIE ? aObj.all.tags('INPUT') : aObj.getElementsByTagName("INPUT");
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].type != "checkbox") continue;
	    elem[i].checked = false;
	    C_RowSelect(elem[i]);
	}
}

/*
  해당 폼에 선택된 체크박스나 라디오버튼의 Value 값을 리턴한다.
  다수가 선택된 경우 ','로 구분한다("1,2,3,4")
*/
function C_getCheckedRadioValue(aObj)
{
	var elem = isIE ? aObj.all.tags('INPUT') : aObj.getElementsByTagName("INPUT");
	var strKey = "";
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].type != "radio" && elem[i].type != "checkbox") continue;
	    if (elem[i].checked) strKey += elem[i].value + ",";
	}
	
	return strKey.substr(0, strKey.length - 1);
}

// 체크박스나 라디오버튼을 선택할 경우 Row에 색상을 변경한다.
var check = 0;
function C_RowSelect(aoItem)
{
	var objTable;
	
	try
	{
		objTable = aoItem.parentElement.parentElement.parentElement.parentElement;
	
		if (aoItem.type == "radio")
		{
	    	for (var i = 0; i < objTable.rows.length; i++)
			{
			    objTable.rows(i).bgColor = DEFAULT_ROW_BGCOLOR;
			}
	    }
		
		aoItem.parentElement.parentElement.bgColor = aoItem.checked ? ROW_SELECT_BGCOLOR : DEFAULT_ROW_BGCOLOR;
	}
	catch (E)
	{
	}
	
	check = 1;
}

// 체크박스나 라디오버튼을 선택할 경우 Row에 색상을 변경한다.(POP-UP 창에 관련된것) -- 작성자-> 이승준
function C_PopRowSelect(aoItem)
{
	var objTable;
	
	try
	{
		objTable = aoItem.parentElement.parentElement.parentElement.parentElement;
	
		if (aoItem.type == "radio")
		{
	    	for (var i = 0; i < objTable.rows.length; i++)
			{
			    objTable.rows(i).bgColor = DEFAULT_ROW_BGCOLOR;
			}
	    }
		
		aoItem.parentElement.parentElement.bgColor = aoItem.checked ? POPUP_ROW_SELECT_BGCOLOR : DEFAULT_ROW_BGCOLOR;
	}
	catch (E)
	{
	}
	
	check = 1;
}

/*-------------------- 테이블 관련 함수 --------------------*/
// 마우스가 위치한 테이블의 Row에 색상을 변경한다.
function C_RowMouseOver(aoRow)
{
    aoRow.bgColor = ROW_MOUSEOVER_BGCOLOR;
}

// 마우스가 해당 Row에서 벗어난 경우 Row에 색상을 변경한다.
function C_RowMouseOut(aoRow)
{
    aoRow.bgColor = aoRow.childNodes[0].childNodes[0].checked ? ROW_MOUSEOUT_BGCOLOR : DEFAULT_ROW_BGCOLOR;
}

// 마우스가 위치한 테이블의 Row에 색상을 변경한다. (POP-UP)-- 작성자-> 이승준
function C_PopRowMouseOver(aoRow)
{
    aoRow.bgColor = POPUP_ROW_MOUSEOVER_BGCOLOR;
}

// 마우스가 해당 Row에서 벗어난 경우 Row에 색상을 변경한다. (POP-UP)
function C_PopRowMouseOut(aoRow)
{
    aoRow.bgColor = aoRow.childNodes[0].childNodes[0].checked ? POPUP_ROW_MOUSEOUT_BGCOLOR : DEFAULT_ROW_BGCOLOR;
}

// 마우스가 해당 Row에서 벗어난 경우 Row에 색상을 변경한다.
function C_RowMouseClick(aoRow)
{
	if (check == 1)
	{
		check = 0;
		return;
	}
	
	var elem = aoRow.getElementsByTagName("INPUT");
	var obj;
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].type == "radio" || elem[i].type == "checkbox")
		{
			if (elem[i].type == "checkbox")
			{
				elem[i].checked = elem[i].checked ? false : true;
			}
			else
			{
				elem[i].checked = true;
			}
			
			C_RowSelect(elem[i]);
			check = 0;
		}
	}
}

// 기존의 체크박스가 체크되어있는경우 체크된 체크박스에 이벤트를 받지않게 하기위한 함수.//이승준
function C_NotRowMouseClick(aoRow)
{
	if (check == 1)
	{
		check = 0;
		return;
	}
	
	var elem = aoRow.getElementsByTagName("INPUT");
	var obj;
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].type == "radio" || elem[i].type == "checkbox")
		{
			if (elem[i].type == "checkbox")
			{
				elem[i].checked = elem[i].checked ? true : false;
			}
			else
			{
				elem[i].checked = true;
			}
			
			C_RowSelect(elem[i]);
			check = 0;
		}
	}
}

// 마우스가 해당 Row에서 벗어난 경우 Row에 색상을 변경한다.(pop-up 화면에 적용)-- 작성자-> 이승준
function C_PopRowMouseClick(aoRow)
{
	if (check == 1)
	{
		check = 0;
		return;
	}
	
	var elem = aoRow.getElementsByTagName("INPUT");
	var obj;
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].type == "radio" || elem[i].type == "checkbox")
		{
			if (elem[i].type == "checkbox")
			{
				elem[i].checked = elem[i].checked ? false : true;
			}
			else
			{
				elem[i].checked = true;
			}
			
			C_PopRowSelect(elem[i]);
			check = 0;
		}
	}
}

/*-------------------- 날짜, 시간 관련 함수 --------------------*/
// 유효한(존재하는) 년(年)인지 체크
function C_isValidYear(yyyy)
{
	var intYear = parseInt(yyyy, 10);
	return (intYear >= 1900 && intYear <= 2999);
}

// 유효한(존재하는) 월(月)인지 체크
function C_isValidMonth(mm)
{
	var intMonth = parseInt(mm, 10);
	return (intMonth >= 1 && intMonth <= 12);
}

// 유효한(존재하는) 일(日)인지 체크
function C_isValidDay(yyyy, mm, dd)
{
	var intMonth = parseInt(mm, 10) - 1;
	var intDay = parseInt(dd, 10);	
	var arrLastDay = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	
	if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) arrLastDay[1] = 29;	
	
	return (intDay >= 1 && intDay <= arrLastDay[intMonth]);
}

// 유효한(존재하는) 시(時)인지 체크
function C_isValidHour(hh)
{
	var intHour = parseInt(hh, 10);
	return (intHour >= 1 && intHour <= 24);
}

// 유효한(존재하는) 분(分)인지 체크
function C_isValidMin(mi)
{
	var intMin = parseInt(mi, 10);
	return (intMin >= 1 && intMin <= 60);
}

// 입력된 날짜값에서 '-', '/', '.', ':', ' '(공백)을 없앤다.
function C_removeDateTimeFormat(asValue)
{
	return asValue.toString().replace(/-/g, "").replace(/\//g, "").replace(/\./g, "").replace(/:/g, "").replace(/ /g, "");
}

/*
  유효하는(존재하는) 날짜 인지 체크
  ex) var date = form.date.value; //'20010231'
      if (!C_isValidDate(date)) {
          alert("올바른 날짜가 아닙니다.");
      }
 */
function C_isValidDate(asDate)
{
	if (C_isNull(asDate)) return true;
	
	var strDate = C_removeDateTimeFormat(asDate);
	var year  = "";
	var month = "";
	var day   = "";
	var hour  = "";
	var min   = "";
	
	if (strDate.length == 6)
	{
		year  = strDate.substr(0,4);
		month = strDate.substr(4,2);
		
		if (parseInt(year, 10) >= 1900 && C_isValidMonth(month)) return true;
	}
	else if (strDate.length == 8)
	{
		year  = strDate.substr(0,4);
		month = strDate.substr(4,2);
		day   = strDate.substr(6,2);
		
		if (parseInt(year, 10) >= 1900 && C_isValidMonth(month) && C_isValidDay(year,month,day)) return true;
	}
	else if (strDate.length == 12)
	{
		year  = strDate.substr(0,4);
		month = strDate.substr(4,2);
		day   = strDate.substr(6,2);
		hour  = strDate.substr(8,2);
		min   = strDate.substr(10,2);
		
		if (parseInt(year, 10) >= 1900 && C_isValidMonth(month) && C_isValidDay(year, month, day) &&
			C_isValidHour(hour) && C_isValidMin(min)) return true;
	}

	return false;
}

/*
  Date 스트링을 자바스크립트 Date 객체로 변환
  ex) alert(C_toDate("20040329"));
 */
function C_toDate(asDate)
{
	var strDate = C_removeDateTimeFormat(asDate);
	var year  = "";
	var month = "";
	var day   = "";
	var hour  = "";
    var min   = "";
	
	if (strDate.length == 6)
	{
		year  = strDate.substr(0,4);
		month = strDate.substr(4,2) - 1; // 1월=0,12월=11
		
		return new Date(year, month, 1);
	}
	else if (strDate.length == 8)
	{
		year  = strDate.substr(0,4);
		month = strDate.substr(4,2) - 1; // 1월=0,12월=11
		day   = strDate.substr(6,2);
		
		return new Date(year, month, day);
	}
	else if (strDate.length == 12)
	{
		year  = strDate.substr(0,4);
		month = strDate.substr(4,2) - 1; // 1월=0,12월=11
		day   = strDate.substr(6,2);
		hour  = strDate.substr(8,2);
	    min   = strDate.substr(10,2);
		
		return new Date(year, month, day, hour, min);
	}
	
	return null;
}

/*
  자바스크립트 Date 객체를 Date 스트링(20031225)으로 변환
  ex) var date = new Date();
      alert(C_toDateString(date, 8));
 */
function C_toDateString(aoDate, aiLength)
{
	var year  = aoDate.getFullYear();
	var month = aoDate.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
	var day   = aoDate.getDate();
	var hour  = aoDate.getHours();
    var min   = aoDate.getMinutes();
    
    if (("" + month).length == 1) { month = "0" + month; }
	if (("" + day).length   == 1) { day   = "0" + day;   }
	if (("" + hour).length  == 1) { hour  = "0" + hour;  }
    if (("" + min).length   == 1) { min   = "0" + min;   }
	
	if (aiLength == 8)
	{
		return ("" + year + month + day)
	}
	else if (aiLength == 12)
	{
		return ("" + year + month + day + hour + min)
	}
	
	return "";
}

/*
  Date 스트링을 yyyy-mm-dd 포맷의 스트링으로 변환.
  ex) alert(C_toDateFormatString("20040329"));
 */
function C_toDateFormatString(asDate)
{
	var strDate = C_removeDateTimeFormat(asDate);
	var strTemp = "";
	
	if (strDate.length == 6)
	{
		strTemp += strDate.substr(0,4);
		strTemp += "-";
		strTemp += strDate.substr(4,2);
	}
	else if (strDate.length == 8)
	{
		strTemp += strDate.substr(0,4);
		strTemp += "-";
		strTemp += strDate.substr(4,2);
		strTemp += "-";
		strTemp += strDate.substr(6,2);
	}
	else if (strDate.length == 12)
	{
		strTemp += strDate.substr(0,4);
		strTemp += "-";
		strTemp += strDate.substr(4,2);
		strTemp += "-";
		strTemp += strDate.substr(6,2);
		strTemp += " ";
		strTemp += strDate.substr(8,2);
		strTemp += ":";
		strTemp += strDate.substr(10,2);
	}
	else
	{
		strTemp = asDate;
	}
	
	return strTemp;
}

// 현재 시각을 Date String 형식으로 리턴 (20040329)
function C_getNowDateString(aiLength)
{
	return C_toDateString(new Date(), aiLength);
}

// 현재 시각을 Date Format String 형식으로 리턴 (2004-03-29)
function C_getNowDateFormatString(aiLength)
{
	return C_toDateFormatString(C_toDateString(new Date(), aiLength));
}

// 현재 시각을 지정한 구분자를 Date Format String 형식으로 리턴 (YYYY-MM) 예 delimiter -
//추가 - 한재원
function getYearMonth(delimiter)
{
	var strYear = C_getYear();
	var strMonth = C_getMonth();
			
	var strYearMonth = strYear + ''+ delimiter + ''+ strMonth;
	return strYearMonth;
}
// 현재 年을 YYYY형식으로 리턴
function C_getYear()
{
	return C_getNowDateString(12).substr(0,4);
}

// 현재 月을 MM형식으로 리턴
function C_getMonth()
{
	return C_getNowDateString(12).substr(4,2);
}

// 현재 日을 DD형식으로 리턴
function C_getDay()
{
	return C_getNowDateString(12).substr(6,2);
}

// 현재 時를 HH형식으로 리턴
function C_getHour()
{
	return C_getNowDateString(12).substr(8,2);
}


// 현재 日의 요일을 구한다.
function C_getToDayOfWeek()
{
	var week = new Array('일','월','화','수','목','금','토');
	var now  = new Date();
	var day  = now.getDay(); //일요일=0,월요일=1,...,토요일=6

	return week[day];
}

// 특정날짜의 요일을 구한다.
function C_getDayOfWeek(asDate)
{
	var week = new Array('일','월','화','수','목','금','토');
	var now  = C_toDate(asDate);
	var day  = now.getDay(); //일요일=0,월요일=1,...,토요일=6

	return week[day];
}

// 현재날짜의 데이트+시각을 구한다
function C_getDateTime()
{
   var d, s = "";

   d = new Date();
   s += C_getNowDateString(8); 
   s += d.getHours();
   s += d.getMinutes();
   s += d.getSeconds();
   s += d.getMilliseconds();
   return(s);
}


//월의 끝 일자 얻기
function C_getEndDay(asDate)
{
	var arrLastDay = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var strDate = C_removeDateTimeFormat(asDate);
	var year = parseInt(strDate.substr(0,4), 10);
	var month = parseInt(strDate.substr(4,2), 10);
	
	if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) arrLastDay[1] = 29;	

	return arrLastDay[month - 1];
}

//시작일자와 종료일자를 비교(종료일자가 크면 true, 시작일자가 크면 false)
function C_compareDateFT(asFDate, asTDate)
{
	if (!C_isValidDate(asFDate) || !C_isValidDate(asTDate)) return true;
	
	var iFDate = parseFloat(C_removeDateTimeFormat(asFDate));
	var iTDate = parseFloat(C_removeDateTimeFormat(asTDate));
	
	if (isNaN(iFDate) || isNaN(iTDate)) return true;
	
	return iFDate <= iTDate ? true : false;
}

//시작일자와 종료일자를 계산해서 몇년, 몇월, 몇일이 차이가 나는지 계산(결과값은 배열로 넘긴다)
function C_calcDateFT(asFromDate, asToDate)
{
	if (!C_isValidDate(asFromDate) || !C_isValidDate(asToDate)) return null;
	
	var lsFromDate = C_removeDateTimeFormat(asFromDate);
	var lsToDate = C_removeDateTimeFormat(asToDate);
	
	if (isNaN(parseFloat(lsFromDate)) || isNaN(parseFloat(lsToDate))) return null;
	
	var larrRet = new Array(3);
	var liFromDay = 0;
	var liToDay = 0;
	var liTemp = 0;
	var liYear = 0;
	var liMonth = 0;
	var liDay = 0;
	
	liFromDay = (parseFloat(lsFromDate.substr(0, 4)) * 365) + (parseFloat(lsFromDate.substr(4, 2)) * 30) + parseFloat(lsFromDate.substr(6, 2));
	liToDay = (parseFloat(lsToDate.substr(0, 4)) * 365) + (parseFloat(lsToDate.substr(4, 2)) * 30) + parseFloat(lsToDate.substr(6, 2));
	
	liTemp = Math.abs(liToDay - liFromDay);
	
	// 년 계산
	if (liTemp >= 365)
	{
		liYear = parseInt(liTemp / 365);
		liTemp = (liTemp % 365);
	}
	else
	{
		liYear = 0;
	}
	
	// 월 계산
	if (liTemp >= 30)
	{
		liMonth = parseInt(liTemp / 30);
		liTemp = (liTemp % 30);
	}
	else
	{
		liMonth = 0;
	}
	
	liDay = liTemp;
	
	larrRet[0] = liYear;
	larrRet[1] = liMonth;
	larrRet[2] = liDay;
	
	return larrRet;
}

/*-------------------- 전화번호 관련 함수 --------------------*/
// 전화번호 국번검증
function C_isValidPhoneNum(asPhoneNum)
{
	if (C_isNull(asPhoneNum)) return false;

	if (asPhoneNum != "02" && asPhoneNum != "031" && asPhoneNum != "032" && asPhoneNum != "033" && asPhoneNum != "041" &&
		asPhoneNum != "042" && asPhoneNum != "043" && asPhoneNum != "051" && asPhoneNum != "052" && asPhoneNum != "053" &&
		asPhoneNum != "054" && asPhoneNum != "055" && asPhoneNum != "061" && asPhoneNum != "062" && asPhoneNum != "063" &&
		asPhoneNum != "064" && asPhoneNum != "011" && asPhoneNum != "016" && asPhoneNum != "017" && asPhoneNum != "018" &&
		asPhoneNum != "019" && asPhoneNum != "010")
	{
		ERR_MSG = "잘못된 전화번호 국번입니다.";
		return false;
	}

	return true;
	
}

/*-------------------- 콤보박스 관련 함수 --------------------*/
// 콤보박스 초기화
function C_intiCombo(aCbo)
{
	while (aCbo.options.length > 0)
	{
		for (var i = 0; i < aCbo.options.length; i++)
		{
			aCbo.remove(i);
		}
	}
}

// 해당 URL에서 데이터를 읽어와 콤보박스 설정
function C_setCombo(aCbo, asURL)
{
	var oOption = null;
	var arrData = null;
	var arrTemp = null;
	
	C_intiCombo(aCbo);
	
	arrData = C_ReceiveData(asURL);
	
	if (arrData == null || arrData.length < 1) return;
	if (arrData[0] != RECEIVE_DATA_OK)
	{
		C_msgOk(arrData[0], "에러");
		return;
	}
	
	for (var i = 1; i < arrData.length; i++)
	{
		oOption = document.createElement("OPTION");
		arrTemp = arrData[i].split("\t");
		
		oOption.value = arrTemp[0];
		oOption.text = arrTemp[1];
		aCbo.add(oOption);
	}
}

// 해당 URL에서 데이터를 읽어와 콤보박스 설정(전체포함)
function C_setComboAll(aCbo, asURL, asAllString)
{
	var oOption = null;
	var arrData = null;
	var arrTemp = null;
	
	C_intiCombo(aCbo);
	
	arrData = C_ReceiveData(asURL);
	
	if (arrData == null || arrData.length < 1) return;
	if (arrData[0] != RECEIVE_DATA_OK)
	{
		C_msgOk(arrData[0], "에러");
		return;
	}
	
	oOption = document.createElement("OPTION");
	oOption.value = C_isNull(asAllString) ? "%" : asAllString;
	oOption.text = "전체";
	aCbo.add(oOption);
	
	for (var i = 1; i < arrData.length; i++)
	{
		oOption = document.createElement("OPTION");
		arrTemp = arrData[i].split("\t");
		
		oOption.value = arrTemp[0];
		oOption.text = arrTemp[1];
		aCbo.add(oOption);
	}
}

// 해당 배열의 값으로 콤보박스 설정
function C_setArrayCombo(aCbo, aArr)
{
	var oOption = null;
	var arrTemp = null;
	
	C_intiCombo(aCbo);
	
	if (aArr == null || aArr.length < 1) return;
	
	for (var i = 0; i < aArr.length; i++)
	{
		oOption = document.createElement("OPTION");
		arrTemp = aArr[i].split("\t");
		
		oOption.value = arrTemp[0];
		oOption.text = arrTemp[1];
		aCbo.add(oOption);
	}
}

// 해당 배열의 값으로 콤보박스 설정(전체포함)
function C_setArrayComboAll(aCbo, aArr, asAllString)
{
	var oOption = null;
	var arrTemp = null;
	
	C_intiCombo(aCbo);
	
	oOption = document.createElement("OPTION");
	oOption.value = C_isNull(asAllString) ? "%" : asAllString;
	oOption.text = "전체";
	aCbo.add(oOption);
	
	if (aArr == null || aArr.length < 1) return;
	
	for (var i = 0; i < aArr.length; i++)
	{
		oOption = document.createElement("OPTION");
		arrTemp = aArr[i].split("\t");
		
		oOption.value = arrTemp[0];
		oOption.text = arrTemp[1];
		aCbo.add(oOption);
	}
}

// 항목을 추가한다.
function C_addComboItem(aCbo, aValue, aText)
{
	var oOption = null;
	var oNewOption = null;
	var isAdd = true;
	
	if (aCbo == null || C_isNull(aValue) || C_isNull(aText)) return;
	
	for (var i = 0; i < aCbo.options.length; i++)
	{
		oOption = aCbo.options(i);
		
		if (oOption.value == aValue) isAdd = false;
	}
	
	if (isAdd)
	{
		oNewOption = document.createElement("OPTION");
		
		oNewOption.value = aValue;
		oNewOption.text = aText;
		aCbo.add(oNewOption);
	}
}

/*-------------------- 탭페이지 관련 함수 --------------------*/
// 탭페이지 선택시 이미지 변환 함수
// index : 선택된 탭의 순번
// totcount : 전체 탭의 갯수
// 탭 좌측 이미지명 : imgTabLeft + 순번
// 탭 중앙 td명 : tab + 순번
// 탭 우측 이미지명 : imgTabRight + 순번
function C_selectTab(index, totcount)
{
	var tab = null;
	var imgTabLeft = null;
	var imgTabRight = null;
	
	try
	{
		for (var i = 1; i <= totcount; i++)
		{
			tab = eval("tab" + i);
			imgTabLeft = eval("imgTabLeft" + i);
			imgTabRight = eval("imgTabRight" + i);
			
			tab.background = "../images/Content_tab_bgimage.gif";
			imgTabLeft.src="../images/Content_tab_after.gif";
			imgTabRight.src="../images/Content_tab_back.gif";
		}
		
		tab = eval("tab" + index);
		imgTabLeft = eval("imgTabLeft" + index);
		imgTabRight = eval("imgTabRight" + index);
		
		tab.background = "../images/Content_tab_bgimage_r.gif";
		imgTabLeft.src="../images/Content_tab_after_r.gif";
		imgTabRight.src="../images/Content_tab_back_r.gif";
	}
	catch (ex)
	{
		C_msgOk("탭페이지 에러 : " + ex.message, "에러");
		return false;
	}
	
	return true;
}


/*-------------------- Dictionary 객체 --------------------*/
// 생성 : var lrDict = new C_Dictionary();
// 전체삭제 : lrDict.removeAll();
// 기타등등
function	C_Dictionary()
{
	this.List = new ActiveXObject("Scripting.Dictionary");
	this.set = C_dictSetMapElement;
	this.get = C_dictGetMapElement;
	this.remove = C_dictRemoveMapElement;
	this.count = C_dictCountMapElement;
	this.exists = C_dictExistsMapElement;
	this.keys = C_dictKeysMapElement;
	this.items = C_dictItemsMapElement;
	this.removeAll = C_dictRemoveAllMapElement;
}
function	C_dictRemoveAllMapElement()
{
	this.List.RemoveAll();
}
function	C_dictItemsMapElement()
{
	return (new VBArray(this.List.Items())).toArray();
}
function	C_dictKeysMapElement()
{
	return (new VBArray(this.List.Keys())).toArray();
}
function	C_dictExistsMapElement(asKey)
{
	return this.List.Exists(asKey);
}
function	C_dictCountMapElement()
{
	return this.List.Count;
}
function	C_dictSetMapElement(asKey,asValue)
{
	this.List.Item(asKey) = asValue;
}
function	C_dictGetMapElement(asKey)
{
	try
	{
		return this.List.Item(asKey);
	}
	catch(e)
	{
		return undefined;
	}
}
function	C_dictRemoveMapElement(asKey)
{
	try
	{
		this.List.Remove(asKey);
	}
	catch(e)
	{
	}
}


/*-------------------- 텍스트 박스에서 LOV 자동호출 함수 --------------------*/
function	C_AutoPopWhenChange(arDataSet,asLOVName,arTextControl,varName,abIfNullClear,abAutoRetrieve)
{
	this.Dataset = arDataSet;
	this.LOVName = asLOVName;
	this.VarName = varName;
	this.TextControl = arTextControl;
	this.OldValue = arTextControl.value;
	this.OldOnBlur = arTextControl.onblur;
	this.OldOnFocus = arTextControl.onfocus;
	this.NewOnBlur = C_autoPopOnBlur;
	this.NewOnFocus = C_autoPopOnFocus;
	arTextControl.attachEvent ("onblur", new Function("C_autoPopOnBlur("+arTextControl.id+"," + varName + ");"));
	arTextControl.attachEvent ("onfocus", new Function("C_autoPopOnFocus("+arTextControl.id+"," + varName + ");"));
	this.Args = new C_Dictionary();
	this.ArgInfo = new C_Dictionary();
	this.ReturnInfo = new C_Dictionary();
	this.SetArgBind = C_setArgBind;
	this.SetReturnBind = C_setReturnBind;
	this.SetArgConst = C_setArgConst;
	this.NullClear = abIfNullClear;
	this.AutoRetrieve = (abAutoRetrieve == null)?'F':abAutoRetrieve;
	this.OldOnClick = null;
	this.NewOnClick = null;
	this.Button = null;
	this.AttachButton = C_autoPopAttachButton;
}
function	C_autoPopAttachButton(arButton)
{
	this.Button = arButton;
	this.OldOnClick = arButton.onclick;
	this.NewOnClick = C_popLov;
	arButton.attachEvent ("onclick", new Function("C_popLov("+this.VarName + ");"));
}

function	C_popLov(objvar)
{
	var			arrKeys;
	var			arrItems;
	
	
	arrKeys = objvar.ArgInfo.keys();
	arrItems = objvar.ArgInfo.items();
	objvar.Args.removeAll();
	
	for (var i = 0; i < arrKeys.length; i++)
	{
		var		lrInfo = arrItems[i];
		
		if(lrInfo.IsConst)
		{
			objvar.Args.set(lrInfo.ArgName,lrInfo.RelControlAttr);
		}
		else
		{
			objvar.Args.set(lrInfo.ArgName,lrInfo.RelControl.getAttribute(lrInfo.RelControlAttr));
		}
	}
	
	var		lrRet = C_LOV(objvar.LOVName,objvar.Args,objvar.AutoRetrieve);
	
	if(lrRet == null)
	{
		C_raiseEvent_OnCancelLov(objvar.TextControl);
		return;
	}
	
	arrKeys = objvar.ReturnInfo.keys();
	arrItems = objvar.ReturnInfo.items();
	
	for (var i = 0; i < arrKeys.length; i++)
	{
		var		lrInfo = arrItems[i];
		lrInfo.RelControl.setAttribute(lrInfo.RelControlAttr,lrRet.get(lrInfo.ArgName));
	}
	C_raiseEvent_OnSuccessLov(objvar.TextControl);
}

function	C_AutoPopArgInfo(arControl,arControlAttribute,asArgName,abConst)
{
	this.RelControl = arControl;
	this.RelControlAttr = arControlAttribute;
	this.ArgName = asArgName;
	this.IsConst = abConst;
}

function	C_setArgConst(asArgName,asConst)
{
	this.ArgInfo.set(asArgName,new C_AutoPopArgInfo(null,asConst,asArgName,true));
}

function	C_setArgBind(asArgName,arControl,arControlAttribute)
{
	this.ArgInfo.set(asArgName,new C_AutoPopArgInfo(arControl,arControlAttribute,asArgName,false));
}

function	C_setReturnBind(asArgName,arControl,arControlAttribute)
{
	this.ReturnInfo.set(asArgName,new C_AutoPopArgInfo(arControl,arControlAttribute,asArgName,false));
}

function	C_autoPopOnFocus(objtarget,objvar)
{
	objvar.OldValue = objtarget.value;
}
function	C_raiseEvent_OnSuccessLov(objtarget)
{
	try
	{
		OnSuccessLov(objtarget);
	}
	catch (e)
	{
		if (typeof(OnSuccessLov) == "function")
		{
			C_msgOk("OnSuccessLov 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}
function	C_raiseEvent_OnCancelLov(objtarget)
{
	try
	{
		OnCancelLov(objtarget);
	}
	catch (e)
	{
		if (typeof(OnCancelLov) == "function")
		{
			C_msgOk("OnSuccessLov 이벤트의 개발자 정의 함수 Call 에러 : " + e.message, "에러");
		}
	}
}

function	C_autoPopOnBlur(objtarget,objvar)
{
	var			strOldBack = objvar.OldValue;
	var			arrKeys;
	var			arrItems;
	
	if(objtarget.value == objvar.OldValue)
	{
		C_raiseEvent_OnCancelLov(objtarget);
		return;
	}
	
	if(C_isNull(objtarget.value) && objvar.NullClear)
	{
		arrKeys = objvar.ReturnInfo.keys();
		arrItems = objvar.ReturnInfo.items();
		
		for (var i = 0; i < arrKeys.length; i++)
		{
			var		lrInfo = arrItems[i];
			lrInfo.RelControl.setAttribute(lrInfo.RelControlAttr,"");
		}
		C_raiseEvent_OnSuccessLov(objtarget);
		return;
	}
	
	arrKeys = objvar.ArgInfo.keys();
	arrItems = objvar.ArgInfo.items();
	objvar.Args.removeAll();
	
	for (var i = 0; i < arrKeys.length; i++)
	{
		var		lrInfo = arrItems[i];
		
		if(lrInfo.IsConst)
		{
			objvar.Args.set(lrInfo.ArgName,lrInfo.RelControlAttr);
		}
		else
		{
			objvar.Args.set(lrInfo.ArgName,lrInfo.RelControl.getAttribute(lrInfo.RelControlAttr));
		}
	}
	
	var		lrRet = C_AutoLov(objvar.Dataset,objvar.LOVName,objvar.Args);
	
	if(lrRet == null)
	{
		objtarget.value = strOldBack;
		objtarget.focus();
		C_raiseEvent_OnCancelLov(objtarget);
		return;
	}
	
	arrKeys = objvar.ReturnInfo.keys();
	arrItems = objvar.ReturnInfo.items();
	
	for (var i = 0; i < arrKeys.length; i++)
	{
		var		lrInfo = arrItems[i];
		lrInfo.RelControl.setAttribute(lrInfo.RelControlAttr,lrRet.get(lrInfo.ArgName));
	}
	C_raiseEvent_OnSuccessLov(objtarget);
}

/*-------------------- Wait 프레임 함수 --------------------*/
function C_ShowWait(aShow)
{
	if (frmWait == null || frmWait == undefined)
	{
		// Wait 프레임 객체 생성
		var liWidth = document.body.scrollWidth;
		var liHeight = document.body.scrollHeight;
		
		frmWait = document.createElement("<iframe id='frmWait' width='140' height='60' style='position:absolute; visibility:hidden' frameborder='0' tabindex='-1' scrolling='no'></iframe>");
		
		frmWait.src = WAIT_PAGE;
		frmWait.style.top = (liHeight / 2 - 30) + "px";
		frmWait.style.left = (liWidth / 2 - 70) + "px";
		
		document.body.insertBefore(frmWait);
	}
	
	frmWait.style.visibility = aShow == true ? "visible" : "hidden";
}
function	C_convSafeFloat(asData)
{
	try
	{
		var			lfRet = parseFloat(asData);
		if(isNaN(lfRet)) return 0.0;
		return lfRet;
	}
	catch(e)
	{
		return 0.0;
	}
}
function	C_convSafeInt(asData)
{
	try
	{
		var			lfRet = parseInt(asData);
		if(isNaN(lfRet)) return 0;
		return lfRet;
	}
	catch(e)
	{
		return 0;
	}
}
function	C_safeDivide(af1,af2)
{
	if(af2 == 0)
	{
		return 0;
	}
	else
	{
		return af1 / af2;
	}
}
function	C_Round(arNumber,arDec)
{
	return Math.round(arNumber * Math.pow(10,(C_isNull(arDec)?0:arDec))) / Math.pow(10,(C_isNull(arDec)?0:arDec));
}
function	C_Floor(arNumber,arDec)
{
	return Math.floor(arNumber * Math.pow(10,(C_isNull(arDec)?0:arDec))) / Math.pow(10,(C_isNull(arDec)?0:arDec));
}
function	C_Ceil(arNumber,arDec)
{
	return Math.ceil(arNumber * Math.pow(10,(C_isNull(arDec)?0:arDec))) / Math.pow(10,(C_isNull(arDec)?0:arDec));
}
