/**************************************************************************/
/* 1. 프 로 그 램 id : t_RBillListR.jsp(어음/수표발행대장)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 어음/수표발행대장 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-24)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{

	G_addDataSet(dsLOV, null, null,  null, "LOV");
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

}
function OnLoadBefore(dataset)
{
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

//검색조건체크
function print_condition_check()
{
	if(!CheckBudgYyyyMm()) return false;
	if(!CheckCompCode()) return false;
   	return true;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
//인쇄
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
				
	// 공통 Check
	//if (!checkCommon()) return;
	if(!print_condition_check()) return;
	
	 
   
   
   	var reportFile ="r_t_040001.rpt";
	
	var strCHK_BILL_CLS = getBillCls();
	var	strBILL_TYPE = getBillType();
	
	
	
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile;
	
	var strTemp = "";
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;
	
	
	strTemp += "CHK_BILL_CLS__" + strCHK_BILL_CLS;
	strTemp += "&&CHK_BILL_TYPE__" + strBILL_TYPE;
	strTemp += "&&COMPANY_CODE__" + txtCOMP_CODE.value;
	strTemp += "&&PUBL_DT_F__" + txtDT_F.value.replace(/-/g, "");
	strTemp += "&&PUBL_DT_T__" + txtDT_T.value.replace(/-/g, "");
	if (C_isNull(txtBANK_CODE.value))
	{
		strTemp += "&&PAY_BANK__%";
	}
	else
	{
		strTemp += "&&PAY_BANK__" + txtBANK_CODE.value;
	}
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
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
function OnRowPosChanged(dataset, row)
{

}

// 이벤트관련-------------------------------------------------------------------//

 
 
function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을 입력하세요.", "확인");
		return false;
	}
	return true;
}

function	CheckBudgYyyyMm()
{
	if (C_isNull(txtDT_F.value))
	{
		C_msgOk("기간을 입력하세요.", "확인");
		return false;
	}
	if (C_isNull(txtDT_T.value))
	{
		C_msgOk("기간을 입력하세요.", "확인");
		return false;
	}
	return true;
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

	var chkTYPECur = getBillCls();
	var		lrRet;
	if(chkTYPECur == "B")
	{
		lrRet = C_AutoLov(dsLOV,"T_BANK_CODE3",lrArgs,"T");
	}
	else
	{
		lrRet = C_AutoLov(dsLOV,"T_BANK_CODE2",lrArgs,"T");
	}

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

	var chkTYPECur = getBillCls();
	if(chkTYPECur == "B")
	{
		lrRet = C_LOV("T_BANK_CODE3", lrArgs,"T");
	}
	else
	{
		lrRet = C_LOV("T_BANK_CODE2", lrArgs,"T");
	}

	if (lrRet != null)
	{
		txtBANK_CODE.value	= lrRet.get("BANK_CODE");
		txtBANK_NAME.value	= lrRet.get("BANK_NAME");
	}
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
function clearPayBank(obj)
{
	var chkTYPECur = getBillCls();

	if(chkTYPECur != chkTYPEOld.value){
		txtBANK_CODE.value = "";
		txtBANK_NAME.value = "";
		chkTYPEOld.value = chkTYPECur;
	}
}
function	getBillCls()
{
	var chkTYPECur = "";
	if(chkTYPE1.checked)
	{
		chkTYPECur = "B";
	}
	else if(chkTYPE2.checked)
	{
		chkTYPECur = "B";
	}
	else if(chkTYPE3.checked)
	{
		chkTYPECur = "A";
	}
	else if(chkTYPE4.checked)
	{
		chkTYPECur = "A";
	}
	return chkTYPECur;
}
function	getBillType()
{
	var	strTYPE = "";
	if(chkTYPE1.checked)
	{
		strTYPE = "0";
	}
	else if(chkTYPE2.checked)
	{
		strTYPE = "1";
	}
	else if(chkTYPE3.checked)
	{
		strTYPE = "0";
	}
	else if(chkTYPE4.checked)
	{
		strTYPE = "1";
	}
	return strTYPE;
}