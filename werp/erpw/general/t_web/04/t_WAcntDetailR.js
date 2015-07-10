/**************************************************************************/
/* 1. 프 로 그 램 id : t_WAcntDetailR(계좌별세부내역조회)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-22)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

var				R_SLIP_ID = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "부서목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsSLIP_INFO,null,null,"","");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	

	gridMAIN.focus();

	if (!C_isNull(vstrKEEP_DT_FROM))
	{
		txtCOMP_CODE.value				= 	vstrMAKE_COMPANY;
		txtCOMPANY_NAME.value			= 	vstrCOMPANY_NAME;
		txtDT_F.value	     		= 	vstrKEEP_DT_FROM;
		txtDT_T.value	     			= 	vstrKEEP_DT_TO;
		txtBANK_CODE.value	     			= 	vstrBANK_CODE;
		txtBANK_NAME.value	     			= 	vstrBANK_NAME;
		txtACC_CODE.value	     			= 	vstrACC_CODE;
		txtACC_NAME.value	     			= 	vstrACC_NAME;
		txtACCNO.value						=	vstrACCNO;

		btnRetrieve.style.display = "";
		
		G_Load(dsMAIN);
	}
	else
	{
		btnRetrieve.style.display = "none";
	}



}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("MAKE_COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("ACC_CODE",txtACC_CODE.value)
											+ D_P2("BANK_CODE",txtBANK_CODE.value)
											+ D_P2("DEPT_CODE",txtDEPT_CODE.value)
											+ D_P2("ACCNO",txtACCNO.value)
											+ D_P2("MAKE_DT_F",txtDT_F.value.replace(/-/gi,""))
											+ D_P2("MAKE_DT_T",txtDT_T.value.replace(/-/gi,""));
	}
	else if (dataset == dsSLIP_INFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SLIP_INFO")
										 + D_P2("SLIP_ID",R_SLIP_ID);
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
	if(!CheckCompCode()) return;
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	//D_defaultAdd();
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_NAME") = txtCOMPANY_NAME.value;

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
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsMAIN)
	{
	}
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

function	OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "CHK_CLS")
		{
		}
	}
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
	if(dataset == dsMAIN)
	{
		showDetail(dataset, grid, row, colid);
	}
}
function	showDetail(dataset,grid,row,colid)
{
	if(row < 1) return;


	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_IDSEQ");

	if(C_isNull(pSLIP_ID))
	{
		return;
	}

	R_SLIP_ID = pSLIP_ID;
	G_Load(dsSLIP_INFO);
	var pMAKE_COMP_CODE = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"SLIP_KIND_TAG");
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

function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	S_nextFocus(btnDT_F);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}

function btnKEEP_DT_onClick()
{
	C_Calendar("KEEP_DT", "D", txtKEEP_DT.value);
	S_nextFocus(btnKEEP_DT);
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

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE17", lrArgs,"T");

	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	if (C_isNull(txtACC_CODE.value))
	{
		lrRet = C_LOV("T_ACC_CODE17", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE17", lrArgs,"T");
	}
	
	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}
//금융기관
function txtBANK_CODE_onblur()
{
	if (txtBANK_CODE.value == "")
	{
		txtBANK_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);

	var		lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1",lrArgs,"T");

	if (lrRet != null)
	{
		txtBANK_CODE.value	= lrRet.get("BANK_CODE");
		txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	}
}

function btnBANK_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);

	lrRet = C_LOV("T_BANK_CODE1", lrArgs,"T");

	if (lrRet != null)
	{
		txtBANK_CODE.value	= lrRet.get("BANK_CODE");
		txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	}
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
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_NAME.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_NAME.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}
function	txtACCNO_onblur()
{
	
	if (C_isNull(txtACCNO.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null; 

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO.value);

	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	if (C_isNull(txtBANK_CODE.value))
	{
		txtBANK_CODE.value	= lrRet.get("BANK_CODE");
		txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	}

	txtACCNO.value		= lrRet.get("ACCNO");

}
function	btnACCNO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null; 

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SEARCH_CONDITION", '');

	lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"F");

	if (lrRet == null) return;

	if (C_isNull(txtBANK_CODE.value))
	{
		txtBANK_CODE.value	= lrRet.get("BANK_CODE");
		txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	}

	txtACCNO.value		= lrRet.get("ACCNO");
}

function	btnShowDetail_onClick()
{
	if(dsMAIN.CountRow < 1)
	{
		C_msgOk("먼저 집계내역을 조회하십시오.");
		return;
	}
	showDetail(dsMAIN,gridMAIN,dsMAIN.RowPosition,"");
}
function	btnRetrieve_onClick()
{
	G_Load(dsMAIN);
}
