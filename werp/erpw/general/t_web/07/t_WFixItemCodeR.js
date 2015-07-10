/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixItemCodeR.js(고정자산품목코드등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 고정자산품목코드등록 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "고정자산품목코드");
	
	G_addDataSet(dsFIX_ASSET_CLS_CODE, null, null, sSelectPageName+D_P1("ACT","FIX_ASSET_CLS_CODE"), "고정자산종류코드");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");

	
	gridMAIN.focus();
	G_setReadOnlyCol(gridMAIN, "ASSET_ACC_NAME");
	G_Load(dsFIX_ASSET_CLS_CODE, null);
	 D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									+ D_P2("ASSET_CLS_CODE", dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_CODE"));
	}
	else if(dataset == dsFIX_ASSET_CLS_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","FIX_ASSET_CLS_CODE");
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

// 추가
function btnadd_onclick()
{
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	D_defaultAdd();
}

// 삭제
function btndelete_onclick()
{
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	D_defaultSave(dsMAIN);
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
	if (dataset == dsMAIN)
	{
		dataset.NameValue(row, "ASSET_CLS_NAME") = dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_NAME"); 
		dataset.NameValue(row, "ASSET_CLS_CODE") = dsFIX_ASSET_CLS_CODE.NameValue(dsFIX_ASSET_CLS_CODE.RowPosition, "ASSET_CLS_CODE"); 	
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

function OnRowPosChanged(dataset, row)
{
	if (dataset == dsFIX_ASSET_CLS_CODE)
	{
		D_defaultLoad();	
	}
}

// 이벤트관련-------------------------------------------------------------------//
