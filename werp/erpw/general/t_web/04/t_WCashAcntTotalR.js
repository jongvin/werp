/**************************************************************************/
/* 1. 프 로 그 램 id : t_WAcntTotalR(계좌별집계조회)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-22)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "부서목록");
	G_addDataSet(dsCASH, trans, gridCASH, sSelectPageName+D_P1("ACT","MAIN"), "부서목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	
	
	
	G_setReadOnlyCol(gridCASH,"CASH_NAME");
	

	gridMAIN.focus();
}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("MAKE_DT_F",txtDT_T.value)
											+ D_P2("MAKE_DT_T",txtDT_T.value)
											+ D_P2("COMP_CODE",txtCOMP_CODE.value);
	}
	else if (dataset == dsCASH)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CASH")
											+ D_P2("WORK_DT",txtDT_T.value)
											+ D_P2("COMP_CODE",txtCOMP_CODE.value);
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
	if(!CheckCompCode()) return;
	G_Load(dsMAIN);
	G_Load(dsCASH);
}

// 추가
function btnadd_onclick()
{
	//D_defaultAdd();
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_NAME") = txtCOMPANY_NAME.value;

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
	D_defaultSave(dsCASH);
}

// 취소
function btncancel_onclick()
{
	//if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsMAIN)
	{
	}
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

function OnColumnPosChanged(dataset, grid, row, colid)
{
	if(grid == gridCASH)
	{
		if(colid == 'QTY')
		{
			if(dataset.NameString(row,"UNIT_COST") == "0")
			{
				grid.ColumnProp(colid,'Edit') = 'None';
			}
			else
			{
				grid.ColumnProp(colid,'Edit') = 'Numeric';
			}
		}
		else if(colid == 'AMT')
		{
			if(dataset.NameString(row,"UNIT_COST") == "0")
			{
				grid.ColumnProp(colid,'Edit') = 'Numeric';
			}
			else
			{
				grid.ColumnProp(colid,'Edit') = 'None';
			}
		}
	}
}
function	OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsCASH)
	{
		if(colid == "QTY")
		{
			dataset.NameString(row,"AMT") = C_convSafeFloat(dataset.NameString(row,"QTY")) * C_convSafeFloat(dataset.NameString(row,"UNIT_COST"));
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

function OnDuplicateColumn(dataset,grid,row,colid) 
{
}

function OnDblClick(dataset, grid, row, colid)
{
	if(dataset == dsMAIN)
	{
		showDetail(dataset, grid, row, colid);
	}
}

function	showDetail(dataset,grid,row,colid)
{
	if(row < 1) return;
	if (C_isNull(dataset.NameString(row,"MAKE_COMP_CODE"))) return;
	
	var			lfAmt1 = C_convSafeFloat(dataset.NameString(row,"SET_AMT"));
	var			lfAmt2 = C_convSafeFloat(dataset.NameString(row,"RESET_AMT"));
	if(lfAmt1 == 0 && lfAmt2 == 0)
	{
		C_msgOk("설정 또는 반제 금액이 있는 행을 선택하십시오.");
		return;
	}

	var myObject = new Object;
	myObject.window = window;

	var 	strMAKE_COMPANY		= dsMAIN.NameString(row,"MAKE_COMP_CODE");
	var 	strCOMPANY_NAME		= dsMAIN.NameString(row,"COMPANY_NAME");
	var 	strKEEP_DT_FROM		= txtDT_T.value;
	var 	strKEEP_DT_TO		= txtDT_T.value;
	var 	strACCNO			= dsMAIN.NameString(row,"MNG_ITEM");
	var 	strBANK_CODE			= dsMAIN.NameString(row,"BANK_CODE");
	var 	strBANK_NAME			= dsMAIN.NameString(row,"BANK_NAME");
	var 	strACC_CODE			= dsMAIN.NameString(row,"ACC_CODE");
	var 	strACC_NAME			= dsMAIN.NameString(row,"ACC_NAME");
	var 	strPROJ_CODE		= dsMAIN.NameString(row,"POSS_DEPT_PROJ");
	var 	strPROJ_NAME		= dsMAIN.NameString(row,"PROJ_NAME");

	var arrRtn = window.showModalDialog
	(
		"t_WAcntDetailR.jsp?MAKE_COMPANY="+strMAKE_COMPANY+
										"&MAKE_COMPANY_NAME="+strCOMPANY_NAME+
										"&KEEP_DT_FROM="+strKEEP_DT_FROM+
										"&KEEP_DT_TO="+strKEEP_DT_TO+
										"&ACC_CODE="+strACC_CODE+
										"&ACC_NAME="+strACC_NAME+
										"&ACCNO="+strACCNO+
										"&PROJ_CODE="+strPROJ_CODE+
										"&PROJ_NAME="+strPROJ_NAME+
										"&BANK_NAME="+strBANK_NAME+
										"&BANK_CODE="+strBANK_CODE,
		myObject,
		"center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no"
	);
}
// 이벤트관련-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		//SetDefaultCheckDept();
	}
}

function	txtCOMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
}

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE.value == '%')
	{
		txtCOMPANY_NAME.value = "전체";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
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


function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}

function btnKEEP_DT_onClick()
{
	C_Calendar("KEEP_DT", "D", txtKEEP_DT.value);
	S_nextFocus(btnKEEP_DT);
}

function	btnShowDetail_onClick()
{
	if(dsMAIN.CountRow < 1)
	{
		C_msgOk("먼저 집계내역을 조회하십시오.");
		return;
	}
	showDetail(dsMAIN,gridMAIN,dsMAIN.RowPosition,"");
}
