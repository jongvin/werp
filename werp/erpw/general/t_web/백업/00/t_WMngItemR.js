/**************************************************************************/
/* 1. 프 로 그 램 id : t_WMngItemR.js(관리항목코드등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 관리항목코드를 등록 및 조회한다.
/* 4. 변  경  이  력 : 최언회 작성(2005-10-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "관리항목코드등록");
	G_addDataSet(dsDATA_TYPE, null, null, sSelectPageName+D_P1("ACT","DATA_TYPE"), "데이타타입");

	
	G_Load(dsDATA_TYPE, null);

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsDATA_TYPE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DATA_TYPE");
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
	if (G_FocusDataset == dsMAIN)
	{
		G_Load(dsMAIN, null);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 추가
function btnadd_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		G_addRow(dsMAIN);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 삽입
function btninsert_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		G_insertRow(dsMAIN);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 삭제
function btndelete_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		G_deleteRow(dsMAIN);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 저장
function btnsave_onclick()
{
	if (G_FocusDataset == dsMAIN)
	{
		G_saveDataMsg(dsMAIN);
	}
	
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dsMAIN.NameString(row,"DATA_TYPE") = "C";
		dsMAIN.NameString(row,"USE_TG") = "T";
		dsMAIN.NameString(row,"SEQ") = row;
	}
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
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
