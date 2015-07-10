/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSlipAllSumRegister.jsp(전표기간집계)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 전표기간집계
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-03) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "집계");
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
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
function	CheckBudgYyyyMm()
{
	if (C_isNull(txtBUDG_YYYY_MM_FR.value))
	{
		C_msgOk("기간을 입력하세요.", "확인");
		return false;
	}
	if (C_isNull(txtBUDG_YYYY_MM_TO.value))
	{
		C_msgOk("기간을 입력하세요.", "확인");
		return false;
	}
	return true;
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	//D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	//D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	//D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	//D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	//D_defaultSave(dsMAIN);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "BUDG_YYYY_MM_FR")
	{
		txtBUDG_YYYY_MM_FR.value = asDate;
	}
	else if (asCalendarID == "BUDG_YYYY_MM_TO")
	{
		txtBUDG_YYYY_MM_TO.value = asDate;
	}
}

function OnRowInserted(dataset, row)
{
	dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
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

function btnBUDG_YYYY_MM_FR_onClick()
{
	C_Calendar("BUDG_YYYY_MM_FR", "M", txtBUDG_YYYY_MM_FR.value);
	 
}

function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("BUDG_YYYY_MM_TO", "M", txtBUDG_YYYY_MM_TO.value);
	
}
 
function	btnSum_onClick()
{
	if(!CheckBudgYyyyMm()) return;
	G_Load(dsMAIN);
	dsMAIN.NameString(dsMAIN.RowPosition,"YMF") = txtBUDG_YYYY_MM_FR.value.replace(/-/g,'');
	dsMAIN.NameString(dsMAIN.RowPosition,"YMT") = txtBUDG_YYYY_MM_TO.value.replace(/-/g,'');
	
	if(G_saveData(dsMAIN))
	{
		C_msgOk("집계가 정상 수행되었습니다.");
	}
}
