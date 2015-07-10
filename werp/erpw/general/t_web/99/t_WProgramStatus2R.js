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
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "프로그램수정요청");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsREQ_NO, null, null, sSelectPageName+D_P1("ACT","REQ_NO"), "REQ_NO");
	


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"MENU_NO","MENU_NO");	
	G_addRelCol(dsSUB01,"PROGRAM_NO","PROGRAM_NO");	
	
	G_setReadOnlyCol(gridMAIN,"MAKE_PROGRAMMER");
	G_setReadOnlyCol(gridMAIN,"MENU_NAME");
	G_setReadOnlyCol(gridMAIN,"PROGRAM_NAME");
	G_setReadOnlyCol(gridMAIN,"TEST_USER_NAME_1");
	G_setReadOnlyCol(gridMAIN,"TEST_USER_NAME_2");
	G_setReadOnlyCol(gridMAIN,"CHANGE_PROGRAMMER");
	G_setReadOnlyCol(gridMAIN,"MAKE_DT");
	G_setReadOnlyCol(gridMAIN,"CHANGE_DT");
	
	G_setReadOnlyCol(gridSUB01,"PROCESS_DT");
	G_setReadOnlyCol(gridSUB01,"PROCESS_TAG");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.

	gridMAIN.TabToss = false;
	gridSUB01.TabToss = false;
	gridMAIN.focus();
	//G_Load(dsMAIN, null);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										+ D_P2("MENU_NAME",txtMENU_NAME.value)
										+ D_P2("PROGRAM_NAME",txtPROGRAM_NAME.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										+ D_P2("MENU_NO",dsMAIN.NameString(dsMAIN.RowPosition,"MENU_NO"))
										+ D_P2("PROGRAM_NO",dsMAIN.NameString(dsMAIN.RowPosition,"PROGRAM_NO"));
	}
	else if(dataset == dsREQ_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REQ_NO");
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
	if(G_FocusDataset == dsMAIN)
	{
		C_msgOk("프로그램 목록을 등록하실 수 없습니다.");
		return;
	}
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		C_msgOk("프로그램 목록을 등록하실 수 없습니다.");
		return;
	}
	D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset == dsMAIN)
	{
		C_msgOk("프로그램 목록을 삭제하실 수 없습니다.");
		return;
	}
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
	if (asCalendarID == "MAKE_DT" || asCalendarID == "CHANGE_DT" || asCalendarID == "CONFIRM_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,asCalendarID) = asDate;
	}
	else if(asCalendarID == "REQ_DT2")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"REQ_DT") = asDate;
	}
	else if(asCalendarID == "PROCESS_DT2")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"PROCESS_DT") = asDate;
	}
	else if(asCalendarID == "CONFIRM_DT2")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"CONFIRM_DT") = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}


function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_AutoLov(dsLOV,"T_PROGRAM", lrArgs,"F");
		if (lrRet != null)
		{
			sMenuNo = lrRet.get("MENU_NO");
			sProgramNo = lrRet.get("PROGRAM_NO");
			sMenuName = lrRet.get("MENU_NAME");
			sProgramName = lrRet.get("PROGRAM_NAME");
			sProgramId = lrRet.get("PROGRAM_ID");
			return true;
		}
		else
		{
			return false;
		}
	}
	
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dataset.NameString(row,"MENU_NO") = sMenuNo;
		dataset.NameString(row,"PROGRAM_NO") = sProgramNo;
		dataset.NameString(row,"MENU_NAME") = sMenuName;
		dataset.NameString(row,"PROGRAM_NAME") = sProgramName;
		dataset.NameString(row,"PROGRAM_ID") = sProgramId;
		dataset.NameString(row,"MAKE_PROGRAMMER") = sName;
		dataset.NameString(row,"MAKE_DT") = sNow;
	}
	else if(dataset == dsSUB01)
	{
		G_Load(dsREQ_NO);
		
		dataset.NameString(row,"REQ_NO") = dsREQ_NO.NameString(dsREQ_NO.RowPosition,"REQ_NO");
		dataset.NameString(row,"REQ_DT") = sNow;
		dataset.NameString(row,"REQ_USER_NAME") = sName;
		dataset.NameString(row,"PROCESS_TAG") = "F";
		dataset.NameString(row,"CONFIRM_TAG") = "F";
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
	var		COL_DATA;
	if (dataset == dsMAIN)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "MAKE_DT" || colid == "CHANGE_DT" ||colid == "CONFIRM_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "REQ_DT" || colid == "PROCESS_DT" ||colid == "CONFIRM_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if(colid == "MAKE_DT" || colid == "CHANGE_DT" ||colid == "CONFIRM_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "REQ_DT" || colid == "PROCESS_DT" ||colid == "CONFIRM_DT")
		{
			C_Calendar(colid+"2", "D", dataset.NameString(row,colid));
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
}

// 이벤트관련-------------------------------------------------------------------//
