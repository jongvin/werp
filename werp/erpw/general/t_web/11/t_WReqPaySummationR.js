/**************************************************************************/
/* 1. 프 로 그 램 id : t_WChangeBillPwR.js(개인암호관리)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, null, "계좌암호설정");
	G_addDataSet(dsLOV,null,null,null);
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
}


function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("BANK_CODE",txtBANK_CODE.value)
											+ D_P2("ACCT_NUMBER",txtACCNO_CODE.value)
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

function btnquery_onclick()
{
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

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnKeyPress(dataset, grid, kcode)
{
}

function OnDblClick(dataset, grid, row, colid)
{
}

// 이벤트관련-------------------------------------------------------------------//


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

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

//계좌번호
function txtACCNO_CODE_onblur()
{
	
	if (C_isNull(txtACCNO_CODE.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);
	
	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE2", lrArgs,"T");

	if (lrRet == null) return;
	txtBANK_NAME.value = lrRet.get("BANK_MAIN_NAME");
	txtBANK_CODE.value = lrRet.get("BANK_MAIN_CODE");
	txtACCNO_CODE.value = lrRet.get("ACCNO");
}
function btnACCNO_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);

	lrRet = C_LOV("T_ACCNO_CODE4", lrArgs,"F");

	if (lrRet == null) return;

	txtBANK_NAME.value = lrRet.get("BANK_MAIN_NAME");
	txtBANK_CODE.value = lrRet.get("BANK_MAIN_CODE");
	txtACCNO_CODE.value = lrRet.get("ACCNO");
}

function	btnGetData_onClick()
{
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을 선택하십시오.");
		return;
	}
	if(C_isNull(txtACCNO_CODE.value))
	{
		C_msgOk("계좌를 선택하십시오.");
		return;
	}
	G_Load(dsMAIN);
}