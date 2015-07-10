/**************************************************************************/
/* 1. 프 로 그 램 id : t_RFixSheetTra.js(고정자산대장출력(폐기))
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 고정자산대장출력(폐기)
/* 4. 변  경  이  력 : 한재원 작성(2006-02-02)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "고정자산대장");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "자산종류");

	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtINCREDU_DT_FROM.value = vDate;
	txtINCREDU_DT_TO.value = vDate;
	G_Load(dsASSETCLS, null);
	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("ASSET_CLS_CODE",dsASSETCLS.NameString(dsASSETCLS.RowPosition,"ASSET_CLS_CODE"))
									 + D_P2("ITEM_CODE",txtITEM_CODE.value)
									 + D_P2("ITEM_NM_CODE", txtITEM_NM_CODE.value)
									 + D_P2("DEPREC_FINISH",dsDEPREC_FINISH.NameString(dsDEPREC_FINISH.RowPosition,"CODE_LIST_ID"));
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
//인쇄
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
     
   	var reportFile ="r_t_070009";
  	
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
	strITEM_NM_CODE	= txtITEM_NM_CODE.value;
	strDEPT_CODE = txtDEPT_CODE.value
	
	if ( strITEM_CODE=="")
	{
		strITEM_CODE="%";
	}
	if ( strITEM_NM_CODE=="")
	{
		strITEM_NM_CODE="%";
	}
	if ( strDEPT_CODE=="")
	{
		strDEPT_CODE="%";
	}
	
	
	strTemp += "CompCode__" + txtCOMP_CODE.value + "&&";
	strTemp += "AssetClsCode__" + dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE") + "&&";
	strTemp += "ItemCode__" + strITEM_CODE  + "&&";
	strTemp += "ItemNmCode__" +  strITEM_NM_CODE + "&&";
	strTemp += "DeptCode__" +  strDEPT_CODE + "&&";
	strTemp += "IncreduDtFrom__" + txtINCREDU_DT_FROM.value + "&&";
	strTemp += "IncreduDtTo__" + txtINCREDU_DT_TO.value + "&&";
	strTemp += "FixedCls__" + cboFIXED_CLS.value;
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	//strTemp ="";
}


//조회시 체크
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을 선택하세요.", "확인");
		return;
	}
	
	if (C_isNull(txtINCREDU_DT_FROM.value))
	{
		C_msgOk("기준일을 입력하세요", "확인");
		return;
	}
	if (C_isNull(INCREDU_DT_TO.value))
	{
		C_msgOk("기준일을 입력하세요", "확인");
		return;
	}
	return true;
}
//전체 선택 종료
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//


// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "INCREDU_DT_FROM")
	{
		txtINCREDU_DT_FROM.value = asDate;
	}
	if (asCalendarID == "INCREDU_DT_TO")
	{
		txtINCREDU_DT_TO.value = asDate;
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
}
//품목코드
function txtITEM_CODE_onblur()
{
	if (C_isNull(txtITEM_CODE.value))
	{
		txtITEM_NAME.value = "";
		return;
	}
	if (txtITEM_CODE.value == '%')
	{
		return false;
	}
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
	chkTotal02.disabled=false;
}

function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
	chkTotal02.disabled=false;
}
//품명코드
function txtITEM_NM_CODE_onblur()
{

	if (C_isNull(txtITEM_NM_CODE.value) || txtITEM_NM_CODE.value=='%')
	{
		if (C_isNull(txtITEM_CODE.value))
		{
			C_msgOk("품목구분을 먼저 선택하세요.");
			return;
		}
	}
	
	if (C_isNull(txtITEM_NM_CODE.value))
	{
		txtITEM_NM_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtITEM_NM_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}

function btnITEM_NM_CODE_onClick()
{
	if (txtITEM_CODE.value == "")
	{
		C_msgOk("품목구분을 먼저 선택하세요.");
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//권한없는 부서현장(전사업장)

function btnINCREDU_DT_FROM_onClick()
{
	C_Calendar("INCREDU_DT_FROM", "D", txtINCREDU_DT_FROM.value);
	S_nextFocus(btnINCREDU_DT_FROM);
}

function btnINCREDU_DT_TO_onClick()
{
	C_Calendar("INCREDU_DT_TO", "D", txtINCREDU_DT_TO.value);
	S_nextFocus(btnINCREDU_DT_TO);
}

