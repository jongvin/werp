// Result OK
var RECEIVE_DATA_OK = "S_OK";

// �����޼���
var ERR_MSG = "";

// Commit ����
var isWork = false;

// Title �ʵ� bgcolor
var TITLE_BGCOLOR = "#E8F2FD";

// Wait ������ ��ü
var frmWait = null;
var WAIT_PAGE = "../common/Wait.html";

// �̺�Ʈ �߻� ��ü
var C_EventObject = null;

// ���α׷� ����(U:����, R:�б�, S:����, P:����)
var C_ProgAuthority = "";

// keyCode ��
var C_keyCode = "";

// ǥ�ع�Ʈ color
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

var MSG_NO_DATA = "�ڷᰡ �����ϴ�";
var MSG_SAVE_OK = "����Ϸ�";
var MSG_DELETE_OK = "�����Ϸ�";

var HOME_URL = "http://localhost/DBHM/";
// ���� ������ ���
var COMM_PATH = "../common/";

var	C_arrDateInfos = new Array();

/*-------------------- ��¥�˾��� ���� ���� --------------------*/
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
		C_msgOk("C_DatePopInfo ���� : " + e.message, "����");
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
		C_msgOk("��¥ �÷� ��� ���� : " + e.message, "����");
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

/*-------------------- �������� �ʱ�ȭ --------------------*/
function C_Initialize()
{
	try
	{
		// ���α׷� ����
		C_ProgAuthority = document.location.href.substring(document.location.href.length - 1).toUpperCase();
		
		document.body.onselectstart = C_processMouse;
		document.body.oncontextmenu = C_processMouse;
		document.body.ondragstart = C_processMouse;
		
		document.body.onkeydown = C_processKey;
		
		// Windows XP SP2 ����
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
			
			// ������ ��ġ�� ��� ����
			if (isXpSP2)
			{
				//alert("��ſ� �ü���� Windows XP SP2 �Դϴ�.");
				//var intDalHeight = window.dialogHeight.substring(0, window.dialogHeight.indexOf("px"));
				//window.dialogHeight = (parseInt(intDalHeight) + 20).toString() + "px";
			}
		}
	}
	catch (E)
	{
		alert("C_Initialize() �ʱ�ȭ ���� : " + E.message, "����");
	}
	
	try
	{
		S_Initialize();
	}
	catch (E)
	{
		//C_msgOk("S_Initialize() �Լ��� �������� �ʽ��ϴ�.", "����");
		//C_msgOk("S_Initialize() : " + E.message, "����");
	}
	
	try
	{
		G_Initialize();
	}
	catch (E)
	{
		//C_msgOk("G_Initialize() �Լ��� �������� �ʽ��ϴ�.", "����");
		//C_msgOk("G_Initialize() : " + E.message, "����");
	}
	
	try
	{
		// �����ư ���̱�
		top.frames['main_title'].mouse_over();
	}
	catch (E)
	{
		//C_msgOk("�����ư : " + E.message, "����");
	}
	
	try
	{
		Initialize();
	}
	catch (E)
	{
		//C_msgOk("Initialize() �Լ��� �������� �ʽ��ϴ�.", "����");
		C_msgOk("Initialize() : " + E.message, "����");
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
		C_msgError(document.location.href, "Page ����");
	}
	else if (event.altLeft == true)
	{
		if (C_EventObject != null && C_EventObject != "undefined")
		{
			if (event.keyCode == 82) // ��ȸ(ALT+R)
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
						C_msgOk("�����ư(��ȸ) ������ ���� �Լ� Call ���� : " + e.message, "����");
					}
					else
					{
						C_msgOk("�����ư(��ȸ) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
					}
				}
			}
			else if (event.keyCode == 65 && (C_ProgAuthority == "U")) // �߰�(ALT+A)
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
						C_msgOk("�����ư(�߰�) ������ ���� �Լ� Call ���� : " + e.message, "����");
					}
					else
					{
						C_msgOk("�����ư(�߰�) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
					}
				}
			}
			else if (event.keyCode == 73 && (C_ProgAuthority == "U")) // ����(ALT+I)
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
						C_msgOk("�����ư(����) ������ ���� �Լ� Call ���� : " + e.message, "����");
					}
					else
					{
						C_msgOk("�����ư(����) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
					}
				}
			}
			else if (event.keyCode == 68 && (C_ProgAuthority == "U")) // ����(ALT+D)
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
						C_msgOk("�����ư(����) ������ ���� �Լ� Call ���� : " + e.message, "����");
					}
					else
					{
						C_msgOk("�����ư(����) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
					}
				}
			}
			else if (event.keyCode == 83 && (C_ProgAuthority == "U" || C_ProgAuthority == "S")) // ����(ALT+S)
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
						C_msgOk("�����ư(����) ������ ���� �Լ� Call ���� : " + e.message, "����");
					}
					else
					{
						C_msgOk("�����ư(����) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
					}
				}
			}
			else if (event.keyCode == 70 ) // ã��(ALT+F)
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
						C_msgOk("�����ư(����) ������ ���� �Լ� Call ���� : " + e.message, "����");
					}
					else
					{
						C_msgOk("�����ư(����) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
					}
				}
			}
			else if (event.keyCode == 67 && (C_ProgAuthority == "U" || C_ProgAuthority == "S")) // ����(ALT+C)
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
						C_msgOk("�����ư(����) ������ ���� �Լ� Call ���� : " + e.message, "����");
					}
					else
					{
						C_msgOk("�����ư(����) ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
					}
				}
			}
			
		}
	}
	
	try
	{
		// ������ ������ �Լ�
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
		
		//��ȣȭ ����
		//if (EncForm2(readForm, sendForm)) sendForm.submit();
		
		//��ȣȭ ������
		readForm.submit();
	}
	catch (E)
	{
		C_msgOk("C_Submit Error : " + E.message, "����");
	}
}

