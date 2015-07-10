/**************************************************************************/
/* 1. 프 로 그 램 id : t_PPLMaDeptExecR.jsp(관리손익세부사항)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-06-07)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

var opnrArgs = window.dialogArguments;

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "배부내역목록");
	G_addDataSet(dsSUB01, null, gridSUB01, null, "집적금액목록");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMAIN, dsSUB01);
	
	G_addRelCol(dsSUB01, "WORK_YM", "WORK_YM");
	G_addRelCol(dsSUB01, "ITEM_NO", "ITEM_NO");
	G_addRelCol(dsSUB01, "APPLY_SEQ", "APPLY_SEQ");

	gridMAIN.Focus();
	G_Load(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DEPT_CODE",opnrArgs.get("DEPT_CODE"))
											+ D_P2("WORK_YM",opnrArgs.get("WORK_YM"))
											+ D_P2("ITEM_NO",opnrArgs.get("ITEM_NO"));
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("WORK_YM",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_YM"))
											+ D_P2("ITEM_NO",dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_NO"))
											+ D_P2("APPLY_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"APPLY_SEQ"));
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
function	showSlip(dataset,row)
{
	var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
	var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dataset.NameString(row,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dataset.NameString(row,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";

	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
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
function OnDblClick(dataset, grid, row, colid)
{
}

// 이벤트관련-------------------------------------------------------------------//





function	btnShowCashSlip_onclick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("조회할 행을 선택하십시오.");
		return;
	}
	showSlip(dsSUB01,dsSUB01.RowPosition);
}
