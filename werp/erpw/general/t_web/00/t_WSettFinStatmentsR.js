/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSettFinStatmentsR.js(재무제표기준코드)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsSHEET_TYPE, null, null, sSelectPageName+D_P1("ACT","SHEET_TYPE"), "재무제표양식");
	G_addDataSet(dsROUND_CLS, null, null, sSelectPageName+D_P1("ACT","ROUND_CLS"), "반올림구분");
	G_addDataSet(dsSEQ_TYPE, null, null, sSelectPageName+D_P1("ACT","SEQ_TYPE"), "번호유형");
	G_addDataSet(dsITEM_LVL, null, null, sSelectPageName+D_P1("ACT","ITEM_LVL"), "항목레벨");

	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "재무제표코드");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "레벨별 번호유형");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"SHEET_CODE","SHEET_CODE");

	G_Load(dsROUND_CLS, null);
	G_Load(dsSHEET_TYPE, null);
	G_Load(dsSEQ_TYPE, null);
	G_Load(dsITEM_LVL, null);
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsSHEET_TYPE)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SHEET_TYPE");
	}
	else if(dataset == dsROUND_CLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ROUND_CLS");
	}
	else if(dataset == dsSEQ_TYPE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ_TYPE");
	}
	else if(dataset == dsITEM_LVL)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ITEM_LVL");
	}
	else if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		var			strSHEET_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"SHEET_CODE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("SHEET_CODE",strSHEET_CODE);
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
	D_defaultInsert();
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
