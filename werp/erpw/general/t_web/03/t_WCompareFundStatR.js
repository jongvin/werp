/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCompareFundStatR.jsp(비교대차대조표)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 비교대차대조표
/* 4. 변  경  이  력 : 김흥수 작성(2006-05-22)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			sEMPNO;
function Initialize()
{
	G_addDataSet(dsSHEET_CODE, null, null, null, "재무제표종류");
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "비교대차대조표");

	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	
	
	
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	txtDATE_TO.value = sDTT;


	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;

	G_Load(dsSHEET_CODE, null);

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("SHEET_CODE",dsSHEET_CODE.nameString(dsSHEET_CODE.RowPosition,"SHEET_CODE"))
										 + D_P2("WORK_YM_N_T",txtDATE_TO.value.replace(/-/g,""));
	}
	else if(dataset == dsSHEET_CODE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SHEET_CODE");
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
function	chkTopCondition()
{
	return true;
}
function	chkSave()
{
	return true;
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if (txtDATE_TO.value == "")
	{
		C_msgOk("기준월을 입력 하십시오.", "확인");
		return;
	}
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
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DATE_TO")
	{
		txtDATE_TO.value = asDate;
	}
}

function OnRowInsertBefore(dataset)
{
	return false;
}
function OnRowInserted(dataset, row)
{
}
function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(row < 2) return;
}

// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_onfocus()
{
	oldData1 = txtCOMP_CODE.value;	
}
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE3", lrArgs,"T");
	
	if (lrRet == null)
	{
		txtCOMP_CODE.value = oldData1;
		return;
	}
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}



function btnDATE_TO_onClick()
{
	C_Calendar("DATE_TO", "M", txtDATE_TO.value);
}

