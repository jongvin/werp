/**************************************************************************/
/* 1. 프 로 그 램 id : t_PPLCompExecR.jsp(경영계획실적집계내역)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-28)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

var opnrArgs = window.dialogArguments;

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "거래처코드");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	

	gridMAIN.Focus();
	G_Load(dsMAIN);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("BIZ_PLAN_ITEM_NO",opnrArgs.get("BIZ_PLAN_ITEM_NO"))
											+ D_P2("COMP_CODE",opnrArgs.get("COMP_CODE"))
											+ D_P2("CLSE_ACC_ID",opnrArgs.get("CLSE_ACC_ID"))
											+ D_P2("WORK_YM",opnrArgs.get("WORK_YM"));
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
	if ((G_FocusDataset == dsMAIN) && (cboTRADE_CLS.value == "%"))
	{
		C_msgOk("거래처구분이 전체일때는 추가할수 없습니다. <br><br> 먼저 거래추구분을 선택하세요.", "확인");
		return;
	}
	
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	if ((G_FocusDataset == dsMAIN) && (cboTRADE_CLS.value == "%"))
	{
		C_msgOk("거래처구분이 전체일때는 삽입할수 없습니다. <br><br> 먼저 거래추구분을 선택하세요.", "확인");
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
	if (asCalendarID == "BUDG_YM")
	{
		txtBUDG_YM.value = asDate;
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
	showSlip(dataset,row);
}

// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE_F.value == txtCOMP_CODE.value) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) {
		txtCOMP_CODE.value = txtCOMP_CODE_F.value;
		return;
	}
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	
	txtDEPT_CODE.value = '';
	txtDEPT_NAME.value = '';
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	if (txtCOMP_CODE.value	== lrRet.get("COMP_CODE")) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	
	txtDEPT_CODE.value = '';
	txtDEPT_NAME.value = '';
}

function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	return true;
}

//귀속부서
function txtDEPT_CODE_onblur()
{
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_CODE.value = '';
		txtDEPT_NAME.value = '';
		return;
	}
	
	if (txtDEPT_CODE_F.value == txtDEPT_CODE.value) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"F");

	if (lrRet == null) return;
	
	if (txtDEPT_CODE.value	== lrRet.get("DEPT_CODE")) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

//계정과목
function txtACC_CODE_onblur()
{
	if (C_isNull(txtACC_CODE.value))
	{
		txtACC_CODE.value = '';
		txtACC_NAME.value = '';
		return;
	}
	
	if (txtACC_CODE_F.value == txtACC_CODE.value) return;

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_REL_ACC_CODE", lrArgs,"T");

	if (lrRet == null) {
		txtACC_CODE.value = txtACC_CODE_F.value;
		return;
	}

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", '');

	lrRet = C_LOV("T_BUDG_REL_ACC_CODE", lrArgs,"F");
	
	if (lrRet == null) return;
	
	if (txtACC_CODE.value	== lrRet.get("ACC_CODE")) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnBUDG_YM_onClick()
{
	C_Calendar("BUDG_YM", "M", txtBUDG_YM.value);
	 
}
function	btnShowSlip_onclick()
{
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("조회할 행을 선택하십시오.");
		return;
	}
	showSlip(dsMAIN,dsMAIN.RowPosition);
}

