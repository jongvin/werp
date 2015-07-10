/**************************************************************************/
/* 1. 프 로 그 램 id : t_WYearCloseR.js(회기등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 회기 등록, 조회 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-25)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, null, "사업장목록");
	G_addDataSet(dsLIST, trans, gridLIST, null, "회기목록");
	
	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "COMP_CODE", "COMP_CODE");
	
	gridLIST.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsLIST)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","LIST")
											+ D_P2("COMP_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"));
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
	if(dsLIST.NameString(dsLIST.RowPosition,"CLSE_CLS")=="T")
	{
		if(dsLIST.NameString(dsLIST.RowPosition,"CLSE_DT")=="")
		{
			C_msgOk("마감일을 입력하세요", "확인");
			return false; 
		}
	}
	D_defaultSave(dsLIST);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "ACCOUNT_FDT")
	{
		dsLIST.NameString(dsLIST.RowPosition,"ACCOUNT_FDT") = asDate;
	}
	else if (asCalendarID == "ACCOUNT_EDT")
	{
		dsLIST.NameString(dsLIST.RowPosition,"ACCOUNT_EDT") = asDate;
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
	dsLIST.NameString(row,"CLSE_CLS") = "F";
	dsLIST.NameString(row,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
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
	if (dataset == dsLIST)
	{
		if(colid == "CLSE_CLS")
		{
			if(dsLIST.NameString(row,"CLSE_CLS")=="F")
			{
				dsLIST.NameString(row,"CLSE_DT") = ""; 
			}
			else
			{
				dsLIST.NameString(row,"CLSE_DT") = vDate;
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var COL_DATA = dsLIST.nameValue(row,colid);
	
	if (dataset == dsLIST)
	{	
		if ( colid == "CLSE_ACC_ID")
		{
			var asValue = dsLIST.NameString(dsLIST.RowPosition,"CLSE_ACC_ID");
			
			var strValue = asValue.toString();
			
			if (C_getByteLength(strValue) != 4 || !C_isNum(strValue))
			{
				ERR_MSG = "회기년도는 4자리 숫자입니다.";
				C_msgOk(ERR_MSG, "확인");
				return false;
			}
			
			if (parseInt(asValue) < 1900 || parseInt(asValue) >2990)
			{
				ERR_MSG = "회기년도는 1900년도 보다 크거나 2999보다 작아야 합니다";
				C_msgOk(ERR_MSG, "확인");
				return false;
			}
		}
		else if(colid == "ACCOUNT_FDT")
		{
			if (!C_isNull(dsLIST.NameString(row,"ACCOUNT_EDT")))
			{
				if(dsLIST.NameString(row,"ACCOUNT_FDT").replace(/-/gi,"") > dsLIST.NameString(row,"ACCOUNT_EDT").replace(/-/gi,""))
				{
					C_msgOk("시작일이 종료일보다 큽니다.", "확인");
					dsLIST.NameString(row,colid) = olddata;
					return;
				}
			}
			
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
		else if(colid == "ACCOUNT_EDT")
		{
			if (!C_isNull(dsLIST.NameString(row,"ACCOUNT_EDT")))
			{
				if(dsLIST.NameString(row,"ACCOUNT_FDT").replace(/-/gi,"") > dsLIST.NameString(row,"ACCOUNT_EDT").replace(/-/gi,""))
				{
					C_msgOk("시작일이 종료일보다 큽니다.", "확인");
					dsLIST.NameString(row,colid) = olddata;
					return;
				}
			}
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsLIST)
	{
		if(colid == "ACCOUNT_FDT")
		{
				C_Calendar("ACCOUNT_FDT", "D", dsLIST.NameString(dsLIST.RowPosition,"ACCOUNT_FDT"));
		}
		else if(colid == "ACCOUNT_EDT")
		{
				C_Calendar("ACCOUNT_EDT", "D", dsLIST.NameString(dsLIST.RowPosition,"ACCOUNT_EDT"));		
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
