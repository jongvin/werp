/**************************************************************************/
/* 1. 프 로 그 램 id : t_RBatchBillR.jsp(전자어음대량이체확인서)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 전자어음대량이체확인서 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-16)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{

	G_addDataSet(dsMAIN, null,  gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "대금지급대상");
	G_addDataSet(dsPARAM, trans,  null, sSelectPageName+D_P1("ACT","MAIN"), "대금지급대상");

	G_addDataSet(dsLOV, null, null,  null, "LOV");
	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtF_PUBL_DT.value = sDTF;
	txtE_PUBL_DT.value = sDTT;

	G_setReadOnlyCol(gridMAIN,"OUT_ACCOUNT_NO");
	G_setReadOnlyCol(gridMAIN,"PAY_YMD");
	G_setReadOnlyCol(gridMAIN,"NAME");
	G_setReadOnlyCol(gridMAIN,"CREATION_DATE");
	G_setReadOnlyCol(gridMAIN,"PAY_AMT");
	G_setReadOnlyCol(gridMAIN,"PAY_STATUS_NAME");
	G_setReadOnlyCol(gridMAIN,"DESCRIPTION");


	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("PAY_YMD_F",txtF_PUBL_DT.value)
										 + D_P2("PAY_YMD_T",txtE_PUBL_DT.value);
	}
	if(dataset == dsPARAM)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","PARAM");
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

//검색조건체크
function print_condition_check()
{
	if(!CheckBudgYyyyMm()) return false;
   	return true;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
function btnquery_onclick()
{
	dsMAIN.ClearData();
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
}

// 취소
function btncancel_onclick()
{
}
//인쇄
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
				
	// 공통 Check
	//if (!checkCommon()) return;
	if(!print_condition_check()) return;
	var		lnCnt = dsMAIN.CountRow;
	G_Load(dsPARAM)
	for(i = 1 ; i <= lnCnt ; ++ i)
	{
		if(dsMAIN.NameString(i,"CHK_TAG") == "T")
		{
			G_addRow(dsPARAM);
			dsPARAM.NameString(dsPARAM.RowPosition,"PAY_SEQ") = dsMAIN.NameString(i,"PAY_SEQ");
		}
	}
	if(!G_saveData(dsPARAM))
	{
		return;
	}
	 
   	var vBudgYyyyMmFr   = txtF_PUBL_DT.value.replace(/-/g,'');
   	var vBudgYyyyMmTo   = txtE_PUBL_DT.value.replace(/-/g,'');
   
   
   	var reportFile ="r_t_110004.rpt";
	
	
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
	
	
	strTemp   = "P_STD_YMD_F__" + vBudgYyyyMmFr;
	strTemp += "&&P_STD_YMD_T__" + vBudgYyyyMmTo;
	strTemp += "&&P_COMP_CODE__" + txtCOMP_CODE.value;
	strTemp += "&&P_EMP_NO__" + sEmpNo;
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "F_PUBL_DT")
	{
		txtF_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "E_PUBL_DT")
	{
		txtE_PUBL_DT.value = asDate;
	}
}
function OnRowPosChanged(dataset, row)
{

}

// 이벤트관련-------------------------------------------------------------------//

 
 
function	CheckCompCode()
{
	return true;
}

function	CheckBudgYyyyMm()
{
	if (C_isNull(txtF_PUBL_DT.value))
	{
		C_msgOk("기간을 입력하세요.", "확인");
		return false;
	}
	if (C_isNull(txtE_PUBL_DT.value))
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

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	  = lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value = lrRet.get("COMPANY_NAME");
	dsMAIN.ClearData();
	D_defaultLoad();
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	dsMAIN.ClearData();
	D_defaultLoad();
}
function	btnF_PUBL_DT_onClick()
{
	C_Calendar("F_PUBL_DT", "D", txtF_PUBL_DT.value);
}
function	btnE_PUBL_DT_onClick()
{
	C_Calendar("E_PUBL_DT", "D", txtE_PUBL_DT.value);
}
function	btnRetrieve_onClick()
{
	gridMAIN.focus();
	dsMAIN.ClearData();
	D_defaultLoad();
}
