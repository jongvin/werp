/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFBSendMailR(지급예정메일발송)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "지급예정메일발송");
	G_addDataSet(dsBATCH, transBatch, null, null, "발송데이타추출");
	G_addDataSet(dsSEND, transSEND, null, null, "메일발송");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_setReadOnlyCol(gridMAIN,"VAT_REGISTRATION_NUM_MASK");
	G_setReadOnlyCol(gridMAIN,"VENDOR_NAME");
	G_setReadOnlyCol(gridMAIN,"MAIL_SEND_YN_NAME");
	G_setReadOnlyCol(gridMAIN,"MAIL_SEND_DATE");
	G_setReadOnlyCol(gridMAIN,"TOT_AMT");
	G_setReadOnlyCol(gridMAIN,"C_AMT");
	G_setReadOnlyCol(gridMAIN,"B_AMT");
	G_setReadOnlyCol(gridMAIN,"N_AMT");
	G_setReadOnlyCol(gridMAIN,"P_AMT");
	G_setReadOnlyCol(gridMAIN,"MAIL_SEND_RESULT_MSG");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("PAY_DUE_YMD",txtDT_F.value)
											+ D_P2("MAIL_SEND_YN",cboSTATUS.value)
											+ D_P2("VAT_REGISTRATION_NUM",txtCUST_CODE.value);
	}
	else if(dataset == dsBATCH)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BATCH");
	}
	else if(dataset == dsSEND)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SEND");
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
function	checkConditions()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	return true;
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
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
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
	D_defaultLoad();
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
	D_defaultLoad();
	cboCODE_CLASS.focus();
}
function	cboSTATUS_onChange()
{
}
//거래처코드
function txtCUST_CODE_onblur()
{
	if (C_isNull(txtCUST_CODE.value))
	{
		txtCUST_CODE.value = '';
		txtCUST_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	if (C_isNull(txtCUST_CODE.value))
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}

	if (lrRet == null) return;

	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}
function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
}
function	btnSelectAll_onClick()
{
	var			iCnt = dsMAIN.CountRow;
	for(var i = 1 ; i <= iCnt ; ++i)
	{
		dsMAIN.NameString(i,"CHK") = "T";
	}
}
function	btnUnSelectAll_onClick()
{
	var			iCnt = dsMAIN.CountRow;
	for(var i = 1 ; i <= iCnt ; ++i)
	{
		dsMAIN.NameString(i,"CHK") = "F";
	}
}
function	btnGetData_onClick()
{
	if(!checkConditions()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("이 작업을 위해서는 먼저 저장을 하셔야 합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return ;
		}
	}
	G_Load(dsBATCH);
	dsBATCH.NameString(dsBATCH.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsBATCH.NameString(dsBATCH.RowPosition,"PAY_DUE_YMD") = txtDT_F.value.replace(/-/g, "");
	dsBATCH.NameString(dsBATCH.RowPosition,"VAT_REGISTRATION_NUM") = txtCUST_CODE.value.replace(/-/g, "");
	transBatch.Parameters = "ACT=BATCH";
	if(!G_saveData(dsBATCH))return;
	C_msgOk("데이타 추출이 정상적으로 수행되었습니다.");
	G_Load(dsMAIN);
}
function	btnSendMail_onClick()
{
	if(!checkConditions()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("이 작업을 위해서는 먼저 저장을 하셔야 합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return ;
		}
	}
	G_Load(dsSEND);
	var			iCnt = dsMAIN.CountRow;
	for(var i = 1 ; i <= iCnt ; ++i)
	{
		if(dsMAIN.NameString(i,"CHK") == "T")
		{
			G_addRow(dsSEND);
			dsSEND.NameString(dsSEND.RowPosition,"MAIL_SEQ") = dsMAIN.NameString(i,"MAIL_SEQ");
		}
	}
	transSEND.Parameters = "ACT=SEND";
	if(!G_saveData(dsSEND))return;
	C_msgOk("메일전송이 정상적으로 수행되었습니다.");
	G_Load(dsMAIN);
}
