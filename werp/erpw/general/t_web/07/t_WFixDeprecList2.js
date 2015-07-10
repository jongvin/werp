/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixDeprecList.js(감가상각 집계현황)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 감가상각 명세현황 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-23)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "감가상각집계현황");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "자산종류");
	G_addDataSet(dsLOV, null, null, "", "LOV");
	
	txtCOMP_CODE.value		= sCompCode;
	txtCOMPANY_NAME.value	= sCompName;
	G_Load(dsASSETCLS, null);
	gridMAIN.focus();
	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var 	strCOMP_CODE	= txtCOMP_CODE.value;
		var   strASSET_CLS_CODE      = dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE");
		var 	strITEM_CODE		= txtITEM_CODE.value;
		var 	strYEAR			= cboYEAR.value;
		var   strDEPREC_DIV	= cboDEPREC_DIV.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", strCOMP_CODE)
									 + D_P2("ASSET_CLS_CODE", strASSET_CLS_CODE)
									 + D_P2("ITEM_CODE", strITEM_CODE)
									 + D_P2("YEAR",strYEAR)
									 + D_P2("DEPREC_DIV",strDEPREC_DIV);
									
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
	if (txtCOMP_CODE.value == "")
	{
		C_msgOk("사업장을 입력 하십시오.", "확인");
		return;
	}

	D_defaultLoad();
}


// 공통 재정의 이벤트관련-------------------------------------------------------//


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


function txtITEM_CODE_onblur()
{
	if (txtITEM_CODE.value == "")
	{
		txtITEM_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
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

	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_FIX_ITEM_CODE2", lrArgs);

	if (lrRet != null)
	{
		txtITEM_CODE.value			= lrRet.get("ITEM_CODE");
		txtITEM_NAME.value			= lrRet.get("ITEM_NAME");
	}
}

