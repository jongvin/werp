/**************************************************************************/
/* 1. 프 로 그 램 id : t_WMainAccCodeR.jsp(원가현장구분별계정설정)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-06)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			sACC_CODE = "";
var			sACC_NAME = "";
function Initialize()
{
	G_addDataSet(dsLOV,  null,   null, null, "LOV");

	G_addDataSet(dsCOST_DEPT_KIND, null, null, sSelectPageName+D_P1("ACT","COST_DEPT_KIND"), "부서현장구분");

	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "대표계정");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "부서현장별계정");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"MAIN_ACC_CODE","MAIN_ACC_CODE");
	
	G_setReadOnlyCol(gridMAIN,"MAIN_ACC_CODE");
	G_setReadOnlyCol(gridMAIN,"ACC_NAME");

	G_setReadOnlyCol(gridSUB01,"MAIN_ACC_CODE");

	G_setLovCol(gridSUB01,"ACC_CODE");
	G_setLovCol(gridSUB01,"ACC_NAME");

	G_Load(dsCOST_DEPT_KIND, null);
	
	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridSUB01.TabToss = false;

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsCOST_DEPT_KIND)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COST_DEPT_KIND");
	}
	else if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
							+ D_P2("MAIN_ACC_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"MAIN_ACC_CODE"));
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
	if(dataset == dsMAIN)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
		
		if (lrRet == null) return false;
	
		sACC_CODE	= lrRet.get("ACC_CODE");
		sACC_NAME	= lrRet.get("ACC_NAME");
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dataset.NameString(row,"MAIN_ACC_CODE") = sACC_CODE;
		dataset.NameString(row,"ACC_NAME") = sACC_NAME;
	}
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
	var			COL_DATA = dataset.NameString(row,colid);
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
		if (colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsSUB01)
	{
		if (colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
		}
	}
}
function OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsSUB01)
	{
		if(colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			if(row>=2)
			{
				dataset.NameString(row,"ACC_CODE") = dataset.NameString(row-1,"ACC_CODE");
				dataset.NameString(row,"ACC_NAME") = dataset.NameString(row-1,"ACC_NAME");
			}
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
function	btnAddAll_onClick()
{
	for(var i = 1 ; i <= dsCOST_DEPT_KIND.CountRow ; ++ i)
	{
		G_addRow(dsSUB01);
		dsSUB01.NameString(dsSUB01.RowPosition,"COST_DEPT_KND_TAG") = dsCOST_DEPT_KIND.NameString(i,"COST_DEPT_KND_TAG");
		dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"MAIN_ACC_CODE");
		dsSUB01.NameString(dsSUB01.RowPosition,"ACC_NAME") = dsMAIN.NameString(dsMAIN.RowPosition,"ACC_NAME");
	}
}