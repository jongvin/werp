/**************************************************************************/
/* 1. 프 로 그 램 id : t_WLoanKindR.js(유가증권종류등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "유가증권종류목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "SEC_ACC_CODE" , "SEC_ACC_CODE:SEARCH_CONDITION" , "SEC_ACC_CODE:ACC_CODE,SEC_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "SEC_ACC_CODE_NAME" , "SEC_ACC_CODE_NAME:SEARCH_CONDITION" , "SEC_ACC_CODE:ACC_CODE,SEC_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "ITRP_ACC_CODE" , "ITRP_ACC_CODE:SEARCH_CONDITION" , "ITRP_ACC_CODE:ACC_CODE,ITRP_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "ITRP_ACC_CODE_NAME" , "ITRP_ACC_CODE_NAME:SEARCH_CONDITION" , "ITRP_ACC_CODE:ACC_CODE,ITRP_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "ITRB_ACC_CODE" , "ITRB_ACC_CODE:SEARCH_CONDITION" , "ITRB_ACC_CODE:ACC_CODE,ITRB_ACC_CODE_NAME:ACC_NAME");
	G_setAutoLovCol("T_ACC_CODE1",gridMAIN, dsLOV , "ITRB_ACC_CODE_NAME" , "ITRB_ACC_CODE_NAME:SEARCH_CONDITION" , "ITRB_ACC_CODE:ACC_CODE,ITRB_ACC_CODE_NAME:ACC_NAME");
	

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.

	gridMAIN.TabToss = false;
	gridMAIN.focus();
	//G_Load(dsMAIN, null);
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
	if(dataset == dsMAIN)
	{
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// 이벤트관련-------------------------------------------------------------------//
