/**************************************************************************/
/* 1. 프 로 그 램 id : HTML_1.js(단일 화면)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "자금수지동향코드");
	G_addDataSet(dsCOPY, transCOPY, null, sSelectPageName+D_P1("ACT","COPY"), "집계");
	//alert(sDate);
	txtWORK_DT.value = sDate;
	G_setReadOnlyCol(gridMAIN,"ITEM_NAME");
	G_setReadOnlyCol(gridMAIN,"MONTH_AMT");
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("WORK_DT",txtWORK_DT.value);
	}
	else if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
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
function checkDate()
{
	if(C_isNull(txtWORK_DT.value))
	{
		C_msgOk("기준일자를 입력하세요");
		return false;
	}
	return true;	
}
function	checkConditions()
{
	return checkDate();
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(!checkDate()) return false;
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
}

// 삽입
function btninsert_onclick()
{
}

// 삭제
function btndelete_onclick()
{
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
	if (asCalendarID == "WORK_DT")
	{                                
		txtWORK_DT.value = asDate;
	}                                	
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
		
		dataset.NameValue(row,"WORK_DT") =txtWORK_DT.value;
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
	if(dataset==dsMAIN)
	{
		if(colid=='AMT')
		{
			//dataset.NameValue(row,"MONTH_AMT") = dataset.NameValue(row,"MONTH_AMT_A") + dataset.NameValue(row,"AMT");
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		if(colid=='ITEM_NAME')
		{
			if(C_isNull(dsMAIN.NameValue(row, "ITEM_NAME")))
			{
				dsMAIN.NameValue(row, "ITEM_CODE")='';	
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameValue(row, "ITEM_NAME"));
			lrRet = C_LOV("T_FL_FUND_IN_OUT_CODE1", lrArgs,"T");
		
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row, "ITEM_CODE")	= lrRet.get("ITEM_CODE");
			dsMAIN.NameValue(row, "ITEM_NAME")	= lrRet.get("ITEM_NAME");
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		if(colid=='ITEM_NAME')
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		       lrArgs.set("SEARCH_CONDITION", "");
			lrRet = C_LOV("T_FL_FUND_IN_OUT_CODE1", lrArgs,"F");
		
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row, "ITEM_CODE")	= lrRet.get("ITEM_CODE");
			dsMAIN.NameValue(row, "ITEM_NAME")	= lrRet.get("ITEM_NAME");	
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
function btnWORK_DT_onClick()
{
	C_Calendar("WORK_DT", "D", txtWORK_DT.value);
}
function	btnPreView_onClick()
{
	if(!checkConditions()) return;
	G_Load(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"WORK_DT") = txtWORK_DT.value;
	transCOPY.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	G_Load(dsMAIN);
}
