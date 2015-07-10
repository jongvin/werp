/**************************************************************************/
/* 1. 프 로 그 램 id     : t_WBudgCloseR.js(신청마감등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의     : 신청마감등록 
/* 4. 변  경  이  력     : 한재원 작성(2005-12-13)
/* 5. 관련  프로그램  : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
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
// 세션관련 함수----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

// 함수관련---------------------------------------------------------------------//
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
		C_msgOk("마감일을 입력하세요");
		txtREQ_CLSE_DT.focus();
		return false;	
	}
	
	if(parseInt(strMAKE_DT_F) >parseInt(COL_DATA.toString().replace(/-/g, ""))
	  || parseInt(strMAKE_DT_T) <parseInt(COL_DATA.toString().replace(/-/g, "")))
	{
		C_msgOk("마감일은 편성기간안에서 설정해야 합니다");
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
			C_msgOk("현재일보다 이전입니다");
			return;
		}
		if (!C_isValidDate(lsUMask))
		{
			C_msgOk("올바른 날짜가 아닙니다.");
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
// 공통 재정의 이벤트관련-------------------------------------------------------//
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



// 이벤트관련-------------------------------------------------------------------//
function btnREQ_CLSE_DT_onClick()
{
	C_Calendar("REQ_CLSE_DT", "D", txtREQ_CLSE_DT.value, 30, 0);
	//S_nextFocus(btnREQ_CLSE_DT);
}
