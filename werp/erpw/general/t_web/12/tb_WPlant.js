/**************************************************************************/
/* 1. 프 로 그 램 id : HTML_1.js(단일 화면)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "사업장현황");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COM_ID",txtCOM_ID.value)
									 + D_P2("REG_NUM",txtREG_NUM.value)
									 + D_P2("COMPANY",txtCOMPANY.value);
	}
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

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	D_defaultLoad();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// 이벤트관련-------------------------------------------------------------------//
function txtCOM_ID_onblur()
{
	if (C_isNull(txtCOM_ID.value))
	{
		txtCOM_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOM_ID.value);

	lrRet = C_AutoLov(dsLOV,"T_COM_ID", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOM_ID.value		= lrRet.get("COM_ID");
	txtCOM_NAME.value	= lrRet.get("COM_NAME");
}

function btnCOM_ID_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COM_ID", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOM_ID.value		= lrRet.get("COM_ID");
	txtCOM_NAME.value	= lrRet.get("COM_NAME");

}