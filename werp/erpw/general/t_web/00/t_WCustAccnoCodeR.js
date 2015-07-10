/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCustAccnoCodeR.js(거래처별계좌번호)
/* 2. 유형(시나리오) : Left-Right(Master-Detail)
/* 3. 기  능  정  의 : 거래처 별 계좌번호의 등록
/* 4. 변  경  이  력 : 한재원 작성(2005-11-24)
/* 5. 관련  프로그램 : 없음
/* 6. 특  기  사  항 : 없음
/**************************************************************************/
function Initialize()
{
	
	G_addDataSet(dsMAIN, null, gridMAIN, null, "거래처코드");
	G_addDataSet(dsLIST, trans, gridLIST, null, "거래처별계좌번호");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "CUST_SEQ", "CUST_SEQ");
	
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var 	strTRADE_CLS = cboTRADE_CLS.value;
		var 	strCUST_NAME = txtCUST_NAME_S.value;
		
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("TRADE_CLS",strTRADE_CLS)
											+ D_P2("CUST_NAME",strCUST_NAME);
	}
	
	else if(dataset == dsLIST)
	{
		var 	strCUST_SEQ = dsMAIN.NameString(dsMAIN.RowPosition,"CUST_SEQ");

		dataset.DataID = sSelectPageName	+ D_P1("ACT","LIST")
											+ D_P2("CUST_SEQ",strCUST_SEQ);
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
	if(dataset == dsLIST)
	{
		dsLIST.NameString(row,"ACCNO_CLS") = "1";
		dsLIST.NameString(row,"USE_TG") = "T";
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
	if (dataset == dsLIST)
	{
		if(colid == "BANK_MAIN_NAME")
		{
			if(dsLIST.NameString(row,"BANK_MAIN_NAME")=="")
			{
				dsLIST.NameString(row,"BANK_MAIN_CODE") ="";
			}
			
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("SEARCH_CONDITION", dsLIST.NameString(row,"BANK_MAIN_NAME"));
			
			lrRet = C_AutoLov(dsLOV,"T_BANK_MAIN", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dsLIST.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dsLIST.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
		}
	}				
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsLIST)
	{
			
		var lrArgs = new C_Dictionary();
		
		lrArgs.set("SEARCH_CONDITION", "");
		
		var lrRet = null;

		lrRet = C_LOV("T_BANK_MAIN", lrArgs);

		if (lrRet != null)
		{
			dsLIST.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dsLIST.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//


