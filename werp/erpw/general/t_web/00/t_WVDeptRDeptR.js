/**************************************************************************/
/* 1. 프 로 그 램 id : t_WVDeptRDeptR(미확정현장별실현장관리)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			sDeptCode;
var			sDeptName;
var			sDeptShortName;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "미확정현장목록",null,null,true);
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "미확정현장별실현장목록",null,null,true);
	
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"V_DEPT_CODE","V_DEPT_CODE");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
	G_setReadOnlyCol(gridSUB01,"R_DEPT_CODE");
	G_setReadOnlyCol(gridSUB01,"DEPT_NAME");
	G_setReadOnlyCol(gridSUB01,"DEPT_SHORT_NAME");
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("DEPT_NAME",txtSEARCH_CONDITION.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("V_DEPT_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"V_DEPT_CODE"));
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

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("먼저 회기를 선택하세요.", "확인");
		return false;
	}
	return true;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	D_defaultInsert();
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
	if(dsMAIN == dataset)
	{
		return false;
	}
	else if(dataset == dsSUB01)
	{
		if(!CheckCompCode()) return false;
		
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
		lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	
		lrRet = C_LOV("T_DEPT_CODE4", lrArgs,"F");
		
		if (lrRet == null) return false;
		
		sDeptCode = lrRet.get("DEPT_CODE");
		sDeptName	= lrRet.get("DEPT_NAME");
		sDeptShortName	= lrRet.get("DEPT_SHORT_NAME");
		return true;
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsSUB01)
	{
		dataset.NameString(row,"R_DEPT_CODE") = sDeptCode;
		dataset.NameString(row,"DEPT_NAME") = sDeptName;
		dataset.NameString(row,"DEPT_SHORT_NAME") = sDeptShortName;
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	}
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset, grid, row, colid)
{
}
function OnColumnChanged(dataset, row, colid)
{
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
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
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
	
	D_defaultLoad();
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
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
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
	
	D_defaultLoad();
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
