/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFLDeptPlanR(현장별자금수지계획수립)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "현장별자금수지계획",null,null,true);
	
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtDEPT_CODE.value = sDeptCode;
	txtDEPT_NAME.value = sDeptName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	G_setReadOnlyCol(gridMAIN,"LEVELED_FLOW_ITEM_NAME");

	ckPLAN.checked = true;	
	ckEXEC.checked = true;	
	ckRATIO.checked = true;	
	ck_onChange();
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("DEPT_CODE",txtDEPT_CODE.value);
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
function	CalcSum(row,colid)
{
	if(dsMAIN.NameString(row,"LV") != "2") return;
	if(dsMAIN.NameString(row,"IS_LEAF_TAG") != "T") return;
	dsMAIN.NameString(row + 1,colid) = C_convSafeFloat(dsMAIN.NameString(row - 1,colid)) + C_convSafeFloat(dsMAIN.NameString(row ,colid));
}
function	checkConditions()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	if(C_isNull(txtDEPT_CODE.value))
	{
		C_msgOk("먼저 부서코드를 선택하세요.", "확인");
		return false;
	}

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("먼저 회기를 선택하세요.", "확인");
		return false;
	}
	return true;
}
function	isClose()
{
	return true;
}
function	checkClose()
{
	return true;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(!checkConditions()) return;
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
}

// 삽입
function btninsert_onclick()
{
	btnadd_onclick();
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
	return false;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset, grid, row, colid)
{
	if(colid != 'LEVELED_FLOW_ITEM_NAME' && colid != 'SUBTITLE_NAME')
	{
		if(dataset.NameString(row,"IS_LEAF_TAG") == "T" && dataset.NameString(row,"LV") == "2")
		{
			grid.ColumnProp(colid,'Edit') = 'Numeric';
		}
		else
		{
			grid.ColumnProp(colid,'Edit') = 'None';
		}
	}
}
function OnColumnChanged(dataset, row, colid)
{
	if(bEnter) return;
	bEnter = true;
	if(dataset == dsMAIN)
	{
		try
		{
			CalcSum(row,colid);
		}
		catch(e)
		{
		}
	}
	bEnter = false;
}

function OnExit(dataset, grid, row, colid, olddata)
{
}
function OnClick(dataset, grid, row, colid)
{
}
	
function OnPopup(dataset, grid, row, colid, data)
{
}
function OnPostBefore(dataset, trans)
{
	return true;
}
function	OnSuccess(dataset,trans)
{
}

// 이벤트관련-------------------------------------------------------------------//

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function txtDEPT_CODE_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE_PROJ", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		dsMAIN.ClearData();
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
	
	if(C_isNull(txtDEPT_CODE.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
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
	dsMAIN.ClearData();
}
function btnDEPT_CODE_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE_PROJ", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	if(C_isNull(txtDEPT_CODE.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
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
function	ck_onChange()
{
	gridMAIN.ColumnProp("PLAN_AMT_01","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_02","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_03","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_04","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_05","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_06","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_07","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_08","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_09","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_10","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_11","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_12","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("PLAN_AMT_SUM","Show") = ckPLAN.checked;
	gridMAIN.ColumnProp("EXEC_AMT_01","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_02","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_03","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_04","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_05","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_06","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_07","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_08","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_09","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_10","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_11","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_12","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("EXEC_AMT_SUM","Show") = ckEXEC.checked;
	gridMAIN.ColumnProp("RATIO_01","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_02","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_03","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_04","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_05","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_06","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_07","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_08","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_09","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_10","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_11","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_12","Show") = ckRATIO.checked;
	gridMAIN.ColumnProp("RATIO_SUM","Show") = ckRATIO.checked;
}
