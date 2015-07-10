/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSlipAllSumRegister.jsp(전표기간집계)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 전표기간집계
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-03) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "집계");
	G_addDataSet(dsSLIP_CHECK, trans, null, sSelectPageName+D_P1("ACT","SLIP_CHECK"), "이월전표발행체크");
	G_addDataSet(dsCLSE_ACC_ID, null, null, sSelectPageName+D_P1("ACT","CLSE_ACC_ID"), "회기년도");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	G_Load(dsCLSE_ACC_ID);

	dsCLSE_ACC_ID.RowPosition = dsCLSE_ACC_ID.CountRow
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}

	else if(dataset == dsSLIP_CHECK)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SLIP_CHECK")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value)
										+ D_P2("MAKE_DT",(parseInt(dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"CLSE_ACC_ID"))+1)+'0101');
	}
	else if(dataset == dsCLSE_ACC_ID)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CLSE_ACC_ID")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value);
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
		C_msgOk("기간을 입력하세요.", "확인");
		return false;
	}
	if (C_isNull(txtBUDG_YYYY_MM_TO.value))
	{
		C_msgOk("기간을 입력하세요.", "확인");
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
	if (asCalendarID == "BUDG_YYYY_MM_FR")
	{
		txtBUDG_YYYY_MM_FR.value = asDate;
	}
	else if (asCalendarID == "BUDG_YYYY_MM_TO")
	{
		txtBUDG_YYYY_MM_TO.value = asDate;
	}
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

function btnBUDG_YYYY_MM_FR_onClick()
{
	C_Calendar("BUDG_YYYY_MM_FR", "M", txtBUDG_YYYY_MM_FR.value);
	 
}

function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("BUDG_YYYY_MM_TO", "M", txtBUDG_YYYY_MM_TO.value);
	
}
 
function	btnSum_onClick()
{
	if(dsCLSE_ACC_ID.RowPosition < 1){
		C_msgOk("회기가 등록되지 않았습니다.");
		return;
	}
	G_Load(dsSLIP_CHECK);
	if(dsSLIP_CHECK.NameString(1,"CNT")!="0"){
		var	vRet = C_msgYesNo("이월전표가 이미 생성되었습니다. 삭제하고 다시 생성하시겠습니까?", "확인");
		if (vRet != "Y") return;
	}

	G_Load(dsMAIN);
	dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"COMP_CODE");
	dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID") = dsCLSE_ACC_ID.NameString(dsCLSE_ACC_ID.RowPosition,"CLSE_ACC_ID");
	
	if(G_saveData(dsMAIN))
	{
		C_msgOk("전기이월작업이 정상 수행되었습니다.");
	}
}
