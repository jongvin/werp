/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgAllChangeDetailR.js(일괄예산변경적용)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 일괄예산변경적용 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-09)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN01, null, gridMAIN01, sSelectPageName+D_P1("ACT","MAIN01"), "전월말인원현황");
	G_addDataSet(dsSUB01, null,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "전원말기준금액");
	G_addDataSet(dsMAIN02, null, gridMAIN02, sSelectPageName+D_P1("ACT","MAIN02"), "적용월인원현황");	
	G_addDataSet(dsSUB02, null,   gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "적용월기준금액");
	G_addDataSet(dsALL_CHG_SEQ, null, null, sSelectPageName+D_P1("ACT","ALL_CHG_SEQ"), "일괄변경차수");
	G_addDataSet(dsBUDG_ALL_CHANGE, transBudgAllChange, null, sSelectPageName+D_P1("ACT","BUDG_ALL_CHANGE"), "일괄변경");
	
	G_addDataSet(dsLOV, null, null,null, "LOV");
	G_addDataSet(dsDEPT, null, null,null, "DEPT");
	G_addDataSet(dsCHG_DEPT, null, null,null, "변동부서");
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	G_Load(dsALL_CHG_SEQ,null);
	G_Load(dsDEPT, null);
	//alert(dsALL_CHG_SEQ.CountRow);
	if (dsALL_CHG_SEQ.CountRow > 0 )
	{
		//G_Load(dsMAIN01, null);
		
		//G_Load(dsSUB01, null);
		
		//G_Load(dsMAIN02, null);
		//G_Load(dsSUB02, null);
	}
	
	//G_addRel(dsMAIN01,dsMAIN02);
	//G_addRelCol(dsMAIN02,"COMP_CODE","COMP_CODE");
	//G_addRelCol(dsMAIN02,"CLSE_ACC_ID","CLSE_ACC_ID");
	//G_addRelCol(dsMAIN02,"ALL_CHG_SEQ","ALL_CHG_SEQ");
	//G_addRelCol(dsMAIN02,"DEPT_CODE","DEPT_CODE");
	
	
	G_addRel(dsMAIN01,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsSUB01,"ALL_CHG_SEQ","ALL_CHG_SEQ");
	G_addRelCol(dsSUB01,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsSUB01,"EMP_NO","EMP_NO");
	
	
	G_addRel(dsMAIN02,dsSUB02);
	G_addRelCol(dsSUB02,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB02,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsSUB02,"ALL_CHG_SEQ","ALL_CHG_SEQ");
	G_addRelCol(dsSUB02,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsSUB02,"EMP_NO","EMP_NO");
	
	G_setReadOnlyCol(gridMAIN01,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN01,"EMP_NO");
	G_setReadOnlyCol(gridMAIN01,"GRADE_NAME");
	G_setReadOnlyCol(gridMAIN01,"EMP_NAME");
	
	G_setReadOnlyCol(gridSUB01,"BUDG_CODE_NAME");
	G_setReadOnlyCol(gridSUB01,"ITEM_NAME");
	G_setReadOnlyCol(gridSUB01,"BUDG_YM");
	G_setReadOnlyCol(gridSUB01,"UNIT_COST");
	G_setReadOnlyCol(gridSUB01,"QTY");
	G_setReadOnlyCol(gridSUB01,"AMT");
	
	G_setReadOnlyCol(gridMAIN02,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN02,"EMP_NO");
	G_setReadOnlyCol(gridMAIN02,"GRADE_NAME");
	G_setReadOnlyCol(gridMAIN02,"EMP_NAME");
	G_setReadOnlyCol(gridMAIN02,"ORDER_DT");
	G_setReadOnlyCol(gridMAIN02,"BF_ORDER_DEPT_NAME");
	G_setReadOnlyCol(gridMAIN02,"BF_ORDER_GRADE_NAME");
	
	G_setReadOnlyCol(gridSUB02,"BUDG_CODE_NAME");
	G_setReadOnlyCol(gridSUB02,"ITEM_NAME");
	G_setReadOnlyCol(gridSUB02,"BUDG_YM");
	G_setReadOnlyCol(gridSUB02,"UNIT_COST");
	G_setReadOnlyCol(gridSUB02,"QTY");
	G_setReadOnlyCol(gridSUB02,"AMT");
	
	
	//gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN01)
	{
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN01")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("ALL_CHG_SEQ", dsALL_CHG_SEQ.NameValue(dsALL_CHG_SEQ.RowPosition, "ALL_CHG_SEQ"))
									 + D_P2("DEPT_CODE", dsDEPT.NameValue(dsDEPT.RowPosition, "DEPT_CODE"));
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("ALL_CHG_SEQ", dsALL_CHG_SEQ.NameValue(dsALL_CHG_SEQ.RowPosition, "ALL_CHG_SEQ"))
									 + D_P2("DEPT_CODE", dsMAIN01.NameString(dsMAIN01.RowPosition,"DEPT_CODE"))
									 + D_P2("EMP_NO", dsMAIN01.NameString(dsMAIN01.RowPosition,"EMP_NO"));
	}
	
	else if(dataset == dsMAIN02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN02")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID", txtCLSE_ACC_ID.value)
									 + D_P2("ALL_CHG_SEQ", dsALL_CHG_SEQ.NameValue(dsALL_CHG_SEQ.RowPosition, "ALL_CHG_SEQ"))
									 + D_P2("DEPT_CODE", dsDEPT.NameValue(dsDEPT.RowPosition, "DEPT_CODE")); 
	}
	else if(dataset == dsSUB02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
									 + D_P2("ALL_CHG_SEQ", dsALL_CHG_SEQ.NameValue(dsALL_CHG_SEQ.RowPosition, "ALL_CHG_SEQ"))
								        + D_P2("DEPT_CODE",dsMAIN02.NameString(dsMAIN02.RowPosition,"DEPT_CODE"))
									 + D_P2("EMP_NO",dsMAIN02.NameString(dsMAIN02.RowPosition,"EMP_NO"));
	}
	else if(dataset == dsALL_CHG_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ALL_CHG_SEQ")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
									
	}
	else if(dataset == dsBUDG_ALL_CHANGE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BUDG_ALL_CHANGE");
									
	}
	else if(dataset == dsDEPT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPT")
									 + D_P2("COMP_CODE",txtCOMP_CODE.value);
									 
									
	}
	else if(dataset == dsCHG_DEPT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CHG_DEPT")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID", txtCLSE_ACC_ID.value)
									 + D_P2("ALL_CHG_SEQ", dsALL_CHG_SEQ.NameValue(dsALL_CHG_SEQ.RowPosition, "ALL_CHG_SEQ"));
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
function budgAllChangeApply(div,msg)
{
	G_Load(dsBUDG_ALL_CHANGE, null);
	dsBUDG_ALL_CHANGE.NameString(dsBUDG_ALL_CHANGE.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsBUDG_ALL_CHANGE.NameString(dsBUDG_ALL_CHANGE.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsBUDG_ALL_CHANGE.NameString(dsBUDG_ALL_CHANGE.RowPosition,"ALL_CHG_SEQ") = dsALL_CHG_SEQ.NameString(dsALL_CHG_SEQ.RowPosition, "ALL_CHG_SEQ");
	dsBUDG_ALL_CHANGE.NameString(dsBUDG_ALL_CHANGE.RowPosition,"APPLY_YN") = div;
	
	
	transBudgAllChange.Parameters = "ACT=BUDG_ALL_CHANGE";
	
	if(!G_saveData(dsBUDG_ALL_CHANGE)) return;
	
	G_Load(dsALL_CHG_SEQ, null);
	C_msgOk(msg + " " + "정상적으로 수행되었습니다.");
	//gridMAIN.focus();
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	
	if (dsALL_CHG_SEQ.CountRow > 0 )
	{
		G_Load(dsCHG_DEPT, null);
		
		G_Load(dsMAIN01, null);
		
		//G_Load(dsSUB01, null);
		
		G_Load(dsMAIN02, null);
		//G_Load(dsSUB02, null); 
		
	}
	
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

function OnRowPosChanged(dataset, row)
{
	if (dataset==dsDEPT)
	{
		//btnquery_onclick();
	}
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
	
}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		//dsMAIN.ClearData();
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
	
	G_Load(dsALL_CHG_SEQ,null);
	//G_Load(dsMAIN01, null);
	//G_Load(dsMAIN02, null);

}
function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
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

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
       G_Load(dsALL_CHG_SEQ,null);
	//G_Load(dsMAIN01, null);
	//G_Load(dsMAIN02, null);

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
//일괄예산변경적용
function btnBudgAllChangeApply_onClick()
{
	budgAllChangeApply('Y', '일괄예산 변경적용이');
}
//일괄예산변경적용취소
function btnBudgAllChangeApplyCancel_onClick()
{
 	budgAllChangeApply('N', '일괄예산 변경적용 취소가');
}