/*-------------------- ������ ���� �Լ� --------------------*/
// ��â ���� �Լ�
function C_openWindow(asURL, asName, aiSizeW, aiSizeH)
{
	var intLeft  = screen.width / 2 - aiSizeW / 2;
	var intTop  = screen.height / 2 - aiSizeH / 2;

	opt = ",toolbar=no,menubar=no,location=no,scrollbars=no,status=yes";
	window.open(asURL, asName, "left=" + intLeft + ",top=" +  intTop + ",width=" + aiSizeW + ",height=" + aiSizeH  + opt);
}

// Ȯ�� �޼��� â
// ������ 'O'�� ����
function C_msgOk(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "Ȯ��" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertOk.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "O" : arrRtn;
}

// Ȯ��/��� �޼��� â
// ������ 'O','C'�� ����
function C_msgOkCancel(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "����" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertOkCancel.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "C" : arrRtn;
}

// ��/�ƴϿ� �޼��� â
// ������ 'Y','N'�� ����
function C_msgYesNo(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "����" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertYesNo.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "N" : arrRtn;
}

// ��/�ƴϿ�/��� �޼��� â
// ������ 'Y','N','C'�� ����
function C_msgYesNoCancel(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "����" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertYesNoCancel.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "C" : arrRtn;
}

// ���� �޼��� â
// ������ 'O'�� ����
function C_msgError(asMessage, asTitle)
{
	var arrRtn = null;
	var arrArg = new Array(asMessage, asTitle);
	
	arrArg[0] = asMessage;
	arrArg[1] = C_isNull(asTitle) ? "����" : asTitle;
	
	arrRtn = window.showModalDialog(COMM_PATH + "alertError.jsp", arrArg, "center:yes; dialogWidth:378px; dialogHeight:222px; status:yes; help:no; scroll:no");
	return arrRtn == null ? "O" : arrRtn;
}

// �޷� â(asCalendarID:�޷�ID, asType:�޷�Ÿ��[D,M], asDate:�ʱ⼳�� ����, aiTopPos: ǥ����ġ_Y, aiLeftPos: ǥ����ġ_X)
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
		// �̺�Ʈ �߻� ��ü
		C_EventObject = event.srcElement;
		liX = event.clientX - event.offsetX;
		liY = event.clientY - event.offsetY;
	}
	else // event ��ü�� null�� ���(���콺 �׸���)
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

// �̹� ������ �޷� â�� ���̰� �Ҷ� ���
function C_CalendarShow()
{
	var frmCalender = document.getElementById("C_frmCalender");
	
	if (frmCalender != null)
	{
		frmCalender.style.visibility = "visible";
	}
}

