/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixSheet.js(고정자산대장조회)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 고정자산대장조회 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "고정자산대장");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "자산종류");

	G_addDataSet(dsLOV, null, null, null, "LOV");
	
       txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	txtDEPT_CODE.value = sDeptCode;
	txtDEPT_NAME.value = sDeptName;
	
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"ASSET_CLS_NAME");
	G_setReadOnlyCol(gridMAIN,"ITEM_NAME");
	G_setReadOnlyCol(gridMAIN,"ITEM_NM_NAME");
	G_setReadOnlyCol(gridMAIN,"FIXED_CLS_NAME");
	G_setReadOnlyCol(gridMAIN,"GET_DT");
	G_setReadOnlyCol(gridMAIN,"ASSET_CNT");
	G_setReadOnlyCol(gridMAIN,"START_ASSET_AMT");
	G_setReadOnlyCol(gridMAIN,"INC_SUM_AMT");
	G_setReadOnlyCol(gridMAIN,"SUB_SUM_AMT");
	G_setReadOnlyCol(gridMAIN,"JAN");
	G_setReadOnlyCol(gridMAIN,"OLD_DEPREC_AMT");
	G_setReadOnlyCol(gridMAIN,"CURR_ASSET_INC_AMT");
	G_setReadOnlyCol(gridMAIN,"CURR_ASSET_SUB_AMT");
	gridMAIN.focus();
	G_Load(dsASSETCLS, null);

	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("DEPT_CODE", txtDEPT_CODE.value)
									 + D_P2("ASSET_CLS_CODE",dsASSETCLS.NameString(dsASSETCLS.RowPosition,"ASSET_CLS_CODE"));
	}
	else if(dataset == dsASSETCLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ASSET_CLS_CODE");
										
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


//조회시 체크
function checkCondition()
{
	
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을 선택하십시요.", "확인");
		return;
	}
	
	return true;
}
//전체 선택 종료
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(!checkCondition()) return;
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


function OnLoadCompleted(dataset, rowcnt)
{
}


function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
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
	
	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//보유부서
function txtDEPT_CODE_onblur()
{
	if (txtDEPT_CODE.value == "")
	{
		txtDEPT_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	
	//부서/현장 전사업장
	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnDEPT_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

