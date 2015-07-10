/**************************************************************************/
/* 1. 프 로 그 램 id : t_WLastYearBudgResultCompR.js(전년대비실적현황)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 부서별계정별월별현황(년)
/* 4. 변  경  이  력 : 한재원 작성(2005-12-29)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	
	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "사업장별 부서목록");


	G_addDataSet(dsLOV, null, null,  null, "LOV");


	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	G_Load(dsLIST00, null);
	
	
}
function OnLoadBefore(dataset)
{

	 if (dataset == dsLIST00)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		var vBudgYyyy = txtCLSE_ACC_ID.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST00")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("BUDG_YYYY",vBudgYyyy);
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
function condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	var vClseAccId   = txtCLSE_ACC_ID.value;
   	
   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("사업장을 선택하세요");
   		return;
   	}
   	
   	if ( C_isNull(vClseAccId))
   	{
   		C_msgOk("회기를  선택하세요");
   		return;
   	}
   	
   	return true;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//

//인쇄
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	if (!condition_check()) return;
	
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
   	var vBudgYyyy   = txtCLSE_ACC_ID.value;
   	var vBudgYyyyB4 =	 parseInt(txtCLSE_ACC_ID.value.replace(/-/gi,""))-1;
       var vDeptCode   = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
   	var vDeptFlag = selDeptFlag.value;
   
  
   
   	var reportFile ="";
	var strTemp = "";
   
	if(vDeptFlag == "ALL")
	{
	   	reportFile ="r_t_080030_a"; 
		strTemp	+= "P_COMP_CODE__" + vCompCode;
		strTemp	+= "&&P_CLSE_ACC_ID__" + vBudgYyyy;
		strTemp	+= "&&P_CLSE_ACC_ID_B4__" + vBudgYyyyB4;
		strTemp	+= "&&P_COMP_NAME__" + vCompName;
	}
	else if(vDeptFlag == "CHK_DEPT")
	{
	   	reportFile ="r_t_080030_b"; 
		strTemp	+= "P_COMP_CODE__" + vCompCode;
		strTemp	+= "&&P_CLSE_ACC_ID__" + vBudgYyyy;
		strTemp	+= "&&P_CLSE_ACC_ID_B4__" + vBudgYyyyB4;
		strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
		strTemp	+= "&&P_COMP_NAME__" + vCompName;
	}
	else if(vDeptFlag == "DEPT")
	{
	   	reportFile ="r_t_080030_c"; 
		strTemp	+= "P_COMP_CODE__" + vCompCode;
		strTemp	+= "&&P_CLSE_ACC_ID__" + vBudgYyyy;
		strTemp	+= "&&P_CLSE_ACC_ID_B4__" + vBudgYyyyB4;
		strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
		strTemp	+= "&&P_COMP_NAME__" + vCompName;
	}

   	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 조회
function btnquery_onclick()
{
	if (!condition_check()) return;
	D_defaultLoad();
}



// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//

function OnRowPosChanged(dataset, row)
{
	if(row==0) return;
	if (dataset == dsLIST00)
	{
		//부서
		var vDeptCode = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		
		selDeptFlag.options.length = "0"; 
		var i = 0;
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("전 체","ALL");
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("팀별","CHK_DEPT");
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("부서별","DEPT");
		if(vDeptCode != "%") selDeptFlag.options.options[i++] = new Option("팀별","CHK_DEPT");
		if(vDeptCode != "%") selDeptFlag.options.options[i++] = new Option("부서별","DEPT");
		
	}

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

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");

	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");

	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"F");

	if (lrRet == null) return;

	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");

	
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