// �޷� â�� ������ ȣ��Ǵ� �޼ҵ�(asCalendarID�� (-1)�� ���� ��ҵ��� �ǹ���)
function C_CalendarHide(asCalendarID, asDate)
{
	var frmCalender = document.getElementById("C_frmCalender");
	
	if (frmCalender != null)
	{
		frmCalender.style.visibility = "hidden";
	}
	
	// asCalendarID : -1 <-- ��Ҹ� �ǹ���
	// CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay) <- ������ ������ �Լ�
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
				C_msgOk("CalendarResult ������ ���� �Լ� Call ���� : " + e.message, "����");
			}
			else
			{
				C_msgOk("CalendarResult ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
			}
		}
	}
	
	try
	{
		// �޷��� ȣ���� ��ü���� ��Ŀ���� �ѱ��.
		if (C_EventObject != null && C_EventObject != "undefined") C_EventObject.focus();
	}
	catch (e)
	{
	}
}

// LOV ȣ��
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
			C_msgError("LOV�� �̸��� ��(Null)�Դϴ�.");
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
		C_msgOk("C_LOV ���� : " + e.message, "����");
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
			C_msgError("LOV�� �̸��� ��(Null)�Դϴ�.");
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
		C_msgOk("C_AutoLov ���� : " + e.message, "����");
		return null;
	}
}

/*-------------------- ������ ���� �Լ� --------------------*/
function C_ReceiveData(asURL)
{
	var arrRtn;
	//var intLeft  = screen.width / 2 - aiSizeW / 2;
	//var intTop  = screen.height / 2 - aiSizeH / 2;
	
	if (C_isNull(asURL)) return null;

	return window.showModalDialog(asURL, null, "dialogHide:yes; center:no; dialogTop:" + screen.height + "; dialogLeft:" + screen.width + "; dialogWidth:100; dialogHeight:100; status:yes; help:no; scroll:no");
}

/*-------------------- ��ȿ�� ���� �Լ� --------------------*/
// �Է°��� NULL���� üũ
function C_isNull(asValue)
{
    if (asValue == null || asValue == undefined || asValue.toString().replace(/ /g,"") == "")
    {
        return true;
    }
    
    return false;
}

// ���ڰ���
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

// �����ڰ���
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

// �ѱ۰���
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
  �Է°��� �̸��� �������� üũ
  ex) if (!C_isValidEmail(form.email.value)) {
          alert("�ùٸ� �̸��� �ּҰ� �ƴմϴ�.");
      }
*/
function C_isValidEmail(asValue)
{
	var strFormat = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	return C_isValidFormat(asValue, strFormat);
}

// �Է°��� ��ȭ��ȣ ����(����-����-����)���� üũ
function C_isValidPhone(asValue) {
	var strFormat = /^(\d+)-(\d+)-(\d+)$/;
	return C_isValidFormat(asValue, strFormat);
}

//�ֹε�Ϲ�ȣ ��ȿ�� ����
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
		ERR_MSG = "�ֹε�Ϲ�ȣ�� 13�ڸ� �����Դϴ�.";
		return false;
	}

	for (i = 0; i < 13; i++) arrRegNo[i] = strValue.substr(i, 1);
	
	for (i = 0; i < 12; i++) intSum += arrRegNo[i] * ((i > 7) ? (i - 6) : (i + 2));
	
	intMod = 11 - intSum % 11;
	
	if (intMod >= 10) intMod -= 10;
	
	if (intMod != arrRegNo[12])
	{
		ERR_MSG = "�ùٸ��� ���� �ֹε�Ϲ�ȣ�Դϴ�.";
		return false;
	}
	
	return true;
}

//����ڹ�ȣ ��ȿ�� ����
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
		ERR_MSG = "����ڵ�Ϲ�ȣ�� 10�ڸ� �����Դϴ�.";
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
		ERR_MSG = "�ùٸ��� ���� ����ڵ�Ϲ�ȣ�Դϴ�.";
		return false;
	}
	
	return	true;
}

