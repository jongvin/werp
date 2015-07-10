/**************************************************************************/
/* 1. 프 로 그 램 id : t_WTaxCompanyR.js(세무신고사업장 등록)
/* 2. 유형(시나리오) : 세무신고사업장의 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "사업장코드");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	txtCOMP_CODE_S.value = sCompCode;
	txtCOMPANY_NAME_S.value = sCompName;
	gridMAIN.focus();
	
	
}

function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE_S.value);
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
	if(C_isNull(txtCOMP_CODE_S.value))
	{
		C_msgOk("사업장코드를 입력하세요.", "확인");
		return;
	}
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	if(C_isNull(txtCOMP_CODE_S.value))
	{
		C_msgOk("사업장코드를 입력하세요.", "확인");
		return;
	}
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


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	dsMAIN.NameValue(row, "COMP_CODE") = txtCOMP_CODE_S.value;
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

// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_S_onblur()
{
	if (C_isNull(txtCOMP_CODE_S.value))
	{
		txtCOMPANY_NAME_S.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE_S.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE_S.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME_S.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE_S.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME_S.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}

function btnOPEN_DT_onClick()
{
	C_Calendar("OPEN_DT", "D", txtOPEN_DT.value);
}

function btnBIZPLACE_ZIPCODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
		
	lrArgs.set("SEARCH_CONDITION", "");
		
	var lrRet = null;

	lrRet = C_LOV("T_ZIP_CODE", lrArgs);
	
	if (lrRet != null)
	{
		txtBIZPLACE_ZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
		txtBIZPLACE_ADDR1.value	= lrRet.get("AREA_NAME");
		
	}

}

function btnHEADOFF_ZIPCODE_onClick()
{
}

function btnHEAD_COMP_CODE_onClick()
{
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

function txtBIZPLACE_ZIPCODE_onBlur()
{
	if (C_isNull(txtBIZPLACE_ZIPCODE.value))
	{
		txtBIZPLACE_ADDR1.value = "";
		txtBIZPLACE_ADDR2.value = "";
		btnBIZPLACE_ZIPCODE.focus();
	}
	
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