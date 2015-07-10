/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFinPaySumAccGroupR.jsp(대금지급유형관리)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 대금지급유형관리조회
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-10)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			sACC_CODE = "";
var			sACC_NAME = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "대금지급유형목록");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "계정목록");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"ACC_KIND_CODE","ACC_KIND_CODE");
	

	G_setReadOnlyCol(gridSUB01,"ACC_CODE");
	G_setReadOnlyCol(gridSUB01,"ACC_NAME");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;

	gridMAIN.focus();
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
										 + D_P2("ACC_KIND_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"ACC_KIND_CODE"));
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
function	chkTopCondition()
{
	return true;
}
function	getAccCode()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
	if (lrRet != null)
	{
		sACC_CODE = lrRet.get("ACC_CODE");
		sACC_NAME = lrRet.get("ACC_NAME");
		return true;
	}
	
	return false;
}
function	chkSave()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("변경사항을 저장한 후 작업이 가능합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
			return true;
		}
		else
		{
			return false;
		}
	}
	return true;
}

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

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		return true;
	}
	else if(dataset == dsSUB01)
	{
		return getAccCode();
	}
	return false;
}
function OnRowInserted(dataset, row)
{
	if(dataset == dsSUB01)
	{
		dataset.NameString(row,"ACC_CODE") = sACC_CODE;
		dataset.NameString(row,"ACC_NAME") = sACC_NAME;
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// 이벤트관련-------------------------------------------------------------------//
