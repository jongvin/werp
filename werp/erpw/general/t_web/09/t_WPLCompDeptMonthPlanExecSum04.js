/**************************************************************************/
/* 1. 프 로 그 램 id : HTML_1.js(단일 화면)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "자금수지");
       G_addDataSet(dsCOPY, trans, null, null, "출력");
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	//txtDEPT_CODE.value=sDeptCode;
	//txtDEPT_NAME.value=sDeptName;
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
									
	}
	else if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
									
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
function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("먼저 회기를 선택하세요.", "확인");
		return false;
	}
	
	/*
	if (C_isNull(txtDEPT_CODE.value))
	{
		C_msgOk("먼저 현장을 선택하세요.", "확인");
		return false;
	}
	*/
	return true;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
//인쇄
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
	//alert('hello');
	//return;			
	// 공통 Check
	if (!CheckCompCode()) return;
	
	 var vCompCode  = txtCOMP_CODE.value;
	 var vCompName  = txtCOMPANY_NAME.value;
   	//var vDeptName   = txtDEPT_NAME.value;

       //var vDeptCode   = txtDEPT_CODE.value;
      
       var vClseAccId = txtCLSE_ACC_ID.value;
       //var vMONTH   = cboMONTH.value;
       var vBClseAccId = parseInt(vClseAccId) -1;
       var vNClseAccId = parseInt(vClseAccId) +1;
   	//var vYear      = vYearMonth.substr(0,4);
   	//var vMonth   = vYearMonth.substr(5,2);
   	//alert(vYear);
   	//alert(vMonth);
  	//return;
  	
   	var reportFile ="";

       reportFile ="r_t_091007";  

	frmList.EXPORT_TAG.value ='P';
	frmList.RUN_TAG.value = '1';
	frmList.REQUEST_NAME.value = '';
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";

	
	G_Load(dsCOPY, null);
	dsCOPY.NameString(dsCOPY.RowPosition,"EMP_NO") = sEmpNo;
	dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = vClseAccId;
	//dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = vDeptCode;
	//dsCOPY.NameString(dsCOPY.RowPosition,"MONTH") = vMONTH;
	trans.Parameters = "ACT=COPY";
	//alert(transCopy.Parameters);
	//return;
	if(!G_saveData(dsCOPY))return;
	
	
	strTemp = "P_EMP_NO__" + sEmpNo;
	strTemp += "&&P_COMP_NAME__" + vCompName;
	//strTemp += "&&P_DEPT_NAME__" + vDeptName;
	strTemp += "&&P_CLSE_ACC_ID__" + vClseAccId;
	//strTemp += "&&P_MONTH__" + vMONTH;
	strTemp += "&&P_B_CLSE_ACC_ID__" + vBClseAccId;
	strTemp += "&&P_N_CLSE_ACC_ID__" + vNClseAccId;
	
	
	//alert(frmList.REPORT_FILE_NAME.value);
	//alert(strTemp);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 조회
function btnquery_onclick()
{
	if(!CheckCompCode()) return false;
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
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";

}
function txtDEPT_CODE_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE10", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	
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
function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	
}
function btnDEPT_CODE_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_DEPT_CODE10", lrArgs,"F");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	
	
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

