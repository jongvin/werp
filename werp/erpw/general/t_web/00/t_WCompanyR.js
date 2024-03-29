/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCompanyR(사업장 등록)
/* 2. 유형(시나리오) : 사업장의 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-11)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
var p;
var ph;
var peer;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "사업장코드");
	G_addDataSet(dsLOV, null, null, null, "LOV");

	gridMAIN.focus();
	D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMPANY_NAME",txtCOMPANY_NAME_S.value);
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
	txtCOMP_CODE.focus();
}

// 삽입
function btninsert_onclick()
{
	D_defaultInsert();
	txtCOMP_CODE.focus();
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
	if (asCalendarID == "OPEN_DT")
	{
		txtOPEN_DT.value = asDate;
	}
	else if (asCalendarID == "ACCOUNT_FDT")
	{
		txtACCOUNT_FDT.value = asDate;
	}
	else if (asCalendarID == "ACCOUNT_EDT")
	{
		txtACCOUNT_EDT.value = asDate;
	}
}
function	EnableDisableHeadBranch()
{
	if (dsMAIN.NameValue(dsMAIN.RowPosition, 'HEAD_BRANCH_CLS') != "1")
	{
		document.all.txtHEAD_COMP_CODE.disabled			= false;
		document.all.txtHEAD_COMP_NAME.disabled			= false;
		document.all.btnHEAD_COMP_CODE.disabled			= false;
	}
	else
	{
		document.all.txtHEAD_COMP_CODE.disabled			= true;
		document.all.txtHEAD_COMP_NAME.disabled			= true;
		document.all.btnHEAD_COMP_CODE.disabled			= true;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	EnableDisableHeadBranch();
}
function	OnRowPosChanged(dataset, row)
{
	EnableDisableHeadBranch();
}
function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	dsMAIN.NameValue(row, "HEAD_BRANCH_CLS") = "1";
	dsMAIN.NameValue(row, "BUDG_DIVERT_CLS") = "F";
	dsMAIN.NameValue(row, "BUDG_TRANS_CLS") = "F";
	EnableDisableHeadBranch();
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
	if(dataset == dsMAIN && colid == "HEAD_BRANCH_CLS")
	{
		EnableDisableHeadBranch();
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// 이벤트관련-------------------------------------------------------------------//
function btnOPEN_DT_onClick()
{
	C_Calendar("OPEN_DT", "D", txtOPEN_DT.value);
}

function btnBIZPLACE_ZIPCODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	if (C_isNull(txtBIZPLACE_ZIPCODE.value))
	{
		lrRet = C_LOV("T_ZIP_CODE", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ZIP_CODE", lrArgs,"T");
	}
	
	if (lrRet == null) return;

	txtBIZPLACE_ZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtBIZPLACE_ADDR1.value		= lrRet.get("AREA_NAME");
	txtBIZPLACE_ADDR2.focus();
}

function txtBIZPLACE_ZIPCODE_onblur()
{
	if (C_isNull(txtBIZPLACE_ZIPCODE.value))
	{
		txtBIZPLACE_ADDR1.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBIZPLACE_ZIPCODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ZIP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtBIZPLACE_ZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtBIZPLACE_ADDR1.value		= lrRet.get("AREA_NAME");
	txtBIZPLACE_ADDR2.focus();
}

function btnHEADOFF_ZIPCODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	if (C_isNull(txtHEADOFF_ZIPCODE.value))
	{
		lrRet = C_LOV("T_ZIP_CODE", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ZIP_CODE", lrArgs,"T");
	}
	
	if (lrRet == null) return;

	txtHEADOFF_ZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtHEADOFF_ADDR1.value		= lrRet.get("AREA_NAME");
	txtHEADOFF_ADDR2.focus();
}

function txtHEADOFF_ZIPCODE_onblur()
{
	if (C_isNull(txtHEADOFF_ZIPCODE.value))
	{
		txtHEADOFF_ADDR1.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtHEADOFF_ZIPCODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ZIP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtHEADOFF_ZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtHEADOFF_ADDR1.value		= lrRet.get("AREA_NAME");
	txtHEADOFF_ADDR2.focus();
}

function btnHEAD_COMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_HEAD_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtHEAD_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtHEAD_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.focus();
}

function txtHEAD_COMP_CODE_onblur()
{
	if (C_isNull(txtHEAD_COMP_CODE.value))
	{
		txtHEAD_COMP_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtHEAD_COMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_HEAD_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtHEAD_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtHEAD_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.focus();
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtACC_DEPT_CODE.focus();
}
function btnACC_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;

	txtACC_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtACC_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtFIN_DEPT_CODE.focus();
}
function btnFIN_DEPT_NAME_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;

	txtFIN_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtFIN_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtTAX_OFFICE_NAME.focus();
}
function btnFIN_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;

	txtFIN_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtFIN_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtTAX_OFFICE_NAME.focus();
}

function txtDEPT_CODE_onblur()
{
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtACC_DEPT_CODE.focus();
}
function txtACC_DEPT_CODE_onblur()
{
	if (C_isNull(txtACC_DEPT_CODE.value))
	{
		txtACC_DEPT_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACC_DEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtACC_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtACC_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtFIN_DEPT_CODE.focus();
}
function txtFIN_DEPT_CODE_onblur()
{
	if (C_isNull(txtFIN_DEPT_CODE.value))
	{
		txtFIN_DEPT_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtFIN_DEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtFIN_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtFIN_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtTAX_OFFICE_NAME.focus();
}

function btnACCOUNT_FDT_onClick()
{
	C_Calendar("ACCOUNT_FDT", "D", txtACCOUNT_FDT.value);
}

function btnACCOUNT_EDT_onClick()
{
	C_Calendar("ACCOUNT_EDT", "D", txtACCOUNT_EDT.value);
}

function	txtBIZNO2_onblur()
{
	if (txtBIZNO2.value == "") return;
	txtBIZNO2.value = txtBIZNO2.value.replace(/-/g, "").substr(0, 6) + "-" + txtBIZNO2.value.replace(/-/g, "").substr(6, 7);
}
function	txtCOMPANY_ACC_CODE_onblur()
{
	if (C_isNull(txtCOMPANY_ACC_CODE.value))
	{
		txtCOMPANY_ACC_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMPANY_ACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE4", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMPANY_ACC_CODE.value	= lrRet.get("ACC_CODE");
	txtCOMPANY_ACC_NAME.value	= lrRet.get("ACC_NAME");
}
function	btnCOMPANY_ACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACC_CODE4", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMPANY_ACC_CODE.value	= lrRet.get("ACC_CODE");
	txtCOMPANY_ACC_NAME.value	= lrRet.get("ACC_NAME");
}
//계좌찾기
function	btntxtVAT_RETURN_ACCNO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", dsMAIN.NameValue(dsMAIN.RowPosition, "COMP_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACCNO_CODE4", lrArgs,"F");
	
	if (lrRet == null) return;

	txtVAT_RETURN_ACCNO.value	= lrRet.get("ACCNO");
}
