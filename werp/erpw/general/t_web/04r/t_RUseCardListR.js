/**************************************************************************/
/* 1. 프 로 그 램 id : t_RUseCardListR.jsp(법인카드사용내역)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 
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
	
	 
   
   
   	var reportFile ="r_t_040008.rpt";
	
	
	
	
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
	
	
	strTemp += "CompanyCode__" + txtCOMP_CODE.value;
	strTemp += "&&BaseDtFrom__" + txtDT_F.value.replace(/-/g, "");
	strTemp += "&&BaseDtTo__" + txtDT_T.value.replace(/-/g, "");
	strTemp += "&&Cardno__" + (C_isNull(txtCARD_NO.value)?"%":txtCARD_NO.value);
	strTemp += "&&PayDate__" + (C_isNull(txtPAY_DAY.value)?"%":txtPAY_DAY.value);
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F2")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T2")
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
function btnDT_F2_onClick()
{
	C_Calendar("DT_F2", "D", txtDT_F.value);
	S_nextFocus(btnDT_F2);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T2", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}
function	txtCARD_NO_onblur()
{
	if (txtCARD_NO.value == "")
	{
		txtCARDSEQ.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CARD_CLS", "1");
	lrArgs.set("BANK_MAIN_CODE", "%");
	lrArgs.set("CARDNO", txtCARD_NO.value);

	var		lrRet = C_AutoLov(dsLOV,"T_ACC_CREDCARD2",lrArgs,"T");

	if (lrRet != null)
	{
		txtCARDSEQ.value	= lrRet.get("CARD_SEQ");
		txtCARD_NO.value	= lrRet.get("CARDNO");
	}
}
function	btnCARDNO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CARD_CLS", "1");
	lrArgs.set("BANK_MAIN_CODE", "%");
	lrArgs.set("CARDNO", "");

	lrRet = C_LOV("T_ACC_CREDCARD2", lrArgs,"F");

	if (lrRet != null)
	{
		txtCARDSEQ.value	= lrRet.get("CARD_SEQ");
		txtCARD_NO.value	= lrRet.get("CARDNO");
	}
}
