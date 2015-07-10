/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFBCardUseR.jsp(법인카드이용내역등록)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 법인카드이용내역등록
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-22)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "법인카드이용내역");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	txtDATE_FROM.value = sDTF;
	txtDATE_TO.value = sDTT;

	G_setReadOnlyCol(gridMAIN,"CARDNUMBER");
	G_setReadOnlyCol(gridMAIN,"USE_DATE_TIME");
	G_setReadOnlyCol(gridMAIN,"AMT");
	G_setReadOnlyCol(gridMAIN,"MERCHANTNAME");
	G_setReadOnlyCol(gridMAIN,"APPROVALNUMBER");
	G_setReadOnlyCol(gridMAIN,"MccName");	
	G_setReadOnlyCol(gridMAIN,"GUBUN");	
	G_setReadOnlyCol(gridMAIN,"CHARGEDATE");	

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("CARDNUMBER",cboCARDNUMBER.value)
										 + D_P2("SENDDATE_F",txtDATE_FROM.value.replace(/-/g,''))
										 + D_P2("SENDDATE_T",txtDATE_TO.value.replace(/-/g,''));
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
	//D_defaultAdd();
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
	if (asCalendarID == "DATE_FROM")
	{
		txtDATE_FROM.value = asDate;
	}
	else if (asCalendarID == "DATE_TO")
	{
		txtDATE_TO.value = asDate;
	}
}

function OnRowInsertBefore(dataset)
{
	return false;
}
function OnRowInserted(dataset, row)
{
}
function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// 이벤트관련-------------------------------------------------------------------//



function btnDATE_FROM_onClick()
{
	C_Calendar("DATE_FROM", "D", txtDATE_FROM.value);
}

function btnDATE_TO_onClick()
{
	C_Calendar("DATE_TO", "D", txtDATE_TO.value);
}

function cboCARDNUMBER_onChange()
{
	btnquery_onclick();
}

