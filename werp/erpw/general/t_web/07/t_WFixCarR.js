/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixCarR.js(고정자산차량등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 고정자산차량등록 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "고정자산대장");
	
	G_addDataSet(dsDEPREC_FINISH, null, null, sSelectPageName+D_P1("ACT","DEPREC_FINISH"), "상각완료구분");

	
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	
	Value_Readonly(true);
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPREC_FINISH_NAME");
	G_setReadOnlyCol(gridMAIN,"CAR_NO");
	G_setReadOnlyCol(gridMAIN,"CAR_BODY_NO");
	G_setReadOnlyCol(gridMAIN,"CAR_YEAR");
	gridMAIN.focus();
	
	G_Load(dsDEPREC_FINISH, null);
	
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("ASSET_CLS_CODE",strAssetClsCode)
									 + D_P2("ITEM_CODE",txtITEM_CODE.value)
									 + D_P2("ITEM_NM_CODE", txtITEM_NM_CODE.value)
									 + D_P2("DEPREC_FINISH",dsDEPREC_FINISH.NameString(dsDEPREC_FINISH.RowPosition,"CODE_LIST_ID"));
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
function	Value_Readonly(abTag)
{
	document.all.txtCAR_NO.readOnly			= abTag;
	document.all.txtCAR_BODY_NO.readOnly	= abTag;
	document.all.txtCAR_YEAR.readOnly		= abTag;
	document.all.txtCAR_LENGTH.readOnly		= abTag;
	document.all.txtCAR_HEIGHT.readOnly		= abTag;
	document.all.txtCAR_WEIGHT.readOnly		= abTag;
	document.all.txtCAR_CC.readOnly			= abTag;
	document.all.txtCAR_CYLINDER.readOnly	= abTag;
	document.all.txtCAR_FORM_NO.readOnly	= abTag;
	document.all.txtCAR_OIL.readOnly			= abTag;
	document.all.txtCAR_USE.readOnly			= abTag;
	document.all.txtCAR_USER.readOnly		= abTag;
	document.all.txtREGULAR_CHECK_START.readOnly	= abTag;
	document.all.txtREGULAR_CHECK_END.readOnly		= abTag;
	document.all.txtGET_TAX.readOnly	= abTag;
	document.all.txtREG_TAX.readOnly			= abTag;
	document.all.txtVAT_TAX.readOnly		= abTag;
	document.all.txtINSURANCE_START.readOnly	= abTag;
	document.all.txtINSURANCE_END.readOnly	= abTag;
	
	document.all.btnREGULAR_CHECK_START.disabled= abTag;
	document.all.btnREGULAR_CHECK_END.disabled	= abTag;
	document.all.btnINSURANCE_START.disabled		= abTag;
	document.all.btnINSURANCE_END.disabled		= abTag;
	


}
function chkInputItem()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을  선택하십시요.", "확인");
		return;
	}
	
	//날짜 유효성체크
	if ( !C_isNull(txtREGULAR_CHECK_START.value))
	{
		strReChSt = txtREGULAR_CHECK_START.value.replace(/-/gi,"");
		strReChEn= txtREGULAR_CHECK_END.value.replace(/-/gi,"");

		if (parseInt(strReChSt) > parseInt(strReChEn))
		{
			C_msgOk("시작일은 종료일보다 작게 입력하세요");
			txtREGULAR_CHECK_START.value = olddata1;
			txtREGULAR_CHECK_START.focus();
			return;
		}
	}
	
	if ( !C_isNull(txtREGULAR_CHECK_END.value))
	{
		strReChSt = txtREGULAR_CHECK_START.value.replace(/-/gi,"");
		strReChEn= txtREGULAR_CHECK_END.value.replace(/-/gi,"");

		if (parseInt(strReChSt) > parseInt(strReChEn))
		{
			C_msgOk("시작일은 종료일보다 작게 입력하세요");
			txtREGULAR_CHECK_END.value = olddata2;
			txtREGULAR_CHECK_END.focus();
			return;
		}
	}
	
	if ( !C_isNull(txtINSURANCE_START.value))
	{
		strInsuSt   = txtINSURANCE_START.value.replace(/-/gi,"");
		strInsuEn	 = txtINSURANCE_END.value.replace(/-/gi,"");

		if (parseInt(strInsuSt) > parseInt(strInsuEn))
		{
			C_msgOk("시작일은 종료일보다 작게 입력하세요");
			txtINSURANCE_START.value = olddata3;
			txtINSURANCE_START.focus();
			return;
		}
	}	
	
	if ( !C_isNull(txtINSURANCE_END.value))
	{
		strInsuSt   = txtINSURANCE_START.value.replace(/-/gi,"");
		strInsuEn	 = txtINSURANCE_END.value.replace(/-/gi,"");

		if (parseInt(strInsuSt) > parseInt(strInsuEn))
		{
			C_msgOk("시작일은 종료일보다 작게 입력하세요");
			txtINSURANCE_END.value = olddata4;
			txtINSURANCE_END.focus();
			return;
		}
	}			
	
	if (C_isNull(txtITEM_CODE.value))
	{
		C_msgOk("품목구분을 선택하십시요.", "확인");
		return;
	}
	
	if (C_isNull(txtITEM_NM_CODE.value))
	{
		C_msgOk("품명구분을  선택하십시요.", "확인");
		return;
	}
	return true;	
}



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
	Value_Readonly(false);
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	//조회여부체크
	if(!G_isLoaded("dsMAIN"))
	{
		C_msgOk("먼저 조회를 수행하세요");
		return;
	}
	if (!chkInputItem()) return;
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("ITEM_NM_CODE", txtITEM_NM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_SHEET1", lrArgs,"F");
	
	if (lrRet == null) return;

	strAssetName		 = lrRet.get("ASSET_NAME");
	strAssetMngNo		 = lrRet.get("ASSET_MNG_NO");
	strDeprecFinishName = lrRet.get("DEPREC_FINISH_NAME");
	strFixAssetSeq		 =  lrRet.get("FIX_ASSET_SEQ");
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
	
	//if(!chkInputItem()) return;
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
	 if (asCalendarID == "REGULAR_CHECK_START")
	{
		txtREGULAR_CHECK_START.value = asDate;
	}
	else if (asCalendarID == "REGULAR_CHECK_END")
	{
		txtREGULAR_CHECK_END.value = asDate;
	}
	else if (asCalendarID == "INSURANCE_START")
	{
		txtINSURANCE_START.value = asDate;
	}
	else if (asCalendarID == "INSURANCE_END")
	{
		txtINSURANCE_END.value = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
	if ( dataset == dsMAIN)
	{
		olddata1 = txtREGULAR_CHECK_START.value;
		olddata2 = txtREGULAR_CHECK_END.value;
		olddata3 = txtINSURANCE_START.value;
		olddata4 = txtINSURANCE_END.value;
	}
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	
	
	if ( dataset == dsMAIN)
	{
		dataset.NameValue(row, "ASSET_MNG_NO") = strAssetMngNo;
		dataset.NameValue(row, "ASSET_NAME") = strAssetName;
		dataset.NameValue(row, "DEPREC_FINISH_NAME") = strDeprecFinishName;
		dataset.NameString(row,"FIX_ASSET_SEQ") 	= strFixAssetSeq;	
	}
	
	gridMAIN.focus();
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

	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
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
	
	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_CODE1", lrArgs,"F");
	
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
			C_msgOk("품목구분을  먼저 선택하세요.");
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
	
	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
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
	
	lrArgs.set("ASSET_CLS_CODE", strAssetClsCode);
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//권한없는 부서현장(전사업장)
function btnREGULAR_CHECK_START_onClick()
{
	C_Calendar("REGULAR_CHECK_START", "D", txtREGULAR_CHECK_START.value);
}

function btnREGULAR_CHECK_END_onClick()
{
	C_Calendar("REGULAR_CHECK_END", "D", txtREGULAR_CHECK_END.value);
}
function btnINSURANCE_START_onClick()
{
	C_Calendar("INSURANCE_START", "D", txtINSURANCE_START.value);
}

function btnINSURANCE_END_onClick()
{
	C_Calendar("INSURANCE_END", "D", txtINSURANCE_END.value);
}

