/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFLCompPlnFunctionBR(본사자금수지계획본사집계함수등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "본사자금수지계획집계함수");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsSEQ, null, null, null, "SEQ");


	G_setLovCol(gridMAIN,"FUNC_NAME");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//부가세코드 가져오기
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");
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
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"DEPT_PLN_FUNC_NO") = dsSEQ.NameString(dsSEQ.RowPosition,"SEQ");
		dataset.NameString(row,"AUTO_RECALCC_TAG") = "F";
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
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "FUNC_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,"FUNC_NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_SEARCH_PROCEDURE", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,"FUNC_NAME")	= lrRet.get("OBJECT_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if (colid == "FUNC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_SEARCH_PROCEDURE", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dsMAIN.NameString(row,"FUNC_NAME")	= lrRet.get("OBJECT_NAME");
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
