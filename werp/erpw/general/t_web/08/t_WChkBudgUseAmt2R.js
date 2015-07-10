/**************************************************************************/
/* 1. 프 로 그 램 id : t_WChkBudgUseAmtR.js(통제예산실적조회(년))
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 통제예산실적조회
/* 4. 변  경  이  력 : 한재원 작성(2005-12-29)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	
	//G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "사업장별 부서목록");

	G_addDataSet(dsLIST02, null, gridLIST02, sSelectPageName+D_P1("ACT","LIST02")	, "부서별-월별 신청내역");
      
	G_addDataSet(dsLOV, null, null,  null, "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	txtDEPT_CODE.value = sDeptCode;
	txtDEPT_NAME.value = sDeptName;		
	//G_Load(dsLIST00, null);
	
	gridLIST02.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsLIST02)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		var vMONTH = selMonth.value;
		var vCLSE_ACC_ID = txtCLSE_ACC_ID.value;
		var vDEPT_CODE = txtDEPT_CODE.value;
	
		dataset.DataID = sSelectPageName + D_P1("ACT", "LIST02")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("CLSE_ACC_ID",vCLSE_ACC_ID)
									 + D_P2("MONTH",vMONTH)
									 + D_P2("DEPT_CODE",vDEPT_CODE);
									 

		
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
	var vCompCode = txtCOMP_CODE.value;
   	
   	
   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("사업장을 선택하세요");
   		return;
   	}
   	
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
//인쇄
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	print_condition_check();
	
	var vCompName  = txtCOMPANY_NAME.value;
	var vCompCode  = txtCOMP_CODE.value;
	var vClseAccId   = txtCLSE_ACC_ID.value;

	var vDeptCode   = C_isNull(txtDEPT_CODE.value)?"%":txtDEPT_CODE.value;
      
	var vMonth   = selMonth.value;
   
	var reportFile ="";

	reportFile ="r_t_080080";  


   	
	frmList.EXPORT_TAG.value ="P";
	frmList.RUN_TAG.value = "1";
	frmList.REQUEST_NAME.value = "통제예산실적조회";
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";

	
	strTemp += "P_COMP_CODE__" + vCompCode;
	strTemp  += "&&P_CLSE_ACC_ID__" + vClseAccId;
	strTemp += "&&P_MONTH__" + vMonth;
	strTemp += "&&P_DEPT_CODE__" + vDeptCode;
	strTemp  += "&&P_COMP_NAME__" + vCompName;
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 조회
function btnquery_onclick()
{
	//CheckBudgYyyyMm();
	D_defaultLoad();
}



// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	
	
}
function OnRowPosChanged(dataset, row)
{
	if(row==0) return;
	
	

}

// 이벤트관련-------------------------------------------------------------------//
function deptFlag_onChange()
{
	//(dsLIST02,null);	
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

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");

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


//출력
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}
 
 function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
		
}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
			
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

	lrRet = C_AutoLov(dsLOV,"T_BUDG_DEPT_CODE2", lrArgs,"T");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");

}

 
function btnDEPT_CODE_onClick()
{     
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_BUDG_DEPT_CODE2", lrArgs,"F");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");

}

