/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBillKindR.js(프로그램진행상태등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			sMenuNo = "";
var			sProgramNo= "";
var			sMenuName = "";
var			sProgramName = "";
var			sProgramId = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "프로그램목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	

	G_setReadOnlyCol(gridMAIN,"MENU_NAME");
	G_setReadOnlyCol(gridMAIN,"PROGRAM_NAME");
	G_setReadOnlyCol(gridMAIN,"MAKE_PROGRAMMER");
	G_setReadOnlyCol(gridMAIN,"REQ_DT");
	G_setReadOnlyCol(gridMAIN,"REQ_USER_NAME");
	G_setReadOnlyCol(gridMAIN,"CONFIRM_TAG");
	G_setReadOnlyCol(gridMAIN,"CONFIRM_DT");
	

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.

	gridMAIN.TabToss = false;
	gridMAIN.focus();
	//G_Load(dsMAIN, null);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										+ D_P2("MENU_NAME",txtMENU_NAME.value)
										+ D_P2("PROGRAM_NAME",txtPROGRAM_NAME.value)
										+ D_P2("MAKE_PROGRAMMER",txtMAKE_PROGRAMMER.value)
										+ D_P2("REQ_DT_F",txtDT_F.value)
										+ D_P2("REQ_DT_T",txtDT_T.value)
										+ D_P2("PROCESS_TAG",cboPROCESS_TAG.value)
										+ D_P2("CONFIRM_TAG",cboCONFIRM_TAG.value)
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
}

// 삽입
function btninsert_onclick()
{
}

// 삭제
function btndelete_onclick()
{
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
	if (asCalendarID == "PROCESS_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}


function OnRowInsertBefore(dataset)
{
	return false;
}

function OnRowInserted(dataset, row)
{
}

function OnRowDeleteBefore(dataset)
{
	return false;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN && colid == "PROCESS_TAG")
	{
		if(dataset.NameString(row,colid) == "T")
		{
			dataset.NameString(row,"PROCESS_DT") = sNow;
			dataset.NameString(row,"CHANGE_PROGRAMMER") = sName;
		}
		else
		{
			dataset.NameString(row,"PROCESS_DT") = "";
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	if (dataset == dsMAIN)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "PROCESS_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if(colid == "PROCESS_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// 이벤트관련-------------------------------------------------------------------//
function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	S_nextFocus(btnDT_F);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}