// xxxx���� ���¹�ȣ ����
function C_isValidAcctNo(asValue)
{
	var intSum = 0;
	var intValue = 0;
	var intCheckDigit = parseInt(asValue.substring(10));
	
	if (C_isNull(asValue)) return true;
	
	var strValue = asValue.toString().replace(/-/g, "");
	
	if (C_getByteLength(strValue) != 11 || !C_isNum(strValue))
	{
		ERR_MSG = "���¹�ȣ�� '-'�� ������ 11�ڸ� �����Դϴ�.";
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
		ERR_MSG = "�ùٸ��� ���� ���¹�ȣ�Դϴ�.";
		return false;
	}
	
	return true;
}

/*-------------------- ���ڿ� ���� �Լ� --------------------*/
// ĳ���� Ÿ�� ���� 'H'-�ѱ�, 'E'-����, 'N'-����, 'Z'-��Ÿ
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
  �Է°��� Ư�� ����(chars)�� �ִ��� üũ
  Ư�� ���ڸ� ������� ������ �� �� ���
  ex) if (containsChars(form.name,"!,*&^%$#@~;")) {
          alert("�̸� �ʵ忡�� Ư�� ���ڸ� ����� �� �����ϴ�.");
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
  �Է°��� Ư�� ����(chars)������ �Ǿ��ִ��� üũ
  Ư�� ���ڸ� ����Ϸ� �� �� ���
  ex) if (!C_containsCharsOnly("M", "MW")) {
          alert("���� �ʵ忡�� M,W ���ڸ� ����� �� �ֽ��ϴ�.");
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
  �Է°��� ����ڰ� ������ ���� �������� üũ
  �ڼ��� format ������ �ڹٽ�ũ��Ʈ�� 'regular expression'�� ����
*/
function C_isValidFormat(asValue, asFormat)
{
	if (C_isNull(asValue)) return true;
	if (asValue.search(asFormat) != -1) return true; //�ùٸ� ���� ����

	return false;
}

/*
  �Է°��� ����Ʈ ���̸� ����
  ex) if (getByteLength(form.title) > 100) {
          alert("������ �ѱ� 50��(���� 100��) �̻� �Է��� �� �����ϴ�.");
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

// ���ڿ��� �ִ� Ư������������ �ٸ� ������������ �ٲٴ� �Լ�.
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

// ���ڿ����� �¿� ��������
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

// ���ڿ��� ���� �������� �����Ѵ�.(abDot : true(�Ҽ��� ����), false(�Ҽ��� ������))
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

// �Է°����� �޸� �� ������ ���ش�.(abDot : true(�Ҽ��� ����), false(�Ҽ��� ������))
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
//�Է°����� �޸� �� ������ ���ְ� �������� ���ڿ��� �ǵ�����.
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
// Left ���ڸ� ��ŭ strPadChar �� ���δ�.
function C_LPad(strValue, intLength, strPadChar)
{
	var strTemp = "";
	var intPadCnt = intLength - strValue.length;
	
	for (var i = 0; i < intPadCnt; i++) strTemp += strPadChar;
	
	return strTemp + strValue;
}

// Right ���ڸ� ��ŭ strPadChar �� ���δ�.
function C_RPad(strValue, intLength, strPadChar)
{
	var strTemp = "";
	var intPadCnt = intLength - strValue.length;
	
	for (var i = 0; i < intPadCnt; i++) strTemp += strPadChar;
	
	return strValue + strTemp;
}

// �빮�ں�ȯ
function C_toUpperCase(asValue)
{
	if(C_isNull(asValue)) return asValue;
	return asValue.toUpperCase();
}

// �ҹ��ں�ȯ
function C_toLowerCase(asValue)
{
	if(C_isNull(asValue)) return asValue;
	return asValue.toLowerCase();
}

/*
���ڿ��� �Է��� �������� �����Ѵ�.
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

// �ѱۺ�ȯ�� bolTag�� true�� �ѱ�� ���� �ڵ����� ���� �ݵ�� ���ڵ��Ѵ�.
function C_Encode(strValue, bolTag)
{
	return bolTag == true ? escape(encodeURI(strValue)) : encodeURI(strValue) ;
}

// �ѱ��� ���ڵ��� ��� bolTag�� true�� �ѱ��.
function C_Decode(strValue, bolTag)
{
	return bolTag == true ? decodeURI(unescape(strValue)) : decodeURI(strValue);
}

/*-------------------- üũ�ڽ��� ������ư ���� �Լ� --------------------*/
// �ش� ���� ���õ� üũ�ڽ��� ������ư�� �ִ��� üũ
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

// �ش� ���� ���õ� üũ�ڽ��� ������ư�� �� ������ ��ȯ
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

// �ش� ���� ��� üũ�ڽ��� �����Ѵ�.
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

// �ش� ���� ��� üũ�ڽ��� ������ ����Ѵ�.
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
  �ش� ���� ���õ� üũ�ڽ��� ������ư�� Value ���� �����Ѵ�.
  �ټ��� ���õ� ��� ','�� �����Ѵ�("1,2,3,4")
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

// üũ�ڽ��� ������ư�� ������ ��� Row�� ������ �����Ѵ�.
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

// üũ�ڽ��� ������ư�� ������ ��� Row�� ������ �����Ѵ�.(POP-UP â�� ���õȰ�) -- �ۼ���-> �̽���
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

/*-------------------- ���̺� ���� �Լ� --------------------*/
// ���콺�� ��ġ�� ���̺��� Row�� ������ �����Ѵ�.
function C_RowMouseOver(aoRow)
{
    aoRow.bgColor = ROW_MOUSEOVER_BGCOLOR;
}

// ���콺�� �ش� Row���� ��� ��� Row�� ������ �����Ѵ�.
function C_RowMouseOut(aoRow)
{
    aoRow.bgColor = aoRow.childNodes[0].childNodes[0].checked ? ROW_MOUSEOUT_BGCOLOR : DEFAULT_ROW_BGCOLOR;
}

// ���콺�� ��ġ�� ���̺��� Row�� ������ �����Ѵ�. (POP-UP)-- �ۼ���-> �̽���
function C_PopRowMouseOver(aoRow)
{
    aoRow.bgColor = POPUP_ROW_MOUSEOVER_BGCOLOR;
}

// ���콺�� �ش� Row���� ��� ��� Row�� ������ �����Ѵ�. (POP-UP)
function C_PopRowMouseOut(aoRow)
{
    aoRow.bgColor = aoRow.childNodes[0].childNodes[0].checked ? POPUP_ROW_MOUSEOUT_BGCOLOR : DEFAULT_ROW_BGCOLOR;
}

// ���콺�� �ش� Row���� ��� ��� Row�� ������ �����Ѵ�.
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

// ������ üũ�ڽ��� üũ�Ǿ��ִ°�� üũ�� üũ�ڽ��� �̺�Ʈ�� �����ʰ� �ϱ����� �Լ�.//�̽���
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

// ���콺�� �ش� Row���� ��� ��� Row�� ������ �����Ѵ�.(pop-up ȭ�鿡 ����)-- �ۼ���-> �̽���
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

/*-------------------- ��¥, �ð� ���� �Լ� --------------------*/
// ��ȿ��(�����ϴ�) ��(Ҵ)���� üũ
function C_isValidYear(yyyy)
{
	var intYear = parseInt(yyyy, 10);
	return (intYear >= 1900 && intYear <= 2999);
}

// ��ȿ��(�����ϴ�) ��(��)���� üũ
function C_isValidMonth(mm)
{
	var intMonth = parseInt(mm, 10);
	return (intMonth >= 1 && intMonth <= 12);
}

// ��ȿ��(�����ϴ�) ��(��)���� üũ
function C_isValidDay(yyyy, mm, dd)
{
	var intMonth = parseInt(mm, 10) - 1;
	var intDay = parseInt(dd, 10);	
	var arrLastDay = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	
	if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) arrLastDay[1] = 29;	
	
	return (intDay >= 1 && intDay <= arrLastDay[intMonth]);
}

