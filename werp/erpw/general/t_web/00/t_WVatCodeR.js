/**************************************************************************/
/* 1. 프 로 그 램 id : t_WVatCodeR(부가세코드등록)
/* 2. 유형(시나리오) : 부가세코드 조회 및 입력
/* 3. 기  능  정  의 : 부가세코드를 등록및 조회한다.
/* 4. 변  경  이  력 : 최언회 작성(2005-10-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "부가세코드등록");
	G_addDataSet(dsLOV, null, null, null, "LOV");

	G_Load(dsMAIN,null);

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//부가세코드 가져오기
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
	if(dataset == dsMAIN)
	{
		dsMAIN.NameString(row,"RCPTBILL_CLS") = "01";
		dsMAIN.NameString(row,"SUBTR_CLS") = "1";
		dsMAIN.NameString(row,"SALEBUY_CLS") = "1";
		dsMAIN.NameString(row,"VATOCCUR_CLS") = "F";
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
	if(dataset == dsMAIN)
	{
		if(colid=='ACC_CODE')
		{
			if(C_isNull(dsMAIN.NameString(row,"ACC_CODE")))
			{
				dsMAIN.NameString(row,"ACC_NAME") = "";
				return;
			}
			
			var lrArgs = new C_Dictionary();
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"ACC_CODE"));

			var		lrRet = C_AutoLov(dsLOV,"T_ACC_CODE10",lrArgs, "T");

			if (lrRet != null)
			{
				dsMAIN.NameString(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
				dsMAIN.NameString(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if (colid == "ACC_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"ACC_CODE"));
		
			if (C_isNull(dsMAIN.NameString(row,"ACC_CODE")))
			{
				lrRet = C_LOV("T_ACC_CODE10", lrArgs,"F");
			}
			else
			{
				lrRet = C_LOV("T_ACC_CODE10", lrArgs,"T");
			}
			
			if (lrRet == null) return;
		
			dsMAIN.NameString(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dsMAIN.NameString(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
