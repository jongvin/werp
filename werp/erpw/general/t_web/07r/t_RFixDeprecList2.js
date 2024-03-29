/**************************************************************************/
/* 1. 프 로 그 램 id : t_RFixDeprecSumByAcc.js(감가상각비 계정별 명세서)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 감가상각비 계정별 명세서 
/* 4. 변  경  이  력 : 한재원 작성(2006-02-02)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	
	G_addDataSet(dsLOV, null, null, "", "LOV");
	
	
	txtCOMP_CODE.value		= sCompCode;
	txtCOMPANY_NAME.value	= sCompName;
	

	 
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

//조회시 체크
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을  선택하십시요.", "확인");
		return;
	}
	
	return true;
}


// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
 function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
       if(!checkCondition()) return;
       var   strDEPREC_DIV	= cboDEPREC_DIV.value;
       if (strDEPREC_DIV =='S')
       {
   		var reportFile ="r_t_070007_2";
   	}
   	else
   	{
   		var reportFile ="r_t_070007_2_T";
   	}
  	
   	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	//alert(frmList.REPORT_FILE_NAME.value);
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	strITEM_CODE = txtITEM_CODE.value;
	if ( strITEM_CODE=="")
	{
		strITEM_CODE="%";
	}
	
	strTemp += "CompCode__" + txtCOMP_CODE.value + "&&";
	strTemp += "AssetClsCode__" + cboASSET_CLS_CODE.value + "&&";
	strTemp += "ItemCode__" + strITEM_CODE + "&&";
	strTemp += "Year__" + cboBUY_YEAR.value;
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	//strTemp ="";
}
// 공통 재정의 이벤트관련-------------------------------------------------------//
function OnLoadCompleted(dataset, rowcnt)
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

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//계정코드
function txtACC_CODE_onblur()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	
	lrArgs.set("SEARCH_CONDITION", "txtACC_CODE.value");

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_ACC_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}



function txtITEM_CODE_onblur()
{
	if (C_isNull(txtITEM_CODE.value))
	{
		txtITEM_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", cboASSET_CLS_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtITEM_CODE.value);

	var		lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE2",lrArgs,'T');

	if (lrRet != null)
	{
		txtITEM_CODE.value			= lrRet.get("ITEM_CODE");
		txtITEM_NAME.value			= lrRet.get("ITEM_NAME");
	}
}
function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", cboASSET_CLS_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_FIX_ITEM_CODE2", lrArgs);

	if (lrRet != null)
	{
		txtITEM_CODE.value			= lrRet.get("ITEM_CODE");
		txtITEM_NAME.value			= lrRet.get("ITEM_NAME");
	}
}