// ��ȿ��(�����ϴ�) ��(��)���� üũ
function C_isValidHour(hh)
{
	var intHour = parseInt(hh, 10);
	return (intHour >= 1 && intHour <= 24);
}

// ��ȿ��(�����ϴ�) ��(��)���� üũ
function C_isValidMin(mi)
{
	var intMin = parseInt(mi, 10);
	return (intMin >= 1 && intMin <= 60);
}

// �Էµ� ��¥������ '-', '/', '.', ':', ' '(����)�� ���ش�.
function C_removeDateTimeFormat(asValue)
{
	return asValue.toString().replace(/-/g, "").replace(/\//g, "").replace(/\./g, "").replace(/:/g, "").replace(/ /g, "");
}

/*
  ��ȿ�ϴ�(�����ϴ�) ��¥ ���� üũ
  ex) var date = form.date.value; //'20010231'
      if (!C_isValidDate(date)) {
          alert("�ùٸ� ��¥�� �ƴմϴ�.");
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
  Date ��Ʈ���� �ڹٽ�ũ��Ʈ Date ��ü�� ��ȯ
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
		month = strDate.substr(4,2) - 1; // 1��=0,12��=11
		
		return new Date(year, month, 1);
	}
	else if (strDate.length == 8)
	{
		year  = strDate.substr(0,4);
		month = strDate.substr(4,2) - 1; // 1��=0,12��=11
		day   = strDate.substr(6,2);
		
		return new Date(year, month, day);
	}
	else if (strDate.length == 12)
	{
		year  = strDate.substr(0,4);
		month = strDate.substr(4,2) - 1; // 1��=0,12��=11
		day   = strDate.substr(6,2);
		hour  = strDate.substr(8,2);
	    min   = strDate.substr(10,2);
		
		return new Date(year, month, day, hour, min);
	}
	
	return null;
}

/*
  �ڹٽ�ũ��Ʈ Date ��ü�� Date ��Ʈ��(20031225)���� ��ȯ
  ex) var date = new Date();
      alert(C_toDateString(date, 8));
 */
function C_toDateString(aoDate, aiLength)
{
	var year  = aoDate.getFullYear();
	var month = aoDate.getMonth() + 1; // 1��=0,12��=11�̹Ƿ� 1 ����
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
  Date ��Ʈ���� yyyy-mm-dd ������ ��Ʈ������ ��ȯ.
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

// ���� �ð��� Date String �������� ���� (20040329)
function C_getNowDateString(aiLength)
{
	return C_toDateString(new Date(), aiLength);
}

// ���� �ð��� Date Format String �������� ���� (2004-03-29)
function C_getNowDateFormatString(aiLength)
{
	return C_toDateFormatString(C_toDateString(new Date(), aiLength));
}

// ���� �ð��� ������ �����ڸ� Date Format String �������� ���� (YYYY-MM) �� delimiter -
//�߰� - �����
function getYearMonth(delimiter)
{
	var strYear = C_getYear();
	var strMonth = C_getMonth();
			
	var strYearMonth = strYear + ''+ delimiter + ''+ strMonth;
	return strYearMonth;
}
// ���� Ҵ�� YYYY�������� ����
function C_getYear()
{
	return C_getNowDateString(12).substr(0,4);
}

// ���� ���� MM�������� ����
function C_getMonth()
{
	return C_getNowDateString(12).substr(4,2);
}

// ���� ���� DD�������� ����
function C_getDay()
{
	return C_getNowDateString(12).substr(6,2);
}

// ���� ���� HH�������� ����
function C_getHour()
{
	return C_getNowDateString(12).substr(8,2);
}


// ���� ���� ������ ���Ѵ�.
function C_getToDayOfWeek()
{
	var week = new Array('��','��','ȭ','��','��','��','��');
	var now  = new Date();
	var day  = now.getDay(); //�Ͽ���=0,������=1,...,�����=6

	return week[day];
}

// Ư����¥�� ������ ���Ѵ�.
function C_getDayOfWeek(asDate)
{
	var week = new Array('��','��','ȭ','��','��','��','��');
	var now  = C_toDate(asDate);
	var day  = now.getDay(); //�Ͽ���=0,������=1,...,�����=6

	return week[day];
}

// ���糯¥�� ����Ʈ+�ð��� ���Ѵ�
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


//���� �� ���� ���
function C_getEndDay(asDate)
{
	var arrLastDay = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var strDate = C_removeDateTimeFormat(asDate);
	var year = parseInt(strDate.substr(0,4), 10);
	var month = parseInt(strDate.substr(4,2), 10);
	
	if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) arrLastDay[1] = 29;	

	return arrLastDay[month - 1];
}

//�������ڿ� �������ڸ� ��(�������ڰ� ũ�� true, �������ڰ� ũ�� false)
function C_compareDateFT(asFDate, asTDate)
{
	if (!C_isValidDate(asFDate) || !C_isValidDate(asTDate)) return true;
	
	var iFDate = parseFloat(C_removeDateTimeFormat(asFDate));
	var iTDate = parseFloat(C_removeDateTimeFormat(asTDate));
	
	if (isNaN(iFDate) || isNaN(iTDate)) return true;
	
	return iFDate <= iTDate ? true : false;
}

//�������ڿ� �������ڸ� ����ؼ� ���, ���, ������ ���̰� ������ ���(������� �迭�� �ѱ��)
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
	
	// �� ���
	if (liTemp >= 365)
	{
		liYear = parseInt(liTemp / 365);
		liTemp = (liTemp % 365);
	}
	else
	{
		liYear = 0;
	}
	
	// �� ���
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

/*-------------------- ��ȭ��ȣ ���� �Լ� --------------------*/
// ��ȭ��ȣ ��������
function C_isValidPhoneNum(asPhoneNum)
{
	if (C_isNull(asPhoneNum)) return false;

	if (asPhoneNum != "02" && asPhoneNum != "031" && asPhoneNum != "032" && asPhoneNum != "033" && asPhoneNum != "041" &&
		asPhoneNum != "042" && asPhoneNum != "043" && asPhoneNum != "051" && asPhoneNum != "052" && asPhoneNum != "053" &&
		asPhoneNum != "054" && asPhoneNum != "055" && asPhoneNum != "061" && asPhoneNum != "062" && asPhoneNum != "063" &&
		asPhoneNum != "064" && asPhoneNum != "011" && asPhoneNum != "016" && asPhoneNum != "017" && asPhoneNum != "018" &&
		asPhoneNum != "019" && asPhoneNum != "010")
	{
		ERR_MSG = "�߸��� ��ȭ��ȣ �����Դϴ�.";
		return false;
	}

	return true;
	
}

/*-------------------- �޺��ڽ� ���� �Լ� --------------------*/
// �޺��ڽ� �ʱ�ȭ
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

// �ش� URL���� �����͸� �о�� �޺��ڽ� ����
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
		C_msgOk(arrData[0], "����");
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

// �ش� URL���� �����͸� �о�� �޺��ڽ� ����(��ü����)
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
		C_msgOk(arrData[0], "����");
		return;
	}
	
	oOption = document.createElement("OPTION");
	oOption.value = C_isNull(asAllString) ? "%" : asAllString;
	oOption.text = "��ü";
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

