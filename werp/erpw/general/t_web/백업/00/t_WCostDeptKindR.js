/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCostDeptKindR.js(현장구분등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "현장구분목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.

	gridMAIN.TabToss = false;
	gridMAIN.focus();
	//G_Load(dsMAIN, null);
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
		if(colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" 
			|| colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME"
			|| colid == "ITRB_ACC_CODE" || colid == "ITRB_ACC_CODE_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" ? "SEC_ACC_CODE":
												(colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME" ? "ITRP_ACC_CODE":"ITRB_ACC_CODE");
			var			lsTargetName = colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" ? "SEC_ACC_CODE_NAME":
												(colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME" ? "ITRP_ACC_CODE_NAME":"ITRB_ACC_CODE_NAME");
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,lsTargetCode) = "";
				dsMAIN.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
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
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" 
			|| colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME"
			|| colid == "ITRB_ACC_CODE" || colid == "ITRB_ACC_CODE_NAME")
		{
			var			lsTargetCode = colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" ? "SEC_ACC_CODE":
												(colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME" ? "ITRP_ACC_CODE":"ITRB_ACC_CODE");
			var			lsTargetName = colid == "SEC_ACC_CODE" || colid == "SEC_ACC_CODE_NAME" ? "SEC_ACC_CODE_NAME":
												(colid == "ITRP_ACC_CODE" || colid == "ITRP_ACC_CODE_NAME" ? "ITRP_ACC_CODE_NAME":"ITRB_ACC_CODE_NAME");
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dsMAIN.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(colid == "SEC_ACC_CODE")
	{
		dataset.NameString(row,"SEC_ACC_CODE_NAME") = dataset.NameString(row - 1,"SEC_ACC_CODE_NAME");
	}
	else if(colid == "SEC_ACC_CODE_NAME")
	{
		dataset.NameString(row,"SEC_ACC_CODE") = dataset.NameString(row - 1,"SEC_ACC_CODE");
	}
	else if(colid == "ITRP_ACC_CODE")
	{
		dataset.NameString(row,"ITRP_ACC_CODE_NAME") = dataset.NameString(row - 1,"ITRP_ACC_CODE_NAME");
	}
	else if(colid == "ITRP_ACC_CODE_NAME")
	{
		dataset.NameString(row,"ITRP_ACC_CODE") = dataset.NameString(row - 1,"ITRP_ACC_CODE");
	}
	else if(colid == "ITRB_ACC_CODE")
	{
		dataset.NameString(row,"ITRB_ACC_CODE_NAME") = dataset.NameString(row - 1,"ITRB_ACC_CODE_NAME");
	}
	else if(colid == "ITRB_ACC_CODE_NAME")
	{
		dataset.NameString(row,"ITRB_ACC_CODE") = dataset.NameString(row - 1,"ITRB_ACC_CODE");
	}
}

// 이벤트관련-------------------------------------------------------------------//
