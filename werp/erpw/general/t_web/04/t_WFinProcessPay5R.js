/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFinProcessPay4R.jsp(대금지급관리법인카드)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-05-16) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "대금지급관리법인카드");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsIN_NO,null,null,sSelectPageName+D_P1("ACT","IN_NO"), "IN_NO");
	G_addDataSet(dsMAKE_SLIP, trans,  null, sSelectPageName+D_P1("ACT","MAKE_SLIP"), "전표생성");
	G_addDataSet(dsMAKE_SLIP_RET, null,  null, sSelectPageName+D_P1("ACT","MAKE_SLIP"), "전표생성");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	
	gridMAIN.TabToss = false;
	
	G_setReadOnlyCol(gridMAIN,"EMP_NO");
	G_setReadOnlyCol(gridMAIN,"NAME");
	G_setReadOnlyCol(gridMAIN,"MNG_ITEM_DT1");
	G_setReadOnlyCol(gridMAIN,"PAY_CON_BILL_DAYS");
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridMAIN,"ACC_CODE");
	G_setReadOnlyCol(gridMAIN,"CARDNO");

	G_setReadOnlyCol(gridMAIN,"ACC_NAME");
	G_setReadOnlyCol(gridMAIN,"REMAIN_AMT");
	G_setReadOnlyCol(gridMAIN,"ANTICIPATION_DT");

	G_setLovCol(gridMAIN,"EXPR_DT");

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("AR_COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("OUT_ACC_NO",cboACCNO1.value)
											+ D_P2("WORK_DT",txtDT_T.value)
											+ D_P2("ACC_KIND_CODE",cboSUM_ACC_GROUP.value);
	}
	else if(dataset == dsIN_NO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","IN_NO");
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
function	SelectData(aiRow,arTag)
{
	dsMAIN.NameString(aiRow,"CHK_TAG") = arTag;
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(!CheckCompCode()) return;
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	D_defaultAdd();

}

// 삽입
function btninsert_onclick()
{
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
	G_Load(dsMAKE_SLIP);
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"WORK_DT") = txtDT_T.value;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"CRTUSERNO") = sEmpNo;
	dsMAKE_SLIP.NameString(dsMAKE_SLIP.RowPosition,"DEPT_CODE") = sDeptCode;
	if(!G_saveData(dsMAIN))return;
	
	var pSLIP_ID        = dsMAKE_SLIP_RET.NameString(dsMAKE_SLIP_RET.RowPosition,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAKE_SLIP_RET.NameString(dsMAKE_SLIP_RET.RowPosition,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAKE_SLIP_RET.NameString(dsMAKE_SLIP_RET.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsMAKE_SLIP_RET.NameString(dsMAKE_SLIP_RET.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsMAKE_SLIP_RET.NameString(dsMAKE_SLIP_RET.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAKE_SLIP_RET.NameString(dsMAKE_SLIP_RET.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	
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

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "EXPR_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"EXPR_DT") = asDate;
	}
	if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
	if (asCalendarID == "DT_APPLY")
	{
		txtDT_APPLY.value = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	return false;
}

function OnRowInserted(dataset, row)
{
}
function OnRowDeleteBefore(dataset)
{
	return false;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN && colid == "CHK_TAG")
	{
		if(dataset.NameString(row,colid) == "T")
		{
			var		i = row;
			var		lfCash = C_convSafeFloat(dsMAIN.NameString(i,"C_RATIO"));
			var		lfBill = C_convSafeFloat(dsMAIN.NameString(i,"B_RATIO"));
			var		lfAssignAmt = C_convSafeFloat(dsMAIN.NameString(i,"REMAIN_AMT"));
			if(lfAssignAmt <= 0 ) return;
			if(lfCash == 0 ) return;
			if(lfCash + lfBill == 0 ) return;
			lfAssignAmt = Math.round(lfAssignAmt * lfCash / (lfCash + lfBill));
			if(lfAssignAmt == 0 ) return;
			dataset.NameString(row,"EXEC_AMT") = lfAssignAmt;
		}
		else
		{
			dataset.NameString(row,"EXEC_AMT") = "0";
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "EXPR_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "EXPR_DT")
		{
			C_Calendar(dataset.id + "." + colid, "D", dataset.NameString(row,colid));
		}
	}
}

function OnDuplicateColumn(dataset,grid,row,colid) {
}

// 이벤트관련-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		//SetDefaultCheckDept();
	}
}
function	txtCOMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
}

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE.value == '%')
	{
		txtCOMPANY_NAME.value = "전체";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
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

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}

function	btnSelectAll1_onClick()
{
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++ i)
	{
		SelectData(i,"T");
	}
}

function	btnDeSelectAll1_onClick()
{
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++ i)
	{
		SelectData(i,"F");
	}
}
function	btnShowListSlip_onClick()
{
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"TARGET_SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	
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
function	btnDT_APPLY_onClick()
{
	C_Calendar("DT_APPLY", "D", txtDT_APPLY.value);
	S_nextFocus(btnDT_APPLY);
}
function	btnSelectDt_onClick()
{
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++ i)
	{
		if(dsMAIN.NameString(i,"ANTICIPATION_DT") == txtDT_APPLY.value)
		{
			dsMAIN.NameString(i,"CHK_TAG") = "T";
		}
	}
}
