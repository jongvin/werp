/**************************************************************************/
/* 1. 프 로 그 램 id : t_PMakeEmpPayTaxSlipR(차입상환전표)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-16)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var vAccClse = false;
var vMonClse = false;
var vDayClse = false;
var vDeptClse = false;

var vMAKE_COMP_CODE = "";
var vMAKE_DEPT_CODE = "";
var vMAKE_DT_TRANS  = "";

var vGET_TYPE = "";
var vWORK_SLIP_ID = "";
var vWORK_SLIP_IDSEQ = "";

function Initialize()
{
	document.body.topMargin = 0;
	document.body.leftMargin = 0;

	lrArgs = window.dialogArguments;


	G_addDataSet(dsWORK_SLIP_IDSEQ, transMakeDefault,  null, sSelectPageName+D_P1("ACT","WORK_SLIP_IDSEQ"), "상대계정순번");
	G_addDataSet(dsMAKE_SLIP, transMakeSlip,  null, sSelectPageName+D_P1("ACT","WORK_SLIP_IDSEQ"), "상대계정순번");

	G_Load(dsWORK_SLIP_IDSEQ);
	vWORK_SLIP_ID = dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"WORK_SLIP_ID");
	vWORK_SLIP_IDSEQ = dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"WORK_SLIP_IDSEQ");
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"WORK_CODE") = vWORK_CODE;
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"COMP_CODE") = lrArgs.comp_code;
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"DEPT_CODE") = lrArgs.dept_code;
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"AMT") = lrArgs.amt;
	dsWORK_SLIP_IDSEQ.NameString(dsWORK_SLIP_IDSEQ.RowPosition,"WORK_DT") = lrArgs.work_dt;
	transMakeDefault.Parameters = "ACT=MAKE_DEFAULT";
	G_saveData(dsWORK_SLIP_IDSEQ);
	AccSearch();

}

function OnLoadBefore(dataset)
{
	if (dataset == dsWORK_SLIP_IDSEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","WORK_SLIP_IDSEQ");
	}
	else if(dataset == dsMAKE_SLIP)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAKE_SLIP");
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

function AccSearch()
{
	ifrmOtherAccPage.AccSearch(vWORK_CODE, vWORK_SLIP_ID, vWORK_SLIP_IDSEQ);
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
	//if (G_FocusObject != null) G_FocusObject.focus();
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

var lockOnColumnChanged = false;

function	OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

function OnDuplicateColumn(dataset,grid,row,colid)
{
}

function OnDblClick(dataset, grid, row, colid)
{
}

function OnSuccess(dataset, p_Trans)
{
}
// 이벤트관련-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		//SetDefaultCheckDept();
	}
}





function	ConfirmSelected()
{
	if(!ifrmOtherAccPage.AccSaveNoMsg())
	{
		return;
	}
	lrArgs.work_slip_id = vWORK_SLIP_ID;
	lrArgs.work_slip_idseq = vWORK_SLIP_IDSEQ;

	window.returnValue = lrArgs;
	window.close();
	
}
function imgOk_onClick()
{

	ConfirmSelected();
}

function imgCancle_onClick()
{
	window.returnValue = null;
	window.close();
}
