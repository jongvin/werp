/**************************************************************************/
/* 1. 프 로 그 램 id : HTML_1.js(단일 화면)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "입출금내역코드");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "본사수지내역");

	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"ITEM_CODE","ITEM_CODE");
	gridMAIN.focus();
	G_setLovCol(gridSUB01,"FLOW_ITEM_NAME");
	//G_setReadOnlyCol(gridSUB01,"FLOW_ITEM_NAME");
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
									 + D_P2("ITEM_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_CODE"));
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
	D_defaultSave();
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
	if(dataset==dsMAIN)
	{
		dataset.NameValue(row,"IO_TAG") = "1";	
	}
	else if(dataset ==dsSUB01)
	{
		
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
	if(dataset == dsSUB01)
	{
		if(colid=='FLOW_ITEM_NAME')
		{
			if(C_isNull(dataset.NameValue(row, "FLOW_ITEM_NAME")))
			{
				dataset.NameValue(row, "FLOW_CODE_B")='';	
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "FLOW_CODE_B"));
			lrRet = C_LOV("T_FL_FLOW_CODE_B1", lrArgs,"T");
		
			if (lrRet == null) return;
		
			dataset.NameValue(row, "FLOW_CODE_B")	= lrRet.get("FLOW_CODE_B");
			dataset.NameValue(row, "FLOW_ITEM_NAME")	= lrRet.get("FLOW_ITEM_NAME");	
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsSUB01)
	{
		if(colid=='FLOW_ITEM_NAME')
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		       lrArgs.set("SEARCH_CONDITION", "");
			lrRet = C_LOV("T_FL_FLOW_CODE_B1", lrArgs,"F");
		
			if (lrRet == null) return;
		
			dataset.NameValue(row, "FLOW_CODE_B")	= lrRet.get("FLOW_CODE_B");
			dataset.NameValue(row, "FLOW_ITEM_NAME")	= lrRet.get("FLOW_ITEM_NAME");	
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
