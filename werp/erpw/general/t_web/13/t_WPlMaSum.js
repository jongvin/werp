/**************************************************************************/
/* 1. 프 로 그 램 id : t_WPlMaSum.jsp(관리손익집계 및 배부)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 관리손익집계 및 배부
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-25) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			autopopval_1;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "집계");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","MAIN"), "LOV");
	
	C_addDateCol(txtBUDG_YYYY_MM_FR,btnBUDG_YYYY_MM_FR,"M");
	autopopval_1 = new C_AutoPopWhenChange(dsLOV,"T_PL_MA_DEV_RAT_HIST",txtDVD_RAT_HIST,"autopopval_1",true,true);
	autopopval_1.SetArgBind("SEARCH_CONDITION",txtDVD_RAT_HIST,"value");
	
	////LOV의 결과를 리턴 받을 컨트롤을 설정
	autopopval_1.SetReturnBind("HIST_SEQ",txtHIST_SEQ,"value");
	autopopval_1.SetReturnBind("NAME",txtDVD_RAT_HIST,"value");
	autopopval_1.AttachButton(btnDVD_RAT);
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
function	CheckBudgYyyyMm()
{
	if (C_isNull(txtBUDG_YYYY_MM_FR.value))
	{
		C_msgOk("작업년월을 입력하세요.", "확인");
		return false;
	}
	return true;
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	//D_defaultLoad();
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
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}

function OnRowInserted(dataset, row)
{
	dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
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


 
function	btnSum_onClick()
{
	if(!CheckBudgYyyyMm()) return;
	G_Load(dsMAIN);
	dsMAIN.NameString(dsMAIN.RowPosition,"YMF") = txtBUDG_YYYY_MM_FR.value.replace(/-/g,'');
	dsMAIN.NameString(dsMAIN.RowPosition,"HIST_SEQ") = txtHIST_SEQ.value;
	
	if(G_saveData(dsMAIN))
	{
		C_msgOk("집계가 정상 수행되었습니다.");
	}
}