// �ش� �迭�� ������ �޺��ڽ� ����
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

// �ش� �迭�� ������ �޺��ڽ� ����(��ü����)
function C_setArrayComboAll(aCbo, aArr, asAllString)
{
	var oOption = null;
	var arrTemp = null;
	
	C_intiCombo(aCbo);
	
	oOption = document.createElement("OPTION");
	oOption.value = C_isNull(asAllString) ? "%" : asAllString;
	oOption.text = "��ü";
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

// �׸��� �߰��Ѵ�.
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

/*-------------------- �������� ���� �Լ� --------------------*/
// �������� ���ý� �̹��� ��ȯ �Լ�
// index : ���õ� ���� ����
// totcount : ��ü ���� ����
// �� ���� �̹����� : imgTabLeft + ����
// �� �߾� td�� : tab + ����
// �� ���� �̹����� : imgTabRight + ����
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
		C_msgOk("�������� ���� : " + ex.message, "����");
		return false;
	}
	
	return true;
}


/*-------------------- Dictionary ��ü --------------------*/
// ���� : var lrDict = new C_Dictionary();
// ��ü���� : lrDict.removeAll();
// ��Ÿ���
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


/*-------------------- �ؽ�Ʈ �ڽ����� LOV �ڵ�ȣ�� �Լ� --------------------*/
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
			C_msgOk("OnSuccessLov �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
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
			C_msgOk("OnSuccessLov �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
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

/*-------------------- Wait ������ �Լ� --------------------*/
function C_ShowWait(aShow)
{
	if (frmWait == null || frmWait == undefined)
	{
		// Wait ������ ��ü ����
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
