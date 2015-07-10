/**************************************************************************/
/* 1. 프 로 그 램 id : t_WPLMADeptR(현장별관리손익조회)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-25)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			bEnter = false;
var			strLastColId = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "현장목록",null,null,true);
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "현장별관리손익조회",null,null,true);
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"DEPT_CODE","DEPT_CODE");
	
	G_addDataSet(dsCOPY,transCopy,null,null,"복사");
	G_addDataSet(dsREMOVE,transRemove,null,null,"삭제");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCLOSE, null, null, null, "CLOSE");
	
	

	txtCLSE_ACC_ID.value = sClseAccId;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
	
	
	G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"LEVELED_NAME");
	G_setReadOnlyCol(gridMAIN,"SUBTITLE_NAME");
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("WORK_YM",txtCLSE_ACC_ID.value)
											+ D_P2("DEPT_NAME",txtDEPT_NAME.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("WORK_YM",txtCLSE_ACC_ID.value)
											+ D_P2("DEPT_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"));
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REMOVE");
	}
	else if (dataset == dsCLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CLOSE")
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
function	CalcSum(row,colid)
{
	if(dsMAIN.NameString(row,"LV") != "2") return;
	if(dsMAIN.NameString(row,"IS_LEAF_TAG") != "T") return;
	dsMAIN.NameString(row + 1,colid) = C_convSafeFloat(dsMAIN.NameString(row - 1,colid)) + C_convSafeFloat(dsMAIN.NameString(row ,colid));
}
function	checkConditions()
{

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("먼저 회기를 선택하세요.", "확인");
		return false;
	}
	return true;
}
function	isClose()
{
	return false;
}
function	checkClose()
{
	if(isClose())
	{
		C_msgOk("이미 마감되었습니다.");
		return true;
	}
	else
	{
		return false;
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
	var			lbRet = D_defaultSave(dsMAIN);
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
		G_Load(dsCLOSE);
		if(checkClose())
		{
			gridMAIN.Editable = false;
		}
		else
		{
			gridMAIN.Editable = true;
		}
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
	return false;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset, grid, row, colid)
{
	if(dataset == dsSUB01)
	{
		strLastColId = colid;
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

function txtCLSE_ACC_ID_onblur()
{
	
}
function	CheckCompCode()
{
	return true;
}
function	btnShowDetail_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("세부사항을 보고싶은 행을 선택하십시오.");
		return;
	}
	if(dsSUB01.NameString(dsSUB01.RowPosition,"IS_LEAF_TAG") != "T")
	{
		C_msgOk("집계 항목은 세부사항을 보실 수 없습니다.");
		return;
	}
	
	if(strLastColId == "AMT_01")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "01");
	}
	else if (strLastColId == "AMT_02")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "02");
	}
	else if (strLastColId == "AMT_03")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "03");
	}
	else if (strLastColId == "AMT_04")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "04");
	}
	else if (strLastColId == "AMT_05")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "05");
	}
	else if (strLastColId == "AMT_06")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "06");
	}
	else if (strLastColId == "AMT_07")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "07");
	}
	else if (strLastColId == "AMT_08")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "08");
	}
	else if (strLastColId == "AMT_09")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "09");
	}
	else if (strLastColId == "AMT_10")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "10");
	}
	else if (strLastColId == "AMT_11")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "11");
	}
	else if (strLastColId == "AMT_12")
	{
		lrArgs.set("WORK_YM", txtCLSE_ACC_ID.value + "12");
	}
	else
	{
		C_msgOk("세부사항을 보고싶은 열(월)을 선택하십시오.");
		return;
	}
	

	lrArgs.set("DEPT_CODE", dsSUB01.NameString(dsSUB01.RowPosition,"DEPT_CODE"));
	lrArgs.set("ITEM_NO", dsSUB01.NameString(dsSUB01.RowPosition,"ITEM_NO"));
	var	lrRet = window.showModalDialog(
		"t_PPLMaDeptExecR.jsp",
		lrArgs,
		"center:yes; dialogWidth:976px;	dialogHeight:623px;	status:no; help:no;	scroll:no"
	);
}
