/**************************************************************************/
/* 1. �� �� �� �� id     : t_WBudgCloseR.js(��û�������)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  ��     : ��û������� 
/* 4. ��  ��  ��  ��     : ����� �ۼ�(2005-12-13)
/* 5. ����  ���α׷�  : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	//set();  
}

function set()
{
	//var lrArgs  = new Array(3); 
	//lrArgs  = window.dialogArguments;
	//txtMAKE_DT_F=  lrArgs[0];
	//txtMAKE_DT_T=  lrArgs[1];
}
// ���ǰ��� �Լ�----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

// �Լ�����---------------------------------------------------------------------//
function	ConfirmSelected()
{
	var arrRet = Array(3);
	arrRet[0] = "TRUE";
	arrRet[1] = txtREQ_CLSE_DT.value;

	window.returnValue = arrRet;
	window.close();
}
function imgOk_onClick()
{
	lrArgs = window.dialogArguments;
	var COL_DATA = txtREQ_CLSE_DT.value;
	var  strMAKE_DT_F=  lrArgs[0];
	var  strMAKE_DT_T=  lrArgs[1];  
	if ( C_isNull(COL_DATA))
	{
		C_msgOk("�������� �Է��ϼ���");
		txtREQ_CLSE_DT.focus();
		return false;	
	}
	
	if(parseInt(strMAKE_DT_F) >parseInt(COL_DATA.toString().replace(/-/g, ""))
	  || parseInt(strMAKE_DT_T) <parseInt(COL_DATA.toString().replace(/-/g, "")))
	{
		C_msgOk("�������� ���Ⱓ�ȿ��� �����ؾ� �մϴ�");
		return false;	
	}
	
	if(!dateFormatCheck()) return;
	
	ConfirmSelected();
}
function dateFormatCheck()
{
	var COL_DATA = txtREQ_CLSE_DT.value;
	if(C_isNull(COL_DATA))
	{
		return ;
	}
	else
	{
		var	lsUMask = COL_DATA.toString().replace(/-/g, "");
		
		var strYear = C_getYear();
		var strMonth = C_getMonth();
		var strDay = C_getDay();
		var strDate = strYear + strMonth+ strDay;

		if (parseInt(lsUMask) < parseInt(strDate))
		{
			txtREQ_CLSE_DT.value="";
			txtREQ_CLSE_DT.focus();
			C_msgOk("�����Ϻ��� �����Դϴ�");
			return;
		}
		if (!C_isValidDate(lsUMask))
		{
			C_msgOk("�ùٸ� ��¥�� �ƴմϴ�.");
			txtREQ_CLSE_DT.value="";
			txtREQ_CLSE_DT.focus();
			return;
		}

		 
		txtREQ_CLSE_DT.value = lsUMask.substr(0, 4) + "-" + lsUMask.substr(4, 2)+ "-" + lsUMask.substr(6, 2);
		return true;
		 
	}	
}
function imgCancle_onClick()
{
	
	window.returnValue = null;
	window.close();
}
// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "REQ_CLSE_DT")
	{
		txtREQ_CLSE_DT.value = asDate;
	}
	
}

function OnLoadBefore(dataset)
{
}



// �̺�Ʈ����-------------------------------------------------------------------//
function btnREQ_CLSE_DT_onClick()
{
	C_Calendar("REQ_CLSE_DT", "D", txtREQ_CLSE_DT.value, 30, 0);
	//S_nextFocus(btnREQ_CLSE_DT);
}
