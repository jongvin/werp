/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixDeprecRatR.js(고정자산내용년수등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 고정자산내용년수등록
/* 4. 변  경  이  력 :  한재원작성(2006-01-16)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "내용년수");
	
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	 gridMAIN.focus();
	 G_setReadOnlyCol(gridMAIN, "SRVLIFE");
	 D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
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
	D_defaultAdd();
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
	if (dataset == dsMAIN)
	{
		dataset.NameValue(row, "SRVLIFE") = 	dataset.CountRow;
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

function OnRowPosChanged(dataset, row)
{
	if (dataset == dsMAIN)
	{
		oldData = dataset.NameValue(row, "ASSET_ACC_CODE");	
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if ( colid == "ASSET_ACC_CODE")
		{
			if ( C_isNull(dataset.NameValue(row, "ASSET_ACC_CODE")))
			{
				dataset.NameValue(row, "ASSET_ACC_NAME") = "";
			}
			else
			{
				var lrArgs = new C_Dictionary();
				var lrRet = null;
			
				
				
				lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "ASSET_ACC_CODE"));
				lrRet = C_AutoLov(dsLOV,"T_ACC_CODE3", lrArgs,"T");
				
				if (lrRet == null) 
				{
					dataset.NameValue(row, "ASSET_ACC_CODE") = oldData;
					
					return;
				}
				
				dataset.NameValue(row, "ASSET_ACC_CODE")	= lrRet.get("ACC_CODE");
				dataset.NameValue(row, "ASSET_ACC_NAME")	= lrRet.get("ACC_NAME");
			}	
		}		
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	
}

// 이벤트관련-------------------------------------------------------------------//
