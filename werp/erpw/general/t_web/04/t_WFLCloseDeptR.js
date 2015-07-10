/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFLComPlanR(자금수지현장별마감)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "당회기관리현장",null,null,true);
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "현장및미확정현장목록",null,null,true);
	G_addDataSet(dsMASTER, trans, null, null, "본사마감여부",null,null,true);
	
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
	G_setReadOnlyCol(gridSUB01,"DEPT_CODE");
	G_setReadOnlyCol(gridSUB01,"DEPT_NAME");
	//G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	//G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	
	G_Load(dsMAIN);
	//G_Load(dsSUB01);
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
	}
	else if(dataset == dsMASTER)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MASTER")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
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
function	CopyOneRow(arSrcDataset,arSrcRow,arDstDataset,arDstRow)
{
	for(var j = 1 ; j <= arSrcDataset.CountColumn ; ++ j)
	{
		arDstDataset.NameString(arDstRow,arSrcDataset.ColumnID(j)) = arSrcDataset.ColumnString(arSrcRow,j);
	}
	return true;
}
function	MoveSelectedRows(arSrcDataset,arDstDataset)
{
	var		lrArrayRows = new Array();
	if(arSrcDataset == dsMAIN)
	{
		for(var i = 1 ; i <= arSrcDataset.CountRow ; ++ i)
		{
			if(arSrcDataset.RowMark(i) == 1)
			{
				if(dsMAIN.NameString(i,"PLAN_CONFIRM_TAG") == "T"||dsMAIN.NameString(i,"IS_DATA_EXISTS") == "T")
				{
					C_msgOk("마감된 자료나 작업된 자료가 있는 현장은 삭제하실 수 없습니다.");
					dsMAIN.RowPosition = i;
					return;
				}
				lrArrayRows.push(i);
			}
		}
	}
	else
	{
		for(var i = 1 ; i <= arSrcDataset.CountRow ; ++ i)
		{
			if(arSrcDataset.RowMark(i) == 1)
			{
				lrArrayRows.push(i);
			}
		}
	}
	for(var i = 0 ; i < lrArrayRows.length  ; ++i)
	{
		G_addRow(arDstDataset);
		if(!CopyOneRow(arSrcDataset,lrArrayRows[i],arDstDataset,arDstDataset.RowPosition)) return;
	}
	for(var i = lrArrayRows.length - 1 ; i >= 0 ; --i)
	{
		G_deleteRow(arSrcDataset,lrArrayRows[i],false);
	}
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
function	checckClose()
{
	if(isClose())
	{
		C_msgOk("이미 본사 마감되어 있습니다.");
		return true;
	}
	return false;
}
function	isClose()
{
	if(dsMASTER.CountRow < 1) return false;
	if(dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG") == "T")
	{
		return true;
	}
	return false;
}
function	processClose()
{
	if(isClose())
	{
		G_setReadOnlyCol(gridMAIN,"PLAN_CONFIRM_TAG");
	}
	else
	{
		G_setReadWriteCol(gridMAIN,"PLAN_CONFIRM_TAG");
	}
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
	//D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	//D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	//D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	if(!checkConditions()) return;
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
	if(dataset == dsMAIN)
	{
		G_Load(dsSUB01);
		G_Load(dsMASTER);
		processClose();
	}
}
function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	}
	else if(dataset == dsMASTER)
	{
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
function	btnGrantCompCode_onClick()
{
	if(checckClose()) return;
	try
	{
		MoveSelectedRows(dsSUB01,dsMAIN);
	}
	catch(e)
	{
	}
}
function	btnRevokeCompCode_onClick()
{
	if(checckClose()) return;
	try
	{
		MoveSelectedRows(dsMAIN,dsSUB01);
	}
	catch(e)
	{
	}
}
function	btnSelectAll_onClick()
{
	if(checckClose()) return;
	var			liCnt = dsMAIN.CountRow;
	for(var i = 1 ; i <= liCnt ; ++i)
	{
		dsMAIN.NameString(i,"PLAN_CONFIRM_TAG") = "T";
	}
}
function	btnDeSelectAll_onClick()
{
	if(checckClose()) return;
	var			liCnt = dsMAIN.CountRow;
	for(var i = 1 ; i <= liCnt ; ++i)
	{
		dsMAIN.NameString(i,"PLAN_CONFIRM_TAG") = "F";
	}
}
function	btnCloseB_onClick()
{
	if(!checkConditions()) return;
	if(checckClose()) return;
	if(dsMASTER.CountRow < 1)
	{
		G_addRow(dsMASTER);
	}
	dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG") = "T";
	dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG_NM") = "마감됨";
	processClose();
}
function	btnOpenB_onClick()
{
	if(!checkConditions()) return;
	if(dsMASTER.CountRow < 1)
	{
		G_addRow(dsMASTER);
	}
	dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG") = "F";
	dsMASTER.NameString(dsMASTER.RowPosition,"PLAN_CONFIRM_TAG_NM") = "마감안됨";
	processClose();
}
