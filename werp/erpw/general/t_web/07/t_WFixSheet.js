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
	G_addDataSet(dsDEPREC_FINISH, null, null, sSelectPageName+D_P1("ACT","DEPREC_FINISH"), "상각완료구분");

	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPREC_FINISH");
	G_setReadOnlyCol(gridMAIN,"ASSET_SIZE");
	G_setReadOnlyCol(gridMAIN,"GET_DT");
	G_setReadOnlyCol(gridMAIN,"SRVLIFE");
	G_setReadOnlyCol(gridMAIN,"GET_COST_AMT");
	G_setReadOnlyCol(gridMAIN,"INC_SUB_SUM_AMT");
	G_setReadOnlyCol(gridMAIN,"BASE_AMT");
	G_setReadOnlyCol(gridMAIN,"ESTIMATE_AMT1");
	G_setReadOnlyCol(gridMAIN,"ESTIMATE_AMT2");
	G_setReadOnlyCol(gridMAIN,"FOREIGN_AMT");
	G_setReadOnlyCol(gridMAIN,"BASE_AMT");
	G_setReadOnlyCol(gridMAIN,"MNG_DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"REMARK");
	gridMAIN.focus();
	G_Load(dsASSETCLS, null);
	G_Load(dsDEPREC_FINISH, null);
	
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
	else if(dataset == dsDEPREC_FINISH)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPREC_FINISH");
										
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
		C_msgOk("사업장을 선택하세요.", "확인");
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

// 추가
function btnadd_onclick()
{
	if (txtITEM_CODE.value == "" )
	{
		C_msgOk("품목구분을 선택하세요.", "확인");
		return;
	}
	if (txtITEM_NM_CODE.value == "")
	{
		C_msgOk("품명구분을 선택하세요.", "확인");
		return;
	}
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	btnadd_onclick();
}

// 삭제
function btndelete_onclick()
{
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{	

	D_defaultSave(dsMAIN);
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

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	
	
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
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
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}

function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}
//품명코드
function txtITEM_NM_CODE_onblur()
{
	
	if (!C_isNull(txtITEM_NM_CODE.value))
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
	lrArgs.set("SEARCH_CONDITION", "");

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
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//권한없는 부서현장(전사업장)
//계정코드찾기
function txtACC_CODE_onblur()
{
	if (txtACC_CODE.value == "")
	{
		txtACC_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);
	
	//입력가능,불가능계정
	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}
function btnACC_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_ACC_CODE3", lrArgs,"F");
	
	if (lrRet == null) return;

	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}
//구매부서
function txtMNG_DEPT_CODE_onblur()
{
	if (txtMNG_DEPT_CODE.value == "")
	{
		txtMNG_DEPT_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtMNG_DEPT_CODE.value);
	
	//부서/현장 전사업장
	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtMNG_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMNG_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnMNG_DEPT_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtMNG_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMNG_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
//배치현장
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
//거래처검색
function txtCUST_CODE_onblur()
{
	if (txtCUST_CODE.value == "")
	{
		txtCUST_NAME.value 	= "";
		hiCUST_SEQ.value		= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);
	

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
}
function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
}

//견적거래처검색
function txtEST_CUST_CODE_onblur()
{
	if (txtEST_CUST_CODE.value == "")
	{
		txtEST_CUST_NAME.value 	= "";
		hiCUST_SEQ2.value		= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtEST_CUST_CODE.value);
	

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtEST_CUST_CODE.value	= lrRet.get("CUST_CODE");
	txtEST_CUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ2.value			= lrRet.get("CUST_SEQ");
}
function btnEST_CUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtEST_CUST_CODE.value	= lrRet.get("CUST_CODE");
	txtEST_CUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ2.value			= lrRet.get("CUST_SEQ");
}
