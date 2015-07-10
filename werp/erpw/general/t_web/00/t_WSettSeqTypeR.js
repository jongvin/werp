/**************************************************************************/
/* 1. 프 로 그 램 id : t_WUserAuthR.jsp(사용자별권한관리)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 사용자별권한관리
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-12)
/* 5. 관련  프로그램 : 없음
/* 6. 특  기  사  항 : 없음
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "재무제표순번형식");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "재무제표순번목록");


	G_addRel(dsMAIN, dsSUB01);
	G_addRelCol(dsSUB01, "SEQ_TYPE", "SEQ_TYPE");
	
	gridMAIN.focus();
	//G_focusDataset(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//계정과목 가져오기
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		var 	strSEQ_TYPE = dsMAIN.NameString(dsMAIN.RowPosition,"SEQ_TYPE");
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("SEQ_TYPE",strSEQ_TYPE);
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
	D_defaultSave(dsSUB01);
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
	if(dataset == dsSUB01)
	{
		dataset.NameString(row,"SEQ_SEQ") = dataset.CountRow;
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
function txtMAIN_onblur()
{
	G_Load(dsMAIN,null);
}
